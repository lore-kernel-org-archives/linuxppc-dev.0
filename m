Message-ID: <20020412022609.27613.qmail@web9503.mail.yahoo.com>
Date: Thu, 11 Apr 2002 19:26:09 -0700 (PDT)
From: Pete McCormick <pete261@yahoo.com>
Subject: building glibc eabi vs. elf
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all.

I am running into problems building glibc 2.2.5 using my powerpc-eabi-gcc
compiler.  I had no problems using this compiler to build newlib, ppcboot, and
the linux kernel.  I am getting the feeling, though, that I should be using
powerpc-elf-gcc instead.

I believe my current build error is because in sysdep.h __ELF__ is not defined
and therefore some macros don't get defined either.  Is this sounding familiar
to anyone?  Here's the output of "make":

make -r PARALLELMFLAGS="" CVSOPTS="" -C ../../src/glibc-2.2.5 objdir=`pwd` all
make[1]: Entering directory `/usr/src/glibc-2.2.5'
make  -C csu subdir_lib
make[2]: Entering directory `/usr/src/glibc-2.2.5/csu'
powerpc-eabi-linux-gnu-gcc -B/usr/local/powerpc-eabi/bin/
../sysdeps/powerpc/elf/start.S -c  -I../include -I.
-I/usr/build/glibc-2.2.5/csu -I.. -I../libio  -I/usr/build/glibc-2.2.5
-I../sysdeps/powerpc/elf -I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../sysdeps/pthread
-I../linuxthreads/sysdeps/unix/sysv -I../linuxthreads/sysdeps/unix
-I../linuxthreads/sysdeps/powerpc -I../sysdeps/unix/sysv/linux/powerpc
-I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix/common
-I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv
-I../sysdeps/unix/powerpc -I../sysdeps/unix -I../sysdeps/posix
-I../sysdeps/powerpc/fpu -I../sysdeps/powerpc -I../sysdeps/wordsize-32
-I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64
-I../sysdeps/powerpc/soft-fp -I../sysdeps/ieee754 -I../sysdeps/generic/elf
-I../sysdeps/generic  -nostdinc -isystem
/usr/local/powerpc-eabi/lib/gcc-lib/powerpc-eabi/3.0.4/include -isystem
d:/src/linux-2.4.18/include -D_LIBC_REENTRANT -include
../include/libc-symbols.h     -DHAVE_INITFINI -DASSEMBLER
-I/usr/build/glibc-2.2.5/csu/. -Wa,-mppc  -o /usr/build/glibc-2.2.5/csu/start.o
../sysdeps/powerpc/elf/start.S: Assembler messages:
../sysdeps/powerpc/elf/start.S:28: Error: Unrecognized opcode:
`l(start_addresses):'
../sysdeps/powerpc/elf/start.S:30: Warning: rest of line ignored; first ignored
character is `('
../sysdeps/powerpc/elf/start.S:31: Warning: rest of line ignored; first ignored
character is `('
../sysdeps/powerpc/elf/start.S:32: Warning: rest of line ignored; first ignored
character is `('
../sysdeps/powerpc/elf/start.S:33: Error: Unrecognized opcode:
`asm_size_directive(L(start_addresses))'
../sysdeps/powerpc/elf/start.S:36: Error: Unrecognized opcode: `entry(_start)'
../sysdeps/powerpc/elf/start.S:47: Error: syntax error; found `(' but expected
`,'
../sysdeps/powerpc/elf/start.S:47: Error: junk at end of line:
`(start_addresses)@ha'
../sysdeps/powerpc/elf/start.S:48: Error: junk at end of line: `@l(8)'
../sysdeps/powerpc/elf/start.S:50: Error: syntax error; found `(' but expected
`,'
../sysdeps/powerpc/elf/start.S:50: Error: junk at end of line:
`(__libc_start_main)'
make[2]: *** [/usr/build/glibc-2.2.5/csu/start.o] Error 1
make[2]: Leaving directory `/usr/src/glibc-2.2.5/csu'
make[1]: *** [csu/subdir_lib] Error 2
make[1]: Leaving directory `/usr/src/glibc-2.2.5'
make: *** [all] Error 2

Any helpful tips would be appreciated.

Pete

P.S.  My powerpc-eabi-ld can create an ELF image.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
