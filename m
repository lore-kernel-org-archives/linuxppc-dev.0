Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 326CB1A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:21:38 +1100 (AEDT)
Received: by oixx65 with SMTP id x65so19676393oix.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 15:21:36 -0800 (PST)
Date: Tue, 24 Nov 2015 17:21:30 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, timur@tabi.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 1/3] ASoC: fsl_esai: spba clock is needed by esai device
Message-ID: <20151124232130.GA3400@rob-hp-laptop>
References: <cover.1448348336.git.shengjiu.wang@freescale.com>
 <37808c01df126622c41c2d413fddf838dc2aa71d.1448348336.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37808c01df126622c41c2d413fddf838dc2aa71d.1448348336.git.shengjiu.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 24, 2015 at 03:03:28PM +0800, Shengjiu Wang wrote:
> ESAI need to enable the spba clock, when sdma is using share peripheral
> script. In this case, there is two spba master port is used, if don't
> enable the clock, the spba bus will have arbitration issue, which may
> cause read/write wrong data from/to ESAI registers.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,esai.txt |  5 +++++

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/fsl/fsl_esai.c                             | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> index d3b6b5f..cd3ee5d 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
> @@ -27,6 +27,11 @@ Required properties:
>  			  derive HCK, SCK and FS.
>  	"fsys"		  The system clock derived from ahb clock used to
>  			  derive HCK, SCK and FS.
> +	"spba"		  The spba clock is required when ESAI is placed as a
> +			  bus slave of the Shared Peripheral Bus and when two
> +			  or more bus masters (CPU, DMA or DSP) try to access
> +			  it. This property is optional depending on the SoC
> +			  design.
>  
>    - fsl,fifo-depth	: The number of elements in the transmit and receive
>  			  FIFOs. This number is the maximum allowed value for
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 504e731..4d7589c 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -35,6 +35,7 @@
>   * @coreclk: clock source to access register
>   * @extalclk: esai clock source to derive HCK, SCK and FS
>   * @fsysclk: system clock source to derive HCK, SCK and FS
> + * @spbaclk: SPBA clock (optional, depending on SoC design)
>   * @fifo_depth: depth of tx/rx FIFO
>   * @slot_width: width of each DAI slot
>   * @slots: number of slots
> @@ -54,6 +55,7 @@ struct fsl_esai {
>  	struct clk *coreclk;
>  	struct clk *extalclk;
>  	struct clk *fsysclk;
> +	struct clk *spbaclk;
>  	u32 fifo_depth;
>  	u32 slot_width;
>  	u32 slots;
> @@ -469,6 +471,9 @@ static int fsl_esai_startup(struct snd_pcm_substream *substream,
>  	ret = clk_prepare_enable(esai_priv->coreclk);
>  	if (ret)
>  		return ret;
> +	ret = clk_prepare_enable(esai_priv->spbaclk);
> +	if (ret)
> +		goto err_spbaclk;
>  	if (!IS_ERR(esai_priv->extalclk)) {
>  		ret = clk_prepare_enable(esai_priv->extalclk);
>  		if (ret)
> @@ -499,6 +504,8 @@ err_fsysclk:
>  	if (!IS_ERR(esai_priv->extalclk))
>  		clk_disable_unprepare(esai_priv->extalclk);
>  err_extalck:
> +	clk_disable_unprepare(esai_priv->spbaclk);
> +err_spbaclk:
>  	clk_disable_unprepare(esai_priv->coreclk);
>  
>  	return ret;
> @@ -564,6 +571,7 @@ static void fsl_esai_shutdown(struct snd_pcm_substream *substream,
>  		clk_disable_unprepare(esai_priv->fsysclk);
>  	if (!IS_ERR(esai_priv->extalclk))
>  		clk_disable_unprepare(esai_priv->extalclk);
> +	clk_disable_unprepare(esai_priv->spbaclk);
>  	clk_disable_unprepare(esai_priv->coreclk);
>  }
>  
> @@ -819,6 +827,11 @@ static int fsl_esai_probe(struct platform_device *pdev)
>  		dev_warn(&pdev->dev, "failed to get fsys clock: %ld\n",
>  				PTR_ERR(esai_priv->fsysclk));
>  
> +	esai_priv->spbaclk = devm_clk_get(&pdev->dev, "spba");
> +	if (IS_ERR(esai_priv->spbaclk))
> +		dev_warn(&pdev->dev, "failed to get spba clock: %ld\n",
> +				PTR_ERR(esai_priv->spbaclk));
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
> -- 
> 1.9.1
> 
