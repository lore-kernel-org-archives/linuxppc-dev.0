Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Use more accurate limit for first segment
	memory allocations
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100511045918.GA13509@kryten>
References: <20100511045918.GA13509@kryten>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-rTmrY/CDRzjszGRMGt/a"
Date: Tue, 11 May 2010 23:24:50 +1000
Message-ID: <1273584290.2030.5.camel@concordia>
Mime-Version: 1.0
Cc: mikey@neuling.org, miltonm@bga.com, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-rTmrY/CDRzjszGRMGt/a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-11 at 14:59 +1000, Anton Blanchard wrote:
> Author: Milton Miller <miltonm@bga.com>
>=20
> On large machines we are running out of room below 256MB. In some cases w=
e
> only need to ensure the allocation is in the first segment, which may be
> 256MB or 1TB.
>=20
> Add slb0_limit and use it to specify the upper limit for the irqstack and
> emergency stacks.
>=20
> On a large ppc64 box, this fixes a panic at boot when the crashkernel=3D
> option is specified (previously we would run out of memory below 256MB).
>=20
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> Some things we should add:
>=20
> - Specify a more intelligent limit for BookE
> - The allocation of the PACAs should use this limit too

We access the PACA from real mode?

> Index: linux-2.6/arch/powerpc/kernel/setup_64.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/powerpc/kernel/setup_64.c	2010-04-22 17:23:42.000=
000000 +1000
> +++ linux-2.6/arch/powerpc/kernel/setup_64.c	2010-04-30 09:46:15.00000000=
0 +1000
> @@ -424,9 +424,18 @@ void __init setup_system(void)
>  	DBG(" <- setup_system()\n");
>  }
> =20
> +static u64 slb0_limit(void)
> +{
> +	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
> +		return 1UL << SID_SHIFT_1T;
> +	}
> +	return 1UL << SID_SHIFT;
> +}

I take it there's no chance the CPU feature is there but we're using 256
for whatever reason?

cheers


--=-rTmrY/CDRzjszGRMGt/a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvpWpwACgkQdSjSd0sB4dIUggCfWjqGposKtx3dFZJ1sM/nzQtO
NVcAoJSOCSV3hatFWKm4AqBrzlt2kIHB
=E5/N
-----END PGP SIGNATURE-----

--=-rTmrY/CDRzjszGRMGt/a--
