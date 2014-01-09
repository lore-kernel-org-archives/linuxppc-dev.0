Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2884C2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 05:45:31 +1100 (EST)
Date: Thu, 9 Jan 2014 18:44:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140109184453.GP12858@sirena.org.uk>
References: <1389265078-16256-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iq/fWD14IMVFWBCD"
In-Reply-To: <1389265078-16256-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Add ESAI CPU DAI driver
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, shawn.guo@linaro.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, timur@tabi.org, lgirdwood@gmail.com,
 robh+dt@kernel.org, rob@landley.net, galak@codeaurora.org,
 grant.likely@linaro.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--iq/fWD14IMVFWBCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2014 at 06:57:58PM +0800, Nicolin Chen wrote:

> +/**
> + * This function configures the ratio between MCLK (HCK) and BCLK (SCK)
> + * (For DAI Master Mode only)
> + *
> + * Note: Machine driver should calculate the ratio to call this function.
> + * 	 Only effective after calling set_dai_sysclk() to set HCK direction.
> + */
> +static int fsl_esai_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)

Why does the machine driver have to do this by hand, being able to
override is fine but having sensible defaults is easier?  Or does it
actually do that and the comment just needs updating?

> +	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_esai_component,
> +					      &fsl_esai_dai, 1);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = imx_pcm_dma_init(pdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "failed to init imx pcm dma: %d\n", ret);
> +
> +	/* Reset ESAI unit */
> +	regmap_write(esai_priv->regmap, REG_ESAI_ECR, ESAI_ECR_ERST);
> +
> +	/*
> +	 * We need to enable ESAI so as to access some of its registers.
> +	 * Otherwise, we would fail to dump regmap from user space.
> +	 */
> +	regmap_write(esai_priv->regmap, REG_ESAI_ECR, ESAI_ECR_ESAIEN);

I would expect to see the hardware initialisation before we start
registering with the core otherwise the core might start trying to run
prior to the hardware being initialised.

Otherwise this looks good.

--iq/fWD14IMVFWBCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzu4iAAoJELSic+t+oim9DfcP/AzCOkPoLdopNt/3TZ3iqGKU
Wx65nKrMmAquGqHyMGnGmdOXGs7w8RGp549sgu2Su3GgaIAOPvpipgLncIDRQBsi
yM5QFrb9dG0DOhXhen64tF0/e+qdPLr1ux7hvv+8URxw6vnrLOU3w0fO8emAtzzE
E5zOdO/ON6XYKCgVgJZg9Ctu3nEO4spl0TIEFlXPsurDN+O6CjFqJpbfRsScjDA1
4Yl77NwMfk+3giDdPnXx5v6WZDVyt4FtxrEbMfnM1UPbLwer3xSEtWic3UKvx8Oy
D1pHdHkbR7HXjY8GxODvTgsqvvk+jp9w+DiXuj6UD0rQWvyGXdAhJBt/Y6Imp+f/
0zA6LtQbRj+EBDAiQpMU8CgwzAENgBfiX/6ZEMShu1qBOFbXfEbvVGyVH81pJ+1c
zljl1BM4BAxc3hyaSJG1MnuF/ro7Qk4l+wzD/+HxyS19qrq/wjm9HWPFyxB7GBrC
/10U78uGugU0PJ/1HarT7XukrB4a/pqLMFHMHTSYlhmdpfr5rvkTBu4RNK0jVETf
EedHp81IwJU0NbGO4VFwrVauhvJv2IH4zxlQ4cPc6Wty28z8WMnYtax//bU5JiAU
RBUoR6ubVoQ8T/20iDhLqMYBufHFMiuoCW7TJ+AlL5/nDVuqfHRst5gVHn/iJgfv
SLcLY9/PKf7IgVNoqKqJ
=JoHQ
-----END PGP SIGNATURE-----

--iq/fWD14IMVFWBCD--
