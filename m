Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21D53B7CE2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 10:10:06 +1100 (EST)
In-Reply-To: <20100211213900.CF5ECE8CCE4@gemini.denx.de>
References: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
	<20100211163328.GC16348@lisas.de>
	<OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.005CF730@transmode.se>
	<20100211213900.CF5ECE8CCE4@gemini.denx.de>
Subject: Re: Endian/__BYTE_ORDER question
To: Wolfgang Denk <wd@denx.de>
Message-ID: <OFC480F58E.3391EA2B-ONC12576C7.007E7F6B-C12576C7.007F3EE7@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 12 Feb 2010 00:09:51 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Denk <wd@denx.de> wrote on 2010/02/11 22:39:00:
>
> Dear Joakim Tjernlund,
>
> In message <OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.
> 005CF730@transmode.se> you wrote:
> >
> > > I have no idea how it is actually done in the kernel code... but gcc
> > > defines it:
> > >
> > > gcc -dM -E -x c - <<<'' | grep ENDIAN
> > > #define __BIG_ENDIAN__ 1
> > > #define _BIG_ENDIAN 1
> >
> > That doesn't define __BYTE_ORDER. Try the same gcc command
> > on a file that #includes <stdlib.h> and you will get both
> > __BIG_ENDIAN and __LITTLE_ENDIAN
>
> For me this appears to work:
>
> On x86:
>
>    $ echo '#include <stdlib.h>' | gcc -dM -E -x c - | grep ENDIAN
>    #define _ENDIAN_H 1
>    #define PDP_ENDIAN __PDP_ENDIAN
>    #define __PDP_ENDIAN 3412
>    #define BIG_ENDIAN __BIG_ENDIAN
>    #define __BYTE_ORDER __LITTLE_ENDIAN
>    #define __LITTLE_ENDIAN 1234
>    #define __BIG_ENDIAN 4321
>    #define LITTLE_ENDIAN __LITTLE_ENDIAN
>
> On PowerPC:
>
>    $ echo '#include <stdlib.h>' | gcc -dM -E -x c - | grep ENDIAN
>    #define __BIG_ENDIAN__ 1
>    #define __PDP_ENDIAN 3412
>    #define __LITTLE_ENDIAN 1234
>    #define BIG_ENDIAN __BIG_ENDIAN
>    #define _BIG_ENDIAN 1
>    #define __BYTE_ORDER __BIG_ENDIAN
>    #define _ENDIAN_H 1
>    #define __BIG_ENDIAN 4321
>    #define PDP_ENDIAN __PDP_ENDIAN
>    #define LITTLE_ENDIAN __LITTLE_ENDIAN
>
> In both cases __BYTE_ORDER is set to a sane value.

Yes, but that was not what I meant. If you look closer you see that both
__BIG_ENDIAN and __LITTLE_ENDIAN are defined in each compiler. This means
you cannot use these two defines directly to tell if your arch is BE or LE.
Guess what the kernel uses :(

I think the kernel should #define __BYTE_ORDER properly so one
can use __BYTE_ORDER in the kernel too.
Just grep for __BYTE_ORDER in the linux tree to see some ugly
workarounds just because __BYTE_ORDER isn't defined.

 Jocke
