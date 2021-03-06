#include <lavish/graphics/vertexBuffer.hpp>
#include <lavish/core/display.hpp>
#include <lavish/graphics/model.hpp>
#include <lavish/core/timer.hpp>

#include <iostream>

#include <AppKit/AppKit.h>



using namespace lavish;

int main(int argc, char** argv)
{
	// TODO: this needs to be integrated during intialization of the library
	[[NSFileManager defaultManager] changeCurrentDirectoryPath:[[NSBundle mainBundle] resourcePath]];
	
	
    Display d;
	
    d.Initialize(800, 600, 24, "Sample 04");
	
    if( d.Show() == false )
    {
        std::cout << "Failed to open window, exiting." << std::endl;
        return 1;
    }
	
    d.ClearColor( Color::Blue() );
	
	Model* m = new Model("cube.obj");
	
	uint time = Timer::GetCurrentGameTime();
	
	Matrix4 modelTransformations = Matrix4::Translate(0.0f, 0.0f, -10.0f);
	
	float angle;
	
    while(d.Listener()->Update())
    {
		//rotate model
		angle = 90.0f * (((float)(Timer::GetCurrentGameTime() - time)) / 1000.0f);
		
		modelTransformations *= Matrix4::RotateX(angle);
		modelTransformations *= Matrix4::RotateY(angle);
		modelTransformations *= Matrix4::RotateZ(angle);
		
		time = Timer::GetCurrentGameTime();


        d.ClearScreen();
        d.SetupPerspective(45.0f, 0.1f, 100.0f);
		
		m->Render(&modelTransformations);
		
        d.SwapBuffers();
    }
	
    return 0;
}