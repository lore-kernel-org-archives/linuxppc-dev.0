Message-ID: <000b01c1e418$f49c0c20$0a02a8c0@WorkGroup>
From: "Timothy Robb" <xavier@vianet.ca>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Trouble building a cross compiler
Date: Sun, 14 Apr 2002 21:00:37 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm having trouble building a cross compiler for a IBM PowerPC
403GB.  I have a old ncd xterm and want it to boot linux as part
of a experiment I have planned.

So I downloaed
binutils 2.12.2
gcc 2.95.3
glib 2.2.5
linux 2.4.17

I have set the environment variables.  TARGET=powerpc-linux
PREFIX=/usr/local/powerpc and PATH=$PATH:$PREFIX/bin

I built binutils with
configure --target=$TARGET --prefix=$PREFIX
make
make install

Now this works and the binutils get installed in $PREFIX

GCC
configure --target=$TARGET --prefix=$PREFIX --without-headers\
--with-newlib --disable-shared --enable-languages=c
make all-gcc
make install-gcc

Linux, here I just do a make menuconfig to get headers
make ARCH=powerpc CROSS_COMPILE=sh4-linux- menuconfig
(save the kernel settings. then copy headers)
cp -r linux/include/linux $PREFIX/$TARGET/include
cp -r linux/include/asm-ppc $PREFIX/$TARGET/include/asm

And this works...

Now the problem lies with my glibc.  I do the following, which I got
from the instructions for building a sh4-linux target but with some
input for the embedded power pc stuff and it doesn't work.

CC=powerpc-linux-gcc AR=powerpc-linux-ar RANLIB=powerpc-linux-ranlib
configure --host=$TARGET --prefix=$PREFIX
--with-headers=$PREFIX/TARGET/include --disable-debug
--disable-profile --disable-sanity-checks
make

But this fails when I go to make it (where as when I do it for the sh4 it
works :(  )
Please keep in mind I don't know what the following means so I am posting
only the last bit of the output which should be relavent.

make[2]: Entering directory `/root/cross/glibc-2.2.5/misc'
powerpc-linux-gcc
syslog.c -c -O2 -Wall -Winline -Wstrict-prototypes -Wwrite-strings -g -mnew-
mnemonics -Wa,-mppc -mpowerpc      -I../include -I. -I/root/cross/build-glib
c/misc -I.. -I../libio  -I/root/cross/build-glibc -I../sysdeps/powerpc/elf -
I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux -I../sysdep
s/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman -I../sysdeps/unix/inet
 -I../sysdeps/unix/sysv -I../sysdeps/unix/powerpc -I../sysdeps/unix -I../sys
deps/posix -I../sysdeps/powerpc/fpu -I../sysdeps/powerpc -I../sysdeps/wordsi
ze-32 -I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 -I../sysdeps/p
owerpc/soft-fp -I../sysdeps/ieee754 -I../sysdeps/generic/elf -I../sysdeps/ge
neric  -nostdinc -isystem
/usr/local/powerpc/lib/gcc-lib/powerpc-linux/2.95.3/include -isystem
/usr/local/powerpc/powerpc-linux/include  -include
nclude/libc-symbols.h     -o /root/cross/build-glibc/misc/syslog.o
syslog.c: In function `vsyslog':
syslog.c:219: `cancel_handler' undeclared (first use in this function)
syslog.c:219: (Each undeclared identifier is reported only once
syslog.c:219: for each function it appears in.)
syslog.c:219: warning: type defaults to `int' in declaration of `__save_FCT'
syslog.c:272: called object is not a function
syslog.c: In function `openlog':
syslog.c:331: parse error before `)'
syslog.c:331: `__save_FCT' undeclared (first use in this function)
syslog.c:331: parse error before `)'
syslog.c:338: `__save_ARG' undeclared (first use in this function)
syslog.c: In function `closelog':
syslog.c:363: parse error before `)'
syslog.c:363: `__save_FCT' undeclared (first use in this function)
syslog.c:363: parse error before `)'
syslog.c:372: `__save_ARG' undeclared (first use in this function)
make[2]: *** [/root/cross/build-glibc/misc/syslog.o] Error 1
make[2]: Leaving directory `/root/cross/glibc-2.2.5/misc'
make[1]: *** [misc/subdir_lib] Error 2
make[1]: Leaving directory `/root/cross/glibc-2.2.5'
make: *** [all] Error 2


Any and all help would be appreciated.
Thank you,
Timothy Robb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
