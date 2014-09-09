Return-Path: <mpa@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E49421A001C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 20:06:55 +1000 (EST)
Date: Tue, 9 Sep 2014 11:49:13 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [alsa-devel] [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage in
 this module
Message-ID: <20140909094913.GE24081@pengutronix.de>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
In-Reply-To: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 Li.Xiubo@freescale.com, timur@tabi.org, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 09, 2014 at 05:18:07PM +0800, Shengjiu Wang wrote:
> Move the ipg clock enable and disable operation to startup and shutdown,
> that is only enable ipg clock when ssi is working. we don't need to enable
> ipg clock in probe.
> Another register accessing need the ipg clock, so use devm_regmap_init_mm=
io_clk
> instead of devm_regmap_init_mmio.
>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
>  sound/soc/fsl/fsl_ssi.c |   38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index 2fc3e66..d32d0f5 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -531,6 +531,9 @@ static int fsl_ssi_startup(struct snd_pcm_substream *=
substream,
>  	struct fsl_ssi_private *ssi_private =3D
>  		snd_soc_dai_get_drvdata(rtd->cpu_dai);
> =20
> +	if (ssi_private->soc->imx)
> +		clk_prepare_enable(ssi_private->clk);
> +
>  	/* When using dual fifo mode, it is safer to ensure an even period
>  	 * size. If appearing to an odd number while DMA always starts its
>  	 * task from fifo0, fifo1 would be neglected at the end of each
> @@ -544,6 +547,22 @@ static int fsl_ssi_startup(struct snd_pcm_substream =
*substream,
>  }
> =20
>  /**
> + * fsl_ssi_shutdown: shutdown the SSI
> + *
> + */
> +static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
> +                             struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> +	struct fsl_ssi_private *ssi_private =3D
> +		snd_soc_dai_get_drvdata(rtd->cpu_dai);
> +
> +	if (ssi_private->soc->imx)
> +		clk_disable_unprepare(ssi_private->clk);
> +
> +}
> +
> +/**
>   * fsl_ssi_set_bclk - configure Digital Audio Interface bit clock
>   *
>   * Note: This function can be only called when using SSI as DAI master
> @@ -1043,6 +1062,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *da=
i)
> =20
>  static const struct snd_soc_dai_ops fsl_ssi_dai_ops =3D {
>  	.startup	=3D fsl_ssi_startup,
> +	.shutdown       =3D fsl_ssi_shutdown,
>  	.hw_params	=3D fsl_ssi_hw_params,
>  	.hw_free	=3D fsl_ssi_hw_free,
>  	.set_fmt	=3D fsl_ssi_set_dai_fmt,
> @@ -1168,16 +1188,10 @@ static int fsl_ssi_imx_probe(struct platform_devi=
ce *pdev,
>  	u32 dmas[4];
>  	int ret;
> =20
> -	ssi_private->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	ssi_private->clk =3D devm_clk_get(&pdev->dev, "ipg");

This does not work for most imx SoCs at the moment. imx27, imx35, imx51
etc. do not have clock-names defined in the devicetree.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUDs0YAAoJEEpcgKtcEGQQ3fIQAIZ20+HrGbKP+S4zaouVr91n
Egs0PLCqbOAgJtkZabPfr+q8rJD0wCq8Ghz9rzNWes6OFz2IZoQ8gmqUoMvMqNxd
TeNeNmcL4qICdYGFmdUUWkV5p62bfwqD6UfUOQvAzm1pkQjn7q+3FgWRxsUvyUqQ
/3mlP6044QaR8gtYmcQMIJfozrMH8SADsKjb2LtlFU2i9ehf6gS3c/49RYF5l6PM
Qn2oe2rLTBoZiQc/E8+ScLVbDqnRKZgXxyrlBWJ1UZhjglGqsfHEHr3mOPrpkuY4
6G4iyHvbNdtcCy7dVKlp8LS+8PhybEcQznk5USPB5OtzmE4ka7FocrZnSdtcJ87A
8HsEVzXH+f2aG2JpuTAV1S1zE+TSJBwDKVSoMCkOFPCNq7Sux2wIQaOs3ahl4M9V
2TQZAPCkzXaPMu2DcHj9+Fi6hI5mT+wlNtU83fXYQDy5lLdBYTGiOIuo2qrCbetk
ccvz+D79YIckR1uxdVZ+CFRfxKAo0YICzWU0oLx1pqdgM72Px+FVRe74UlA22XkA
MORvzNC6BQRRu9J00ejDBEMMTWzBkJVgoYEFOPj617Y3XIWVyzVufDIcdfzlqYPA
TY+1CqQHqKV04oVITZ0Hms28Dlhu9KNf4Ivtm478SlR9kcezRbAE6HAdOkDRjusf
Tavmw7FBPqhKiyjJQfG+
=KDh+
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
