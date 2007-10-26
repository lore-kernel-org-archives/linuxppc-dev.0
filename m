Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 26 Oct 2007 10:23:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/2] powerpc: prpmc2800 - Add MTD support
Message-Id: <20071026102353.b837423b.sfr@canb.auug.org.au>
In-Reply-To: <20071025233948.GA22703@mag.az.mvista.com>
References: <20071025233948.GA22703@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__26_Oct_2007_10_23_53_+1000_UcER69eIc1ZcJu9e"
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__26_Oct_2007_10_23_53_+1000_UcER69eIc1ZcJu9e
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Thu, 25 Oct 2007 16:39:48 -0700 "Mark A. Greer" <mgreer@mvista.com> wrot=
e:
>
> +static int __init prpmc2800_register_mtd(void)
> +{
> +	struct device_node *np =3D NULL;
                              ^^^^^^^
Not needed if you use for_each_compatible_node().

> +
> +	while ((np =3D of_find_compatible_node(np, NULL, "cfi-flash")) !=3D NUL=
L)

	for_each_compatible_node(np, NULL, "cfi-flash")

> +		of_platform_device_create(np, NULL, NULL);
> +
> +	of_node_put(np);

Not needed as np must be NULL when you get here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__26_Oct_2007_10_23_53_+1000_UcER69eIc1ZcJu9e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHITOeTgG2atn1QN8RAoDkAJ9flQ5YwRDv18ogM702+Bg8/7dkTACeOXcE
eF7Spgs5k2aH2dt90Wlq1J0=
=+HV0
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Oct_2007_10_23_53_+1000_UcER69eIc1ZcJu9e--
