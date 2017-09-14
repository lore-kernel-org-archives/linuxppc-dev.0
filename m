Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt3PZ3QVbzDqh5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 13:08:02 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id i23so897816pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 20:08:02 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org, lukma@denx.de,
 caleb@crome.org, max.krummenacher@toradex.com, arnaud.mouiche@invoxia.com,
 mail@maciej.szmigiero.name
Subject: [PATCH v2] ASoC: fsl_ssi: Caculate bit clock rate using slot number
 and width
Date: Wed, 13 Sep 2017 20:07:09 -0700
Message-Id: <1505358429-18314-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The set_sysclk() now is used to override the output bit clock rate.
But this is not a common way to implement a set_dai_sysclk(). And
this creates a problem when a general machine driver (simple-card
for example) tries to do set_dai_sysclk() by passing an input clock
rate for the baud clock instead of setting the bit clock rate as
fsl_ssi driver expected.

So this patch solves this problem by firstly removing set_sysclk()
since the hw_params() can calculate the bit clock rate. Secondly,
in order not to break those TDM use cases which previously might
have been using set_sysclk() to override the bit clock rate, this
patch changes the driver to calculate the bit clock rate using the
slot number and the slot width from the via set_tdm_slot().

The patch also removes an obsolete comment of the dir parameter.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 64598d1..f2f51e06 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -197,12 +197,13 @@ struct fsl_ssi_soc_data {
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for both FIFOs used
  * @fifo_deph: Depth of the SSI FIFOs
+ * @slot_width: width of each DAI slot
+ * @slots: number of slots
  * @rxtx_reg_val: Specific register settings for receive/transmit configuration
  *
  * @clk: SSI clock
  * @baudclk: SSI baud clock for master mode
  * @baudclk_streams: Active streams that are using baudclk
- * @bitclk_freq: bitclock frequency set by .set_dai_sysclk
  *
  * @dma_params_tx: DMA transmit parameters
  * @dma_params_rx: DMA receive parameters
@@ -233,12 +234,13 @@ struct fsl_ssi_private {
 	bool use_dual_fifo;
 	bool has_ipg_clk_name;
 	unsigned int fifo_depth;
+	unsigned int slot_width;
+	unsigned int slots;
 	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
 
 	struct clk *clk;
 	struct clk *baudclk;
 	unsigned int baudclk_streams;
-	unsigned int bitclk_freq;
 
 	/* regcache for volatile regs */
 	u32 regcache_sfcsr;
@@ -700,8 +702,8 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
  * Note: This function can be only called when using SSI as DAI master
  *
  * Quick instruction for parameters:
- * freq: Output BCLK frequency = samplerate * 32 (fixed) * channels
- * dir: SND_SOC_CLOCK_OUT -> TxBCLK, SND_SOC_CLOCK_IN -> RxBCLK.
+ * freq: Output BCLK frequency = samplerate * slots * slot_width
+ *       (In 2-channel I2S Master mode, slot_width is fixed 32)
  */
 static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai,
@@ -712,15 +714,21 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
 	unsigned long clkrate, baudrate, tmprate;
+	unsigned int slots = params_channels(hw_params);
+	unsigned int slot_width = 32;
 	u64 sub, savesub = 100000;
 	unsigned int freq;
 	bool baudclk_is_used;
 
-	/* Prefer the explicitly set bitclock frequency */
-	if (ssi_private->bitclk_freq)
-		freq = ssi_private->bitclk_freq;
-	else
-		freq = params_channels(hw_params) * 32 * params_rate(hw_params);
+	/* Override slots and slot_width if being specifically set... */
+	if (ssi_private->slots)
+		slots = ssi_private->slots;
+	/* ...but keep 32 bits if slots is 2 -- I2S Master mode */
+	if (ssi_private->slot_width && slots != 2)
+		slot_width = ssi_private->slot_width;
+
+	/* Generate bit clock based on the slot number and slot width */
+	freq = slots * slot_width * params_rate(hw_params);
 
 	/* Don't apply it to any non-baudclk circumstance */
 	if (IS_ERR(ssi_private->baudclk))
@@ -805,16 +813,6 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
-		int clk_id, unsigned int freq, int dir)
-{
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
-
-	ssi_private->bitclk_freq = freq;
-
-	return 0;
-}
-
 /**
  * fsl_ssi_hw_params - program the sample size
  *
@@ -1095,6 +1093,12 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	struct regmap *regs = ssi_private->regs;
 	u32 val;
 
+	/* The word length should be 8, 10, 12, 16, 18, 20, 22 or 24 */
+	if (slot_width & 1 || slot_width < 8 || slot_width > 24) {
+		dev_err(cpu_dai->dev, "invalid slot width: %d\n", slot_width);
+		return -EINVAL;
+	}
+
 	/* The slot number should be >= 2 if using Network mode or I2S mode */
 	regmap_read(regs, CCSR_SSI_SCR, &val);
 	val &= CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_NET;
@@ -1121,6 +1125,9 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 
 	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, val);
 
+	ssi_private->slot_width = slot_width;
+	ssi_private->slots = slots;
+
 	return 0;
 }
 
@@ -1191,7 +1198,6 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.hw_params	= fsl_ssi_hw_params,
 	.hw_free	= fsl_ssi_hw_free,
 	.set_fmt	= fsl_ssi_set_dai_fmt,
-	.set_sysclk	= fsl_ssi_set_dai_sysclk,
 	.set_tdm_slot	= fsl_ssi_set_dai_tdm_slot,
 	.trigger	= fsl_ssi_trigger,
 };
-- 
2.7.4
