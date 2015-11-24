Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 641821A0999
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 10:24:51 +1100 (AEDT)
Received: by oiww189 with SMTP id w189so19680921oiw.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 15:24:49 -0800 (PST)
Date: Tue, 24 Nov 2015 17:24:44 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, timur@tabi.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 3/3] ASoC: fsl_asrc: spba clock is needed by asrc device
Message-ID: <20151124232444.GA5273@rob-hp-laptop>
References: <cover.1448348336.git.shengjiu.wang@freescale.com>
 <40629d5e0c3509afe27877874d225d5cd3cde261.1448348336.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40629d5e0c3509afe27877874d225d5cd3cde261.1448348336.git.shengjiu.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 24, 2015 at 03:03:30PM +0800, Shengjiu Wang wrote:
> ASRC need to enable the spba clock, when sdma is using share peripheral
> script. In this case, there is two spba master port is used, if don't
> enable the clock, the spba bus will have arbitration issue, which may
> cause read/write wrong data from/to ASRC registers
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt |  5 +++++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/fsl/fsl_asrc.c                             | 10 ++++++++++
>  sound/soc/fsl/fsl_asrc.h                             |  2 ++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index b93362a..3e26a94 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -25,6 +25,11 @@ Required properties:
>  	"mem"		  Peripheral access clock to access registers.
>  	"ipg"		  Peripheral clock to driver module.
>  	"asrck_<0-f>"	  Clock sources for input and output clock.
> +	"spba"		  The spba clock is required when ASRC is placed as a
> +			  bus slave of the Shared Peripheral Bus and when two
> +			  or more bus masters (CPU, DMA or DSP) try to access
> +			  it. This property is optional depending on the SoC
> +			  design.
>  
>     - big-endian		: If this property is absent, the little endian mode
>  			  will be in use as default. Otherwise, the big endian
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 9f087d4..800828e 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -859,6 +859,10 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  		return PTR_ERR(asrc_priv->ipg_clk);
>  	}
>  
> +	asrc_priv->spba_clk = devm_clk_get(&pdev->dev, "spba");
> +	if (IS_ERR(asrc_priv->spba_clk))
> +		dev_warn(&pdev->dev, "failed to get spba clock\n");
> +
>  	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
>  		sprintf(tmp, "asrck_%x", i);
>  		asrc_priv->asrck_clk[i] = devm_clk_get(&pdev->dev, tmp);
> @@ -939,6 +943,9 @@ static int fsl_asrc_runtime_resume(struct device *dev)
>  	ret = clk_prepare_enable(asrc_priv->ipg_clk);
>  	if (ret)
>  		goto disable_mem_clk;
> +	ret = clk_prepare_enable(asrc_priv->spba_clk);
> +	if (ret)
> +		goto disable_ipg_clk;
>  	for (i = 0; i < ASRC_CLK_MAX_NUM; i++) {
>  		ret = clk_prepare_enable(asrc_priv->asrck_clk[i]);
>  		if (ret)
> @@ -950,6 +957,8 @@ static int fsl_asrc_runtime_resume(struct device *dev)
>  disable_asrck_clk:
>  	for (i--; i >= 0; i--)
>  		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
> +	clk_disable_unprepare(asrc_priv->spba_clk);
> +disable_ipg_clk:
>  	clk_disable_unprepare(asrc_priv->ipg_clk);
>  disable_mem_clk:
>  	clk_disable_unprepare(asrc_priv->mem_clk);
> @@ -963,6 +972,7 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
>  
>  	for (i = 0; i < ASRC_CLK_MAX_NUM; i++)
>  		clk_disable_unprepare(asrc_priv->asrck_clk[i]);
> +	clk_disable_unprepare(asrc_priv->spba_clk);
>  	clk_disable_unprepare(asrc_priv->ipg_clk);
>  	clk_disable_unprepare(asrc_priv->mem_clk);
>  
> diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
> index 4aed63c..68802cd 100644
> --- a/sound/soc/fsl/fsl_asrc.h
> +++ b/sound/soc/fsl/fsl_asrc.h
> @@ -426,6 +426,7 @@ struct fsl_asrc_pair {
>   * @paddr: physical address to the base address of registers
>   * @mem_clk: clock source to access register
>   * @ipg_clk: clock source to drive peripheral
> + * @spba_clk: SPBA clock (optional, depending on SoC design)
>   * @asrck_clk: clock sources to driver ASRC internal logic
>   * @lock: spin lock for resource protection
>   * @pair: pair pointers
> @@ -442,6 +443,7 @@ struct fsl_asrc {
>  	unsigned long paddr;
>  	struct clk *mem_clk;
>  	struct clk *ipg_clk;
> +	struct clk *spba_clk;
>  	struct clk *asrck_clk[ASRC_CLK_MAX_NUM];
>  	spinlock_t lock;
>  
> -- 
> 1.9.1
> 
