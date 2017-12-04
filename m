Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrH4b4yDWzDsGM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 07:47:27 +1100 (AEDT)
Received: by mail-pf0-x22d.google.com with SMTP id v26so9438000pfl.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 12:47:27 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
Subject: [PATCH 04/10] ASoC: fsl_ssi: Refine all comments
Date: Mon,  4 Dec 2017 12:46:37 -0800
Message-Id: <1512420403-10164-5-git-send-email-nicoleotsuka@gmail.com>
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

This patch refines the comments by:
1) Removing all out-of-date comments
2) Removing all not-so-useful comments
3) Unifying the styles of all comments
4) Simplifying over-descriptive comments
5) Adding comments to improve code readablity
6) Moving all register related comments to fsl_ssi.h
7) Adding comments to all register and field defines

Even after adding dozens of lines in fsl_ssi.h, this patch reduces
100 lines totally.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c     | 358 +++++++++++++-------------------------------
 sound/soc/fsl/fsl_ssi.h     |  67 ++++++++-
 sound/soc/fsl/fsl_ssi_dbg.c |  12 +-
 3 files changed, 168 insertions(+), 269 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e903c92..2643ee4 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -187,42 +187,48 @@ struct fsl_ssi_soc_data {
 /**
  * fsl_ssi: per-SSI private data
  *
- * @reg: Pointer to the regmap registers
+ * @regs: Pointer to the regmap registers
  * @irq: IRQ of this SSI
  * @cpu_dai_drv: CPU DAI driver for this device
  *
  * @dai_fmt: DAI configuration this device is currently used with
- * @i2s_mode: i2s and network mode configuration of the device. Is used to
- * switch between normal and i2s/network mode
- * mode depending on the number of channels
+ * @i2s_mode: I2S and Network mode configuration of SCR register
  * @use_dma: DMA is used or FIQ with stream filter
- * @use_dual_fifo: DMA with support for both FIFOs used
- * @fifo_deph: Depth of the SSI FIFOs
- * @slot_width: width of each DAI slot
- * @slots: number of slots
- * @rxtx_reg_val: Specific register settings for receive/transmit configuration
+ * @use_dual_fifo: DMA with support for dual FIFO mode
+ * @has_ipg_clk_name: If "ipg" is in the clock name list of device tree
+ * @fifo_depth: Depth of the SSI FIFOs
+ * @slot_width: Width of each DAI slot
+ * @slots: Number of slots
+ * @rxtx_reg_val: Specific RX/TX register settings
  *
- * @clk: SSI clock
- * @baudclk: SSI baud clock for master mode
+ * @clk: Clock source to access register
+ * @baudclk: Clock source to generate bit and frame-sync clocks
  * @baudclk_streams: Active streams that are using baudclk
  *
+ * @regcache_sfcsr: Cache sfcsr register value during suspend and resume
+ * @regcache_sacnt: Cache sacnt register value during suspend and resume
+ *
  * @dma_params_tx: DMA transmit parameters
  * @dma_params_rx: DMA receive parameters
  * @ssi_phys: physical address of the SSI registers
  *
  * @fiq_params: FIQ stream filtering parameters
  *
- * @pdev: Pointer to pdev used for deprecated fsl-ssi sound card
+ * @pdev: Pointer to pdev when using fsl-ssi as sound card (ppc only)
+ *        TODO: Should be replaced with simple-sound-card
  *
  * @dbg_stats: Debugging statistics
  *
  * @soc: SoC specific data
+ * @dev: Pointer to &pdev->dev
+ *
+ * @fifo_watermark: The FIFO watermark setting. Notifies DMA when there are
+ *                  @fifo_watermark or fewer words in TX fifo or
+ *                  @fifo_watermark or more empty words in RX fifo.
+ * @dma_maxburst: Max number of words to transfer in one go. So far,
+ *                this is always the same as fifo_watermark.
  *
- * @fifo_watermark: the FIFO watermark setting.  Notifies DMA when
- *             there are @fifo_watermark or fewer words in TX fifo or
- *             @fifo_watermark or more empty words in RX fifo.
- * @dma_maxburst: max number of words to transfer in one go.  So far,
- *             this is always the same as fifo_watermark.
+ * @ac97_reg_lock: Mutex lock to serialize AC97 register access operations
  */
 struct fsl_ssi {
 	struct regmap *regs;
@@ -243,20 +249,15 @@ struct fsl_ssi {
 	struct clk *baudclk;
 	unsigned int baudclk_streams;
 
-	/* regcache for volatile regs */
 	u32 regcache_sfcsr;
 	u32 regcache_sacnt;
 
-	/* DMA params */
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	dma_addr_t ssi_phys;
 
-	/* params for non-dma FIQ stream filtered mode */
 	struct imx_pcm_fiq_params fiq_params;
 
-	/* Used when using fsl-ssi as sound-card. This is only used by ppc and
-	 * should be replaced with simple-sound-card. */
 	struct platform_device *pdev;
 
 	struct fsl_ssi_dbg dbg_stats;
@@ -271,19 +272,15 @@ struct fsl_ssi {
 };
 
 /*
- * imx51 and later SoCs have a slightly different IP that allows the
- * SSI configuration while the SSI unit is running.
+ * SoC specific data
  *
- * More important, it is necessary on those SoCs to configure the
- * sperate TX/RX DMA bits just before starting the stream
- * (fsl_ssi_trigger). The SDMA unit has to be configured before fsl_ssi
- * sends any DMA requests to the SDMA unit, otherwise it is not defined
- * how the SDMA unit handles the DMA request.
- *
- * SDMA units are present on devices starting at imx35 but the imx35
- * reference manual states that the DMA bits should not be changed
- * while the SSI unit is running (SSIEN). So we support the necessary
- * online configuration of fsl-ssi starting at imx51.
+ * Notes:
+ * 1) SDMA available since imx35. However, imx35 does not support
+ *    DMA bits changing when SSI is running (SSIEN)
+ * 2) imx51 and later versions support register configurations when
+ *    SSI is running (SSIEN); For these versions, DMA needs to be
+ *    configured before SSI sends DMA request to avoid an undefined
+ *    DMA request on the SDMA side.
  */
 
 static struct fsl_ssi_soc_data fsl_ssi_mpc8610 = {
@@ -342,18 +339,7 @@ static bool fsl_ssi_is_i2s_cbm_cfs(struct fsl_ssi *ssi)
 	return (ssi->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
 		SND_SOC_DAIFMT_CBM_CFS;
 }
-/**
- * fsl_ssi_isr: SSI interrupt handler
- *
- * Although it's possible to use the interrupt handler to send and receive
- * data to/from the SSI, we use the DMA instead.  Programming is more
- * complicated, but the performance is much better.
- *
- * This interrupt handler is used only to gather statistics.
- *
- * @irq: IRQ of the SSI device
- * @dev_id: pointer to the fsl_ssi structure for this SSI device
- */
+
 static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 {
 	struct fsl_ssi *ssi = dev_id;
@@ -361,10 +347,6 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	__be32 sisr;
 	__be32 sisr2;
 
-	/* We got an interrupt, so read the status register to see what we
-	   were interrupted for.  We mask it with the Interrupt Enable register
-	   so that we only check for events that we're interested in.
-	 */
 	regmap_read(regs, CCSR_SSI_SISR, &sisr);
 
 	sisr2 = sisr & ssi->soc->sisr_write_mask;
@@ -377,8 +359,8 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/*
- * Enable/Disable all rx/tx config flags at once.
+/**
+ * Enable or disable all rx/tx config flags at once
  */
 static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 {
@@ -405,13 +387,8 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 	}
 }
 
-/*
- * Clear RX or TX FIFO to remove samples from the previous
- * stream session which may be still present in the FIFO and
- * may introduce bad samples and/or channel slipping.
- *
- * Note: The SOR is not documented in recent IMX datasheet, but
- * is described in IMX51 reference manual at section 56.3.3.15.
+/**
+ * Clear remaining data in the FIFO to avoid dirty data or channel slipping
  */
 static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 {
@@ -424,7 +401,7 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 	}
 }
 
-/*
+/**
  * Calculate the bits that have to be disabled for the current stream that is
  * getting disabled. This keeps the bits enabled that are necessary for the
  * second stream to work if 'stream_active' is true.
@@ -444,9 +421,8 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 	((vals_disable) & \
 	 ((vals_disable) ^ ((vals_stream) * (u32)!!(stream_active))))
 
-/*
- * Enable/Disable a ssi configuration. You have to pass either
- * ssi->rxtx_reg_val.rx or tx as vals parameter.
+/**
+ * Enable or disable SSI configuration.
  */
 static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		struct fsl_ssi_reg_val *vals)
@@ -467,25 +443,21 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 	else
 		keep_active = 0;
 
-	/* Find the other direction values rx or tx which we do not want to
-	 * modify */
+	/* Get the opposite direction to keep its values untouched */
 	if (&ssi->rxtx_reg_val.rx == vals)
 		avals = &ssi->rxtx_reg_val.tx;
 	else
 		avals = &ssi->rxtx_reg_val.rx;
 
-	/* If vals should be disabled, start with disabling the unit */
 	if (!enable) {
+		/* Exclude necessary bits for the opposite stream */
 		u32 scr = fsl_ssi_disable_val(vals->scr, avals->scr,
 				keep_active);
+		/* Safely disable SCR register for the stream */
 		regmap_update_bits(regs, CCSR_SSI_SCR, scr, 0);
 	}
 
-	/*
-	 * We are running on a SoC which does not support online SSI
-	 * reconfiguration, so we have to enable all necessary flags at once
-	 * even if we do not use them later (capture and playback configuration)
-	 */
+	/* Online configuration not supported; re-enable all necessary bits */
 	if (ssi->soc->offline_config) {
 		if ((enable && !nr_active_streams) ||
 				(!enable && !keep_active))
@@ -494,10 +466,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		goto config_done;
 	}
 
-	/*
-	 * Configure single direction units while the SSI unit is running
-	 * (online configuration)
-	 */
+	/* Online configure single direction while SSI is running */
 	if (enable) {
 		fsl_ssi_fifo_clear(ssi, vals->scr & CCSR_SSI_SCR_RE);
 
@@ -509,16 +478,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		u32 srcr;
 		u32 stcr;
 
-		/*
-		 * Disabling the necessary flags for one of rx/tx while the
-		 * other stream is active is a little bit more difficult. We
-		 * have to disable only those flags that differ between both
-		 * streams (rx XOR tx) and that are set in the stream that is
-		 * disabled now. Otherwise we could alter flags of the other
-		 * stream
-		 */
-
-		/* These assignments are simply vals without bits set in avals*/
+		/* Exclude necessary bits for the opposite stream */
 		sier = fsl_ssi_disable_val(vals->sier, avals->sier,
 				keep_active);
 		srcr = fsl_ssi_disable_val(vals->srcr, avals->srcr,
@@ -526,6 +486,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		stcr = fsl_ssi_disable_val(vals->stcr, avals->stcr,
 				keep_active);
 
+		/* Safely disable other control registers for the stream */
 		regmap_update_bits(regs, CCSR_SSI_SRCR, srcr, 0);
 		regmap_update_bits(regs, CCSR_SSI_STCR, stcr, 0);
 		regmap_update_bits(regs, CCSR_SSI_SIER, sier, 0);
@@ -534,26 +495,17 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 config_done:
 	/* Enabling of subunits is done after configuration */
 	if (enable) {
+		/* Start DMA before setting TE to avoid underrun */
+		/* TODO: FIQ cases might also need this upon testing */
 		if (ssi->use_dma && (vals->scr & CCSR_SSI_SCR_TE)) {
-			/*
-			 * Be sure the Tx FIFO is filled when TE is set.
-			 * Otherwise, there are some chances to start the
-			 * playback with some void samples inserted first,
-			 * generating a channel slip.
-			 *
-			 * First, SSIEN must be set, to let the FIFO be filled.
-			 *
-			 * Notes:
-			 * - Limit this fix to the DMA case until FIQ cases can
-			 *   be tested.
-			 * - Limit the length of the busy loop to not lock the
-			 *   system too long, even if 1-2 loops are sufficient
-			 *   in general.
-			 */
 			int i;
 			int max_loop = 100;
+
+			/* Enable SSI first to send TX DMA request */
 			regmap_update_bits(regs, CCSR_SSI_SCR,
 					CCSR_SSI_SCR_SSIEN, CCSR_SSI_SCR_SSIEN);
+
+			/* Wait until TX FIFO not empty -- DMA working */
 			for (i = 0; i < max_loop; i++) {
 				u32 sfcsr;
 				regmap_read(regs, CCSR_SSI_SFCSR, &sfcsr);
@@ -565,6 +517,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 					"Timeout waiting TX FIFO filling\n");
 			}
 		}
+		/* Enable all remaining bits */
 		regmap_update_bits(regs, CCSR_SSI_SCR, vals->scr, vals->scr);
 	}
 }
@@ -581,20 +534,9 @@ static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi *ssi)
 
 	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
 	if (!ssi->soc->imx21regs) {
-		/*
-		 * Note that these below aren't just normal registers.
-		 * They are a way to disable or enable bits in SACCST
-		 * register:
-		 * - writing a '1' bit at some position in SACCEN sets the
-		 * relevant bit in SACCST,
-		 * - writing a '1' bit at some position in SACCDIS unsets
-		 * the relevant bit in SACCST register.
-		 *
-		 * The two writes below first disable all channels slots,
-		 * then enable just slots 3 & 4 ("PCM Playback Left Channel"
-		 * and "PCM Playback Right Channel").
-		 */
+		/* Disable all channel slots */
 		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
+		/* Enable slots 3 & 4 -- PCM Playback Left & Right channels */
 		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
 	}
 }
@@ -602,23 +544,11 @@ static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi *ssi)
 static void fsl_ssi_tx_config(struct fsl_ssi *ssi, bool enable)
 {
 	/*
-	 * Why are we setting up SACCST everytime we are starting a
-	 * playback?
-	 * Some CODECs (like VT1613 CODEC on UDOO board) like to
-	 * (sometimes) set extra bits in their SLOTREQ requests.
-	 * When a bit is set in a SLOTREQ request then SSI sets the
-	 * relevant bit in SACCST automatically (it is enough if a bit was
-	 * set in a SLOTREQ just once, bits in SACCST are 'sticky').
-	 * If an extra slot gets enabled that's a disaster for playback
-	 * because some of normal left or right channel samples are
-	 * redirected instead to this extra slot.
+	 * SACCST might be modified via AC Link by a CODEC if it sends
+	 * extra bits in their SLOTREQ requests, which'll accidentally
+	 * send valid data to slots other than normal playback slots.
 	 *
-	 * A workaround implemented in fsl-asoc-card of setting an
-	 * appropriate CODEC register so that slots 3 & 4 (the normal
-	 * stereo playback slots) are used for S/PDIF seems to mostly fix
-	 * this issue on the UDOO board but since this CODEC is so
-	 * untrustworthy let's play safe here and make sure that no extra
-	 * slots are enabled every time a playback is started.
+	 * To be safe, configure SACCST right before TX starts.
 	 */
 	if (enable && fsl_ssi_is_ac97(ssi))
 		fsl_ssi_tx_ac97_saccst_setup(ssi);
@@ -626,10 +556,8 @@ static void fsl_ssi_tx_config(struct fsl_ssi *ssi, bool enable)
 	fsl_ssi_config(ssi, enable, &ssi->rxtx_reg_val.tx);
 }
 
-/*
- * Setup rx/tx register values used to enable/disable the streams. These will
- * be used later in fsl_ssi_config to setup the streams without the need to
- * check for all different SSI modes.
+/**
+ * Cache register values to later set them at once
  */
 static void fsl_ssi_setup_reg_vals(struct fsl_ssi *ssi)
 {
@@ -663,24 +591,17 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
 {
 	struct regmap *regs = ssi->regs;
 
-	/*
-	 * Setup the clock control register
-	 */
+	/* Setup the clock control register */
 	regmap_write(regs, CCSR_SSI_STCCR,
 			CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13));
 	regmap_write(regs, CCSR_SSI_SRCCR,
 			CCSR_SSI_SxCCR_WL(17) | CCSR_SSI_SxCCR_DC(13));
 
-	/*
-	 * Enable AC97 mode and startup the SSI
-	 */
+	/* Enable AC97 mode and startup the SSI */
 	regmap_write(regs, CCSR_SSI_SACNT,
 			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
 
-	/*
-	 * Enable SSI, Transmit and Receive. AC97 has to communicate with the
-	 * codec before a stream is started.
-	 */
+	/* AC97 has to communicate with codec before starting a stream */
 	regmap_update_bits(regs, CCSR_SSI_SCR,
 			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE,
 			CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
@@ -688,14 +609,6 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi *ssi)
 	regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_WAIT(3));
 }
 
-/**
- * fsl_ssi_startup: create a new substream
- *
- * This is the first function called when a stream is opened.
- *
- * If this is the first stream open, then grab the IRQ and program most of
- * the SSI registers.
- */
 static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
@@ -707,7 +620,8 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	if (ret)
 		return ret;
 
-	/* When using dual fifo mode, it is safer to ensure an even period
+	/*
+	 * When using dual fifo mode, it is safer to ensure an even period
 	 * size. If appearing to an odd number while DMA always starts its
 	 * task from fifo0, fifo1 would be neglected at the end of each
 	 * period. But SSI would still access fifo1 with an invalid data.
@@ -719,10 +633,6 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/**
- * fsl_ssi_shutdown: shutdown the SSI
- *
- */
 static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
@@ -734,7 +644,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 }
 
 /**
- * fsl_ssi_set_bclk - configure Digital Audio Interface bit clock
+ * Configure Digital Audio Interface bit clock
  *
  * Note: This function can be only called when using SSI as DAI master
  *
@@ -851,17 +761,12 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 }
 
 /**
- * fsl_ssi_hw_params - program the sample size
+ * Configure SSI based on PCM hardware parameters
  *
- * Most of the SSI registers have been programmed in the startup function,
- * but the word length must be programmed here.  Unfortunately, programming
- * the SxCCR.WL bits requires the SSI to be temporarily disabled.  This can
- * cause a problem with supporting simultaneous playback and capture.  If
- * the SSI is already playing a stream, then that stream may be temporarily
- * stopped when you start capture.
- *
- * Note: The SxCCR.DC and SxCCR.PM bits are only used if the SSI is the
- * clock master.
+ * Notes:
+ * 1) Setting SxCCR.WL bits requires the SSI to be temporarily disabled.
+ *    It creates limitation to support simultaneous playback and capture.
+ * 2) SxCCR.DC and SxCCR.PM bits will be configured if SSI is clock master.
  */
 static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *cpu_dai)
@@ -878,10 +783,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	regmap_read(regs, CCSR_SSI_SCR, &scr_val);
 	enabled = scr_val & CCSR_SSI_SCR_SSIEN;
 
-	/*
-	 * If we're in synchronous mode, and the SSI is already enabled,
-	 * then STCCR is already set properly.
-	 */
+	/* To support simultaneous TX and RX, bypass it if SSI is enabled */
 	if (enabled && ssi->cpu_dai_drv.symmetric_rates)
 		return 0;
 
@@ -902,10 +804,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 
 	if (!fsl_ssi_is_ac97(ssi)) {
 		u8 i2smode;
-		/*
-		 * Switch to normal net mode in order to have a frame sync
-		 * signal every 32 bits instead of 16 bits
-		 */
+		/* Normal + Network mode to send 16-bit data in 32-bit frames */
 		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
 			i2smode = CCSR_SSI_SCR_I2S_MODE_NORMAL |
 				CCSR_SSI_SCR_NET;
@@ -917,16 +816,6 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 				channels == 1 ? 0 : i2smode);
 	}
 
-	/*
-	 * FIXME: The documentation says that SxCCR[WL] should not be
-	 * modified while the SSI is enabled.  The only time this can
-	 * happen is if we're trying to do simultaneous playback and
-	 * capture in asynchronous mode.  Unfortunately, I have been enable
-	 * to get that to work at all on the P1022DS.  Therefore, we don't
-	 * bother to disable/enable the SSI when setting SxCCR[WL], because
-	 * the SSI will stop anyway.  Maybe one day, this will get fixed.
-	 */
-
 	/* In synchronous mode, the SSI uses STCCR for capture */
 	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
 	    ssi->cpu_dai_drv.symmetric_rates)
@@ -1106,7 +995,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 }
 
 /**
- * fsl_ssi_set_dai_fmt - configure Digital Audio Interface Format.
+ * Configure Digital Audio Interface (DAI) Format
  */
 static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 {
@@ -1119,9 +1008,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 }
 
 /**
- * fsl_ssi_set_dai_tdm_slot - set TDM slot number
- *
- * Note: This function can be only called when using SSI as DAI master
+ * Set TDM slot number and slot width
  */
 static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 				u32 rx_mask, int slots, int slot_width)
@@ -1149,9 +1036,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	regmap_update_bits(regs, CCSR_SSI_SRCCR, CCSR_SSI_SxCCR_DC_MASK,
 			CCSR_SSI_SxCCR_DC(slots));
 
-	/* The register SxMSKs needs SSI to provide essential clock due to
-	 * hardware design. So we here temporarily enable SSI to set them.
-	 */
+	/* Temporarily enable SSI to allow SxMSKs to be configurable */
 	regmap_read(regs, CCSR_SSI_SCR, &val);
 	val &= CCSR_SSI_SCR_SSIEN;
 	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN,
@@ -1160,6 +1045,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	regmap_write(regs, CCSR_SSI_STMSK, ~tx_mask);
 	regmap_write(regs, CCSR_SSI_SRMSK, ~rx_mask);
 
+	/* Then disable it */
 	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, val);
 
 	ssi->slot_width = slot_width;
@@ -1169,13 +1055,7 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 }
 
 /**
- * fsl_ssi_trigger: start and stop the DMA transfer.
- *
- * This function is called by ALSA to start, stop, pause, and resume the DMA
- * transfer of data.
- *
- * The DMA channel is in external master start and pause mode, which
- * means the SSI completely controls the flow of data.
+ * Start or stop SSI and corresponding DMA transaction.
  */
 static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			   struct snd_soc_dai *dai)
@@ -1207,6 +1087,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
+	/* Clear corresponding FIFO */
 	if (fsl_ssi_is_ac97(ssi)) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			regmap_write(regs, CCSR_SSI_SOR, CCSR_SSI_SOR_TX_CLR);
@@ -1239,7 +1120,6 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.trigger	= fsl_ssi_trigger,
 };
 
-/* Template for the CPU dai driver structure */
 static struct snd_soc_dai_driver fsl_ssi_dai_template = {
 	.probe = fsl_ssi_dai_probe,
 	.playback = {
@@ -1383,6 +1263,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	u32 dmas[4];
 	int ret;
 
+	/* Backward compatible for a DT without ipg clock name assigned */
 	if (ssi->has_ipg_clk_name)
 		ssi->clk = devm_clk_get(dev, "ipg");
 	else
@@ -1393,6 +1274,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		return ret;
 	}
 
+	/* Enable the clock since regmap will not handle it in this case */
 	if (!ssi->has_ipg_clk_name) {
 		ret = clk_prepare_enable(ssi->clk);
 		if (ret) {
@@ -1401,9 +1283,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		}
 	}
 
-	/* For those SLAVE implementations, we ignore non-baudclk cases
-	 * and, instead, abandon MASTER mode that needs baud clock.
-	 */
+	/* Do not error out for slave cases that live without a baud clock */
 	ssi->baudclk = devm_clk_get(dev, "baud");
 	if (IS_ERR(ssi->baudclk))
 		dev_dbg(dev, "could not get baud clock: %ld\n",
@@ -1414,25 +1294,17 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 	ssi->dma_params_tx.addr = ssi->ssi_phys + CCSR_SSI_STX0;
 	ssi->dma_params_rx.addr = ssi->ssi_phys + CCSR_SSI_SRX0;
 
+	/* Set to dual FIFO mode according to the SDMA sciprt */
 	ret = of_property_read_u32_array(np, "dmas", dmas, 4);
 	if (ssi->use_dma && !ret && dmas[2] == IMX_DMATYPE_SSI_DUAL) {
 		ssi->use_dual_fifo = true;
-		/* When using dual fifo mode, we need to keep watermark
-		 * as even numbers due to dma script limitation.
-		 */
+		/* Use even numbers to avoid channel swap due to SDMA script */
 		ssi->dma_params_tx.maxburst &= ~0x1;
 		ssi->dma_params_rx.maxburst &= ~0x1;
 	}
 
 	if (!ssi->use_dma) {
-
-		/*
-		 * Some boards use an incompatible codec. To get it
-		 * working, we are using imx-fiq-pcm-audio, that
-		 * can handle those codecs. DMA is not possible in this
-		 * situation.
-		 */
-
+		/* Use imx-fiq-pcm-audio for codec incompatible with DMA */
 		ssi->fiq_params.irq = ssi->irq;
 		ssi->fiq_params.base = iomem;
 		ssi->fiq_params.dma_params_rx = &ssi->dma_params_rx;
@@ -1490,12 +1362,14 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ssi->soc = of_id->data;
 	ssi->dev = dev;
 
+	/* Check if being used in AC97 mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (sprop) {
 		if (!strcmp(sprop, "ac97-slave"))
 			ssi->dai_fmt = SND_SOC_DAIFMT_AC97;
 	}
 
+	/* Select DMA or FIQ */
 	ssi->use_dma = !of_property_read_bool(np, "fsl,fiq-stream-filter");
 
 	if (fsl_ssi_is_ac97(ssi)) {
@@ -1504,7 +1378,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 		fsl_ac97_data = ssi;
 	} else {
-		/* Initialize this copy of the CPU DAI driver structure */
 		memcpy(&ssi->cpu_dai_drv, &fsl_ssi_dai_template,
 		       sizeof(fsl_ssi_dai_template));
 	}
@@ -1517,10 +1390,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	ssi->ssi_phys = res->start;
 
 	if (ssi->soc->imx21regs) {
-		/*
-		 * According to datasheet imx21-class SSI
-		 * don't have SACC{ST,EN,DIS} regs.
-		 */
+		/* No SACC{ST,EN,DIS} regs in imx21-class SSI */
 		regconfig.max_register = CCSR_SSI_SRMSK;
 		regconfig.num_reg_defaults_raw =
 			CCSR_SSI_SRMSK / sizeof(uint32_t) + 1;
@@ -1546,7 +1416,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return ssi->irq;
 	}
 
-	/* Are the RX and the TX clocks locked? */
+	/* Set software limitations for synchronous mode */
 	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
 		if (!fsl_ssi_is_ac97(ssi)) {
 			ssi->cpu_dai_drv.symmetric_rates = 1;
@@ -1556,50 +1426,28 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ssi->cpu_dai_drv.symmetric_channels = 1;
 	}
 
-	/* Determine the FIFO depth. */
+	/* Fetch FIFO depth; Set to 8 for older DT without this property */
 	iprop = of_get_property(np, "fsl,fifo-depth", NULL);
 	if (iprop)
 		ssi->fifo_depth = be32_to_cpup(iprop);
 	else
-                /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi->fifo_depth = 8;
 
 	/*
-	 * Set the watermark for transmit FIFO 0 and receive FIFO 0. We don't
-	 * use FIFO 1 but set the watermark appropriately nontheless.
-	 * We program the transmit water to signal a DMA transfer
-	 * if there are N elements left in the FIFO. For chips with 15-deep
-	 * FIFOs, set watermark to 8.  This allows the SSI to operate at a
-	 * high data rate without channel slipping. Behavior is unchanged
-	 * for the older chips with a fifo depth of only 8.  A value of 4
-	 * might be appropriate for the older chips, but is left at
-	 * fifo_depth-2 until sombody has a chance to test.
+	 * Configure TX and RX DMA watermarks.
 	 *
-	 * We set the watermark on the same level as the DMA burstsize.  For
-	 * fiq it is probably better to use the biggest possible watermark
-	 * size.
+	 * Values should be tested to avoid FIFO under/over run. Set maxburst
+	 * to fifo_watermark to maxiumize DMA transaction to reduce overhead.
 	 */
 	switch (ssi->fifo_depth) {
 	case 15:
-		/*
-		 * 2 samples is not enough when running at high data
-		 * rates (like 48kHz @ 16 bits/channel, 16 channels)
-		 * 8 seems to split things evenly and leave enough time
-		 * for the DMA to fill the FIFO before it's over/under
-		 * run.
-		 */
+		/* Tested with cases running at 48kHz @ 16 bits x 16 channels */
 		ssi->fifo_watermark = 8;
 		ssi->dma_maxburst = 8;
 		break;
 	case 8:
 	default:
-		/*
-		 * maintain old behavior for older chips.
-		 * Keeping it the same because I don't have an older
-		 * board to test with.
-		 * I suspect this could be changed to be something to
-		 * leave some more space in the fifo.
-		 */
+		/* Use old watermark configurations for older chips */
 		ssi->fifo_watermark = ssi->fifo_depth - 2;
 		ssi->dma_maxburst = ssi->fifo_depth - 2;
 		break;
@@ -1642,18 +1490,14 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_asoc_register;
 
-	/*
-	 * If codec-handle property is missing from SSI node, we assume
-	 * that the machine driver uses new binding which does not require
-	 * SSI driver to trigger machine driver's probe.
-	 */
+	/* Bypass it if using newer DT bindings of ASoC machine drivers */
 	if (!of_get_property(np, "codec-handle", NULL))
 		goto done;
 
-	/* Trigger the machine driver's probe function.  The platform driver
-	 * name of the machine driver is taken from /compatible property of the
-	 * device tree.  We also pass the address of the CPU DAI driver
-	 * structure.
+	/*
+	 * Backward compatible for older bindings by manually triggering the
+	 * machine driver's probe(). Use /compatible property, including the
+	 * address of CPU DAI driver structure, as the name of machine driver.
 	 */
 	sprop = of_get_property(of_find_node_by_path("/"), "compatible", NULL);
 	/* Sometimes the compatible name has a "fsl," prefix, so we strip it. */
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 5cf56d2..a16b82a 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -1,5 +1,5 @@
 /*
- * fsl_ssi.h - ALSA SSI interface for the Freescale MPC8610 SoC
+ * fsl_ssi.h - ALSA SSI interface for the Freescale MPC8610 and i.MX SoC
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
@@ -12,31 +12,75 @@
 #ifndef _MPC8610_I2S_H
 #define _MPC8610_I2S_H
 
-/* SSI registers */
+/* -- SSI Register Map -- */
+
+/* SSI Transmit Data Register 0 */
 #define CCSR_SSI_STX0			0x00
+/* SSI Transmit Data Register 1 */
 #define CCSR_SSI_STX1			0x04
+/* SSI Receive Data Register 0 */
 #define CCSR_SSI_SRX0			0x08
+/* SSI Receive Data Register 1 */
 #define CCSR_SSI_SRX1			0x0c
+/* SSI Control Register */
 #define CCSR_SSI_SCR			0x10
+/* SSI Interrupt Status Register */
 #define CCSR_SSI_SISR			0x14
+/* SSI Interrupt Enable Register */
 #define CCSR_SSI_SIER			0x18
+/* SSI Transmit Configuration Register */
 #define CCSR_SSI_STCR			0x1c
+/* SSI Receive Configuration Register */
 #define CCSR_SSI_SRCR			0x20
+/* SSI Transmit Clock Control Register */
 #define CCSR_SSI_STCCR			0x24
+/* SSI Receive Clock Control Register */
 #define CCSR_SSI_SRCCR			0x28
+/* SSI FIFO Control/Status Register */
 #define CCSR_SSI_SFCSR			0x2c
+/*
+ * SSI Test Register (Intended for debugging purposes only)
+ *
+ * Note: STR is not documented in recent IMX datasheet, but
+ * is described in IMX51 reference manual at section 56.3.3.14
+ */
 #define CCSR_SSI_STR			0x30
+/*
+ * SSI Option Register (Intended for internal use only)
+ *
+ * Note: SOR is not documented in recent IMX datasheet, but
+ * is described in IMX51 reference manual at section 56.3.3.15
+ */
 #define CCSR_SSI_SOR			0x34
+/* SSI AC97 Control Register */
 #define CCSR_SSI_SACNT			0x38
+/* SSI AC97 Command Address Register */
 #define CCSR_SSI_SACADD			0x3c
+/* SSI AC97 Command Data Register */
 #define CCSR_SSI_SACDAT			0x40
+/* SSI AC97 Tag Register */
 #define CCSR_SSI_SATAG			0x44
+/* SSI Transmit Time Slot Mask Register */
 #define CCSR_SSI_STMSK			0x48
+/* SSI  Receive Time Slot Mask Register */
 #define CCSR_SSI_SRMSK			0x4c
+/*
+ * SSI AC97 Channel Status Register
+ *
+ * The status could be changed by:
+ * 1) Writing a '1' bit at some position in SACCEN sets relevant bit in SACCST
+ * 2) Writing a '1' bit at some position in SACCDIS unsets the relevant bit
+ * 3) Receivng a '1' in SLOTREQ bit from external CODEC via AC Link
+ */
 #define CCSR_SSI_SACCST			0x50
+/* SSI AC97 Channel Enable Register -- Set bits in SACCST */
 #define CCSR_SSI_SACCEN			0x54
+/* SSI AC97 Channel Disable Register -- Clear bits in SACCST */
 #define CCSR_SSI_SACCDIS		0x58
 
+/* -- SSI Register Field Maps -- */
+
+/* SSI Control Register -- CCSR_SSI_SCR 0x10 */
 #define CCSR_SSI_SCR_SYNC_TX_FS		0x00001000
 #define CCSR_SSI_SCR_RFR_CLK_DIS	0x00000800
 #define CCSR_SSI_SCR_TFR_CLK_DIS	0x00000400
@@ -52,6 +96,7 @@
 #define CCSR_SSI_SCR_TE			0x00000002
 #define CCSR_SSI_SCR_SSIEN		0x00000001
 
+/* SSI Interrupt Status Register -- CCSR_SSI_SISR 0x14 */
 #define CCSR_SSI_SISR_RFRC		0x01000000
 #define CCSR_SSI_SISR_TFRC		0x00800000
 #define CCSR_SSI_SISR_CMDAU		0x00040000
@@ -74,6 +119,7 @@
 #define CCSR_SSI_SISR_TFE1		0x00000002
 #define CCSR_SSI_SISR_TFE0		0x00000001
 
+/* SSI Interrupt Enable Register -- CCSR_SSI_SIER 0x18 */
 #define CCSR_SSI_SIER_RFRC_EN		0x01000000
 #define CCSR_SSI_SIER_TFRC_EN		0x00800000
 #define CCSR_SSI_SIER_RDMAE		0x00400000
@@ -100,6 +146,7 @@
 #define CCSR_SSI_SIER_TFE1_EN		0x00000002
 #define CCSR_SSI_SIER_TFE0_EN		0x00000001
 
+/* SSI Transmit Configuration Register -- CCSR_SSI_STCR 0x1C */
 #define CCSR_SSI_STCR_TXBIT0		0x00000200
 #define CCSR_SSI_STCR_TFEN1		0x00000100
 #define CCSR_SSI_STCR_TFEN0		0x00000080
@@ -111,6 +158,7 @@
 #define CCSR_SSI_STCR_TFSL		0x00000002
 #define CCSR_SSI_STCR_TEFS		0x00000001
 
+/* SSI Receive Configuration Register -- CCSR_SSI_SRCR 0x20 */
 #define CCSR_SSI_SRCR_RXEXT		0x00000400
 #define CCSR_SSI_SRCR_RXBIT0		0x00000200
 #define CCSR_SSI_SRCR_RFEN1		0x00000100
@@ -123,7 +171,10 @@
 #define CCSR_SSI_SRCR_RFSL		0x00000002
 #define CCSR_SSI_SRCR_REFS		0x00000001
 
-/* STCCR and SRCCR */
+/*
+ * SSI Transmit Clock Control Register -- CCSR_SSI_STCCR 0x24
+ * SSI Receive Clock Control Register -- CCSR_SSI_SRCCR 0x28
+ */
 #define CCSR_SSI_SxCCR_DIV2_SHIFT	18
 #define CCSR_SSI_SxCCR_DIV2		0x00040000
 #define CCSR_SSI_SxCCR_PSR_SHIFT	17
@@ -142,9 +193,10 @@
 	((((x) - 1) << CCSR_SSI_SxCCR_PM_SHIFT) & CCSR_SSI_SxCCR_PM_MASK)
 
 /*
- * The xFCNT bits are read-only, and the xFWM bits are read/write.  Use the
- * CCSR_SSI_SFCSR_xFCNTy() macros to read the FIFO counters, and use the
- * CCSR_SSI_SFCSR_xFWMy() macros to set the watermarks.
+ * SSI FIFO Control/Status Register -- CCSR_SSI_SFCSR 0x2c
+ *
+ * Tx or Rx FIFO Counter -- CCSR_SSI_SFCSR_xFCNTy Read-Only
+ * Tx or Rx FIFO Watermarks -- CCSR_SSI_SFCSR_xFWMy Read/Write
  */
 #define CCSR_SSI_SFCSR_RFCNT1_SHIFT	28
 #define CCSR_SSI_SFCSR_RFCNT1_MASK	0xF0000000
@@ -179,6 +231,7 @@
 #define CCSR_SSI_SFCSR_TFWM0(x)	\
 	(((x) << CCSR_SSI_SFCSR_TFWM0_SHIFT) & CCSR_SSI_SFCSR_TFWM0_MASK)
 
+/* SSI Test Register -- CCSR_SSI_STR 0x30 */
 #define CCSR_SSI_STR_TEST		0x00008000
 #define CCSR_SSI_STR_RCK2TCK		0x00004000
 #define CCSR_SSI_STR_RFS2TFS		0x00002000
@@ -188,6 +241,7 @@
 #define CCSR_SSI_STR_TFS2RFS		0x00000020
 #define CCSR_SSI_STR_TXSTATE(x) ((x) & 0x1F)
 
+/* SSI Option Register -- CCSR_SSI_SOR 0x34 */
 #define CCSR_SSI_SOR_CLKOFF		0x00000040
 #define CCSR_SSI_SOR_RX_CLR		0x00000020
 #define CCSR_SSI_SOR_TX_CLR		0x00000010
@@ -197,6 +251,7 @@
 #define CCSR_SSI_SOR_WAIT(x) (((x) & 3) << CCSR_SSI_SOR_WAIT_SHIFT)
 #define CCSR_SSI_SOR_SYNRST 		0x00000001
 
+/* SSI AC97 Control Register -- CCSR_SSI_SACNT 0x38 */
 #define CCSR_SSI_SACNT_FRDIV(x)		(((x) & 0x3f) << 5)
 #define CCSR_SSI_SACNT_WR		0x00000010
 #define CCSR_SSI_SACNT_RD		0x00000008
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 5469ffb..9c7fa6c 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -82,9 +82,10 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 		dbg->stats.tfe0++;
 }
 
-/* Show the statistics of a flag only if its interrupt is enabled.  The
- * compiler will optimze this code to a no-op if the interrupt is not
- * enabled.
+/**
+ * Show the statistics of a flag only if its interrupt is enabled
+ *
+ * Compilers will optimze it to a no-op if the interrupt is disabled
  */
 #define SIER_SHOW(flag, name) \
 	do { \
@@ -94,10 +95,9 @@ void fsl_ssi_dbg_isr(struct fsl_ssi_dbg *dbg, u32 sisr)
 
 
 /**
- * fsl_sysfs_ssi_show: display SSI statistics
+ * Display the statistics for the current SSI device
  *
- * Display the statistics for the current SSI device.  To avoid confusion,
- * we only show those counts that are enabled.
+ * To avoid confusion, only show those counts that are enabled
  */
 static int fsl_ssi_stats_show(struct seq_file *s, void *unused)
 {
-- 
2.7.4
