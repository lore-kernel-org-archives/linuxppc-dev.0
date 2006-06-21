Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: disable OProfile for iSeries (take 2!)
From: Michael Ellerman <michael@ellerman.id.au>
To: Kelly Daly <kelly@au1.ibm.com>
In-Reply-To: <200606211151.01386.kelly@au.ibm.com>
References: <200606211151.01386.kelly@au.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PoRFfuscunfABJcfAG+G"
Date: Wed, 21 Jun 2006 13:10:33 +1000
Message-Id: <1150859433.8293.9.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-PoRFfuscunfABJcfAG+G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-21 at 11:51 +1000, Kelly Daly wrote:
> This patch removes the changes from an earlier patch that disables oProfi=
le for iSeries within the oProfile KConfig (submitted Feb 23, 2006).  Check=
s within the arch init for iSeries, still allowing profiling for timer inte=
rrupts.
>=20
> Signed-off-by: Kelly Daly <kelly@au.ibm.com>
> ---
>=20
>=20
> diff -urdp linux-2.6.16.20/arch/powerpc/oprofile/Kconfig linux-2.6.16.20_=
kel/arch/powerpc/oprofile/Kconfig
> --- linux-2.6.16.20/arch/powerpc/oprofile/Kconfig	2006-06-06 03:18:23.000=
000000 +1000
> +++ linux-2.6.16.20_kel/arch/powerpc/oprofile/Kconfig	2006-06-20 15:53:02=
.000000000 +1000
> @@ -1,5 +1,4 @@
>  config PROFILING
> -	depends on !PPC_ISERIES
>  	bool "Profiling support (EXPERIMENTAL)"
>  	help
>  	  Say Y here to enable the extended profiling support mechanisms used
> diff -urdp linux-2.6.16.20/arch/powerpc/oprofile/common.c linux-2.6.16.20=
_kel/arch/powerpc/oprofile/common.c
> --- linux-2.6.16.20/arch/powerpc/oprofile/common.c	2006-06-06 03:18:23.00=
0000000 +1000
> +++ linux-2.6.16.20_kel/arch/powerpc/oprofile/common.c	2006-06-20 15:33:5=
6.000000000 +1000
> @@ -137,7 +137,10 @@ int __init oprofile_arch_init(struct opr
>  {
>  	if (!cur_cpu_spec->oprofile_cpu_type)
>  		return -ENODEV;
> -
> +#ifdef CONFIG_PPC_ISERIES
> +	return -ENODEV;
> +#endif
> +=09

AFAICT that still doesn't let us build a combined kernel, but I haven't
looked at the code.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-PoRFfuscunfABJcfAG+G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEmLipdSjSd0sB4dIRAuA5AKC6PT/mzEo9XmjNEKvaUAENnvFsjQCghQny
YwVZPiPLJ4kqjPKt2fZD5tc=
=dXc2
-----END PGP SIGNATURE-----

--=-PoRFfuscunfABJcfAG+G--
