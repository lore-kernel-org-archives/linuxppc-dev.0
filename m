Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKgDc6lgZzF0Yv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 15:22:24 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id k19so7475417pfj.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 20:22:24 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v3 07/17] ASoC: fsl_ssi: Clean up helper functions of trigger()
Date: Sun, 14 Jan 2018 20:21:17 -0800
Message-Id: <1515990087-11598-8-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The trigger() calls fsl_ssi_tx_config() and fsl_ssi_rx_config(),
and both of them jump to fsl_ssi_config(). And fsl_ssi_config()
later calls another fsl_ssi_rxtx_config().

However, the whole routine, especially fsl_ssi_config() function,
is too complicated because of the folowing reasons:
1) It has to handle the concern of the opposite stream.
2) It has to handle cases of offline configurations support.
3) It has to handle enable and disable operations while they're
   mostly different.

Since the enable and disable routines have more differences than
TX and RX rountines, this patch simplifies these helper functions
with the following changes:
- Changing to two helper functions of enable and disable instead
  of TX and RX.
- Removing fsl_ssi_rxtx_config() by separately integrating it to
  two newly introduced enable & disable functions.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 256 +++++++++++++++++++++++-------------------------
 1 file changed, 122 insertions(+), 134 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index a2ac92f..7a6a32b 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -382,31 +382,83 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 }
 
 /**
- * Enable or disable all rx/tx config flags at once
+ * Set SCR, SIER, STCR and SRCR registers with cached values in regvals
+ *
+ * Notes:
+ * 1) For offline_config SoCs, enable all necessary bits of both streams
+ *    when 1st stream starts, even if the opposite stream will not start
+ * 2) It also clears FIFO before setting regvals; SOR is safe to set online
  */
-static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
+static void fsl_ssi_config_enable(struct fsl_ssi *ssi, bool tx)
 {
-	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_regvals *vals = ssi->regvals;
+	int dir = tx ? TX : RX;
+	u32 sier, srcr, stcr;
 
-	if (enable) {
-		regmap_update_bits(regs, REG_SSI_SIER,
-				   vals[RX].sier | vals[TX].sier,
-				   vals[RX].sier | vals[TX].sier);
-		regmap_update_bits(regs, REG_SSI_SRCR,
-				   vals[RX].srcr | vals[TX].srcr,
-				   vals[RX].srcr | vals[TX].srcr);
-		regmap_update_bits(regs, REG_SSI_STCR,
-				   vals[RX].stcr | vals[TX].stcr,
-				   vals[RX].stcr | vals[TX].stcr);
+	/* Clear dirty data in the FIFO; It also prevents channel slipping */
+	regmap_update_bits(ssi->regs, REG_SSI_SOR,
+			   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
+
+	/*
+	 * On offline_config SoCs, SxCR and SIER are already configured when
+	 * the previous stream started. So skip all SxCR and SIER settings
+	 * to prevent online reconfigurations, then jump to set SCR directly
+	 */
+	if (ssi->soc->offline_config && ssi->streams)
+		goto enable_scr;
+
+	if (ssi->soc->offline_config) {
+		/*
+		 * Online reconfiguration not supported, so enable all bits for
+		 * both streams at once to avoid necessity of reconfigurations
+		 */
+		srcr = vals[RX].srcr | vals[TX].srcr;
+		stcr = vals[RX].stcr | vals[TX].stcr;
+		sier = vals[RX].sier | vals[TX].sier;
 	} else {
-		regmap_update_bits(regs, REG_SSI_SRCR,
-				   vals[RX].srcr | vals[TX].srcr, 0);
-		regmap_update_bits(regs, REG_SSI_STCR,
-				   vals[RX].stcr | vals[TX].stcr, 0);
-		regmap_update_bits(regs, REG_SSI_SIER,
-				   vals[RX].sier | vals[TX].sier, 0);
+		/* Otherwise, only set bits for the current stream */
+		srcr = vals[dir].srcr;
+		stcr = vals[dir].stcr;
+		sier = vals[dir].sier;
 	}
+
+	/* Configure SRCR, STCR and SIER at once */
+	regmap_update_bits(ssi->regs, REG_SSI_SRCR, srcr, srcr);
+	regmap_update_bits(ssi->regs, REG_SSI_STCR, stcr, stcr);
+	regmap_update_bits(ssi->regs, REG_SSI_SIER, sier, sier);
+
+enable_scr:
+	/*
+	 * Start DMA before setting TE to avoid FIFO underrun
+	 * which may cause a channel slip or a channel swap
+	 *
+	 * TODO: FIQ cases might also need this upon testing
+	 */
+	if (ssi->use_dma && tx) {
+		int try = 100;
+		u32 sfcsr;
+
+		/* Enable SSI first to send TX DMA request */
+		regmap_update_bits(ssi->regs, REG_SSI_SCR,
+				   SSI_SCR_SSIEN, SSI_SCR_SSIEN);
+
+		/* Busy wait until TX FIFO not empty -- DMA working */
+		do {
+			regmap_read(ssi->regs, REG_SSI_SFCSR, &sfcsr);
+			if (SSI_SFCSR_TFCNT0(sfcsr))
+				break;
+		} while (--try);
+
+		/* FIFO still empty -- something might be wrong */
+		if (!SSI_SFCSR_TFCNT0(sfcsr))
+			dev_warn(ssi->dev, "Timeout waiting TX FIFO filling\n");
+	}
+	/* Enable all remaining bits in SCR */
+	regmap_update_bits(ssi->regs, REG_SSI_SCR,
+			   vals[dir].scr, vals[dir].scr);
+
+	/* Log the enabled stream to the mask */
+	ssi->streams |= BIT(dir);
 }
 
 /**
@@ -430,14 +482,17 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 	((vals) & _ssi_xor_shared_bits(vals, avals, aactive))
 
 /**
- * Enable or disable SSI configuration.
+ * Unset SCR, SIER, STCR and SRCR registers with cached values in regvals
+ *
+ * Notes:
+ * 1) For offline_config SoCs, to avoid online reconfigurations, disable all
+ *    bits of both streams at once when the last stream is abort to end
+ * 2) It also clears FIFO after unsetting regvals; SOR is safe to set online
  */
-static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
-			   struct fsl_ssi_regvals *vals)
+static void fsl_ssi_config_disable(struct fsl_ssi *ssi, bool tx)
 {
-	bool tx = &ssi->regvals[TX] == vals;
-	struct regmap *regs = ssi->regs;
-	struct fsl_ssi_regvals *avals;
+	struct fsl_ssi_regvals *vals, *avals;
+	u32 sier, srcr, stcr, scr;
 	int adir = tx ? RX : TX;
 	int dir = tx ? TX : RX;
 	bool aactive;
@@ -445,52 +500,36 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 	/* Check if the opposite stream is active */
 	aactive = ssi->streams & BIT(adir);
 
-	/* Get the opposite direction to keep its values untouched */
-	if (&ssi->regvals[RX] == vals)
-		avals = &ssi->regvals[TX];
-	else
-		avals = &ssi->regvals[RX];
+	vals = &ssi->regvals[dir];
 
-	if (!enable) {
-		/*
-		 * To keep the other stream safe, exclude shared bits between
-		 * both streams, and get safe bits to disable current stream
-		 */
-		u32 scr = ssi_excl_shared_bits(vals->scr, avals->scr, aactive);
-		/* Safely disable SCR register for the stream */
-		regmap_update_bits(regs, REG_SSI_SCR, scr, 0);
-
-		/* Log the disabled stream to the mask */
-		ssi->streams &= ~BIT(dir);
-	}
+	/* Get regvals of the opposite stream to keep opposite stream safe */
+	avals = &ssi->regvals[adir];
 
 	/*
-	 * For cases where online configuration is not supported,
-	 * 1) Enable all necessary bits of both streams when 1st stream starts
-	 *    even if the opposite stream will not start
-	 * 2) Disable all remaining bits of both streams when last stream ends
+	 * To keep the other stream safe, exclude shared bits between
+	 * both streams, and get safe bits to disable current stream
 	 */
-	if (ssi->soc->offline_config) {
-		if ((enable && !ssi->streams) || (!enable && !aactive))
-			fsl_ssi_rxtx_config(ssi, enable);
+	scr = ssi_excl_shared_bits(vals->scr, avals->scr, aactive);
 
-		goto config_done;
-	}
+	/* Disable safe bits of SCR register for the current stream */
+	regmap_update_bits(ssi->regs, REG_SSI_SCR, scr, 0);
 
-	/* Online configure single direction while SSI is running */
-	if (enable) {
-		/* Clear FIFO to prevent dirty data or channel slipping */
-		regmap_update_bits(ssi->regs, REG_SSI_SOR,
-				   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
+	/* Log the disabled stream to the mask */
+	ssi->streams &= ~BIT(dir);
 
-		regmap_update_bits(regs, REG_SSI_SRCR, vals->srcr, vals->srcr);
-		regmap_update_bits(regs, REG_SSI_STCR, vals->stcr, vals->stcr);
-		regmap_update_bits(regs, REG_SSI_SIER, vals->sier, vals->sier);
-	} else {
-		u32 sier;
-		u32 srcr;
-		u32 stcr;
+	/*
+	 * On offline_config SoCs, if the other stream is active, skip
+	 * SxCR and SIER settings to prevent online reconfigurations
+	 */
+	if (ssi->soc->offline_config && aactive)
+		goto fifo_clear;
 
+	if (ssi->soc->offline_config) {
+		/* Now there is only current stream active, disable all bits */
+		srcr = vals->srcr | avals->srcr;
+		stcr = vals->stcr | avals->stcr;
+		sier = vals->sier | avals->sier;
+	} else {
 		/*
 		 * To keep the other stream safe, exclude shared bits between
 		 * both streams, and get safe bits to disable current stream
@@ -498,57 +537,17 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		sier = ssi_excl_shared_bits(vals->sier, avals->sier, aactive);
 		srcr = ssi_excl_shared_bits(vals->srcr, avals->srcr, aactive);
 		stcr = ssi_excl_shared_bits(vals->stcr, avals->stcr, aactive);
-
-		/* Safely disable other control registers for the stream */
-		regmap_update_bits(regs, REG_SSI_SRCR, srcr, 0);
-		regmap_update_bits(regs, REG_SSI_STCR, stcr, 0);
-		regmap_update_bits(regs, REG_SSI_SIER, sier, 0);
-
-		/* Clear FIFO to prevent dirty data or channel slipping */
-		regmap_update_bits(ssi->regs, REG_SSI_SOR,
-				   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 	}
 
-config_done:
-	/* Enabling of subunits is done after configuration */
-	if (enable) {
-		/*
-		 * Start DMA before setting TE to avoid FIFO underrun
-		 * which may cause a channel slip or a channel swap
-		 *
-		 * TODO: FIQ cases might also need this upon testing
-		 */
-		if (ssi->use_dma && (vals->scr & SSI_SCR_TE)) {
-			int i;
-			int max_loop = 100;
-
-			/* Enable SSI first to send TX DMA request */
-			regmap_update_bits(regs, REG_SSI_SCR,
-					   SSI_SCR_SSIEN, SSI_SCR_SSIEN);
-
-			/* Busy wait until TX FIFO not empty -- DMA working */
-			for (i = 0; i < max_loop; i++) {
-				u32 sfcsr;
-				regmap_read(regs, REG_SSI_SFCSR, &sfcsr);
-				if (SSI_SFCSR_TFCNT0(sfcsr))
-					break;
-			}
-			if (i == max_loop) {
-				dev_err(ssi->dev,
-					"Timeout waiting TX FIFO filling\n");
-			}
-		}
-		/* Enable all remaining bits */
-		regmap_update_bits(regs, REG_SSI_SCR, vals->scr, vals->scr);
-
-		/* Log the enabled stream to the mask */
-		ssi->streams |= BIT(dir);
-	}
-}
+	/* Clear configurations of SRCR, STCR and SIER at once */
+	regmap_update_bits(ssi->regs, REG_SSI_SRCR, srcr, 0);
+	regmap_update_bits(ssi->regs, REG_SSI_STCR, stcr, 0);
+	regmap_update_bits(ssi->regs, REG_SSI_SIER, sier, 0);
 
-static void fsl_ssi_rx_config(struct fsl_ssi *ssi, bool enable)
-{
-	fsl_ssi_config(ssi, enable, &ssi->regvals[RX]);
+fifo_clear:
+	/* Clear remaining data in the FIFO */
+	regmap_update_bits(ssi->regs, REG_SSI_SOR,
+			   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 }
 
 static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi *ssi)
@@ -564,21 +563,6 @@ static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi *ssi)
 	}
 }
 
-static void fsl_ssi_tx_config(struct fsl_ssi *ssi, bool enable)
-{
-	/*
-	 * SACCST might be modified via AC Link by a CODEC if it sends
-	 * extra bits in their SLOTREQ requests, which'll accidentally
-	 * send valid data to slots other than normal playback slots.
-	 *
-	 * To be safe, configure SACCST right before TX starts.
-	 */
-	if (enable && fsl_ssi_is_ac97(ssi))
-		fsl_ssi_tx_ac97_saccst_setup(ssi);
-
-	fsl_ssi_config(ssi, enable, &ssi->regvals[TX]);
-}
-
 /**
  * Cache critical bits of SIER, SRCR, STCR and SCR to later set them safely
  */
@@ -1087,24 +1071,28 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			fsl_ssi_tx_config(ssi, true);
-		else
-			fsl_ssi_rx_config(ssi, true);
+		/*
+		 * SACCST might be modified via AC Link by a CODEC if it sends
+		 * extra bits in their SLOTREQ requests, which'll accidentally
+		 * send valid data to slots other than normal playback slots.
+		 *
+		 * To be safe, configure SACCST right before TX starts.
+		 */
+		if (tx && fsl_ssi_is_ac97(ssi))
+			fsl_ssi_tx_ac97_saccst_setup(ssi);
+		fsl_ssi_config_enable(ssi, tx);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			fsl_ssi_tx_config(ssi, false);
-		else
-			fsl_ssi_rx_config(ssi, false);
+		fsl_ssi_config_disable(ssi, tx);
 		break;
 
 	default:
-- 
2.7.4
