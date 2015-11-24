Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
 [209.85.218.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAC0E1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:23:47 +1100 (AEDT)
Received: by oiww189 with SMTP id w189so19668259oiw.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 15:23:45 -0800 (PST)
Date: Tue, 24 Nov 2015 17:23:39 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, timur@tabi.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 2/3] ASoC: fsl_spdif: spba clk is needed by spdif device
Message-ID: <20151124232339.GA4565@rob-hp-laptop>
References: <cover.1448348336.git.shengjiu.wang@freescale.com>
 <6f03afc87c7958b975df66b163c1186be979afb6.1448348336.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6f03afc87c7958b975df66b163c1186be979afb6.1448348336.git.shengjiu.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 24, 2015 at 03:03:29PM +0800, Shengjiu Wang wrote:
> SPDIF need to enable the spba clock, when sdma is using share peripheral
> script. In this case, there is two spba master port is used, if don't
> enable the clock, the spba bus will have arbitration issue, which may
> cause read/write wrong data from/to SPDIF registers.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,spdif.txt |  5 +++++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/fsl/fsl_spdif.c                             | 15 +++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> index b5ee32e..4ca39dd 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> @@ -27,6 +27,11 @@ Required properties:
>  			  Transceiver Clock Diagram" of SoC reference manual.
>  			  It can also be referred to TxClk_Source bit of
>  			  register SPDIF_STC.
> +	"spba"		  The spba clock is required when SPDIF is placed as a
> +			  bus slave of the Shared Peripheral Bus and when two
> +			  or more bus masters (CPU, DMA or DSP) try to access
> +			  it. This property is optional depending on the SoC
> +			  design.
>  
>     - big-endian		: If this property is absent, the native endian mode
>  			  will be in use as default, or the big endian mode
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index 28a8823..64e2a1f 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -88,6 +88,7 @@ struct spdif_mixer_control {
>   * @rxclk: rx clock sources for capture
>   * @coreclk: core clock for register access via DMA
>   * @sysclk: system clock for rx clock rate measurement
> + * @spbaclk: SPBA clock (optional, depending on SoC design)
>   * @dma_params_tx: DMA parameters for transmit channel
>   * @dma_params_rx: DMA parameters for receive channel
>   */
> @@ -106,6 +107,7 @@ struct fsl_spdif_priv {
>  	struct clk *rxclk;
>  	struct clk *coreclk;
>  	struct clk *sysclk;
> +	struct clk *spbaclk;
>  	struct snd_dmaengine_dai_dma_data dma_params_tx;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
>  	/* regcache for SRPC */
> @@ -474,6 +476,12 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
>  			return ret;
>  		}
>  
> +		ret = clk_prepare_enable(spdif_priv->spbaclk);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to enable spba clock\n");
> +			goto err_spbaclk;
> +		}
> +
>  		ret = spdif_softreset(spdif_priv);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to soft reset\n");
> @@ -515,6 +523,8 @@ disable_txclk:
>  	for (i--; i >= 0; i--)
>  		clk_disable_unprepare(spdif_priv->txclk[i]);
>  err:
> +	clk_disable_unprepare(spdif_priv->spbaclk);
> +err_spbaclk:
>  	clk_disable_unprepare(spdif_priv->coreclk);
>  
>  	return ret;
> @@ -548,6 +558,7 @@ static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
>  		spdif_intr_status_clear(spdif_priv);
>  		regmap_update_bits(regmap, REG_SPDIF_SCR,
>  				SCR_LOW_POWER, SCR_LOW_POWER);
> +		clk_disable_unprepare(spdif_priv->spbaclk);
>  		clk_disable_unprepare(spdif_priv->coreclk);
>  	}
>  }
> @@ -1261,6 +1272,10 @@ static int fsl_spdif_probe(struct platform_device *pdev)
>  		return PTR_ERR(spdif_priv->coreclk);
>  	}
>  
> +	spdif_priv->spbaclk = devm_clk_get(&pdev->dev, "spba");
> +	if (IS_ERR(spdif_priv->spbaclk))
> +		dev_warn(&pdev->dev, "no spba clock in devicetree\n");
> +
>  	/* Select clock source for rx/tx clock */
>  	spdif_priv->rxclk = devm_clk_get(&pdev->dev, "rxtx1");
>  	if (IS_ERR(spdif_priv->rxclk)) {
> -- 
> 1.9.1
> 
