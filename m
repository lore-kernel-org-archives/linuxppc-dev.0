Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x232.google.com (mail-pg0-x232.google.com
 [IPv6:2607:f8b0:400e:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxt1F6dXGzDqnt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 10:18:57 +1100 (AEDT)
Received: by mail-pg0-x232.google.com with SMTP id b18so2112039pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 15:18:57 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v3 01/11] ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
Date: Wed, 13 Dec 2017 15:18:18 -0800
Message-Id: <1513207108-30430-2-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shorten the private data structure to save some wrapped lines.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 456 +++++++++++++++++++++++-------------------------
 1 file changed, 220 insertions(+), 236 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c350117..84d2f7e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -185,7 +185,7 @@ struct fsl_ssi_soc_data {
 };
 
 /**
- * fsl_ssi_private: per-SSI private data
+ * fsl_ssi: per-SSI private data
  *
  * @reg: Pointer to the regmap registers
  * @irq: IRQ of this SSI
@@ -224,7 +224,7 @@ struct fsl_ssi_soc_data {
  * @dma_maxburst: max number of words to transfer in one go.  So far,
  *             this is always the same as fifo_watermark.
  */
-struct fsl_ssi_private {
+struct fsl_ssi {
 	struct regmap *regs;
 	int irq;
 	struct snd_soc_dai_driver cpu_dai_drv;
@@ -325,21 +325,21 @@ static const struct of_device_id fsl_ssi_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
 
-static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
+static bool fsl_ssi_is_ac97(struct fsl_ssi *ssi)
 {
-	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) ==
+	return (ssi->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) ==
 		SND_SOC_DAIFMT_AC97;
 }
 
-static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
+static bool fsl_ssi_is_i2s_master(struct fsl_ssi *ssi)
 {
-	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
+	return (ssi->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
 		SND_SOC_DAIFMT_CBS_CFS;
 }
 
-static bool fsl_ssi_is_i2s_cbm_cfs(struct fsl_ssi_private *ssi_private)
+static bool fsl_ssi_is_i2s_cbm_cfs(struct fsl_ssi *ssi)
 {
-	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
+	return (ssi->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
 		SND_SOC_DAIFMT_CBM_CFS;
 }
 /**
@@ -352,12 +352,12 @@ static bool fsl_ssi_is_i2s_cbm_cfs(struct fsl_ssi_private *ssi_private)
  * This interrupt handler is used only to gather statistics.
  *
  * @irq: IRQ of the SSI device
- * @dev_id: pointer to the ssi_private structure for this SSI device
+ * @dev_id: pointer to the fsl_ssi structure for this SSI device
  */
 static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 {
-	struct fsl_ssi_private *ssi_private = dev_id;
-	struct regmap *regs = ssi_private->regs;
+	struct fsl_ssi *ssi = dev_id;
+	struct regmap *regs = ssi->regs;
 	__be32 sisr;
 	__be32 sisr2;
 
@@ -367,12 +367,12 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	 */
 	regmap_read(regs, CCSR_SSI_SISR, &sisr);
 
-	sisr2 = sisr & ssi_private->soc->sisr_write_mask;
+	sisr2 = sisr & ssi->soc->sisr_write_mask;
 	/* Clear the bits that we set */
 	if (sisr2)
 		regmap_write(regs, CCSR_SSI_SISR, sisr2);
 
-	fsl_ssi_dbg_isr(&ssi_private->dbg_stats, sisr);
+	fsl_ssi_dbg_isr(&ssi->dbg_stats, sisr);
 
 	return IRQ_HANDLED;
 }
@@ -380,11 +380,10 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 /*
  * Enable/Disable all rx/tx config flags at once.
  */
-static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
-		bool enable)
+static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 {
-	struct regmap *regs = ssi_private->regs;
-	struct fsl_ssi_rxtx_reg_val *vals = &ssi_private->rxtx_reg_val;
+	struct regmap *regs = ssi->regs;
+	struct fsl_ssi_rxtx_reg_val *vals = &ssi->rxtx_reg_val;
 
 	if (enable) {
 		regmap_update_bits(regs, CCSR_SSI_SIER,
@@ -414,14 +413,13 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi_private *ssi_private,
  * Note: The SOR is not documented in recent IMX datasheet, but
  * is described in IMX51 reference manual at section 56.3.3.15.
  */
-static void fsl_ssi_fifo_clear(struct fsl_ssi_private *ssi_private,
-		bool is_rx)
+static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 {
 	if (is_rx) {
-		regmap_update_bits(ssi_private->regs, CCSR_SSI_SOR,
+		regmap_update_bits(ssi->regs, CCSR_SSI_SOR,
 			CCSR_SSI_SOR_RX_CLR, CCSR_SSI_SOR_RX_CLR);
 	} else {
-		regmap_update_bits(ssi_private->regs, CCSR_SSI_SOR,
+		regmap_update_bits(ssi->regs, CCSR_SSI_SOR,
 			CCSR_SSI_SOR_TX_CLR, CCSR_SSI_SOR_TX_CLR);
 	}
 }
@@ -448,12 +446,12 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi_private *ssi_private,
 
 /*
  * Enable/Disable a ssi configuration. You have to pass either
- * ssi_private->rxtx_reg_val.rx or tx as vals parameter.
+ * ssi->rxtx_reg_val.rx or tx as vals parameter.
  */
-static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
+static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		struct fsl_ssi_reg_val *vals)
 {
-	struct regmap *regs = ssi_private->regs;
+	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_reg_val *avals;
 	int nr_active_streams;
 	u32 scr_val;
@@ -471,10 +469,10 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 
 	/* Find the other direction values rx or tx which we do not want to
 	 * modify */
-	if (&ssi_private->rxtx_reg_val.rx == vals)
-		avals = &ssi_private->rxtx_reg_val.tx;
+	if (&ssi->rxtx_reg_val.rx == vals)
+		avals = &ssi->rxtx_reg_val.tx;
 	else
-		avals = &ssi_private->rxtx_reg_val.rx;
+		avals = &ssi->rxtx_reg_val.rx;
 
 	/* If vals should be disabled, start with disabling the unit */
 	if (!enable) {
@@ -488,10 +486,10 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 * reconfiguration, so we have to enable all necessary flags at once
 	 * even if we do not use them later (capture and playback configuration)
 	 */
-	if (ssi_private->soc->offline_config) {
+	if (ssi->soc->offline_config) {
 		if ((enable && !nr_active_streams) ||
 				(!enable && !keep_active))
-			fsl_ssi_rxtx_config(ssi_private, enable);
+			fsl_ssi_rxtx_config(ssi, enable);
 
 		goto config_done;
 	}
@@ -501,7 +499,7 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 	 * (online configuration)
 	 */
 	if (enable) {
-		fsl_ssi_fifo_clear(ssi_private, vals->scr & CCSR_SSI_SCR_RE);
+		fsl_ssi_fifo_clear(ssi, vals->scr & CCSR_SSI_SCR_RE);
 
 		regmap_update_bits(regs, CCSR_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, CCSR_SSI_STCR, vals->stcr, vals->stcr);
@@ -536,7 +534,7 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 config_done:
 	/* Enabling of subunits is done after configuration */
 	if (enable) {
-		if (ssi_private->use_dma && (vals->scr & CCSR_SSI_SCR_TE)) {
+		if (ssi->use_dma && (vals->scr & CCSR_SSI_SCR_TE)) {
 			/*
 			 * Be sure the Tx FIFO is filled when TE is set.
 			 * Otherwise, there are some chances to start the
@@ -563,7 +561,7 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 					break;
 			}
 			if (i == max_loop) {
-				dev_err(ssi_private->dev,
+				dev_err(ssi->dev,
 					"Timeout waiting TX FIFO filling\n");
 			}
 		}
@@ -572,17 +570,17 @@ static void fsl_ssi_config(struct fsl_ssi_private *ssi_private, bool enable,
 }
 
 
-static void fsl_ssi_rx_config(struct fsl_ssi_private *ssi_private, bool enable)
+static void fsl_ssi_rx_config(struct fsl_ssi *ssi, bool enable)
 {
-	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.rx);
+	fsl_ssi_config(ssi, enable, &ssi->rxtx_reg_val.rx);
 }
 
-static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi_private *ssi_private)
+static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi *ssi)
 {
-	struct regmap *regs = ssi_private->regs;
+	struct regmap *regs = ssi->regs;
 
 	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
-	if (!ssi_private->soc->imx21regs) {
+	if (!ssi->soc->imx21regs) {
 		/*
 		 * Note that these below aren't just normal registers.
 		 * They are a way to disable or enable bits in SACCST
@@ -601,7 +599,7 @@ static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi_private *ssi_private)
 	}
 }
 
-static void fsl_ssi_tx_config(struct fsl_ssi_private *ssi_private, bool enable)
+static void fsl_ssi_tx_config(struct fsl_ssi *ssi, bool enable)
 {
 	/*
 	 * Why are we setting up SACCST everytime we are starting a
@@ -622,10 +620,10 @@ static void fsl_ssi_tx_config(struct fsl_ssi_private *ssi_private, bool enable)
 	 * untrustworthy let's play safe here and make sure that no extra
 	 * slots are enabled every time a playback is started.
 	 */
-	if (enable && fsl_ssi_is_ac97(ssi_private))
-		fsl_ssi_tx_ac97_saccst_setup(ssi_private);
+	if (enable && fsl_ssi_is_ac97(ssi))
+		fsl_ssi_tx_ac97_saccst_setup(ssi);
 
-	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.tx);
+	fsl_ssi_config(ssi, enable, &ssi->rxtx_reg_val.tx);
 }
 
 /*
@@ -633,9 +631,9 @@ static void fsl_ssi_tx_config(struct fsl_ssi_private *ssi_private, bool enable)
  * be used later in fsl_ssi_config to setup the streams without the need to
  * check for all different SSI modes.
  */
-static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
+static void fsl_ssi_setup_reg_vals(struct fsl_ssi *ssi)
 {
-	struct fsl_ssi_rxtx_reg_val *reg = &ssi_private->rxtx_reg_val;
+	struct fsl_ssi_rxtx_reg_val *reg = &ssi->rxtx_reg_val;
 
 	reg->rx.sier = CCSR_SSI_SIER_RFF0_EN;
 	reg->rx.srcr = CCSR_SSI_SRCR_RFEN0;
@@ -644,12 +642,12 @@ static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
 	reg->tx.stcr = CCSR_SSI_STCR_TFEN0;
 	reg->tx.scr = 0;
 
-	if (!fsl_ssi_is_ac97(ssi_private)) {
+	if (!fsl_ssi_is_ac97(ssi)) {
 		reg->rx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE;
 		reg->tx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE;
 	}
 
-	if (ssi_private->use_dma) {
+	if (ssi->use_dma) {
 		reg->rx.sier |= CCSR_SSI_SIER_RDMAE;
 		reg->tx.sier |= CCSR_SSI_SIER_TDMAE;
 	} else {
@@ -661,9 +659,9 @@ static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
 	reg->tx.sier |= FSLSSI_SIER_DBG_TX_FLAGS;
 }
 
-static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
+static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
 {
-	struct regmap *regs = ssi_private->regs;
+	struct regmap *regs = ssi->regs;
 
 	/*
 	 * Setup the clock control register
@@ -702,11 +700,10 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private =
-		snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	int ret;
 
-	ret = clk_prepare_enable(ssi_private->clk);
+	ret = clk_prepare_enable(ssi->clk);
 	if (ret)
 		return ret;
 
@@ -715,7 +712,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	 * task from fifo0, fifo1 would be neglected at the end of each
 	 * period. But SSI would still access fifo1 with an invalid data.
 	 */
-	if (ssi_private->use_dual_fifo)
+	if (ssi->use_dual_fifo)
 		snd_pcm_hw_constraint_step(substream->runtime, 0,
 				SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
 
@@ -730,10 +727,9 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private =
-		snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 
-	clk_disable_unprepare(ssi_private->clk);
+	clk_disable_unprepare(ssi->clk);
 
 }
 
@@ -750,9 +746,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai,
 		struct snd_pcm_hw_params *hw_params)
 {
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
-	struct regmap *regs = ssi_private->regs;
-	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct regmap *regs = ssi->regs;
+	int synchronous = ssi->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
 	unsigned long clkrate, baudrate, tmprate;
 	unsigned int slots = params_channels(hw_params);
@@ -762,29 +758,29 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	bool baudclk_is_used;
 
 	/* Override slots and slot_width if being specifically set... */
-	if (ssi_private->slots)
-		slots = ssi_private->slots;
+	if (ssi->slots)
+		slots = ssi->slots;
 	/* ...but keep 32 bits if slots is 2 -- I2S Master mode */
-	if (ssi_private->slot_width && slots != 2)
-		slot_width = ssi_private->slot_width;
+	if (ssi->slot_width && slots != 2)
+		slot_width = ssi->slot_width;
 
 	/* Generate bit clock based on the slot number and slot width */
 	freq = slots * slot_width * params_rate(hw_params);
 
 	/* Don't apply it to any non-baudclk circumstance */
-	if (IS_ERR(ssi_private->baudclk))
+	if (IS_ERR(ssi->baudclk))
 		return -EINVAL;
 
 	/*
 	 * Hardware limitation: The bclk rate must be
 	 * never greater than 1/5 IPG clock rate
 	 */
-	if (freq * 5 > clk_get_rate(ssi_private->clk)) {
+	if (freq * 5 > clk_get_rate(ssi->clk)) {
 		dev_err(cpu_dai->dev, "bitclk > ipgclk/5\n");
 		return -EINVAL;
 	}
 
-	baudclk_is_used = ssi_private->baudclk_streams & ~(BIT(substream->stream));
+	baudclk_is_used = ssi->baudclk_streams & ~(BIT(substream->stream));
 
 	/* It should be already enough to divide clock by setting pm alone */
 	psr = 0;
@@ -796,9 +792,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		tmprate = freq * factor * (i + 1);
 
 		if (baudclk_is_used)
-			clkrate = clk_get_rate(ssi_private->baudclk);
+			clkrate = clk_get_rate(ssi->baudclk);
 		else
-			clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
+			clkrate = clk_round_rate(ssi->baudclk, tmprate);
 
 		clkrate /= factor;
 		afreq = clkrate / (i + 1);
@@ -844,7 +840,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		regmap_update_bits(regs, CCSR_SSI_SRCCR, mask, stccr);
 
 	if (!baudclk_is_used) {
-		ret = clk_set_rate(ssi_private->baudclk, baudrate);
+		ret = clk_set_rate(ssi->baudclk, baudrate);
 		if (ret) {
 			dev_err(cpu_dai->dev, "failed to set baudclk rate\n");
 			return -EINVAL;
@@ -870,8 +866,8 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
 {
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
-	struct regmap *regs = ssi_private->regs;
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct regmap *regs = ssi->regs;
 	unsigned int channels = params_channels(hw_params);
 	unsigned int sample_size = params_width(hw_params);
 	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
@@ -886,35 +882,35 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	 * If we're in synchronous mode, and the SSI is already enabled,
 	 * then STCCR is already set properly.
 	 */
-	if (enabled && ssi_private->cpu_dai_drv.symmetric_rates)
+	if (enabled && ssi->cpu_dai_drv.symmetric_rates)
 		return 0;
 
-	if (fsl_ssi_is_i2s_master(ssi_private)) {
+	if (fsl_ssi_is_i2s_master(ssi)) {
 		ret = fsl_ssi_set_bclk(substream, cpu_dai, hw_params);
 		if (ret)
 			return ret;
 
 		/* Do not enable the clock if it is already enabled */
-		if (!(ssi_private->baudclk_streams & BIT(substream->stream))) {
-			ret = clk_prepare_enable(ssi_private->baudclk);
+		if (!(ssi->baudclk_streams & BIT(substream->stream))) {
+			ret = clk_prepare_enable(ssi->baudclk);
 			if (ret)
 				return ret;
 
-			ssi_private->baudclk_streams |= BIT(substream->stream);
+			ssi->baudclk_streams |= BIT(substream->stream);
 		}
 	}
 
-	if (!fsl_ssi_is_ac97(ssi_private)) {
+	if (!fsl_ssi_is_ac97(ssi)) {
 		u8 i2smode;
 		/*
 		 * Switch to normal net mode in order to have a frame sync
 		 * signal every 32 bits instead of 16 bits
 		 */
-		if (fsl_ssi_is_i2s_cbm_cfs(ssi_private) && sample_size == 16)
+		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
 			i2smode = CCSR_SSI_SCR_I2S_MODE_NORMAL |
 				CCSR_SSI_SCR_NET;
 		else
-			i2smode = ssi_private->i2s_mode;
+			i2smode = ssi->i2s_mode;
 
 		regmap_update_bits(regs, CCSR_SSI_SCR,
 				CCSR_SSI_SCR_NET | CCSR_SSI_SCR_I2S_MODE_MASK,
@@ -933,7 +929,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
 	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
-	    ssi_private->cpu_dai_drv.symmetric_rates)
+	    ssi->cpu_dai_drv.symmetric_rates)
 		regmap_update_bits(regs, CCSR_SSI_STCCR, CCSR_SSI_SxCCR_WL_MASK,
 				wl);
 	else
@@ -947,34 +943,32 @@ static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private =
-		snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 
-	if (fsl_ssi_is_i2s_master(ssi_private) &&
-			ssi_private->baudclk_streams & BIT(substream->stream)) {
-		clk_disable_unprepare(ssi_private->baudclk);
-		ssi_private->baudclk_streams &= ~BIT(substream->stream);
+	if (fsl_ssi_is_i2s_master(ssi) &&
+			ssi->baudclk_streams & BIT(substream->stream)) {
+		clk_disable_unprepare(ssi->baudclk);
+		ssi->baudclk_streams &= ~BIT(substream->stream);
 	}
 
 	return 0;
 }
 
 static int _fsl_ssi_set_dai_fmt(struct device *dev,
-				struct fsl_ssi_private *ssi_private,
-				unsigned int fmt)
+				struct fsl_ssi *ssi, unsigned int fmt)
 {
-	struct regmap *regs = ssi_private->regs;
+	struct regmap *regs = ssi->regs;
 	u32 strcr = 0, stcr, srcr, scr, mask;
 	u8 wm;
 
-	ssi_private->dai_fmt = fmt;
+	ssi->dai_fmt = fmt;
 
-	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
+	if (fsl_ssi_is_i2s_master(ssi) && IS_ERR(ssi->baudclk)) {
 		dev_err(dev, "baudclk is missing which is necessary for master mode\n");
 		return -EINVAL;
 	}
 
-	fsl_ssi_setup_reg_vals(ssi_private);
+	fsl_ssi_setup_reg_vals(ssi);
 
 	regmap_read(regs, CCSR_SSI_SCR, &scr);
 	scr &= ~(CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_I2S_MODE_MASK);
@@ -988,7 +982,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	stcr &= ~mask;
 	srcr &= ~mask;
 
-	ssi_private->i2s_mode = CCSR_SSI_SCR_NET;
+	ssi->i2s_mode = CCSR_SSI_SCR_NET;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		regmap_update_bits(regs, CCSR_SSI_STCCR,
@@ -1000,10 +994,10 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBM_CFS:
 		case SND_SOC_DAIFMT_CBS_CFS:
-			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_MASTER;
+			ssi->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_MASTER;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
-			ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
+			ssi->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_SLAVE;
 			break;
 		default:
 			return -EINVAL;
@@ -1028,12 +1022,12 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 			CCSR_SSI_STCR_TXBIT0;
 		break;
 	case SND_SOC_DAIFMT_AC97:
-		ssi_private->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_NORMAL;
+		ssi->i2s_mode |= CCSR_SSI_SCR_I2S_MODE_NORMAL;
 		break;
 	default:
 		return -EINVAL;
 	}
-	scr |= ssi_private->i2s_mode;
+	scr |= ssi->i2s_mode;
 
 	/* DAI clock inversion */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -1072,15 +1066,14 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
-		if (!fsl_ssi_is_ac97(ssi_private))
+		if (!fsl_ssi_is_ac97(ssi))
 			return -EINVAL;
 	}
 
 	stcr |= strcr;
 	srcr |= strcr;
 
-	if (ssi_private->cpu_dai_drv.symmetric_rates
-			|| fsl_ssi_is_ac97(ssi_private)) {
+	if (ssi->cpu_dai_drv.symmetric_rates || fsl_ssi_is_ac97(ssi)) {
 		/* Need to clear RXDIR when using SYNC or AC97 mode */
 		srcr &= ~CCSR_SSI_SRCR_RXDIR;
 		scr |= CCSR_SSI_SCR_SYN;
@@ -1090,13 +1083,13 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, CCSR_SSI_SRCR, srcr);
 	regmap_write(regs, CCSR_SSI_SCR, scr);
 
-	wm = ssi_private->fifo_watermark;
+	wm = ssi->fifo_watermark;
 
 	regmap_write(regs, CCSR_SSI_SFCSR,
 			CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
 			CCSR_SSI_SFCSR_TFWM1(wm) | CCSR_SSI_SFCSR_RFWM1(wm));
 
-	if (ssi_private->use_dual_fifo) {
+	if (ssi->use_dual_fifo) {
 		regmap_update_bits(regs, CCSR_SSI_SRCR, CCSR_SSI_SRCR_RFEN1,
 				CCSR_SSI_SRCR_RFEN1);
 		regmap_update_bits(regs, CCSR_SSI_STCR, CCSR_SSI_STCR_TFEN1,
@@ -1106,7 +1099,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	}
 
 	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
-		fsl_ssi_setup_ac97(ssi_private);
+		fsl_ssi_setup_ac97(ssi);
 
 	return 0;
 
@@ -1117,12 +1110,12 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
  */
 static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
 
-	if (fsl_ssi_is_ac97(ssi_private))
+	if (fsl_ssi_is_ac97(ssi))
 		return 0;
 
-	return _fsl_ssi_set_dai_fmt(cpu_dai->dev, ssi_private, fmt);
+	return _fsl_ssi_set_dai_fmt(cpu_dai->dev, ssi, fmt);
 }
 
 /**
@@ -1133,8 +1126,8 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 				u32 rx_mask, int slots, int slot_width)
 {
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
-	struct regmap *regs = ssi_private->regs;
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
+	struct regmap *regs = ssi->regs;
 	u32 val;
 
 	/* The word length should be 8, 10, 12, 16, 18, 20, 22 or 24 */
@@ -1169,8 +1162,8 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 
 	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, val);
 
-	ssi_private->slot_width = slot_width;
-	ssi_private->slots = slots;
+	ssi->slot_width = slot_width;
+	ssi->slots = slots;
 
 	return 0;
 }
@@ -1188,33 +1181,33 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	struct regmap *regs = ssi_private->regs;
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	struct regmap *regs = ssi->regs;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			fsl_ssi_tx_config(ssi_private, true);
+			fsl_ssi_tx_config(ssi, true);
 		else
-			fsl_ssi_rx_config(ssi_private, true);
+			fsl_ssi_rx_config(ssi, true);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			fsl_ssi_tx_config(ssi_private, false);
+			fsl_ssi_tx_config(ssi, false);
 		else
-			fsl_ssi_rx_config(ssi_private, false);
+			fsl_ssi_rx_config(ssi, false);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	if (fsl_ssi_is_ac97(ssi_private)) {
+	if (fsl_ssi_is_ac97(ssi)) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_TX_CLR);
 		else
@@ -1226,11 +1219,11 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 
 static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 {
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(dai);
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 
-	if (ssi_private->soc->imx && ssi_private->use_dma) {
-		dai->playback_dma_data = &ssi_private->dma_params_tx;
-		dai->capture_dma_data = &ssi_private->dma_params_rx;
+	if (ssi->soc->imx && ssi->use_dma) {
+		dai->playback_dma_data = &ssi->dma_params_tx;
+		dai->capture_dma_data = &ssi->dma_params_rx;
 	}
 
 	return 0;
@@ -1292,7 +1285,7 @@ static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 };
 
 
-static struct fsl_ssi_private *fsl_ac97_data;
+static struct fsl_ssi *fsl_ac97_data;
 
 static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 		unsigned short val)
@@ -1383,24 +1376,24 @@ static void make_lowercase(char *s)
 }
 
 static int fsl_ssi_imx_probe(struct platform_device *pdev,
-		struct fsl_ssi_private *ssi_private, void __iomem *iomem)
+		struct fsl_ssi *ssi, void __iomem *iomem)
 {
 	struct device_node *np = pdev->dev.of_node;
 	u32 dmas[4];
 	int ret;
 
-	if (ssi_private->has_ipg_clk_name)
-		ssi_private->clk = devm_clk_get(&pdev->dev, "ipg");
+	if (ssi->has_ipg_clk_name)
+		ssi->clk = devm_clk_get(&pdev->dev, "ipg");
 	else
-		ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(ssi_private->clk)) {
-		ret = PTR_ERR(ssi_private->clk);
+		ssi->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ssi->clk)) {
+		ret = PTR_ERR(ssi->clk);
 		dev_err(&pdev->dev, "could not get clock: %d\n", ret);
 		return ret;
 	}
 
-	if (!ssi_private->has_ipg_clk_name) {
-		ret = clk_prepare_enable(ssi_private->clk);
+	if (!ssi->has_ipg_clk_name) {
+		ret = clk_prepare_enable(ssi->clk);
 		if (ret) {
 			dev_err(&pdev->dev, "clk_prepare_enable failed: %d\n", ret);
 			return ret;
@@ -1410,27 +1403,27 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	/* For those SLAVE implementations, we ignore non-baudclk cases
 	 * and, instead, abandon MASTER mode that needs baud clock.
 	 */
-	ssi_private->baudclk = devm_clk_get(&pdev->dev, "baud");
-	if (IS_ERR(ssi_private->baudclk))
+	ssi->baudclk = devm_clk_get(&pdev->dev, "baud");
+	if (IS_ERR(ssi->baudclk))
 		dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
-			 PTR_ERR(ssi_private->baudclk));
+			 PTR_ERR(ssi->baudclk));
 
-	ssi_private->dma_params_tx.maxburst = ssi_private->dma_maxburst;
-	ssi_private->dma_params_rx.maxburst = ssi_private->dma_maxburst;
-	ssi_private->dma_params_tx.addr = ssi_private->ssi_phys + CCSR_SSI_STX0;
-	ssi_private->dma_params_rx.addr = ssi_private->ssi_phys + CCSR_SSI_SRX0;
+	ssi->dma_params_tx.maxburst = ssi->dma_maxburst;
+	ssi->dma_params_rx.maxburst = ssi->dma_maxburst;
+	ssi->dma_params_tx.addr = ssi->ssi_phys + CCSR_SSI_STX0;
+	ssi->dma_params_rx.addr = ssi->ssi_phys + CCSR_SSI_SRX0;
 
 	ret = of_property_read_u32_array(np, "dmas", dmas, 4);
-	if (ssi_private->use_dma && !ret && dmas[2] == IMX_DMATYPE_SSI_DUAL) {
-		ssi_private->use_dual_fifo = true;
+	if (ssi->use_dma && !ret && dmas[2] == IMX_DMATYPE_SSI_DUAL) {
+		ssi->use_dual_fifo = true;
 		/* When using dual fifo mode, we need to keep watermark
 		 * as even numbers due to dma script limitation.
 		 */
-		ssi_private->dma_params_tx.maxburst &= ~0x1;
-		ssi_private->dma_params_rx.maxburst &= ~0x1;
+		ssi->dma_params_tx.maxburst &= ~0x1;
+		ssi->dma_params_rx.maxburst &= ~0x1;
 	}
 
-	if (!ssi_private->use_dma) {
+	if (!ssi->use_dma) {
 
 		/*
 		 * Some boards use an incompatible codec. To get it
@@ -1439,14 +1432,12 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		 * situation.
 		 */
 
-		ssi_private->fiq_params.irq = ssi_private->irq;
-		ssi_private->fiq_params.base = iomem;
-		ssi_private->fiq_params.dma_params_rx =
-			&ssi_private->dma_params_rx;
-		ssi_private->fiq_params.dma_params_tx =
-			&ssi_private->dma_params_tx;
+		ssi->fiq_params.irq = ssi->irq;
+		ssi->fiq_params.base = iomem;
+		ssi->fiq_params.dma_params_rx = &ssi->dma_params_rx;
+		ssi->fiq_params.dma_params_tx = &ssi->dma_params_tx;
 
-		ret = imx_pcm_fiq_init(pdev, &ssi_private->fiq_params);
+		ret = imx_pcm_fiq_init(pdev, &ssi->fiq_params);
 		if (ret)
 			goto error_pcm;
 	} else {
@@ -1459,23 +1450,23 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 
 error_pcm:
 
-	if (!ssi_private->has_ipg_clk_name)
-		clk_disable_unprepare(ssi_private->clk);
+	if (!ssi->has_ipg_clk_name)
+		clk_disable_unprepare(ssi->clk);
 	return ret;
 }
 
 static void fsl_ssi_imx_clean(struct platform_device *pdev,
-		struct fsl_ssi_private *ssi_private)
+		struct fsl_ssi *ssi)
 {
-	if (!ssi_private->use_dma)
+	if (!ssi->use_dma)
 		imx_pcm_fiq_exit(pdev);
-	if (!ssi_private->has_ipg_clk_name)
-		clk_disable_unprepare(ssi_private->clk);
+	if (!ssi->has_ipg_clk_name)
+		clk_disable_unprepare(ssi->clk);
 }
 
 static int fsl_ssi_probe(struct platform_device *pdev)
 {
-	struct fsl_ssi_private *ssi_private;
+	struct fsl_ssi *ssi;
 	int ret = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id;
@@ -1490,42 +1481,41 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 
-	ssi_private = devm_kzalloc(&pdev->dev, sizeof(*ssi_private),
+	ssi = devm_kzalloc(&pdev->dev, sizeof(*ssi),
 			GFP_KERNEL);
-	if (!ssi_private)
+	if (!ssi)
 		return -ENOMEM;
 
-	ssi_private->soc = of_id->data;
-	ssi_private->dev = &pdev->dev;
+	ssi->soc = of_id->data;
+	ssi->dev = &pdev->dev;
 
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (sprop) {
 		if (!strcmp(sprop, "ac97-slave"))
-			ssi_private->dai_fmt = SND_SOC_DAIFMT_AC97;
+			ssi->dai_fmt = SND_SOC_DAIFMT_AC97;
 	}
 
-	ssi_private->use_dma = !of_property_read_bool(np,
-			"fsl,fiq-stream-filter");
+	ssi->use_dma = !of_property_read_bool(np, "fsl,fiq-stream-filter");
 
-	if (fsl_ssi_is_ac97(ssi_private)) {
-		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_ac97_dai,
+	if (fsl_ssi_is_ac97(ssi)) {
+		memcpy(&ssi->cpu_dai_drv, &fsl_ssi_ac97_dai,
 				sizeof(fsl_ssi_ac97_dai));
 
-		fsl_ac97_data = ssi_private;
+		fsl_ac97_data = ssi;
 	} else {
 		/* Initialize this copy of the CPU DAI driver structure */
-		memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
+		memcpy(&ssi->cpu_dai_drv, &fsl_ssi_dai_template,
 		       sizeof(fsl_ssi_dai_template));
 	}
-	ssi_private->cpu_dai_drv.name = dev_name(&pdev->dev);
+	ssi->cpu_dai_drv.name = dev_name(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	iomem = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(iomem))
 		return PTR_ERR(iomem);
-	ssi_private->ssi_phys = res->start;
+	ssi->ssi_phys = res->start;
 
-	if (ssi_private->soc->imx21regs) {
+	if (ssi->soc->imx21regs) {
 		/*
 		 * According to datasheet imx21-class SSI
 		 * don't have SACC{ST,EN,DIS} regs.
@@ -1537,42 +1527,42 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	ret = of_property_match_string(np, "clock-names", "ipg");
 	if (ret < 0) {
-		ssi_private->has_ipg_clk_name = false;
-		ssi_private->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
+		ssi->has_ipg_clk_name = false;
+		ssi->regs = devm_regmap_init_mmio(&pdev->dev, iomem,
 			&regconfig);
 	} else {
-		ssi_private->has_ipg_clk_name = true;
-		ssi_private->regs = devm_regmap_init_mmio_clk(&pdev->dev,
+		ssi->has_ipg_clk_name = true;
+		ssi->regs = devm_regmap_init_mmio_clk(&pdev->dev,
 			"ipg", iomem, &regconfig);
 	}
-	if (IS_ERR(ssi_private->regs)) {
+	if (IS_ERR(ssi->regs)) {
 		dev_err(&pdev->dev, "Failed to init register map\n");
-		return PTR_ERR(ssi_private->regs);
+		return PTR_ERR(ssi->regs);
 	}
 
-	ssi_private->irq = platform_get_irq(pdev, 0);
-	if (ssi_private->irq < 0) {
+	ssi->irq = platform_get_irq(pdev, 0);
+	if (ssi->irq < 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
-		return ssi_private->irq;
+		return ssi->irq;
 	}
 
 	/* Are the RX and the TX clocks locked? */
 	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
-		if (!fsl_ssi_is_ac97(ssi_private)) {
-			ssi_private->cpu_dai_drv.symmetric_rates = 1;
-			ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
+		if (!fsl_ssi_is_ac97(ssi)) {
+			ssi->cpu_dai_drv.symmetric_rates = 1;
+			ssi->cpu_dai_drv.symmetric_samplebits = 1;
 		}
 
-		ssi_private->cpu_dai_drv.symmetric_channels = 1;
+		ssi->cpu_dai_drv.symmetric_channels = 1;
 	}
 
 	/* Determine the FIFO depth. */
 	iprop = of_get_property(np, "fsl,fifo-depth", NULL);
 	if (iprop)
-		ssi_private->fifo_depth = be32_to_cpup(iprop);
+		ssi->fifo_depth = be32_to_cpup(iprop);
 	else
                 /* Older 8610 DTs didn't have the fifo-depth property */
-		ssi_private->fifo_depth = 8;
+		ssi->fifo_depth = 8;
 
 	/*
 	 * Set the watermark for transmit FIFO 0 and receive FIFO 0. We don't
@@ -1589,7 +1579,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	 * fiq it is probably better to use the biggest possible watermark
 	 * size.
 	 */
-	switch (ssi_private->fifo_depth) {
+	switch (ssi->fifo_depth) {
 	case 15:
 		/*
 		 * 2 samples is not enough when running at high data
@@ -1598,8 +1588,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 * for the DMA to fill the FIFO before it's over/under
 		 * run.
 		 */
-		ssi_private->fifo_watermark = 8;
-		ssi_private->dma_maxburst = 8;
+		ssi->fifo_watermark = 8;
+		ssi->dma_maxburst = 8;
 		break;
 	case 8:
 	default:
@@ -1610,21 +1600,21 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 * I suspect this could be changed to be something to
 		 * leave some more space in the fifo.
 		 */
-		ssi_private->fifo_watermark = ssi_private->fifo_depth - 2;
-		ssi_private->dma_maxburst = ssi_private->fifo_depth - 2;
+		ssi->fifo_watermark = ssi->fifo_depth - 2;
+		ssi->dma_maxburst = ssi->fifo_depth - 2;
 		break;
 	}
 
-	dev_set_drvdata(&pdev->dev, ssi_private);
+	dev_set_drvdata(&pdev->dev, ssi);
 
-	if (ssi_private->soc->imx) {
-		ret = fsl_ssi_imx_probe(pdev, ssi_private, iomem);
+	if (ssi->soc->imx) {
+		ret = fsl_ssi_imx_probe(pdev, ssi, iomem);
 		if (ret)
 			return ret;
 	}
 
-	if (fsl_ssi_is_ac97(ssi_private)) {
-		mutex_init(&ssi_private->ac97_reg_lock);
+	if (fsl_ssi_is_ac97(ssi)) {
+		mutex_init(&ssi->ac97_reg_lock);
 		ret = snd_soc_set_ac97_ops_of_reset(&fsl_ssi_ac97_ops, pdev);
 		if (ret) {
 			dev_err(&pdev->dev, "could not set AC'97 ops\n");
@@ -1633,24 +1623,24 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_ssi_component,
-					      &ssi_private->cpu_dai_drv, 1);
+					      &ssi->cpu_dai_drv, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
 		goto error_asoc_register;
 	}
 
-	if (ssi_private->use_dma) {
-		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
+	if (ssi->use_dma) {
+		ret = devm_request_irq(&pdev->dev, ssi->irq,
 					fsl_ssi_isr, 0, dev_name(&pdev->dev),
-					ssi_private);
+					ssi);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "could not claim irq %u\n",
-					ssi_private->irq);
+					ssi->irq);
 			goto error_asoc_register;
 		}
 	}
 
-	ret = fsl_ssi_debugfs_create(&ssi_private->dbg_stats, &pdev->dev);
+	ret = fsl_ssi_debugfs_create(&ssi->dbg_stats, &pdev->dev);
 	if (ret)
 		goto error_asoc_register;
 
@@ -1675,20 +1665,18 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	snprintf(name, sizeof(name), "snd-soc-%s", sprop);
 	make_lowercase(name);
 
-	ssi_private->pdev =
-		platform_device_register_data(&pdev->dev, name, 0, NULL, 0);
-	if (IS_ERR(ssi_private->pdev)) {
-		ret = PTR_ERR(ssi_private->pdev);
+	ssi->pdev = platform_device_register_data(&pdev->dev, name, 0, NULL, 0);
+	if (IS_ERR(ssi->pdev)) {
+		ret = PTR_ERR(ssi->pdev);
 		dev_err(&pdev->dev, "failed to register platform: %d\n", ret);
 		goto error_sound_card;
 	}
 
 done:
-	if (ssi_private->dai_fmt)
-		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
-				     ssi_private->dai_fmt);
+	if (ssi->dai_fmt)
+		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi, ssi->dai_fmt);
 
-	if (fsl_ssi_is_ac97(ssi_private)) {
+	if (fsl_ssi_is_ac97(ssi)) {
 		u32 ssi_idx;
 
 		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
@@ -1697,11 +1685,10 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			goto error_sound_card;
 		}
 
-		ssi_private->pdev =
-			platform_device_register_data(NULL,
+		ssi->pdev = platform_device_register_data(NULL,
 					"ac97-codec", ssi_idx, NULL, 0);
-		if (IS_ERR(ssi_private->pdev)) {
-			ret = PTR_ERR(ssi_private->pdev);
+		if (IS_ERR(ssi->pdev)) {
+			ret = PTR_ERR(ssi->pdev);
 			dev_err(&pdev->dev,
 				"failed to register AC97 codec platform: %d\n",
 				ret);
@@ -1712,37 +1699,37 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	return 0;
 
 error_sound_card:
-	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
+	fsl_ssi_debugfs_remove(&ssi->dbg_stats);
 
 error_asoc_register:
-	if (fsl_ssi_is_ac97(ssi_private))
+	if (fsl_ssi_is_ac97(ssi))
 		snd_soc_set_ac97_ops(NULL);
 
 error_ac97_ops:
-	if (fsl_ssi_is_ac97(ssi_private))
-		mutex_destroy(&ssi_private->ac97_reg_lock);
+	if (fsl_ssi_is_ac97(ssi))
+		mutex_destroy(&ssi->ac97_reg_lock);
 
-	if (ssi_private->soc->imx)
-		fsl_ssi_imx_clean(pdev, ssi_private);
+	if (ssi->soc->imx)
+		fsl_ssi_imx_clean(pdev, ssi);
 
 	return ret;
 }
 
 static int fsl_ssi_remove(struct platform_device *pdev)
 {
-	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&pdev->dev);
+	struct fsl_ssi *ssi = dev_get_drvdata(&pdev->dev);
 
-	fsl_ssi_debugfs_remove(&ssi_private->dbg_stats);
+	fsl_ssi_debugfs_remove(&ssi->dbg_stats);
 
-	if (ssi_private->pdev)
-		platform_device_unregister(ssi_private->pdev);
+	if (ssi->pdev)
+		platform_device_unregister(ssi->pdev);
 
-	if (ssi_private->soc->imx)
-		fsl_ssi_imx_clean(pdev, ssi_private);
+	if (ssi->soc->imx)
+		fsl_ssi_imx_clean(pdev, ssi);
 
-	if (fsl_ssi_is_ac97(ssi_private)) {
+	if (fsl_ssi_is_ac97(ssi)) {
 		snd_soc_set_ac97_ops(NULL);
-		mutex_destroy(&ssi_private->ac97_reg_lock);
+		mutex_destroy(&ssi->ac97_reg_lock);
 	}
 
 	return 0;
@@ -1751,13 +1738,11 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int fsl_ssi_suspend(struct device *dev)
 {
-	struct fsl_ssi_private *ssi_private = dev_get_drvdata(dev);
-	struct regmap *regs = ssi_private->regs;
+	struct fsl_ssi *ssi = dev_get_drvdata(dev);
+	struct regmap *regs = ssi->regs;
 
-	regmap_read(regs, CCSR_SSI_SFCSR,
-			&ssi_private->regcache_sfcsr);
-	regmap_read(regs, CCSR_SSI_SACNT,
-			&ssi_private->regcache_sacnt);
+	regmap_read(regs, CCSR_SSI_SFCSR, &ssi->regcache_sfcsr);
+	regmap_read(regs, CCSR_SSI_SACNT, &ssi->regcache_sacnt);
 
 	regcache_cache_only(regs, true);
 	regcache_mark_dirty(regs);
@@ -1767,17 +1752,16 @@ static int fsl_ssi_suspend(struct device *dev)
 
 static int fsl_ssi_resume(struct device *dev)
 {
-	struct fsl_ssi_private *ssi_private = dev_get_drvdata(dev);
-	struct regmap *regs = ssi_private->regs;
+	struct fsl_ssi *ssi = dev_get_drvdata(dev);
+	struct regmap *regs = ssi->regs;
 
 	regcache_cache_only(regs, false);
 
 	regmap_update_bits(regs, CCSR_SSI_SFCSR,
 			CCSR_SSI_SFCSR_RFWM1_MASK | CCSR_SSI_SFCSR_TFWM1_MASK |
 			CCSR_SSI_SFCSR_RFWM0_MASK | CCSR_SSI_SFCSR_TFWM0_MASK,
-			ssi_private->regcache_sfcsr);
-	regmap_write(regs, CCSR_SSI_SACNT,
-			ssi_private->regcache_sacnt);
+			ssi->regcache_sfcsr);
+	regmap_write(regs, CCSR_SSI_SACNT, ssi->regcache_sacnt);
 
 	return regcache_sync(regs);
 }
-- 
2.1.4
