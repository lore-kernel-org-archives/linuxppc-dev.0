Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 134D51A0013
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 18:39:14 +1100 (AEDT)
Received: by padhk6 with SMTP id hk6so13854014pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 23:39:12 -0800 (PST)
Date: Thu, 19 Nov 2015 23:39:06 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org, timur@tabi.org,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 1/3] ASoC: fsl_esai: spba clock is needed by esai device
Message-ID: <20151120073905.GA3740@Asurada-CZ80>
References: <cover.1447997800.git.shengjiu.wang@freescale.com>
 <d5cb15bbd3563ed34c58c15b224495b854bca616.1447997800.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d5cb15bbd3563ed34c58c15b224495b854bca616.1447997800.git.shengjiu.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 20, 2015 at 02:17:51PM +0800, Shengjiu Wang wrote:

> diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> index d3b6b5f..f1d5351 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> @@ -27,6 +27,8 @@ Required properties:
>  			  derive HCK, SCK and FS.
>  	"fsys"		  The system clock derived from ahb clock used to
>  			  derive HCK, SCK and FS.
> +	"spba"		  The spba clock is needed when two spba master port
> +			  is used.

I was expecting a little bit more detail like:

+	"spba"		The spba clock is required when ESAI is placed as
			a bus slave of the Shared Peripheral Bus and when
			two or more bus masters (CPU, DMA or DSP) try to
			access it. This property is optional depending on
			the SoC design.

> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 504e731..8749f53 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -54,6 +54,7 @@ struct fsl_esai {
>  	struct clk *coreclk;
>  	struct clk *extalclk;
>  	struct clk *fsysclk;
> +	struct clk *spbaclk;

Please add one entry in the comment above for the new clock.

> @@ -819,6 +826,11 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev, "failed to get fsys clock: %ld\n",
>  				PTR_ERR(esai_priv->fsysclk));
>  
> +	esai_priv->spbaclk = devm_clk_get(&pdev->dev, "spba");
> +	if (IS_ERR(esai_priv->spbaclk))
> +		dev_warn(&pdev->dev, "Cannot get spba clock: %ld\n",

It'd be better to write the warning following the previous one:
+  		dev_warn(&pdev->dev, "failed to get spba clock: %ld\n",
