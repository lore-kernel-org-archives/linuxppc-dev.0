Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrH4d4f4RzDrpX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 07:47:29 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id w7so9045101pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 12:47:29 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
Subject: [PATCH 06/10] ASoC: fsl_ssi: Refine indentations and wrappings
Date: Mon,  4 Dec 2017 12:46:39 -0800
Message-Id: <1512420403-10164-7-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch just simply unifies the coding style.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c     | 225 ++++++++++++++++++++++----------------------
 sound/soc/fsl/fsl_ssi.h     |   2 +-
 sound/soc/fsl/fsl_ssi_dbg.c |   3 +-
 3 files changed, 113 insertions(+), 117 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index dce4889..ae5d98b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -69,21 +69,35 @@
  * samples will be written to STX properly.
  */
 #ifdef __BIG_ENDIAN
-#define FSLSSI_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE | \
-	 SNDRV_PCM_FMTBIT_S18_3BE | SNDRV_PCM_FMTBIT_S20_3BE | \
-	 SNDRV_PCM_FMTBIT_S24_3BE | SNDRV_PCM_FMTBIT_S24_BE)
+#define FSLSSI_I2S_FORMATS \
+	(SNDRV_PCM_FMTBIT_S8 | \
+	 SNDRV_PCM_FMTBIT_S16_BE | \
+	 SNDRV_PCM_FMTBIT_S18_3BE | \
+	 SNDRV_PCM_FMTBIT_S20_3BE | \
+	 SNDRV_PCM_FMTBIT_S24_3BE | \
+	 SNDRV_PCM_FMTBIT_S24_BE)
 #else
-#define FSLSSI_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
-	 SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S20_3LE | \
-	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE)
+#define FSLSSI_I2S_FORMATS \
+	(SNDRV_PCM_FMTBIT_S8 | \
+	 SNDRV_PCM_FMTBIT_S16_LE | \
+	 SNDRV_PCM_FMTBIT_S18_3LE | \
+	 SNDRV_PCM_FMTBIT_S20_3LE | \
+	 SNDRV_PCM_FMTBIT_S24_3LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE)
 #endif
 
-#define FSLSSI_SIER_DBG_RX_FLAGS (SSI_SIER_RFF0_EN | \
-		SSI_SIER_RLS_EN | SSI_SIER_RFS_EN | \
-		SSI_SIER_ROE0_EN | SSI_SIER_RFRC_EN)
-#define FSLSSI_SIER_DBG_TX_FLAGS (SSI_SIER_TFE0_EN | \
-		SSI_SIER_TLS_EN | SSI_SIER_TFS_EN | \
-		SSI_SIER_TUE0_EN | SSI_SIER_TFRC_EN)
+#define FSLSSI_SIER_DBG_RX_FLAGS \
+	(SSI_SIER_RFF0_EN | \
+	 SSI_SIER_RLS_EN | \
+	 SSI_SIER_RFS_EN | \
+	 SSI_SIER_ROE0_EN | \
+	 SSI_SIER_RFRC_EN)
+#define FSLSSI_SIER_DBG_TX_FLAGS \
+	(SSI_SIER_TFE0_EN | \
+	 SSI_SIER_TLS_EN | \
+	 SSI_SIER_TFS_EN | \
+	 SSI_SIER_TUE0_EN | \
+	 SSI_SIER_TFRC_EN)
 
 enum fsl_ssi_type {
 	FSL_SSI_MCP8610,
@@ -287,8 +301,8 @@ static struct fsl_ssi_soc_data fsl_ssi_mpc8610 = {
 	.imx = false,
 	.offline_config = true,
 	.sisr_write_mask = SSI_SISR_RFRC | SSI_SISR_TFRC |
-			SSI_SISR_ROE0 | SSI_SISR_ROE1 |
-			SSI_SISR_TUE0 | SSI_SISR_TUE1,
+			   SSI_SISR_ROE0 | SSI_SISR_ROE1 |
+			   SSI_SISR_TUE0 | SSI_SISR_TUE1,
 };
 
 static struct fsl_ssi_soc_data fsl_ssi_imx21 = {
@@ -302,15 +316,15 @@ static struct fsl_ssi_soc_data fsl_ssi_imx35 = {
 	.imx = true,
 	.offline_config = true,
 	.sisr_write_mask = SSI_SISR_RFRC | SSI_SISR_TFRC |
-			SSI_SISR_ROE0 | SSI_SISR_ROE1 |
-			SSI_SISR_TUE0 | SSI_SISR_TUE1,
+			   SSI_SISR_ROE0 | SSI_SISR_ROE1 |
+			   SSI_SISR_TUE0 | SSI_SISR_TUE1,
 };
 
 static struct fsl_ssi_soc_data fsl_ssi_imx51 = {
 	.imx = true,
 	.offline_config = false,
 	.sisr_write_mask = SSI_SISR_ROE0 | SSI_SISR_ROE1 |
-		SSI_SISR_TUE0 | SSI_SISR_TUE1,
+			   SSI_SISR_TUE0 | SSI_SISR_TUE1,
 };
 
 static const struct of_device_id fsl_ssi_ids[] = {
@@ -369,21 +383,21 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 
 	if (enable) {
 		regmap_update_bits(regs, REG_SSI_SIER,
-				vals->rx.sier | vals->tx.sier,
-				vals->rx.sier | vals->tx.sier);
+				   vals->rx.sier | vals->tx.sier,
+				   vals->rx.sier | vals->tx.sier);
 		regmap_update_bits(regs, REG_SSI_SRCR,
-				vals->rx.srcr | vals->tx.srcr,
-				vals->rx.srcr | vals->tx.srcr);
+				   vals->rx.srcr | vals->tx.srcr,
+				   vals->rx.srcr | vals->tx.srcr);
 		regmap_update_bits(regs, REG_SSI_STCR,
-				vals->rx.stcr | vals->tx.stcr,
-				vals->rx.stcr | vals->tx.stcr);
+				   vals->rx.stcr | vals->tx.stcr,
+				   vals->rx.stcr | vals->tx.stcr);
 	} else {
 		regmap_update_bits(regs, REG_SSI_SRCR,
-				vals->rx.srcr | vals->tx.srcr, 0);
+				   vals->rx.srcr | vals->tx.srcr, 0);
 		regmap_update_bits(regs, REG_SSI_STCR,
-				vals->rx.stcr | vals->tx.stcr, 0);
+				   vals->rx.stcr | vals->tx.stcr, 0);
 		regmap_update_bits(regs, REG_SSI_SIER,
-				vals->rx.sier | vals->tx.sier, 0);
+				   vals->rx.sier | vals->tx.sier, 0);
 	}
 }
 
@@ -394,10 +408,10 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 {
 	if (is_rx) {
 		regmap_update_bits(ssi->regs, REG_SSI_SOR,
-			SSI_SOR_RX_CLR, SSI_SOR_RX_CLR);
+				   SSI_SOR_RX_CLR, SSI_SOR_RX_CLR);
 	} else {
 		regmap_update_bits(ssi->regs, REG_SSI_SOR,
-			SSI_SOR_TX_CLR, SSI_SOR_TX_CLR);
+				   SSI_SOR_TX_CLR, SSI_SOR_TX_CLR);
 	}
 }
 
@@ -425,7 +439,7 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
  * Enable or disable SSI configuration.
  */
 static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
-		struct fsl_ssi_reg_val *vals)
+			   struct fsl_ssi_reg_val *vals)
 {
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_reg_val *avals;
@@ -435,8 +449,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 
 	regmap_read(regs, REG_SSI_SCR, &scr_val);
 
-	nr_active_streams = !!(scr_val & SSI_SCR_TE) +
-				!!(scr_val & SSI_SCR_RE);
+	nr_active_streams = !!(scr_val & SSI_SCR_TE) + !!(scr_val & SSI_SCR_RE);
 
 	if (nr_active_streams - 1 > 0)
 		keep_active = 1;
@@ -452,15 +465,14 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 	if (!enable) {
 		/* Exclude necessary bits for the opposite stream */
 		u32 scr = fsl_ssi_disable_val(vals->scr, avals->scr,
-				keep_active);
+					      keep_active);
 		/* Safely disable SCR register for the stream */
 		regmap_update_bits(regs, REG_SSI_SCR, scr, 0);
 	}
 
 	/* Online configuration not supported; re-enable all necessary bits */
 	if (ssi->soc->offline_config) {
-		if ((enable && !nr_active_streams) ||
-				(!enable && !keep_active))
+		if ((enable && !nr_active_streams) || (!enable && !keep_active))
 			fsl_ssi_rxtx_config(ssi, enable);
 
 		goto config_done;
@@ -480,11 +492,11 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 
 		/* Exclude necessary bits for the opposite stream */
 		sier = fsl_ssi_disable_val(vals->sier, avals->sier,
-				keep_active);
+					   keep_active);
 		srcr = fsl_ssi_disable_val(vals->srcr, avals->srcr,
-				keep_active);
+					   keep_active);
 		stcr = fsl_ssi_disable_val(vals->stcr, avals->stcr,
-				keep_active);
+					   keep_active);
 
 		/* Safely disable other control registers for the stream */
 		regmap_update_bits(regs, REG_SSI_SRCR, srcr, 0);
@@ -503,7 +515,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 
 			/* Enable SSI first to send TX DMA request */
 			regmap_update_bits(regs, REG_SSI_SCR,
-					SSI_SCR_SSIEN, SSI_SCR_SSIEN);
+					   SSI_SCR_SSIEN, SSI_SCR_SSIEN);
 
 			/* Wait until TX FIFO not empty -- DMA working */
 			for (i = 0; i < max_loop; i++) {
@@ -592,19 +604,16 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
 	struct regmap *regs = ssi->regs;
 
 	/* Setup the clock control register */
-	regmap_write(regs, REG_SSI_STCCR,
-			SSI_SxCCR_WL(17) | SSI_SxCCR_DC(13));
-	regmap_write(regs, REG_SSI_SRCCR,
-			SSI_SxCCR_WL(17) | SSI_SxCCR_DC(13));
+	regmap_write(regs, REG_SSI_STCCR, SSI_SxCCR_WL(17) | SSI_SxCCR_DC(13));
+	regmap_write(regs, REG_SSI_SRCCR, SSI_SxCCR_WL(17) | SSI_SxCCR_DC(13));
 
 	/* Enable AC97 mode and startup the SSI */
-	regmap_write(regs, REG_SSI_SACNT,
-			SSI_SACNT_AC97EN | SSI_SACNT_FV);
+	regmap_write(regs, REG_SSI_SACNT, SSI_SACNT_AC97EN | SSI_SACNT_FV);
 
 	/* AC97 has to communicate with codec before starting a stream */
 	regmap_update_bits(regs, REG_SSI_SCR,
-			SSI_SCR_SSIEN | SSI_SCR_TE | SSI_SCR_RE,
-			SSI_SCR_SSIEN | SSI_SCR_TE | SSI_SCR_RE);
+			   SSI_SCR_SSIEN | SSI_SCR_TE | SSI_SCR_RE,
+			   SSI_SCR_SSIEN | SSI_SCR_TE | SSI_SCR_RE);
 
 	regmap_write(regs, REG_SSI_SOR, SSI_SOR_WAIT(3));
 }
@@ -628,19 +637,18 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	 */
 	if (ssi->use_dual_fifo)
 		snd_pcm_hw_constraint_step(substream->runtime, 0,
-				SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 2);
 
 	return 0;
 }
 
 static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
-				struct snd_soc_dai *dai)
+			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 
 	clk_disable_unprepare(ssi->clk);
-
 }
 
 /**
@@ -653,8 +661,8 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
  *       (In 2-channel I2S Master mode, slot_width is fixed 32)
  */
 static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *cpu_dai,
-		struct snd_pcm_hw_params *hw_params)
+			    struct snd_soc_dai *cpu_dai,
+			    struct snd_pcm_hw_params *hw_params)
 {
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
 	struct regmap *regs = ssi->regs;
@@ -741,8 +749,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 
 	stccr = SSI_SxCCR_PM(pm + 1) | (div2 ? SSI_SxCCR_DIV2 : 0) |
 		(psr ? SSI_SxCCR_PSR : 0);
-	mask = SSI_SxCCR_PM_MASK | SSI_SxCCR_DIV2 |
-		SSI_SxCCR_PSR;
+	mask = SSI_SxCCR_PM_MASK | SSI_SxCCR_DIV2 | SSI_SxCCR_PSR;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK || synchronous)
 		regmap_update_bits(regs, REG_SSI_STCCR, mask, stccr);
@@ -769,7 +776,8 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
  * 2) SxCCR.DC and SxCCR.PM bits will be configured if SSI is clock master.
  */
 static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
-	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
+			     struct snd_pcm_hw_params *hw_params,
+			     struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
 	struct regmap *regs = ssi->regs;
@@ -806,36 +814,33 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 		u8 i2smode;
 		/* Normal + Network mode to send 16-bit data in 32-bit frames */
 		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
-			i2smode = SSI_SCR_I2S_MODE_NORMAL |
-				SSI_SCR_NET;
+			i2smode = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
 		else
 			i2smode = ssi->i2s_mode;
 
 		regmap_update_bits(regs, REG_SSI_SCR,
-				SSI_SCR_NET | SSI_SCR_I2S_MODE_MASK,
-				channels == 1 ? 0 : i2smode);
+				   SSI_SCR_NET | SSI_SCR_I2S_MODE_MASK,
+				   channels == 1 ? 0 : i2smode);
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
 	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
 	    ssi->cpu_dai_drv.symmetric_rates)
-		regmap_update_bits(regs, REG_SSI_STCCR, SSI_SxCCR_WL_MASK,
-				wl);
+		regmap_update_bits(regs, REG_SSI_STCCR, SSI_SxCCR_WL_MASK, wl);
 	else
-		regmap_update_bits(regs, REG_SSI_SRCCR, SSI_SxCCR_WL_MASK,
-				wl);
+		regmap_update_bits(regs, REG_SSI_SRCCR, SSI_SxCCR_WL_MASK, wl);
 
 	return 0;
 }
 
 static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
-		struct snd_soc_dai *cpu_dai)
+			   struct snd_soc_dai *cpu_dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 
 	if (fsl_ssi_is_i2s_master(ssi) &&
-			ssi->baudclk_streams & BIT(substream->stream)) {
+	    ssi->baudclk_streams & BIT(substream->stream)) {
 		clk_disable_unprepare(ssi->baudclk);
 		ssi->baudclk_streams &= ~BIT(substream->stream);
 	}
@@ -864,8 +869,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	scr |= SSI_SCR_SYNC_TX_FS;
 
 	mask = SSI_STCR_TXBIT0 | SSI_STCR_TFDIR | SSI_STCR_TXDIR |
-		SSI_STCR_TSCKP | SSI_STCR_TFSI | SSI_STCR_TFSL |
-		SSI_STCR_TEFS;
+	       SSI_STCR_TSCKP | SSI_STCR_TFSI | SSI_STCR_TFSL | SSI_STCR_TEFS;
 	regmap_read(regs, REG_SSI_STCR, &stcr);
 	regmap_read(regs, REG_SSI_SRCR, &srcr);
 	stcr &= ~mask;
@@ -875,11 +879,9 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		regmap_update_bits(regs, REG_SSI_STCCR,
-				   SSI_SxCCR_DC_MASK,
-				   SSI_SxCCR_DC(2));
+				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
 		regmap_update_bits(regs, REG_SSI_SRCCR,
-				   SSI_SxCCR_DC_MASK,
-				   SSI_SxCCR_DC(2));
+				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBM_CFS:
 		case SND_SOC_DAIFMT_CBS_CFS:
@@ -894,7 +896,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 
 		/* Data on rising edge of bclk, frame low, 1clk before data */
 		strcr |= SSI_STCR_TFSI | SSI_STCR_TSCKP |
-			SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
+			 SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		/* Data on rising edge of bclk, frame high */
@@ -903,12 +905,11 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	case SND_SOC_DAIFMT_DSP_A:
 		/* Data on rising edge of bclk, frame high, 1clk before data */
 		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
-			SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
+			 SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		/* Data on rising edge of bclk, frame high */
-		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
-			SSI_STCR_TXBIT0;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |  SSI_STCR_TXBIT0;
 		break;
 	case SND_SOC_DAIFMT_AC97:
 		ssi->i2s_mode |= SSI_SCR_I2S_MODE_NORMAL;
@@ -975,16 +976,16 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	wm = ssi->fifo_watermark;
 
 	regmap_write(regs, REG_SSI_SFCSR,
-			SSI_SFCSR_TFWM0(wm) | SSI_SFCSR_RFWM0(wm) |
-			SSI_SFCSR_TFWM1(wm) | SSI_SFCSR_RFWM1(wm));
+		     SSI_SFCSR_TFWM0(wm) | SSI_SFCSR_RFWM0(wm) |
+		     SSI_SFCSR_TFWM1(wm) | SSI_SFCSR_RFWM1(wm));
 
 	if (ssi->use_dual_fifo) {
-		regmap_update_bits(regs, REG_SSI_SRCR, SSI_SRCR_RFEN1,
-				SSI_SRCR_RFEN1);
-		regmap_update_bits(regs, REG_SSI_STCR, SSI_STCR_TFEN1,
-				SSI_STCR_TFEN1);
-		regmap_update_bits(regs, REG_SSI_SCR, SSI_SCR_TCH_EN,
-				SSI_SCR_TCH_EN);
+		regmap_update_bits(regs, REG_SSI_SRCR,
+				   SSI_SRCR_RFEN1, SSI_SRCR_RFEN1);
+		regmap_update_bits(regs, REG_SSI_STCR,
+				   SSI_STCR_TFEN1, SSI_STCR_TFEN1);
+		regmap_update_bits(regs, REG_SSI_SCR,
+				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
 	}
 
 	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
@@ -1011,7 +1012,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
  * Set TDM slot number and slot width
  */
 static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
-				u32 rx_mask, int slots, int slot_width)
+				    u32 rx_mask, int slots, int slot_width)
 {
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(cpu_dai);
 	struct regmap *regs = ssi->regs;
@@ -1031,16 +1032,15 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 		return -EINVAL;
 	}
 
-	regmap_update_bits(regs, REG_SSI_STCCR, SSI_SxCCR_DC_MASK,
-			SSI_SxCCR_DC(slots));
-	regmap_update_bits(regs, REG_SSI_SRCCR, SSI_SxCCR_DC_MASK,
-			SSI_SxCCR_DC(slots));
+	regmap_update_bits(regs, REG_SSI_STCCR,
+			   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(slots));
+	regmap_update_bits(regs, REG_SSI_SRCCR,
+			   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(slots));
 
 	/* Temporarily enable SSI to allow SxMSKs to be configurable */
 	regmap_read(regs, REG_SSI_SCR, &val);
 	val &= SSI_SCR_SSIEN;
-	regmap_update_bits(regs, REG_SSI_SCR, SSI_SCR_SSIEN,
-			SSI_SCR_SSIEN);
+	regmap_update_bits(regs, REG_SSI_SCR, SSI_SCR_SSIEN, SSI_SCR_SSIEN);
 
 	regmap_write(regs, REG_SSI_STMSK, ~tx_mask);
 	regmap_write(regs, REG_SSI_SRMSK, ~rx_mask);
@@ -1111,13 +1111,13 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 }
 
 static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
-	.startup	= fsl_ssi_startup,
-	.shutdown       = fsl_ssi_shutdown,
-	.hw_params	= fsl_ssi_hw_params,
-	.hw_free	= fsl_ssi_hw_free,
-	.set_fmt	= fsl_ssi_set_dai_fmt,
-	.set_tdm_slot	= fsl_ssi_set_dai_tdm_slot,
-	.trigger	= fsl_ssi_trigger,
+	.startup = fsl_ssi_startup,
+	.shutdown = fsl_ssi_shutdown,
+	.hw_params = fsl_ssi_hw_params,
+	.hw_free = fsl_ssi_hw_free,
+	.set_fmt = fsl_ssi_set_dai_fmt,
+	.set_tdm_slot = fsl_ssi_set_dai_tdm_slot,
+	.trigger = fsl_ssi_trigger,
 };
 
 static struct snd_soc_dai_driver fsl_ssi_dai_template = {
@@ -1140,7 +1140,7 @@ static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 };
 
 static const struct snd_soc_component_driver fsl_ssi_component = {
-	.name		= "fsl-ssi",
+	.name = "fsl-ssi",
 };
 
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
@@ -1168,7 +1168,7 @@ static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 static struct fsl_ssi *fsl_ac97_data;
 
 static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
-		unsigned short val)
+			       unsigned short val)
 {
 	struct regmap *regs = fsl_ac97_data->regs;
 	unsigned int lreg;
@@ -1193,8 +1193,8 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	lval = val << 4;
 	regmap_write(regs, REG_SSI_SACDAT, lval);
 
-	regmap_update_bits(regs, REG_SSI_SACNT, SSI_SACNT_RDWR_MASK,
-			SSI_SACNT_WR);
+	regmap_update_bits(regs, REG_SSI_SACNT,
+			   SSI_SACNT_RDWR_MASK, SSI_SACNT_WR);
 	udelay(100);
 
 	clk_disable_unprepare(fsl_ac97_data->clk);
@@ -1204,10 +1204,9 @@ static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 }
 
 static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
-		unsigned short reg)
+					unsigned short reg)
 {
 	struct regmap *regs = fsl_ac97_data->regs;
-
 	unsigned short val = 0;
 	u32 reg_val;
 	unsigned int lreg;
@@ -1217,8 +1216,7 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 
 	ret = clk_prepare_enable(fsl_ac97_data->clk);
 	if (ret) {
-		pr_err("ac97 read clk_prepare_enable failed: %d\n",
-			ret);
+		pr_err("ac97 read clk_prepare_enable failed: %d\n", ret);
 		goto ret_unlock;
 	}
 
@@ -1240,8 +1238,8 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 }
 
 static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
-	.read		= fsl_ssi_ac97_read,
-	.write		= fsl_ssi_ac97_write,
+	.read = fsl_ssi_ac97_read,
+	.write = fsl_ssi_ac97_write,
 };
 
 /**
@@ -1256,7 +1254,7 @@ static void make_lowercase(char *s)
 }
 
 static int fsl_ssi_imx_probe(struct platform_device *pdev,
-		struct fsl_ssi *ssi, void __iomem *iomem)
+			     struct fsl_ssi *ssi, void __iomem *iomem)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
@@ -1375,7 +1373,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (fsl_ssi_is_ac97(ssi)) {
 		memcpy(&ssi->cpu_dai_drv, &fsl_ssi_ac97_dai,
 				sizeof(fsl_ssi_ac97_dai));
-
 		fsl_ac97_data = ssi;
 	} else {
 		memcpy(&ssi->cpu_dai_drv, &fsl_ssi_dai_template,
@@ -1527,8 +1524,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 			goto error_sound_card;
 		}
 
-		ssi->pdev = platform_device_register_data(NULL,
-					"ac97-codec", ssi_idx, NULL, 0);
+		ssi->pdev = platform_device_register_data(NULL, "ac97-codec",
+							  ssi_idx, NULL, 0);
 		if (IS_ERR(ssi->pdev)) {
 			ret = PTR_ERR(ssi->pdev);
 			dev_err(dev,
@@ -1542,11 +1539,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 error_sound_card:
 	fsl_ssi_debugfs_remove(&ssi->dbg_stats);
-
 error_asoc_register:
 	if (fsl_ssi_is_ac97(ssi))
 		snd_soc_set_ac97_ops(NULL);
-
 error_ac97_ops:
 	if (fsl_ssi_is_ac97(ssi))
 		mutex_destroy(&ssi->ac97_reg_lock);
@@ -1600,9 +1595,9 @@ static int fsl_ssi_resume(struct device *dev)
 	regcache_cache_only(regs, false);
 
 	regmap_update_bits(regs, REG_SSI_SFCSR,
-			SSI_SFCSR_RFWM1_MASK | SSI_SFCSR_TFWM1_MASK |
-			SSI_SFCSR_RFWM0_MASK | SSI_SFCSR_TFWM0_MASK,
-			ssi->regcache_sfcsr);
+			   SSI_SFCSR_RFWM1_MASK | SSI_SFCSR_TFWM1_MASK |
+			   SSI_SFCSR_RFWM0_MASK | SSI_SFCSR_TFWM0_MASK,
+			   ssi->regcache_sfcsr);
 	regmap_write(regs, REG_SSI_SACNT, ssi->regcache_sacnt);
 
 	return regcache_sync(regs);
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 9dd2c40..7bb8a08 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -308,7 +308,7 @@ static inline void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *stats, u32 sisr)
 }
 
 static inline int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg,
-		struct device *dev)
+					 struct device *dev)
 {
 	return 0;
 }
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 50b0cab..0dc71df 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -147,7 +147,8 @@ int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 		return -ENOMEM;
 
 	ssi_dbg->dbg_stats = debugfs_create_file("stats", S_IRUGO,
-			ssi_dbg->dbg_dir, ssi_dbg, &fsl_ssi_stats_ops);
+						 ssi_dbg->dbg_dir, ssi_dbg,
+						 &fsl_ssi_stats_ops);
 	if (!ssi_dbg->dbg_stats) {
 		debugfs_remove(ssi_dbg->dbg_dir);
 		return -ENOMEM;
-- 
2.7.4
