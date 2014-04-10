Return-Path: <shawn.guo@linaro.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7C6F51400B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 00:08:07 +1000 (EST)
Date: Thu, 10 Apr 2014 22:07:47 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v5] ASoC: fsl_sai: Add clock controls for SAI
Message-ID: <20140410140745.GE28420@dragon>
References: <1397128992-3609-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1397128992-3609-1-git-send-email-Guangyu.Chen@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 broonie@kernel.org, ijc+devicetree@hellion.org.uk,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org,
 Li.Xiubo@freescale.com, rob@landley.net, galak@codeaurora.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2014 at 07:23:12PM +0800, Nicolin Chen wrote:
> The SAI mainly has the following clocks:
>   bus clock
>     control and configure registers and to generate synchronous
>     interrupts and DMA requests.
> 
>   mclk1, mclk2, mclk3
>     to generate the bit clock when the receiver or transmitter is
>     configured for an internally generated bit clock.
> 
> So this patch adds these clocks and their clock controls to the driver,
> meanwhile, corrects the existing DTS accordingly so those platforms can
> benifit from the further feature with different clock sources.
> 
> [ To concern the old DTB cases, I've added a bit of extra code to make
>   the driver compatible with them. And by marking clock NULL if failed
>   to get, the clk_prepare() or clk_get_rate() would easily return 0
>   so no further path should be broken. -- by Nicolin ]

In this case, the arch/arm/boot/dts/vf610.dtsi can just go via IMX tree,
since nothing should be broken on sound tree even without dts change?

Shawn

> 
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> Acked-by: Xiubo Li <Li.Xiubo@freescale.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> 
> Changelog
> v5:
>  * Dropped mclk preparing and enabling since we are not using them currecntly.
>  * Made the change compatible to the old DTB.
>  * Added returned error value print.
> v4:
>  * Merged into single patch.
>  * Fixed bus clock ID on vf610.
> v3:
>  * Use int type for ret instead of u32.
>  * Added Acked-by and Tested-by from Xiubo Li.
> v2:
>  * Appended two extra mclks to the driver since SAI actually has three.
>  * Renamed clock name to 'bus' and 'mclk' according to the reference manual.
> 
>  .../devicetree/bindings/sound/fsl-sai.txt          |  9 +++--
>  arch/arm/boot/dts/vf610.dtsi                       |  6 ++--
>  sound/soc/fsl/fsl_sai.c                            | 38 ++++++++++++++++++++--
>  sound/soc/fsl/fsl_sai.h                            |  4 +++
>  4 files changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 35c09fe..0f4e238 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -10,7 +10,8 @@ Required properties:
>  - compatible: Compatible list, contains "fsl,vf610-sai" or "fsl,imx6sx-sai".
>  - reg: Offset and length of the register set for the device.
>  - clocks: Must contain an entry for each entry in clock-names.
> -- clock-names : Must include the "sai" entry.
> +- clock-names : Must include the "bus" for register access and "mclk1" "mclk2"
> +  "mclk3" for bit clock and frame clock providing.
>  - dmas : Generic dma devicetree binding as described in
>    Documentation/devicetree/bindings/dma/dma.txt.
>  - dma-names : Two dmas have to be defined, "tx" and "rx".
> @@ -30,8 +31,10 @@ sai2: sai@40031000 {
>  	      reg = <0x40031000 0x1000>;
>  	      pinctrl-names = "default";
>  	      pinctrl-0 = <&pinctrl_sai2_1>;
> -	      clocks = <&clks VF610_CLK_SAI2>;
> -	      clock-names = "sai";
> +	      clocks = <&clks VF610_CLK_PLATFORM_BUS>,
> +		     <&clks VF610_CLK_SAI2>,
> +		     <&clks 0>, <&clks 0>;
> +	      clock-names = "bus", "mclk1", "mclk2", "mclk3";
>  	      dma-names = "tx", "rx";
>  	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
>  		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index d31ce1b..4c3cd59 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -139,8 +139,10 @@
>  				compatible = "fsl,vf610-sai";
>  				reg = <0x40031000 0x1000>;
>  				interrupts = <0 86 0x04>;
> -				clocks = <&clks VF610_CLK_SAI2>;
> -				clock-names = "sai";
> +				clocks = <&clks VF610_CLK_PLATFORM_BUS>,
> +				       <&clks VF610_CLK_SAI2>,
> +				       <&clks 0>, <&clks 0>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
>  				status = "disabled";
>  			};
>  
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index db9f75e..5fff2e1 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -401,7 +401,15 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  		struct snd_soc_dai *cpu_dai)
>  {
>  	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> +	struct device *dev = &sai->pdev->dev;
>  	u32 reg;
> +	int ret;
> +
> +	ret = clk_prepare_enable(sai->bus_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable bus clock: %d\n", ret);
> +		return ret;
> +	}
>  
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>  		reg = FSL_SAI_TCR3;
> @@ -427,6 +435,8 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
>  
>  	regmap_update_bits(sai->regmap, reg, FSL_SAI_CR3_TRCE,
>  			   ~FSL_SAI_CR3_TRCE);
> +
> +	clk_disable_unprepare(sai->bus_clk);
>  }
>  
>  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> @@ -559,7 +569,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  	struct fsl_sai *sai;
>  	struct resource *res;
>  	void __iomem *base;
> -	int irq, ret;
> +	char tmp[8];
> +	int irq, ret, i;
>  
>  	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
>  	if (!sai)
> @@ -582,12 +593,35 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  		return PTR_ERR(base);
>  
>  	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> -			"sai", base, &fsl_sai_regmap_config);
> +			"bus", base, &fsl_sai_regmap_config);
> +
> +	/* Compatible with old DTB cases */
> +	if (IS_ERR(sai->regmap))
> +		sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> +				"sai", base, &fsl_sai_regmap_config);
>  	if (IS_ERR(sai->regmap)) {
>  		dev_err(&pdev->dev, "regmap init failed\n");
>  		return PTR_ERR(sai->regmap);
>  	}
>  
> +	/* No error out for old DTB cases but only mark the clock NULL */
> +	sai->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +	if (IS_ERR(sai->bus_clk)) {
> +		dev_err(&pdev->dev, "failed to get bus clock: %ld\n",
> +				PTR_ERR(sai->bus_clk));
> +		sai->bus_clk = NULL;
> +	}
> +
> +	for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
> +		sprintf(tmp, "mclk%d", i + 1);
> +		sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
> +		if (IS_ERR(sai->mclk_clk[i])) {
> +			dev_err(&pdev->dev, "failed to get mclk%d clock: %ld\n",
> +					i + 1, PTR_ERR(sai->mclk_clk[i]));
> +			sai->mclk_clk[i] = NULL;
> +		}
> +	}
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 677670d..0e6c9f5 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -119,6 +119,8 @@
>  #define FSL_SAI_CLK_MAST2	2
>  #define FSL_SAI_CLK_MAST3	3
>  
> +#define FSL_SAI_MCLK_MAX	3
> +
>  /* SAI data transfer numbers per DMA request */
>  #define FSL_SAI_MAXBURST_TX 6
>  #define FSL_SAI_MAXBURST_RX 6
> @@ -126,6 +128,8 @@
>  struct fsl_sai {
>  	struct platform_device *pdev;
>  	struct regmap *regmap;
> +	struct clk *bus_clk;
> +	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
>  
>  	bool big_endian_regs;
>  	bool big_endian_data;
> -- 
> 1.8.4
> 
> 
