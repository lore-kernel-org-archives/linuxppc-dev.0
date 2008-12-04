Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 00811DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 17:17:40 +1100 (EST)
Date: Thu, 4 Dec 2008 17:17:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc: Split mmu_context handling
Message-Id: <20081204171733.ad200e55.sfr@canb.auug.org.au>
In-Reply-To: <20081204054228.E8FE6DDE0F@ozlabs.org>
References: <20081204054228.E8FE6DDE0F@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__4_Dec_2008_17_17_33_+1100_DbwEMy2Ft_H5m4Cw"
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__4_Dec_2008_17_17_33_+1100_DbwEMy2Ft_H5m4Cw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 04 Dec 2008 16:41:48 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> --- linux-work.orig/arch/powerpc/include/asm/bug.h	2008-12-03 13:50:01.00=
0000000 +1100
> +++ linux-work/arch/powerpc/include/asm/bug.h	2008-12-03 13:50:18.0000000=
00 +1100
> @@ -26,7 +26,7 @@
>  	 .previous
>  .endm
>  #else
> - .macro EMIT_BUG_ENTRY addr,file,line,flags
> +.macro EMIT_BUG_ENTRY addr,file,line,flags

Please don't make unrelated trivial fixups - they just make us look hard
to see if something really changed.

> -/*
> - * switch_mm is the entry point called from the architecture independent
> +/* switch_mm is the entry point called from the architecture independent

The same goes for just changing the comment style away from the usual ...

> -/*
> - * After we have set current->mm to a new value, this activates
> +/* After we have set current->mm to a new value, this activates

Ditto

> --- linux-work.orig/arch/powerpc/kernel/head_32.S	2008-12-03 13:50:01.000=
000000 +1100
> +++ linux-work/arch/powerpc/kernel/head_32.S	2008-12-03 13:50:18.00000000=
0 +1100
> @@ -1050,7 +1051,7 @@ start_here:
>  	 * We do this here because we know the mmu is disabled, and
>  	 * will be enabled for real in just a few instructions.
>  	 */
> -	lis	r5, abatron_pteptrs@h
> +	lis	r5, abatron_pteptrs@h\
                                     ^
Is this right?

> +++ linux-work/arch/powerpc/mm/mmu_context_hash32.c	2008-12-03 13:50:18.0=
00000000 +1100
> +/*
> + * This function defines the mapping from contexts to VSIDs (virtual
> + * segment IDs).  We use a skew on both the context and the high 4 bits
> + * of the 32-bit virtual address (the "effective segment ID") in order
> + * to spread out the entries in the MMU hash table.  Note, if this
> + * function is changed then arch/ppc/mm/hashtable.S will have to be
> + * changed to correspond.
> + */
> +#define CTX_TO_VSID(ctx, va)	(((ctx) * (897 * 16) + ((va) >> 28) * 0x111=
) \
> +				 & 0xffffff)

Any reason this is not a static inline function?  Hmmm, actually it
doesn't look like it is used anywhere ... I guess its just for
documentation?

> +++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2008-12-03 13:50:18.0=
00000000 +1100
> +#ifdef CONFIG_8xx
> +#define NO_CONTEXT      	16
> +#define LAST_CONTEXT    	15
> +#define FIRST_CONTEXT    	0
> +
> +#elif defined(CONFIG_4xx)
> +#define NO_CONTEXT      	256
> +#define LAST_CONTEXT    	255
> +#define FIRST_CONTEXT    	1
> +
> +#elif defined(CONFIG_E200) || defined(CONFIG_E500)
> +#define NO_CONTEXT      	256
> +#define LAST_CONTEXT    	255
> +#define FIRST_CONTEXT    	1

Why not combine these last two?

> +static unsigned long next_mmu_context;

> +	/* free up context `next_mmu_context' */
> +	/* if we shouldn't free context 0, don't... */
> +	if (next_mmu_context < FIRST_CONTEXT)

If FIRST_CONTEXT is 0, this will generate a compiler warning (as
next_mmu_context can't be < 0).

> +config PPC_MMU_NOHASH_32
> +	def_bool y
> +	depends on PPC_MMU_NOHASH && PPC32
> +
> +config PPC_MMU_NOHASH_64
> +	def_bool y
> +	depends on PPC_MMU_NOHASH && PPC64

Neither of these are used anywhere.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__4_Dec_2008_17_17_33_+1100_DbwEMy2Ft_H5m4Cw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk3df0ACgkQjjKRsyhoI8x2egCeImW/v9HF2LrIzpm7bTgGqBJr
bakAoKFoAPu9m1xLJbkLeAr0xIZCGMD0
=z8r3
-----END PGP SIGNATURE-----

--Signature=_Thu__4_Dec_2008_17_17_33_+1100_DbwEMy2Ft_H5m4Cw--
