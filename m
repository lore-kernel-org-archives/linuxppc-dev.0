Message-ID: <38BEF87A.B614DB7F@machinasapiens.com>
Date: Thu, 02 Mar 2000 18:25:46 -0500
From: Pierre Sarrazin <sarrazip@machinasapiens.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: R_PPC_REL24 relocation out of range, with trivial program
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is another message about the "R_PPC_REL24 relocation out of range"
problem. I have a trivial program and library system that illustrates it.
I have read some of the previous messages on this topic but the solutions
proposed did not make a difference.

The problem happens when the dlopened library exports a C++
function returning 'string', but not when it exports a function
returning 'const char *'.

Here is the program:

--[ prog.cpp ]----------------------------------------------------------------
#include <assert.h>
#include <stdio.h>

#include <dlfcn.h>

#ifdef STRING_EXAMPLE
#include <string>
using namespace std;
#endif

int main()
{
	void *handle = dlopen("./libf.so", RTLD_NOW);
	if (!handle)
	{
		fprintf(stderr, "dlopen: %s\n", dlerror());
		return 1;
	}

	#ifdef STRING_EXAMPLE

	string (*pf)(void) = (string (*)(void)) dlsym(handle, "f");
	assert(pf);
	string s = (*pf)();
	printf("s = [%s]\n", s.c_str());

	#else

	const char *(*pg)(void) = (const char *(*)(void)) dlsym(handle, "g");
	assert(pg);
	const char *s = (*pg)();
	printf("s = [%s]\n", s);

	#endif

	dlclose(handle);

	return 0;
}
------------------------------------------------------------------------------

Here is the library source:

--[ f.cpp ]-------------------------------------------------------------------
#include <stdio.h>

#ifdef STRING_EXAMPLE

#include <string>

using namespace std;

extern "C" string f(void)
{
	printf("f()\n");
	return "pizza";
}

#else

extern "C" const char *g(void)
{
	printf("g()\n");
	return "spaghetti";
}

#endif
------------------------------------------------------------------------------


The Makefile defines STRING_EXAMPLE by default.  The problem only
occurs when it is defined. Here is the Makefile:


--[ Makefile ]----------------------------------------------------------------
# Program that illustrates the problem with the error message
# "R_PPC_REL24 relocation out of range" on LinuxPPC R5.
#
# By Pierre Sarrazin <sarrazip@iname.com> March 2, 2000.

FPIC=-fPIC
DEFINES=-DSTRING_EXAMPLE
CXXFLAGS=-g -Wall $(FPIC) $(DEFINES)

all: prog libf.so

prog: prog.o
	$(CXX) $(CXXFLAGS) -o $@ $< -ldl

prog.o: prog.cpp
	$(CXX) $(CXXFLAGS) -c $<

libf.so: f.o
	$(CXX) -shared -o $@ $<

f.o: f.cpp
	$(CXX) $(CXXFLAGS) -c $<

clean:
	rm prog prog.o libf.so f.o

distrib:
	tar czf R_PPC_REL24-relocation.tar.gz Makefile prog.cpp f.cpp
------------------------------------------------------------------------------


Here is a session on the LinuxPPC R5 machine. The compiler is
"gcc version 2.95.2 19991024 (release)". I have installed the
"binutils-2.9.5.0.14-0a" RPM.

------------------------------------------------------------------------------
$ make
g++ -g -Wall -fPIC -DSTRING_EXAMPLE -c prog.cpp
g++ -g -Wall -fPIC -DSTRING_EXAMPLE -o prog prog.o -ldl
g++ -g -Wall -fPIC -DSTRING_EXAMPLE -c f.cpp
g++ -shared -o libf.so f.o
$ ./prog
dlopen: ./libf.so: R_PPC_REL24 relocation out of range
$ make clean
rm prog prog.o libf.so f.o
$ make DEFINES=
g++ -g -Wall -fPIC  -c prog.cpp
g++ -g -Wall -fPIC  -o prog prog.o -ldl
g++ -g -Wall -fPIC  -c f.cpp
g++ -shared -o libf.so f.o
$ ./prog
g()
s = [spaghetti]
$
------------------------------------------------------------------------------


Here is a session on a Pentium-based RedHat 5.2 system. It uses
"gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)" and
binutils-2.9.1.0.15-1.


------------------------------------------------------------------------------
$ make
g++ -g -Wall -fPIC -DSTRING_EXAMPLE -c prog.cpp
g++ -g -Wall -fPIC -DSTRING_EXAMPLE -o prog prog.o -ldl
g++ -g -Wall -fPIC -DSTRING_EXAMPLE -c f.cpp
g++ -shared -o libf.so f.o
$ ./prog
f()
s = [pizza]
$
------------------------------------------------------------------------------


--
Pierre Sarrazin <sarrazip@machinasapiens.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
