Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id AA3FFDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:39:58 +1100 (EST)
Date: Tue, 31 Mar 2009 15:39:53 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 1/2] powerpc: i2c-mpc: preserve I2C clocking
Message-ID: <20090331133953.GB3044@pengutronix.de>
References: <20090331125028.066613801@denx.de>
	<20090331125451.600446749@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
In-Reply-To: <20090331125451.600446749@denx.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2009 at 02:50:29PM +0200, Wolfgang Grandegger wrote:
> The I2c node property "fsl,preserve-clocking" allows to overtake the
> clock settings from the boot loader and avoids the hard-coded setting.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  drivers/i2c/busses/i2c-mpc.c |   24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> Index: linux-2.6/drivers/i2c/busses/i2c-mpc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/i2c/busses/i2c-mpc.c	2009-03-31 13:25:08.00000=
0000 +0200
> +++ linux-2.6/drivers/i2c/busses/i2c-mpc.c	2009-03-31 13:28:03.000000000 =
+0200
> @@ -318,17 +318,24 @@
>  {
>  	int result =3D 0;
>  	struct mpc_i2c *i2c;
> +	int set_clock;
> =20
>  	i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
>  	if (!i2c)
>  		return -ENOMEM;
> =20
> -	if (of_get_property(op->node, "dfsrr", NULL))
> -		i2c->flags |=3D FSL_I2C_DEV_SEPARATE_DFSRR;
> -
> -	if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
> -			of_device_is_compatible(op->node, "mpc5200-i2c"))
> -		i2c->flags |=3D FSL_I2C_DEV_CLOCK_5200;
> +	if (of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
> +		set_clock =3D 0;
> +	} else {
> +		set_clock =3D 1;
> +
> +		if (of_get_property(op->node, "dfsrr", NULL))
> +			i2c->flags |=3D FSL_I2C_DEV_SEPARATE_DFSRR;
> +
> +		if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
> +		    of_device_is_compatible(op->node, "mpc5200-i2c"))
> +			i2c->flags |=3D FSL_I2C_DEV_CLOCK_5200;
> +	}
> =20
>  	init_waitqueue_head(&i2c->queue);
> =20
> @@ -348,8 +355,9 @@
>  			goto fail_request;
>  		}
>  	}
> -=09
> -	mpc_i2c_setclock(i2c);
> +
> +	if (set_clock)
> +		mpc_i2c_setclock(i2c);

Can't we drop 'set_clock' with something like this here?

+	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
+
+		if (of_get_property(op->node, "dfsrr", NULL))
+			i2c->flags |=3D FSL_I2C_DEV_SEPARATE_DFSRR;
+
+		if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
+		    of_device_is_compatible(op->node, "mpc5200-i2c"))
+			i2c->flags |=3D FSL_I2C_DEV_CLOCK_5200;
+
+		mpc_i2c_setclock(i2c);
+	}

> =20
>  	dev_set_drvdata(&op->dev, i2c);
> =20
>=20
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@ozlabs.org
> https://ozlabs.org/mailman/listinfo/devicetree-discuss

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknSHSkACgkQD27XaX1/VRvC5ACeIzP/QV6thai/6dLX/sUm0o7m
S2AAnidTamYhtjXqgOeDF+Lvdcokgx/s
=/G0m
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
