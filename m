Message-Id: <5.1.0.14.0.20011026092300.02d798e0@pop.gmx.de>
Date: Fri, 26 Oct 2001 09:33:20 +0800
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
From: Michael Habermann <MHabermann@gmx.de>
Subject: RE: Reducing glibc with mklibs.sh
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4D414C66@mail.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:16 AM 10/24/2001 -0400, Jean-Denis Boyer wrote:
>If the linuxthreads add-on is enabled in your glibc configuration, that
>should produce pic & map files, in the following manner:
>   ./linuxthreads/libpthread_pic.a
>   ./libpthread.map

I must apologize, they have been there. (I used accidentally find -name
*_pic.a)

Maybe you can help me another time (I'm lost when it get's to the linker).

It works when having only the libc pic file, but when adding libm_pic.a, I
get the following error:
++ echo :/usr/local/powerpc-linux/lib
++ sed -e 's/::*/:/g' -e 's/^://' -e 's/:$//' -e 's/:/ -L/g'
++ cat /tmp/,mklibs.11755/lib-dependencies
++ sed 's/^/-l/'
+ powerpc-linux-gcc -nostdlib -nostartfiles -shared
-Wl,-soname=libm-2.2.2.so -uceil -ufloor -ulog10 -upow -o
/tmp/,mklibs.11755/lib-so /usr/local/powerpc-linux/lib/libm_pic.a
-L/ppcroot/lib -L/usr/local/powerpc-linux/lib -lc
/usr/local/powerpc-linux/bin/ld: /tmp/,mklibs.11755/lib-so: undefined
versioned symbol name feraiseexcept@GLIBC_2.1
/usr/local/powerpc-linux/bin/ld: failed to set dynamic section sizes: Bad value
collect2: ld returned 1 exit status
+ echo ./mklibs.sh: install-small-lib: powerpc-linux-gcc or
powerpc-linux-objcopy failed.
./mklibs.sh: install-small-lib: powerpc-linux-gcc or powerpc-linux-objcopy
failed.
+ exit 1

That's my build script:
---
#!/bin/sh

make clean
CC=powerpc-linux-gcc \
AR=powerpc-linux-ar \
RANLIB=powerpc-linux-ranlib \
CFLAGS="-Os -DNDEBUG" \
./configure \
--enable-kernel=2.4.4 \
--disable-profile \
--host=powerpc-linux \
--enable-add-ons=linuxthreads \
--with-headers=/usr/local/powerpc-linux/include \
--prefix=

make
make install_root=/usr/local/powerpc-linux install

#Prepare the lib directory for reducing the standard library size with
#mklibs.sh
cp *.map ../lib/
cp `find -name "*_pic.a"` ../lib/
#libc requires special handling
mkdir ../lib/libc_pic
cp elf/interp.os ../lib/libc_pic/interp.o
cp elf/soinit.os ../lib/libc_pic/soinit.o
cp elf/sofini.os ../lib/libc_pic/sofini.o
---


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
