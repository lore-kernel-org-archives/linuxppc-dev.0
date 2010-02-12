Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC0BFB7CA1
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 21:51:02 +1100 (EST)
In-Reply-To: <alpine.LRH.2.00.1002121132010.3816@mink.sonytel.be>
References: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
	<20100211163328.GC16348@lisas.de>
	<OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.005CF730@transmode.se>
	<20100211213900.CF5ECE8CCE4@gemini.denx.de>
	<OFC480F58E.3391EA2B-ONC12576C7.007E7F6B-C12576C7.007F3EE7@transmode.se>
	<alpine.LRH.2.00.1002121132010.3816@mink.sonytel.be>
Subject: Re: Endian/__BYTE_ORDER question
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Message-ID: <OF3D2BF65F.79433240-ONC12576C8.003A3DC3-C12576C8.003B6239@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 12 Feb 2010 11:48:37 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, geert@sonytel.be, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

geert@sonytel.be wrote on 2010/02/12 11:33:02:
>
> On Fri, 12 Feb 2010, Joakim Tjernlund wrote:
> > Wolfgang Denk <wd@denx.de> wrote on 2010/02/11 22:39:00:
> > > Dear Joakim Tjernlund,
> > >
> > > In message <OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.
> > > 005CF730@transmode.se> you wrote:
> > > >
> > > > > I have no idea how it is actually done in the kernel code... but gcc
> > > > > defines it:
> > > > >
> > > > > gcc -dM -E -x c - <<<'' | grep ENDIAN
> > > > > #define __BIG_ENDIAN__ 1
> > > > > #define _BIG_ENDIAN 1
> > > >
> > > > That doesn't define __BYTE_ORDER. Try the same gcc command
> > > > on a file that #includes <stdlib.h> and you will get both
> > > > __BIG_ENDIAN and __LITTLE_ENDIAN
> > >
> > > For me this appears to work:
> > >
> > > On x86:
> > >
> > >    $ echo '#include <stdlib.h>' | gcc -dM -E -x c - | grep ENDIAN
> > >    #define _ENDIAN_H 1
> > >    #define PDP_ENDIAN __PDP_ENDIAN
> > >    #define __PDP_ENDIAN 3412
> > >    #define BIG_ENDIAN __BIG_ENDIAN
> > >    #define __BYTE_ORDER __LITTLE_ENDIAN
> > >    #define __LITTLE_ENDIAN 1234
> > >    #define __BIG_ENDIAN 4321
> > >    #define LITTLE_ENDIAN __LITTLE_ENDIAN
> > >
> > > On PowerPC:
> > >
> > >    $ echo '#include <stdlib.h>' | gcc -dM -E -x c - | grep ENDIAN
> > >    #define __BIG_ENDIAN__ 1
> > >    #define __PDP_ENDIAN 3412
> > >    #define __LITTLE_ENDIAN 1234
> > >    #define BIG_ENDIAN __BIG_ENDIAN
> > >    #define _BIG_ENDIAN 1
> > >    #define __BYTE_ORDER __BIG_ENDIAN
> > >    #define _ENDIAN_H 1
> > >    #define __BIG_ENDIAN 4321
> > >    #define PDP_ENDIAN __PDP_ENDIAN
> > >    #define LITTLE_ENDIAN __LITTLE_ENDIAN
> > >
> > > In both cases __BYTE_ORDER is set to a sane value.
> >
> > Yes, but that was not what I meant. If you look closer you see that both
> > __BIG_ENDIAN and __LITTLE_ENDIAN are defined in each compiler. This means
> > you cannot use these two defines directly to tell if your arch is BE or LE.
>
> The proper tests are:
>   - #if __BYTE_ORDER == __BIG_ENDIAN
>   - #if __BYTE_ORDER == __LITTLE_ENDIAN
> i.e. don't just test for the presence of __BIG_ENDIAN or __LITTLE_ENDIAN.

Yes, but my point is that __BYTE_ORDER isn't defined in the kernel so
there the correct test actually is to test __BIG_ENDIAN/__LITTLE_ENDIAN
directly. Look at lib/crc32.c, it also includes some test code
so one can verify the algo. If you enable the test code and move
it all to user space(some minor hacks needed to do that) one fail
the test on BE machines because both __BIG_ENDIAN and __LITTLE_ENDIAN
are defined in user space so the crc code thinks it still is LE.

There is some ugly code that messes with __BYTE_ORDER in the kernel,
all just because the kernel doesn't define __BYTE_ORDER. Is there
some rule that prevents the kernel to define __BYTE_ORDER?

    Jocke
   Jocke
