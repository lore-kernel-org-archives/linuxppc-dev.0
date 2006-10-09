Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B3ECE67B22
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Oct 2006 16:56:33 +1000 (EST)
Date: Mon, 9 Oct 2006 16:56:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Cell timebase bug workaround
Message-Id: <20061009165629.4fa5813a.sfr@canb.auug.org.au>
In-Reply-To: <1160370623.14601.42.camel@localhost.localdomain>
References: <1160370623.14601.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__9_Oct_2006_16_56_29_+1000_1Ju+K14b7acMb+EQ"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__9_Oct_2006_16_56_29_+1000_1Ju+K14b7acMb+EQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 09 Oct 2006 15:10:22 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Index: linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-06 13:47:54.000000000 +1000
> +++ linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-10-09 13:28:54.000000000 +1000
> @@ -11,6 +11,8 @@
>   * as published by the Free Software Foundation; either version
>   * 2 of the License, or (at your option) any later version.
>   */
> +
> +#include <linux/config.h>

You don't need that (in fact someone just remoed them all).

>  #ifdef __ASSEMBLY__
>
> -#define BEGIN_FTR_SECTION		98:
> +#define BEGIN_FTR_SECTION_NESTED(label)	label:
> +#define BEGIN_FTR_SECTION		BEGIN_FTR_SECTION_NESTED(98)
>
>  #ifndef __powerpc64__
> -#define END_FTR_SECTION(msk, val)		\
> +#define END_FTR_SECTION_NESTED(msk, val, label) \
>  99:						\
>  	.section __ftr_fixup,"a";		\
>  	.align 2;				\
>  	.long msk;				\
>  	.long val;				\
> -	.long 98b;				\
> +	.long label##b;				\
>  	.long 99b;				\
>  	.previous
>  #else /* __powerpc64__ */
> -#define END_FTR_SECTION(msk, val)		\
> +#define END_FTR_SECTION_NESTED(msk, val, label) \
>  99:						\
>  	.section __ftr_fixup,"a";		\
>  	.align 3;				\
>  	.llong msk;				\
>  	.llong val;				\
> -	.llong 98b;				\
> +	.llong label##b;				\
>  	.llong 99b;	 			\
>  	.previous
>  #endif /* __powerpc64__ */
>
> +#define END_FTR_SECTION(msk, val)		\
> +	END_FTR_SECTION_NESTED(msk, val, 98)
> +

The above should be in a separate patch.

> +#ifdef CONFIG_PPC_CELL
> +#define MFTB(dest)			\
> +	mftb  dest;			\
> +BEGIN_FTR_SECTION;			\
> +	cmpwi dest,0;			\
> +	bne+  97f;			\
> +	mftb  dest;			\
> +97:					\
> +END_FTR_SECTION_IFSET(CPU_FTR_CELL_TB_BUG)

Why not branch back to the mftb if the lower word is zero (this would
also take care of the very unlikely "hitting the bug more than once" case
and the "normal" case would then not have to branch at all.  (And it uses
one less instruction.)

> +#ifdef CONFIG_PPC_CELL
> +#define mftb()		({unsigned long rval;				\
> +			asm volatile(					\
> +				"	mftb %0;\n"			\
> +				"98:	cmpwi %0,0;\n"			\
> +				"	bne+ 99f;\n"			\
> +				"	mftb %0;\n"			\
> +				"99:\n"					\

Ditto.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__9_Oct_2006_16_56_29_+1000_1Ju+K14b7acMb+EQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFKfKdFdBgD/zoJvwRAsPaAJ9M5cNdTDiQEId2hRwWNlK5zhO81QCfQP3U
bnkKxm2EbEyoF76/mxVWqkg=
=ktay
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Oct_2006_16_56_29_+1000_1Ju+K14b7acMb+EQ--
