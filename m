Return-Path: <mpa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E11511A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 15:58:48 +1000 (AEST)
Date: Fri, 31 Jul 2015 07:58:43 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 6/6] ASoC: fsl_ssi: adjust set DAI format in AC'97 mode
Message-ID: <20150731055843.GX30895@pengutronix.de>
References: <55BA364E.1000803@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="U8v/hV883cEE9JJG"
In-Reply-To: <55BA364E.1000803@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--U8v/hV883cEE9JJG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 04:35:58PM +0200, Maciej S. Szmigiero wrote:
> Adjust set DAI format function in fsl_ssi driver so it
> doesn't fail and clears RXDIR in AC'97 mode.
>=20
> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> ---
>  sound/soc/fsl/fsl_ssi.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 8e5ff5e..37aabe3 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -900,14 +900,16 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
>  		scr &=3D ~CCSR_SSI_SCR_SYS_CLK_EN;
>  		break;
>  	default:
> -		return -EINVAL;
> +		if (!fsl_ssi_is_ac97(ssi_private))
> +			return -EINVAL;

I think it would be better to add another case for the other mode which
is supported (AC97) instead of using the default case.

>  	}
> =20
>  	stcr |=3D strcr;
>  	srcr |=3D strcr;
> =20
> -	if (ssi_private->cpu_dai_drv.symmetric_rates) {
> -		/* Need to clear RXDIR when using SYNC mode */
> +	if (ssi_private->cpu_dai_drv.symmetric_rates
> +		|| fsl_ssi_is_ac97(ssi_private)) {

Please fix this indention. Most of the driver is written with 2 tab
indention after a line break and the new policy seems to be to indent on
the opening bracket.

Regards,

Markus

> +		/* Need to clear RXDIR when using SYNC or AC97 mode */
>  		srcr &=3D ~CCSR_SSI_SRCR_RXDIR;
>  		scr |=3D CCSR_SSI_SCR_SYN;
>  	}
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

--U8v/hV883cEE9JJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuw6TAAoJEEpcgKtcEGQQWCUP/1X5ivApFgjHYKLYs70UCkRq
o8NtSUErKFEYCEPhPDmcGX3jN3N/EM+c+C4g8IrJTl1wTbLy9zDO1ubf/s8IJJh+
rHerNqgCAANJZUo4qHFO+hbH2400VaxhIt1nxTvAXEese9P3lTVIYg9jPbstXdDH
6jTBSR4at5xI+KfzAyc6FBW915HuKF/lShNUDfO3tddp1X347cS0PbEVdMYdWsSp
t35raOl2ItnqzNCbZs9brJUtgMWsebQMv3/+4vh5qK7LdCMPzrASUWKSTspt2chB
H4U03A37X/IbkXka6NQ/DUQg4hA3bOGzR2Npl/T6ifzUgsRMuQLbekV8wYX9a9FX
tw1RRnS3rFDADkzN32dw5qUdDlyIq7D7rW7huYxRM4jnXc4etJzPJOefZP4jTXVC
te0UBpHZZ3QJRP5L/Dt34HAs9ij7Kb+MkgazAcYV3ANj8AqPTumGp5Hy7UnkRmS4
qB2+tqxILCJn0NwqdnuPPHXR3VxI+0yeuT5YvWI229F1vqBw0OyKp7YTVunwAlYR
W4XyWbWwKarC+dq1RhaVkMDp8tcgWmVWL7LgZQVizT+jVhqP2BNTpBTUgSItaoPU
o4F60PYmg7jecpcSx7m488RxArjcjxNIrwYLoDjlr3yvcJKFy0nmxi8Z2j3oUIXJ
jZe2T6k1GIOWaqWWSgVJ
=o9vG
-----END PGP SIGNATURE-----

--U8v/hV883cEE9JJG--
