Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id BEA64DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 21:36:34 +1000 (EST)
Date: Sat, 15 Sep 2007 21:36:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Message-Id: <20070915213617.817dd349.sfr@canb.auug.org.au>
In-Reply-To: <200709151108.01849.sr@denx.de>
References: <200709151108.01849.sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__15_Sep_2007_21_36_17_+1000_gQ_Sf3zL+B2Z9QKV"
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__15_Sep_2007_21_36_17_+1000_gQ_Sf3zL+B2Z9QKV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Just some trivial things]

On Sat, 15 Sep 2007 11:08:01 +0200 Stefan Roese <sr@denx.de> wrote:
>
> +++ b/drivers/i2c/busses/i2c-ibm_iic.h
> @@ -22,7 +22,8 @@
>  #ifndef __I2C_IBM_IIC_H_
>  #define __I2C_IBM_IIC_H_
> =20
> -#include <linux/i2c.h>=20
> +#include <linux/i2c.h>
> +#include <asm/prom.h>

Please include linux/of.h, of_device.h or of_platform.h (as appropriate)
instead of asm/prom.h.  In this case, since you want struct device_node,
include linux/of.h.

> +static irqreturn_t iic_handler(int irq, void *dev_id)
> +{
> +	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)dev_id;

You shouldn't cast from (void *).

> +static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int =
num)
> +{
> +    	struct ibm_iic_private* dev =3D (struct ibm_iic_private*)(i2c_get_a=
dapdata(adap))i

Again the return value of i2c_get_adapdata() is (void *) so shouldn't be
cast.

> +	prop =3D of_get_property(np, "iic-mode", &len);
> +	/* use 400kHz only if stated in dts, 100kHz otherwise */
> +	if (prop !=3D NULL) {
> +		if (*prop =3D=3D 400)
> +			dev->fast_mode =3D 1;
> +	} else
> +		dev->fast_mode =3D 0;

	dev->fast_mode =3D (prop && (*prop =3D=3D 400));

> +static int __devexit iic_remove(struct of_device *ofdev)
> +{
> +	struct ibm_iic_private *dev =3D
> +		(struct ibm_iic_private *)dev_get_drvdata(&ofdev->dev);

dev_get_drvdata() also returns (void *).

> +static struct of_platform_driver ibm_iic_driver =3D {
> +	.name =3D "ibm-iic",
> +	.match_table =3D ibm_iic_match,
> +	.probe =3D iic_probe,
> +	.remove =3D iic_remove,
> +#if defined(CONFIG_PM)
> +	.suspend =3D NULL,
> +	.resume =3D NULL,
> +#endif

These last two will be NULL anyway, so just leave them out.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__15_Sep_2007_21_36_17_+1000_gQ_Sf3zL+B2Z9QKV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG68O6TgG2atn1QN8RAkwBAJwJRDPgKq0m0wQJcWlLj7j1JcYN4ACfdfEo
0Xf8vSLKOidJuUCLZ4SPJ/I=
=AkEi
-----END PGP SIGNATURE-----

--Signature=_Sat__15_Sep_2007_21_36_17_+1000_gQ_Sf3zL+B2Z9QKV--
