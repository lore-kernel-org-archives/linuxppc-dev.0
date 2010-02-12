Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 08D2CB7CD5
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 21:51:56 +1100 (EST)
Date: Fri, 12 Feb 2010 11:33:02 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Endian/__BYTE_ORDER question
In-Reply-To: <OFC480F58E.3391EA2B-ONC12576C7.007E7F6B-C12576C7.007F3EE7@transmode.se>
Message-ID: <alpine.LRH.2.00.1002121132010.3816@mink.sonytel.be>
References: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
	<20100211163328.GC16348@lisas.de>
	<OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.005CF730@transmode.se>
	<20100211213900.CF5ECE8CCE4@gemini.denx.de>
	<OFC480F58E.3391EA2B-ONC12576C7.007E7F6B-C12576C7.007F3EE7@transmode.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 12 Feb 2010, Joakim Tjernlund wrote:
> Wolfgang Denk <wd@denx.de> wrote on 2010/02/11 22:39:00:
> > Dear Joakim Tjernlund,
> >
> > In message <OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.
> > 005CF730@transmode.se> you wrote:
> > >
> > > > I have no idea how it is actually done in the kernel code... but gc=
c
> > > > defines it:
> > > >
> > > > gcc -dM -E -x c - <<<'' | grep ENDIAN
> > > > #define __BIG_ENDIAN__ 1
> > > > #define _BIG_ENDIAN 1
> > >
> > > That doesn't define __BYTE_ORDER. Try the same gcc command
> > > on a file that #includes <stdlib.h> and you will get both
> > > __BIG_ENDIAN and __LITTLE_ENDIAN
> >
> > For me this appears to work:
> >
> > On x86:
> >
> >    $ echo '#include <stdlib.h>' | gcc -dM -E -x c - | grep ENDIAN
> >    #define _ENDIAN_H 1
> >    #define PDP_ENDIAN __PDP_ENDIAN
> >    #define __PDP_ENDIAN 3412
> >    #define BIG_ENDIAN __BIG_ENDIAN
> >    #define __BYTE_ORDER __LITTLE_ENDIAN
> >    #define __LITTLE_ENDIAN 1234
> >    #define __BIG_ENDIAN 4321
> >    #define LITTLE_ENDIAN __LITTLE_ENDIAN
> >
> > On PowerPC:
> >
> >    $ echo '#include <stdlib.h>' | gcc -dM -E -x c - | grep ENDIAN
> >    #define __BIG_ENDIAN__ 1
> >    #define __PDP_ENDIAN 3412
> >    #define __LITTLE_ENDIAN 1234
> >    #define BIG_ENDIAN __BIG_ENDIAN
> >    #define _BIG_ENDIAN 1
> >    #define __BYTE_ORDER __BIG_ENDIAN
> >    #define _ENDIAN_H 1
> >    #define __BIG_ENDIAN 4321
> >    #define PDP_ENDIAN __PDP_ENDIAN
> >    #define LITTLE_ENDIAN __LITTLE_ENDIAN
> >
> > In both cases __BYTE_ORDER is set to a sane value.
>=20
> Yes, but that was not what I meant. If you look closer you see that both
> __BIG_ENDIAN and __LITTLE_ENDIAN are defined in each compiler. This means
> you cannot use these two defines directly to tell if your arch is BE or L=
E.

The proper tests are:
  - #if __BYTE_ORDER =3D=3D __BIG_ENDIAN
  - #if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
i.e. don't just test for the presence of __BIG_ENDIAN or __LITTLE_ENDIAN.

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
Fortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
