Message-ID: <38AAF67E.36D2@machinasapiens.com>
Date: Wed, 16 Feb 2000 14:11:58 -0500
From: Pierre Sarrazin <sarrazip@machinasapiens.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: kev@primenet.com
Subject: Re: Help w/ gdb
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I read the "Help w/ gdb" thread and I have found that one of the
proposed solutions solves one problem that I had on LinuxPPC R5:
I recompiled my small example program with -gdwarf-2 (and gcc 2.95.2)
instead of just -g and then I was able to step into the shared library
function call correctly.

Kevin Buettner, suggested this fix last month in
http://lists.linuxppc.org/listarcs/linuxppc-dev/200001/msg00245.html


However, the problem persists in a different form when I try the
fix with a larger program and larger library (compiled with gcc 2.95.2
with -fPIC and -gdwarf-2). In gdb, I want to step into the statement

  return ((int (*) (void)) functionPtrs[0])();

and I end up with this:

0xfd1859c in InitInterfaceCorrection ()
    at
/usr/local/lib/gcc-lib/powerpc-unknown-linux-gnu/2.95.2/../../../../include/g++-3/stl_alloc.h:518
518             return(_S_chunk_alloc(__size, __nobjs));

If I then give the "next" command, the program continues until it exits.
InitInterfaceCorrection() is the correct function name. Its first
statement is:

  int error = InitInterfaceCorrection_X(NULL, NULL);


Here is the bug report I sent to the GDB mailing list on 21 Jan 2000,
which includes the example program. Note however that since then I
have upgraded to gcc/g++ 2.95.2.

I am still using gdb 4.17.0.11 (which came with LinuxPPC R5).

===========================================================================

GDB does not step correctly into a runtime-loaded function under
LinuxPPC R5. The problem does not occur under RedHat 5.2 on a Pentium.

The Power Macintosh has the following characterics:
- kernel 2.2.6-15apmac #1 Mon May 31 03:54:09 EDT 1999
- /lib/libc-2.1.1.so
- GNU gdb 4.17.0.11
- gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)

Here is the main program (prog.c):

---------------------------------------------------------------------------
#include <assert.h>
#include <stddef.h>
#include <dlfcn.h>

int main(int argc, char *argv[])
{
        void *handle;
        void (*function)(void);

        handle = dlopen("./libfoo.so", RTLD_NOW);
        assert(handle != NULL);
        function = dlsym(handle, "library_function");
        assert(dlerror() == NULL && function != NULL);

        (*function)();

        dlclose(handle);
        return 0;
}
---------------------------------------------------------------------------


Here is the library source file (libfoo.c):

---------------------------------------------------------------------------
#include <stdio.h>

void library_function(void)
{
        printf("This is library_function()\n");
        printf("--------------------------\n");
}
---------------------------------------------------------------------------


Here is the Makefile:

---------------------------------------------------------------------------
CFLAGS=-fPIC -g -Wall

all: libfoo.so prog

libfoo.so: libfoo.o
        gcc -shared libfoo.o -o libfoo.so

libfoo.o: libfoo.c
        gcc $(CFLAGS) -c libfoo.c

prog: prog.o
        gcc -rdynamic -o prog prog.o -ldl

prog.o: prog.c
        gcc $(CFLAGS) -c prog.c

clean:
        rm -f prog lib*.so *.o core
---------------------------------------------------------------------------


The program executes fine by itself, as well as in GDB without
breakpoints.

Here is the scenario.  I enter GDB and set a breakpoint on this line
of prog.c:

        (*function)();

Then I run the program and GDB stops on that line. I give the "step"
command and get this:

---------------------------------------------------------------------------
(gdb) break 15
Breakpoint 1 at 0x1800734: file prog.c, line 15.
(gdb) run
Starting program: /home/sarrazip/pgm/bug-gdb-dll/prog

Breakpoint 1, main (argc=1, argv=0x7ffffbd4) at prog.c:15
15              (*function)();
(gdb) step
0x161a61c in library_function () at libfoo.c:7
7       }
(gdb) next
This is library_function()
--------------------------
main (argc=1, argv=0x7ffffbd4) at prog.c:17
17              dlclose(handle);
(gdb)
---------------------------------------------------------------------------


On a Pentium machine running RedHat Linux 5.2, the "step" works fine:
it stops on line 5 of libfoo.c, i.e., the first printf() statement.
This Pentium machine has the following characteristics:
- kernel 2.0.36 #1 Tue Oct 13 22:17:11 EDT 1998
- /lib/libc-2.0.7.so
- GNU gdb 4.17.0.4
- gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)

--
Pierre Sarrazin <sarrazip@machinasapiens.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
