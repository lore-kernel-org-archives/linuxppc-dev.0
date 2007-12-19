Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D6765DDE2D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 10:27:53 +1100 (EST)
Date: Thu, 20 Dec 2007 10:27:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/4] [POWERPC][SPI] use brg-frequency for SPI in QE
Message-Id: <20071220102740.4af61d8a.sfr@canb.auug.org.au>
In-Reply-To: <20071219203805.GC20861@localhost.localdomain>
References: <20071219203447.GA18285@localhost.localdomain>
	<20071219203805.GC20861@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__20_Dec_2007_10_27_40_+1100_7Xa=zxImn+lBCF1h"
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__20_Dec_2007_10_27_40_+1100_7Xa=zxImn+lBCF1h
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Dec 2007 23:38:05 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -1227,15 +1227,19 @@ int __init fsl_spi_init(struct spi_board_info *bo=
ard_infos,
> =20
>  	/* SPI controller is either clocked from QE or SoC clock */
>  	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
> -	if (!np)
> +	if (np) {
> +		sysclk =3D of_get_property(np, "brg-frequency", NULL);
> +		if (!sysclk)
> +			return -ENODEV;

You need an of_node_put(np) in the failing case.

> +	} else {
>  		np =3D of_find_node_by_type(NULL, "soc");
> +		if (!np)
> +			return -ENODEV;
> =20
> -	if (!np)
> -		return -ENODEV;
> -
> -	sysclk =3D of_get_property(np, "bus-frequency", NULL);
> -	if (!sysclk)
> -		return -ENODEV;
> +		sysclk =3D of_get_property(np, "bus-frequency", NULL);
> +		if (!sysclk)
> +			return -ENODEV;

And again.

> +	}
> =20
>  	for (np =3D NULL, i =3D 1;

There should be an of_node_put(np) before this as well.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__20_Dec_2007_10_27_40_+1100_7Xa=zxImn+lBCF1h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHaajwTgG2atn1QN8RAmb2AJ49iL3O1v6tJO2hV970a21Ry935OwCdEAIj
TYHH4uLExEBHPW9lpzHQQKo=
=fkFU
-----END PGP SIGNATURE-----

--Signature=_Thu__20_Dec_2007_10_27_40_+1100_7Xa=zxImn+lBCF1h--
