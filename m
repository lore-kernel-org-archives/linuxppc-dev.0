From: oliver.amft@ch.abb.com
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <4125691F.0034CFC3.00@mail1.ch.abb.com>
Date: Mon, 17 Jul 2000 10:39:25 +0200
Subject: GLibC cross compile for ppc-linux
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

i'm trying to build the glibc 2.1.3 on a i686-linux machine for a powerpc-linux
embedded target. The make command works fine (...no errors) but somehow "make
check" stops in the "stdlib tests" part when it is invoking the "isomac" command
for the first time (after compiling it):

/var/powerpc-linux/obj/glibc-2.1.3/stdlib/isomac 'powerpc-linux-gcc'
'-I../include -I.. -I/var/powerpc-linux/obj/glibc-2.1.3 -I../sysdeps/powerpc/elf
 -I../crypt/sysdeps/unix -I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv
-I../linuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/powerpc
-I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux
-I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman
-I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix
-I../sysdeps/posix -I../sysdeps/powerpc -I../sysdeps/wordsize-32
-I../sysdeps/ieee754 -I../sysdeps/libm-ieee754 -I../sysdeps/generic/elf
-I../sysdeps/generic'
> /var/powerpc-linux/obj/glibc-2.1.3/stdlib/isomac.out
make[2]: *** [tests] Error 1
make[2]: Leaving directory `/var/powerpc-linux/src/glibc-2.1.3/stdlib'
make[1]: *** [stdlib/tests] Error 2
make[1]: Leaving directory `/var/powerpc-linux/src/glibc-2.1.3'
make: *** [check] Error 2


The isomac.out file contains the lines:

Tested files:
assert.h
ctype.h
errno.h
system() returned nonzero
float.h
iso646.h
limits.h
locale.h
math.h
setjmp.h
signal.h
stdarg.h
stddef.h
stdio.h
stdlib.h
string.h
time.h
wchar.h
wctype.h

I'm not sure what "isomac" does, but somehow it is intend to find "illegal macro
 definitions" in header files.
Does anyone has an idea how to fix this?

Oliver.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
