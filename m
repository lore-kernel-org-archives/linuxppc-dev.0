Message-Id: <5.1.0.14.0.20011024095739.02d78c50@pop.gmx.de>
Date: Wed, 24 Oct 2001 10:04:06 +0800
To: linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: RE: Reducing glibc with mklibs.sh
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4D414C53@mail.mediatrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:07 AM 10/18/2001 -0400, Jean-Denis Boyer wrote:

>A couple of things are missing in your configuration for mklibs.sh
>to properly work. I spent many hours finding what was the exact
>configuration to have mklibs.sh properly works.

Thank you very much, it worked in exactly this way. I could reduce my
libc-2.2.2 from 1.1 MB to 500 kB now.

For the other people trying this here is my script I execute after
compiling and installing  glibc 2.2.2:

---
#!/bin/sh
cp libc_pic.a ../lib/
cp libc.map ../lib/libc_pic.map
mkdir ../lib/libc_pic
cp elf/interp.os ../lib/libc_pic/interp.o
cp elf/soinit.os ../lib/libc_pic/soinit.o
cp elf/sofini.os ../lib/libc_pic/sofini.o
---



>Note: I successfully reduced libpthread.so, also.


How have you done the libthread? Standard compilation for glibc produces
_pic only for libc on my system. My libm is still quite large.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
