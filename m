Message-Id: <5.1.0.14.0.20011030095652.02d84ec0@pop.gmx.de>
Date: Tue, 30 Oct 2001 10:00:44 +0800
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
From: Michael Habermann <MHabermann@gmx.de>
Subject: RE: Reducing glibc with mklibs.sh
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4D414C7E@mail.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:36 PM 10/29/2001 -0500, Jean-Denis Boyer wrote:
>In your script:
> > cp *.map ../lib/
>might be bad, because the makefile of glibc produces libm.map,
>while mklibs.sh looks for libm_pic.map (the name differs).

Sorry for having posted this buggy script. Here's the correct one:
---
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
#mklibs.shcp
#copy pic files to ../lib/
cp `find -name "*_pic.a"` ../lib/

#rename *.map file to ../lib/*_pic.map
for i  in *.map; do
     cp $i ../lib/${i%%.map}_pic.map
done

#libc requires special handling
mkdir ../lib/libc_pic
cp elf/interp.os ../lib/libc_pic/interp.o
cp elf/soinit.os ../lib/libc_pic/soinit.o
cp elf/sofini.os ../lib/libc_pic/sofini.o

#libm doesn't work
rm -f ../lib/libc.map
rm -f ../lib/libc_pic.a
---


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
