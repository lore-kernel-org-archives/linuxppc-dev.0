Message-ID: <39084D22.417A2FC3@aminocom.com>
Date: Thu, 27 Apr 2000 14:22:26 +0000
From: Elizabeth Clarke <eclarke@aminocom.com>
MIME-Version: 1.0
To: Matt Porter <mmporter@home.com>
CC: linuxppc-dev@lists.linuxppc.org, linuxpp-embedded@lists.linuxppc.org
Subject: Re: glibc-2.1.2 cross-compile problem
References: <20000426002414.912D83C989@elph.research.canon.com.au> <3906FF25.4E9E6AEA@aminocom.com> <20000426120102.E27105@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> > /usr/local/src/gcc-2.95.2/gcc/xgcc -B/usr/local/src/gcc-2.95.2/gcc/
> > -B/usr/local/powerpc-linux/bin/ -c -DHAVE_CONFIG_H -g -O2 -I.
> > -I./../../include  choose-temp.c
> > choose-temp.c:29: stdio.h: No such file or directory
>
> Are you sure you followed the directions on my site?  You need to
> configure your build of gcc with "--with-newlib" then link to your
> kernel headers, then build glibc.

Yes... after all they are not complex instructions.

I sorted that problem (stdio.h missing) by copying the newlib headers
into /usr/local/powerpc-linux/include. So it gets past that now. But....

/usr/local/src/gcc-2.95.2/gcc/xgcc -B/usr/local/src/gcc-2.95.2/gcc/
-B/usr/local/powerpc-linux/bin/ -c -g -O2 -I. -I. -D_IO_MTSAFE_IO
iogetline.c -o pic/iogetline.o
/usr/local/src/gcc-2.95.2/gcc/xgcc -B/usr/local/src/gcc-2.95.2/gcc/
-B/usr/local/powerpc-linux/bin/ -c -g -O2 -I. -I. -D_IO_MTSAFE_IO
iogetline.c
In file included from iolibio.h:1,
                 from libioP.h:47,
                 from iogetline.c:26:
libio.h:30: _G_config.h: No such file or directory
make[1]: *** [iogetline.o] Error 1
make[1]: Leaving directory
`/usr/local/src/gcc-2.95.2/powerpc-linux/libio'

So now I'm where Graham Stoney was at Date: Thu, 12 Aug 1999 14:34:44
-0400.
I *think* it is looking for _G_config.h from my host includes, but it
simply isn't putting the path on the command line. Which I think it did
at one point, or at least on of those -I. was -I./../../include.
Arghh I'm must be going mad, or stupid. Surely its should not be as bad
as this?

Any help very much appreciated!
Beth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
