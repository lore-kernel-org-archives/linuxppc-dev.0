Return-Path: <B42378@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1192E2C00D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 12:32:07 +1000 (EST)
Date: Tue, 20 Aug 2013 10:21:35 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v8 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130820022134.GA13169@MrMyself>
References: <cover.1376912873.git.b42378@freescale.com>
 <a5b34243c0323e7692fab6a52a7adf4e3e8a5844.1376912873.git.b42378@freescale.com>
 <20130819123449.GE31036@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130819123449.GE31036@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, swarren@wwwdotorg.org,
 festevam@gmail.com, timur@tabi.org, rob.herring@calxeda.com,
 tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you Sascha, I'll revise them all in v9

On Mon, Aug 19, 2013 at 02:34:49PM +0200, Sascha Hauer wrote:
> Hi Nicolas,
> 
> Some misc other comments inline.
> 
> On Mon, Aug 19, 2013 at 08:08:48PM +0800, Nicolin Chen wrote:
> > This patch implements a device-tree-only CPU DAI driver for Freescale
> > +
> > +struct fsl_spdif_priv {
> > +	struct spdif_mixer_control fsl_spdif_control;
> > +	struct snd_soc_dai_driver cpu_dai_drv;
> > +	struct platform_device *pdev;
> > +	struct regmap *regmap;
> > +	atomic_t dpll_locked;
> 
> You don't need an atomic_t to track a bool variable. Use a plain bool or
> int instead.
> 
> > +	u8 txclk_div[SPDIF_TXRATE_MAX];
> > +	u8 txclk_src[SPDIF_TXRATE_MAX];
> > +	u8 rxclk_src;
> > +	struct clk *txclk[SPDIF_TXRATE_MAX];
> > +	struct clk *rxclk;
> > +	struct snd_dmaengine_dai_dma_data dma_params_tx;
> > +	struct snd_dmaengine_dai_dma_data dma_params_rx;
> > +
> > +	/* The name space will be allocated dynamically */
> > +	char name[0];
> > +};
> > +
> > +
> > +#ifdef DEBUG
> > +static void dumpregs(struct fsl_spdif_priv *spdif_priv)
> > +{
> > +	struct regmap *regmap = spdif_priv->regmap;
> > +	struct platform_device *pdev = spdif_priv->pdev;
> > +	u32 val, i;
> > +	int ret;
> > +
> > +	/* Valid address set of SPDIF is {[0x0-0x38], 0x44, 0x50} */
> > +	for (i = 0 ; i <= REG_SPDIF_STC; i += 4) {
> > +		ret = regmap_read(regmap, REG_SPDIF_SCR + i, &val);
> > +		if (!ret)
> > +			dev_dbg(&pdev->dev, "REG 0x%02x = 0x%06x\n", i, val);
> > +	}
> > +}
> > +#else
> > +static void dumpregs(struct fsl_spdif_priv *spdif_priv) {}
> > +#endif
> 
> Is this needed? regmap provides a register dump in debugfs.
> 
> > +
> > +static int spdif_clk_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +	unsigned long rate_actual;
> > +
> > +	rate_actual = clk_round_rate(clk, rate);
> > +	return clk_set_rate(clk, rate_actual);
> > +}
> 
> clk_round_rate returns the rate which clk_set_rate would set if called
> with the same rate. The clk_round_rate() is unnecessary.
> 
> > +
> > +	dev_dbg(&pdev->dev, "expected clock rate = %d\n",
> > +			(int)(64 * sample_rate * div));
> > +	dev_dbg(&pdev->dev, "acutal clock rate = %d\n",
> > +			(int)clk_get_rate(spdif_priv->txclk[rate]));
> 
> s/acutal/actual/
> 
> Also please use %ld instead of casting the unsigned long to int.
> 
> > +
> > +	dev_dbg(&pdev->dev, "FreqMeas: %d\n", (int)freqmeas);
> > +	dev_dbg(&pdev->dev, "BusclkFreq: %d\n", (int)busclk_freq);
> > +	dev_dbg(&pdev->dev, "RxRate: %d\n", (int)tmpval64);
> 
> Get rid of the casts
> 
> > +
> > +	spdif_priv = devm_kzalloc(&pdev->dev,
> > +			sizeof(struct fsl_spdif_priv) + strlen(np->name) + 1, GFP_KERNEL);
> > +	if (!spdif_priv) {
> > +		dev_err(&pdev->dev, "could not allocate DAI object\n");
> 
> Please drop this message. You'll never see it.
> 
> > +
> > +	for (i = 0; i < SPDIF_TXRATE_MAX; i++) {
> > +		ret = fsl_spdif_probe_txclk(spdif_priv, i);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	/* Prepare rx/tx clock */
> > +	clk_prepare(spdif_priv->rxclk);
> > +	for (i = 0; i < SPDIF_TXRATE_MAX; i++)
> > +		clk_prepare(spdif_priv->txclk[i]);
> 
> Why do you prepare all clocks instead of the one you actually use? Also,
> no need to do this here. You can use clk_prepare_enable instead where
> you have clk_enable now.
> 
> > +
> > +/* SPDIF rx clock source */
> > +enum spdif_rxclk_src {
> > +	SRPC_CLKSRC_0 = 0,
> > +	SRPC_CLKSRC_1,
> > +	SRPC_CLKSRC_2,
> > +	SRPC_CLKSRC_3,
> > +	SRPC_CLKSRC_4,
> > +	SRPC_CLKSRC_5,
> > +	SRPC_CLKSRC_6,
> > +	SRPC_CLKSRC_7,
> > +	SRPC_CLKSRC_8,
> > +	SRPC_CLKSRC_9,
> > +	SRPC_CLKSRC_10,
> > +	SRPC_CLKSRC_11,
> > +	SRPC_CLKSRC_12,
> > +	SRPC_CLKSRC_13,
> > +	SRPC_CLKSRC_14,
> > +	SRPC_CLKSRC_15,
> > +};
> 
> These are unused and look unnecessary.
> 
> > +
> > +/* SPDIF tx clksrc */
> > +enum spdif_txclk_src {
> > +	STC_TXCLK_SRC_0 = 0,
> > +	STC_TXCLK_SRC_1,
> > +	STC_TXCLK_SRC_2,
> > +	STC_TXCLK_SRC_3,
> > +	STC_TXCLK_SRC_4,
> > +	STC_TXCLK_SRC_5,
> > +	STC_TXCLK_SRC_6,
> > +	STC_TXCLK_SRC_7,
> > +};
> 
> Also unused.
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
