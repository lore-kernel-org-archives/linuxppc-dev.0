Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC 2/2] powerpc: copy_4K_page tweaked for Cell - add CPU feature
From: Michael Ellerman <michael@ellerman.id.au>
To: Mark Nelson <markn@au1.ibm.com>
In-Reply-To: <200808141618.23818.markn@au1.ibm.com>
References: <200808141618.23818.markn@au1.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HcV0icOVyUgLhWG+ckA4"
Date: Thu, 14 Aug 2008 20:51:35 +1000
Message-Id: <1218711095.10673.4.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HcV0icOVyUgLhWG+ckA4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-08-14 at 16:18 +1000, Mark Nelson wrote:
> Add a new CPU feature, CPU_FTR_CP_USE_DCBTZ, to be added to the CPUs that=
 benefit
> from having dcbt and dcbz instructions used in copy_4K_page(). So far Cel=
l, PPC970
> and Power4 benefit.
>=20
> This way all the other 64bit powerpc chips will have the whole prefetchin=
g loop
> nop'ed out.

> Index: upstream/arch/powerpc/lib/copypage_64.S
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- upstream.orig/arch/powerpc/lib/copypage_64.S
> +++ upstream/arch/powerpc/lib/copypage_64.S
> @@ -18,6 +18,7 @@ PPC64_CACHES:
> =20
>  _GLOBAL(copy_4K_page)
>  	li	r5,4096		/* 4K page size */
> +BEGIN_FTR_SECTION
>  	ld      r10,PPC64_CACHES@toc(r2)
>  	lwz	r11,DCACHEL1LOGLINESIZE(r10)	/* log2 of cache line size */
>  	lwz     r12,DCACHEL1LINESIZE(r10)	/* Get cache line size */
> @@ -30,7 +31,7 @@ setup:
>  	dcbz	r9,r3
>  	add	r9,r9,r12
>  	bdnz	setup
> -
> +END_FTR_SECTION_IFSET(CPU_FTR_CP_USE_DCBTZ)
>  	addi	r3,r3,-8
>  	srdi    r8,r5,7		/* page is copied in 128 byte strides */
>  	addi	r8,r8,-1	/* one stride copied outside loop */

Instead of nop'ing it out, we could use an alternative feature section
to either run it or jump over it. It would look something like:


_GLOBAL(copy_4K_page)
BEGIN_FTR_SECTION
        li      r5,4096         /* 4K page size */
        ld      r10,PPC64_CACHES@toc(r2)
        lwz     r11,DCACHEL1LOGLINESIZE(r10)    /* log2 of cache line size =
*/
        lwz     r12,DCACHEL1LINESIZE(r10)       /* Get cache line size */
        li      r9,0
        srd     r8,r5,r11

        mtctr   r8
setup:
        dcbt    r9,r4
        dcbz    r9,r3
        add     r9,r9,r12
        bdnz    setup
FTR_SECTION_ELSE
	b	1f
ALT_FTR_SECTION_END_IFSET(CPU_FTR_CP_USE_DCBTZ)
1:
        addi    r3,r3,-8

So in the no-dcbtz case you'd get a branch instead of 11 nops.

Of course you'd need to benchmark it to see if skipping the nops is
better than executing them ;P

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HcV0icOVyUgLhWG+ckA4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIpA43dSjSd0sB4dIRAu+3AJ9yWUVYm7ZpSOlgmzIFw7XwxOuV+QCdElWQ
gDG8vxifUSwM8ljW7/ghiFI=
=ZwcH
-----END PGP SIGNATURE-----

--=-HcV0icOVyUgLhWG+ckA4--
