Return-Path: <Li.Xiubo@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 80DCA140096
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 20:24:47 +1100 (EST)
From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "shawn.guo@linaro.org"
 <shawn.guo@linaro.org>
Subject: RE: [PATCH 1/2] ASoC: fsl_sai: Add clock control for SAI
Date: Fri, 4 Apr 2014 09:24:39 +0000
Message-ID: <49295d4f0f0f42c4b9c6de77583b978e@BY2PR03MB505.namprd03.prod.outlook.com>
References: <cover.1396352401.git.Guangyu.Chen@freescale.com>
 <87d225a25812d730c0865f9d0bb733c67d8b3ed1.1396352401.git.Guangyu.Chen@freescale.com>
In-Reply-To: <87d225a25812d730c0865f9d0bb733c67d8b3ed1.1396352401.git.Guangyu.Chen@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "timur@tabi.org" <timur@tabi.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "rob@landley.net" <rob@landley.net>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have test this series on my Vybrid-TWR board and it works happily.

[...]
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 3847d2a..2d749df 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -428,5 +428,18 @@ static int fsl_sai_startup(struct snd_pcm_substream
> *substream,
>  {
>  	struct fsl_sai *sai =3D snd_soc_dai_get_drvdata(cpu_dai);
> -	u32 reg;
> +	struct device *dev =3D &sai->pdev->dev;
> +	u32 reg, ret;
> +

I'd prefer:
  +	int ret;


> +	ret =3D clk_prepare_enable(sai->ipg_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to prepare and enable ipg clock\n");
> +		return ret;
> +	}
> +

[...]

> @@ -609,5 +630,5 @@ static int fsl_sai_probe(struct platform_device *pdev=
)
>=20
>  	sai->regmap =3D devm_regmap_init_mmio_clk(&pdev->dev,
> -			"sai", base, &fsl_sai_regmap_config);
> +			"ipg", base, &fsl_sai_regmap_config);
>  	if (IS_ERR(sai->regmap)) {
>  		dev_err(&pdev->dev, "regmap init failed\n");
> @@ -615,4 +636,16 @@ static int fsl_sai_probe(struct platform_device *pde=
v)
>  	}
>=20
> +	sai->ipg_clk =3D devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(sai->ipg_clk)) {
> +		dev_err(&pdev->dev, "failed to get ipg clock\n");
> +		return PTR_ERR(sai->ipg_clk);
> +	}
> +

Since the 'ipg' clock is just intend to be used for registers accessing and
We are using the regmap_init_mmio_clk(), so we can just drop it here and
Let the regmap APIs to do the clock options properly.

Otherwise it look good to me.

After this:
Acked-by: Xiubo Li <Li.Xiubo@freescale.com>



Thanks,

Brs,
Xiubo




> +	sai->sai_clk =3D devm_clk_get(&pdev->dev, "sai");
> +	if (IS_ERR(sai->sai_clk)) {
> +		dev_err(&pdev->dev, "failed to get sai clock\n");
> +		return PTR_ERR(sai->sai_clk);
> +	}
> +
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 677670d..cbaf114 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -127,4 +127,6 @@ struct fsl_sai {
>  	struct platform_device *pdev;
>  	struct regmap *regmap;
> +	struct clk *ipg_clk;
> +	struct clk *sai_clk;
>=20
>  	bool big_endian_regs;
> --
> 1.8.4
>=20
