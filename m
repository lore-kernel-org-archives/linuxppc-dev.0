Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0976DB7D8E
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 23:18:46 +1100 (EST)
In-Reply-To: <OF0311C7C7.F02F52A9-ONC12576B6.002D4A11-C12576B6.002DC689@transmode.se>
References: <20100112022150.GE12666@kryten>		<20100112140136.c8ccc357.sfr@canb.auug.org.au>
	<OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>	<FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
	<1263412963.724.223.camel@pasglop>	<OF20873087.ECC43BEB-ONC12576AB.0029EA9A-C12576AB.002AC5CA@transmode.se>
	<1263459431.724.352.camel@pasglop>
	<OF0311C7C7.F02F52A9-ONC12576B6.002D4A11-C12576B6.002DC689@transmode.se>
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location of
	autoconf.h
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OFEE6723FF.0EB62041-ONC12576B8.004341B9-C12576B8.00437343@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 27 Jan 2010 13:16:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Roel Kluin <roel.kluin@gmail.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Richard Purdie <rpurdie@rpsys.net>, Anton Blanchard <anton@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2010/01/14 09:57:11:
> >
> >
> > > Seen it now as it is in Linus tree:
> > >
> > > 1) IMHO it would have been nicer to use #ifdef __KERNEL__
> > >    instead of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >    as then arches that don't define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >    at all will never use the new optimization or was that what you intended?
> >
> > No, that was on purpose. If an arch doesn't have efficient unaligned
> > accesses, then they should not use the optimization since it will result
> > in a lot of unaligned accesses :-) In which case they are better off
> > falling back to the old byte-by-byte method.
> >
> > The advantage also of doing it this way is that x86 will benefit from
> > the optimisation at boot time since it does include autoconf.h in its
> > boot wrapper (and deals with unaligned accesses just fine at any time)
> > though something tells me that it won't make much of a difference in
> > performances on any recent x86 (it might on some of the newer low power
> > embedded ones, I don't know for sure).
> >
> > > 2) You really should add an comment in the Makefile about not using
> > >    autoconf.h/-D__KERNEL__
> >
> > That's true :-)
>
> So I fixed the new inflate to be endian independent and now
> all arches can use the optimized version. Here goes:

No comments so far, I guess that is a good thing :)
Ben, Andrew could either of you carry this patch for me?

      Jocke

>
>
> From 4e769486e2520e34f532a2d4bf13ab13f05e3e76 Mon Sep 17 00:00:00 2001
> From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Date: Sun, 24 Jan 2010 11:12:56 +0100
> Subject: [PATCH] zlib: Make new optimized inflate endian independent
>
> Commit 6846ee5ca68d81e6baccf0d56221d7a00c1be18b made the
> new optimized inflate only available on arch's that
> define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS. This
> fixes it by defining our own endian independent versions
> of unaligned access.
>
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
>  lib/zlib_inflate/inffast.c |   70 +++++++++++++++++++-------------------------
>  1 files changed, 30 insertions(+), 40 deletions(-)
>
> diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
> index 215447c..5de16f4 100644
> --- a/lib/zlib_inflate/inffast.c
> +++ b/lib/zlib_inflate/inffast.c
> @@ -8,21 +8,6 @@
>  #include "inflate.h"
>  #include "inffast.h"
>
> -/* Only do the unaligned "Faster" variant when
> - * CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set
> - *
> - * On powerpc, it won't be as we don't include autoconf.h
> - * automatically for the boot wrapper, which is intended as
> - * we run in an environment where we may not be able to deal
> - * with (even rare) alignment faults. In addition, we do not
> - * define __KERNEL__ for arch/powerpc/boot unlike x86
> - */
> -
> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> -#include <asm/unaligned.h>
> -#include <asm/byteorder.h>
> -#endif
> -
>  #ifndef ASMINF
>
>  /* Allow machine dependent optimization for post-increment or pre-increment.
> @@ -36,14 +21,31 @@
>     - Pentium III (Anderson)
>     - M68060 (Nikl)
>   */
> +union uu {
> +   unsigned short us;
> +   unsigned char b[2];
> +};
> +
> +/* Endian independed version */
> +static inline unsigned short
> +get_unaligned16(const unsigned short *p)
> +{
> +   union uu  mm;
> +   unsigned char *b = (unsigned char *)p;
> +
> +   mm.b[0] = b[0];
> +   mm.b[1] = b[1];
> +   return mm.us;
> +}
> +
>  #ifdef POSTINC
>  #  define OFF 0
>  #  define PUP(a) *(a)++
> -#  define UP_UNALIGNED(a) get_unaligned((a)++)
> +#  define UP_UNALIGNED(a) get_unaligned16((a)++)
>  #else
>  #  define OFF 1
>  #  define PUP(a) *++(a)
> -#  define UP_UNALIGNED(a) get_unaligned(++(a))
> +#  define UP_UNALIGNED(a) get_unaligned16(++(a))
>  #endif
>
>  /*
> @@ -256,7 +258,6 @@ void inflate_fast(z_streamp strm, unsigned start)
>                      }
>                  }
>                  else {
> -#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>            unsigned short *sout;
>            unsigned long loops;
>
> @@ -274,7 +275,11 @@ void inflate_fast(z_streamp strm, unsigned start)
>           sfrom = (unsigned short *)(from - OFF);
>           loops = len >> 1;
>           do
> +#ifdef  CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +             PUP(sout) = PUP(sfrom);
> +#else
>               PUP(sout) = UP_UNALIGNED(sfrom);
> +#endif
>           while (--loops);
>           out = (unsigned char *)sout + OFF;
>           from = (unsigned char *)sfrom + OFF;
> @@ -282,14 +287,13 @@ void inflate_fast(z_streamp strm, unsigned start)
>           unsigned short pat16;
>
>           pat16 = *(sout-2+2*OFF);
> -         if (dist == 1)
> -#if defined(__BIG_ENDIAN)
> -             pat16 = (pat16 & 0xff) | ((pat16 & 0xff) << 8);
> -#elif defined(__LITTLE_ENDIAN)
> -             pat16 = (pat16 & 0xff00) | ((pat16 & 0xff00) >> 8);
> -#else
> -#error __BIG_ENDIAN nor __LITTLE_ENDIAN is defined
> -#endif
> +         if (dist == 1) {
> +            union uu mm;
> +            /* copy one char pattern to both bytes */
> +            mm.us = pat16;
> +            mm.b[0] = mm.b[1];
> +            pat16 = mm.us;
> +         }
>           loops = len >> 1;
>           do
>               PUP(sout) = pat16;
> @@ -298,20 +302,6 @@ void inflate_fast(z_streamp strm, unsigned start)
>            }
>            if (len & 1)
>           PUP(out) = PUP(from);
> -#else /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
> -                    from = out - dist;          /* copy direct from output */
> -                    do {                        /* minimum length is three */
> -          PUP(out) = PUP(from);
> -          PUP(out) = PUP(from);
> -          PUP(out) = PUP(from);
> -          len -= 3;
> -                    } while (len > 2);
> -                    if (len) {
> -          PUP(out) = PUP(from);
> -          if (len > 1)
> -              PUP(out) = PUP(from);
> -                    }
> -#endif /* !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
>                  }
>              }
>              else if ((op & 64) == 0) {          /* 2nd level distance code */
> --
> 1.6.4.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
