Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7A7121007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 14:12:50 +1100 (EST)
Subject: Re: [PATCH] zlib: Optimize inffast when copying direct from output
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1257843644-8496-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <Received>
	<1257843644-8496-1-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Nov 2009 14:12:43 +1100
Message-ID: <1259032363.16367.108.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-10 at 10:00 +0100, Joakim Tjernlund wrote:
> JFFS2 uses lesser compression ratio and inflate always
> ends up in "copy direct from output" case.
> This patch tries to optimize the direct copy procedure.
> Uses get_unaligned() but only in one place.
> The copy loop just above this one can also use this
> optimization, but I havn't done so as I have not tested if it
> is a win there too.
> On my MPC8321 this is about 17% faster on my JFFS2 root FS
> than the original.
> ---
> 
>  Would like some testing of the PowerPC boot wrapper and
>  a LE target before sending it upstream.

Well, you should probably submit that patch to lkml then :-)

I'm not sure its going to work to use get_unaligned() like that on all
archs .. it might be definitely something to discuss on some more
appropriate mailing list.

Cheers,
Ben.

>  arch/powerpc/boot/Makefile |    4 ++-
>  lib/zlib_inflate/inffast.c |   48 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 9ae7b7e..98e4c4f 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -20,7 +20,7 @@
>  all: $(obj)/zImage
>  
>  BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> -		 -fno-strict-aliasing -Os -msoft-float -pipe \
> +		 -fno-strict-aliasing -Os -msoft-float -pipe -D__KERNEL__\
>  		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
>  		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
>  BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
> @@ -34,6 +34,8 @@ BOOTCFLAGS	+= -fno-stack-protector
>  endif
>  
>  BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
> +BOOTCFLAGS	+= -include include/linux/autoconf.h -Iarch/powerpc/include
> +BOOTCFLAGS	+= -Iinclude
>  
>  DTS_FLAGS	?= -p 1024
>  
> diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
> index 8550b0c..0c7fa3d 100644
> --- a/lib/zlib_inflate/inffast.c
> +++ b/lib/zlib_inflate/inffast.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/zutil.h>
> +#include <asm/unaligned.h>
>  #include "inftrees.h"
>  #include "inflate.h"
>  #include "inffast.h"
> @@ -24,9 +25,11 @@
>  #ifdef POSTINC
>  #  define OFF 0
>  #  define PUP(a) *(a)++
> +#  define UP_UNALIGNED(a) get_unaligned((a)++)
>  #else
>  #  define OFF 1
>  #  define PUP(a) *++(a)
> +#  define UP_UNALIGNED(a) get_unaligned(++(a))
>  #endif
>  
>  /*
> @@ -239,18 +242,41 @@ void inflate_fast(z_streamp strm, unsigned start)
>                      }
>                  }
>                  else {
> +		    unsigned short *sout;
> +		    unsigned long loops;
> +
>                      from = out - dist;          /* copy direct from output */
> -                    do {                        /* minimum length is three */
> -                        PUP(out) = PUP(from);
> -                        PUP(out) = PUP(from);
> -                        PUP(out) = PUP(from);
> -                        len -= 3;
> -                    } while (len > 2);
> -                    if (len) {
> -                        PUP(out) = PUP(from);
> -                        if (len > 1)
> -                            PUP(out) = PUP(from);
> -                    }
> +                    /* minimum length is three */
> +		    /* Align out addr */
> +		    if (!((long)(out - 1 + OFF)) & 1) {
> +			PUP(out) = PUP(from);
> +			len--;
> +		    }
> +		    sout = (unsigned short *)(out - OFF);
> +		    if (dist > 2 ) {
> +			unsigned short *sfrom;
> +
> +			sfrom = (unsigned short *)(from - OFF);
> +			loops = len >> 1;
> +			do
> +			    PUP(sout) = UP_UNALIGNED(sfrom);
> +			while (--loops);
> +			out = (unsigned char *)sout + OFF;
> +			from = (unsigned char *)sfrom + OFF;
> +		    } else { /* dist == 1 or dist == 2 */
> +			unsigned short pat16;
> +
> +			pat16 = *(sout-2+2*OFF);
> +			if (dist == 1)
> +			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff ) << 8);
> +			loops = len >> 1;
> +			do
> +			    PUP(sout) = pat16;
> +			while (--loops);
> +			out = (unsigned char *)sout + OFF;
> +		    }
> +		    if (len & 1)
> +			PUP(out) = PUP(from);
>                  }
>              }
>              else if ((op & 64) == 0) {          /* 2nd level distance code */
