Return-Path: <mpa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BC6E1A0075
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 15:46:23 +1000 (AEST)
Date: Fri, 31 Jul 2015 07:46:17 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 5/6] ASoC: fsl_ssi: instantiate AC'97 CODEC
Message-ID: <20150731054617.GV30895@pengutronix.de>
References: <55BA362B.1010706@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4Kq+wHeKEs1nwG7z"
In-Reply-To: <55BA362B.1010706@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--4Kq+wHeKEs1nwG7z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 04:35:23PM +0200, Maciej S. Szmigiero wrote:
> Instantiate AC'97 CODEC in fsl_ssi driver AC'97 mode.
>=20
> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> ---
>  sound/soc/fsl/fsl_ssi.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 154bcf6..8e5ff5e 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -1460,6 +1460,27 @@ done:
>  		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
>  				     ssi_private->dai_fmt);
> =20
> +	if (fsl_ssi_is_ac97(ssi_private)) {
> +		u32 ssi_idx;
> +
> +		ret =3D of_property_read_u32(np, "cell-index", &ssi_idx);

This property is not set anywhere in the imx* DTs.

> +		if (ret) {
> +			dev_err(&pdev->dev, "cannot get SSI index property\n");
> +			goto error_sound_card;
> +		}
> +
> +		ssi_private->pdev =3D
> +			platform_device_register_data(NULL,
> +					"ac97-codec", ssi_idx, NULL, 0);

If you really want to create a device at this point you should use
PLATFORM_DEVID_AUTO. I would prefer something where this is created in
DT. On the other side it is a discoverable bus..

Regards,

Markus

> +		if (IS_ERR(ssi_private->pdev)) {
> +			ret =3D PTR_ERR(ssi_private->pdev);
> +			dev_err(&pdev->dev,
> +				"failed to register AC97 codec platform: %d\n",
> +				ret);
> +			goto error_sound_card;
> +		}
> +	}
> +
>  	return 0;
> =20
>  error_sound_card:
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--4Kq+wHeKEs1nwG7z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuwupAAoJEEpcgKtcEGQQUq0QAICWvBl/tS6BYks4jLAiGgx+
4jdhUdoNiYx68e/19eKuxiZQFUhuy8lOocBrQszu+qg/HJShPofwo4/NUeGUjet0
2NmDRxL2RI/rpyknMsbFD8Mv7SFQa+dTveGZ3OonKLiZ3hC26qmq9srW59h0yu7d
lH0WIKhc9W+IZWJ+DHDQ0bdD7AY0uUrMN7Rfk84LOJKo1x3lj/TpX8Z0eeo2vMWm
zeh4sZA2i8+4PANkXryvtXpXQzB6cNT1AQgGHx1QtwJb4/gan0C++yOfc59Sqvkz
mx2XDrvEaWzNcfUeXVrlfJIrawBgJz9X9wXhszcnNiQWADME+cQx6ChJFaqg8DvZ
XVxNDttcBdMVIlcamxjdFK2d4WfWkAzsAV9T82TSvgyZqFIwXV3lkID7XirexRqt
mm8DqRoH1Vpyjkp2lp1bl9d6a6n5UJWnGfRtHLb0UIz7m7QNbfMhINZgvhkkECSm
aUevhcaBO2A+irStrzsQRxycOcXH+0U5h+H05eovPu0h81fCuxUnvRmL5Hnxeyay
HPff7/DR8ewJKO+qWfQXzvQEZcW6u2nQccgHqVikNGaL3Ec/8cdrHh7e9n3loBO0
ERUGmUp1lcyBxGkRbJK3PRFuP5rxHCQ1RinGlX2aF25K1EhROPOBBUNk5Xtx8pRh
xK9FKiXoPFXThowQoD/P
=dg5l
-----END PGP SIGNATURE-----

--4Kq+wHeKEs1nwG7z--
