Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E031B679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 11:03:33 +1000 (EST)
Date: Tue, 15 Aug 2006 11:03:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH] powerpc: Instrument Hypervisor Calls
Message-Id: <20060815110319.5f34417a.sfr@canb.auug.org.au>
In-Reply-To: <20060814232144.GG3213@w-mikek2.ibm.com>
References: <20060814232144.GG3213@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_Aug_2006_11_03_19_+1000_aZoQkw6J0q/k8eXf"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_Aug_2006_11_03_19_+1000_aZoQkw6J0q/k8eXf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Aug 2006 16:21:44 -0700 Mike Kravetz <kravetz@us.ibm.com> wrote:
>
> diff -Naupr powerpc2/arch/powerpc/platforms/pseries/hvCall.S powerpc2.wor=
k/arch/powerpc/platforms/pseries/hvCall.S
> --- powerpc2/arch/powerpc/platforms/pseries/hvCall.S	2006-08-14 18:00:55.=
000000000 +0000
> +++ powerpc2.work/arch/powerpc/platforms/pseries/hvCall.S	2006-08-14 22:1=
7:04.000000000 +0000
> @@ -10,9 +10,66 @@
>  #include <asm/hvcall.h>
>  #include <asm/processor.h>
>  #include <asm/ppc_asm.h>
> +#include <asm/asm-offsets.h>
>  =09
>  #define STK_PARM(i)     (48 + ((i)-3)*8)
> =20
> +#ifdef CONFIG_HCALL_STATS
> +/*
> + * precall must preserve all registers.  use unused STK_PARM()
> + * areas to save snapshots and opcode.
> + */
> +#define HCALL_INST_PRECALL					\
> +	std	r3,STK_PARM(r3)(r1);	/* save opcode */	\
> +	mftb	r3;			/* get timebase and */	\
> +	std     r3,STK_PARM(r5)(r1);	/* save for later */	\
> +BEGIN_FTR_SECTION;						\
> +	mfspr	r3,SPRN_PURR;		/* get PURR and */	\
> +END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
> +	std	r3,STK_PARM(r6)(r1);	/* save for later */	\

So if we have no PURR, we use the TB value (this is fine)

> +	ld	r3,STK_PARM(r3)(r1);	/* opcode back in r3 */
> +=09
> +/*
> + * postcall is performed immediately before function return which
> + * allows liberal use of volital registers.
> + */
> +#define HCALL_INST_POSTCALL					\
> +	/* get time and PURR snapshots after hcall */		\
> +	mftb	r7;			/* timebase after */	\
> +BEGIN_FTR_SECTION;						\
> +	mfspr	r8,SPRN_PURR;		/* PURR after */	\
> +END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\
> +								\
> +	/* calculate time and PURR deltas for call */		\
> +	ld	r5,STK_PARM(r5)(r1);	/* timebase before */	\
> +	subf	r5,r5,r7;					\
> +	ld	r6,STK_PARM(r6)(r1);	/* PURR before */	\
> +	subf	r6,r6,r8;					\

But here, if we have no PURR we produce random numbers.  Maybe you should
reuse the TB value so the values reported may make some sense.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_Aug_2006_11_03_19_+1000_aZoQkw6J0q/k8eXf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE4R1dFdBgD/zoJvwRAhgBAJ0aJm8TDUGlPT/8PYstaDW72A4BzQCdEHsH
fz9n4tjD0F4mJ+rvAZBtDHw=
=l/t2
-----END PGP SIGNATURE-----

--Signature=_Tue__15_Aug_2006_11_03_19_+1000_aZoQkw6J0q/k8eXf--
