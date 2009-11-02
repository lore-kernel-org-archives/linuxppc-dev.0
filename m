Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 3B2B31007D2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 00:14:34 +1100 (EST)
Date: Mon, 2 Nov 2009 14:14:27 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mpc52xx-psc-spi: refactor probe and remove to make use
	of of_register_spi_devices()
Message-ID: <20091102131427.GB4696@pengutronix.de>
References: <1256931852-13255-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40910311803m43504167s1ad802aecd2b4344@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
In-Reply-To: <fa686aa40910311803m43504167s1ad802aecd2b4344@mail.gmail.com>
Cc: =?iso-8859-15?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

> the patch referenced above is a little ugly.  Adding the call should

Agreed. I just referenced it to show there are more people wanting this
feature.

> be really simple.  I've drafted a patch to do only that step and
> attached it to this mail.  If this one works for you, then I'll merge
> it immediately into -next.

One minor comment, but works in general:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

> Also, I'm resistant to changing the probe layout on this driver at
> this time.  With the work being done to generalize the OF support
> code, there is a strong possibility that of_platform will be
> deprecated in favor of going back to using the platform bus directly
> (just like how OF support works for i2c, spi, etc).  I'd rather not
> refactor the driver until I'm certain of the direction that things are
> going to go.

And this was possibly the best answer I could get \o/ Sounds really promisi=
ng,
is there somewhere a discussion about how OF-generalization could happen?

> From 7629d40dc343ff216b752d5c68654dc9d30f0c91 Mon Sep 17 00:00:00 2001
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Sat, 31 Oct 2009 17:49:38 -0600
> Subject: [PATCH] spi/mpc5200: Register SPI devices described in device tr=
ee
>=20
> Add call to of_register_spi_devices() to register SPI devices described
> in the OF device tree.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  drivers/spi/mpc52xx_psc_spi.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
> index 1b74d5c..b445464 100644
> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -17,6 +17,7 @@
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_spi.h>
>  #include <linux/workqueue.h>
>  #include <linux/completion.h>
>  #include <linux/io.h>
> @@ -464,6 +465,7 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_=
device *op,
>  	const u32 *regaddr_p;
>  	u64 regaddr64, size64;
>  	s16 id =3D -1;
> +	int rc;
> =20
>  	regaddr_p =3D of_get_address(op->node, 0, &size64, NULL);
>  	if (!regaddr_p) {
> @@ -485,8 +487,12 @@ static int __init mpc52xx_psc_spi_of_probe(struct of=
_device *op,
>  		id =3D *psc_nump + 1;
>  	}
> =20
> -	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
> +	rc =3D mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
>  					irq_of_parse_and_map(op->node, 0), id);
> +	if (!rc)

A matter of taste, maybe: I'd prefer

	if (rc =3D=3D 0)

as (!ptr) is often used for catching errors with pointers, but here it is t=
he
'all went OK'-path.

> +		of_register_spi_devices(dev_get_drvdata(&op->dev), op->node);
> +
> +	return rc;
>  }
> =20
>  static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
> --=20
> 1.6.3.3
>=20

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkru2zMACgkQD27XaX1/VRsXlwCginnzWtZPW2+yQLX4X4OasbYl
1ysAoKrEMvAdFSUqPpUEDNLqXfTcVaOf
=JRui
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
