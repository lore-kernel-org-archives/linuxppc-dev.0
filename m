Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/4] powerpc: consolidate feature fixup code
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1160641793.4792.133.camel@localhost.localdomain>
References: <1160641793.4792.133.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-909da/iKFkPpqryxa0XI"
Date: Thu, 12 Oct 2006 19:56:05 +1000
Message-Id: <1160646965.16101.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-909da/iKFkPpqryxa0XI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-10-12 at 18:29 +1000, Benjamin Herrenschmidt wrote:
> There are currently two versions of the functions for applying the
> feature fixups, one for CPU features and one for firmware features. In
> addition, they are both in assembly.
>=20
> This patch replaces them with a single C function. The call site is
> slightly moved on ppc64 as well to be called from C instead of from
> assembly, though it's a very small move, and thus shouldn't cause any
> problem (called at the start of setup_system() instead of just before
> calling it).

Nice to see it written in C :)

> Index: linux-cell/arch/powerpc/kernel/setup.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-cell.orig/arch/powerpc/kernel/setup.h	2006-10-12 14:24:10.00000=
0000 +1000
> +++ linux-cell/arch/powerpc/kernel/setup.h	2006-10-12 17:46:02.000000000 =
+1000
> @@ -1,9 +1,12 @@
>  #ifndef _POWERPC_KERNEL_SETUP_H
>  #define _POWERPC_KERNEL_SETUP_H
> =20
> -void check_for_initrd(void);
> -void do_init_bootmem(void);
> -void setup_panic(void);
> +extern void check_for_initrd(void);
> +extern void do_init_bootmem(void);
> +extern void setup_panic(void);
> +extern void do_feature_fixups(unsigned long offset, unsigned long value,
> +			      void *fixup_start, void *fixup_end);
> +
>  extern int do_early_xmon;
> =20
>  #endif /* _POWERPC_KERNEL_SETUP_H */
> Index: linux-cell/arch/powerpc/kernel/setup_32.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-cell.orig/arch/powerpc/kernel/setup_32.c	2006-10-12 14:24:10.00=
0000000 +1000
> +++ linux-cell/arch/powerpc/kernel/setup_32.c	2006-10-12 17:46:24.0000000=
00 +1000
> @@ -90,6 +90,7 @@ int ucache_bsize;
>   */
>  unsigned long __init early_init(unsigned long dt_ptr)
>  {
> +	extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;

> Index: linux-cell/arch/powerpc/kernel/setup_64.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-cell.orig/arch/powerpc/kernel/setup_64.c	2006-10-12 14:24:10.00=
0000000 +1000
> +++ linux-cell/arch/powerpc/kernel/setup_64.c	2006-10-12 17:46:18.0000000=
00 +1000
> @@ -346,8 +346,19 @@ static void __init initialize_cache_info
>   */
>  void __init setup_system(void)
>  {
> +	extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
> +	extern unsigned int __start___fw_ftr_fixup, __stop___fw_ftr_fixup;


Every extern in a C file ... god kills a kitten! :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-909da/iKFkPpqryxa0XI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFLhE1dSjSd0sB4dIRAtryAKDF8aP1XbAZDv5w7zjS37FSHYwczACfZsUY
0xDn4h8xzJVcH4ZYjl/dAEA=
=cULV
-----END PGP SIGNATURE-----

--=-909da/iKFkPpqryxa0XI--
