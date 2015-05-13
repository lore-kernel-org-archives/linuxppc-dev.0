Return-Path: <zidan.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FFCB1A027B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 17:11:48 +1000 (AEST)
From: Zidan Wang <zidan.wang@freescale.com>
To: <nicoleotsuka@gmail.com>
Subject: [alsa-devel][PATCH v2 2/3] ASoC: fsl_sai: add tdm slots operation
 support
Date: Wed, 13 May 2015 15:13:00 +0800
Message-ID: <ed83f3aaef3f56c8edde47bacc3cce612431772d.1431500729.git.zidan.wang@freescale.com>
In-Reply-To: <e6293a2408ccd8390fa2999df2af26b6de20f933.1431500729.git.zidan.wang@freescale.com>
References: <e6293a2408ccd8390fa2999df2af26b6de20f933.1431500729.git.zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, timur@tabi.org,
 Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add tdm slots operation support. If tdm slots and slot width have
been configured in machine driver, we should use these values.
Otherwise, using relevant channels and word length to set slots
and slot width.

SAI will generate BCLK depends on sample rate, slots and slot width.
And there may be unused BCLK cycles before each LRCLK transition.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 34 ++++++++++++++++++++++++++++------
 sound/soc/fsl/fsl_sai.h |  3 +++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 1ccc10d1..7624dd0 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -115,6 +115,17 @@ out:
 		return IRQ_HANDLED;
 }
 
+static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+				u32 rx_mask, int slots, int slot_width)
+{
+	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+
+	sai->slots = slots;
+	sai->slot_width = slot_width;
+
+	return 0;
+}
+
 static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int fsl_dir)
 {
@@ -372,11 +383,22 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	u32 word_width = snd_pcm_format_width(params_format(params));
 	u32 val_cr4 = 0, val_cr5 = 0;
+	u32 slots, slot_width;
 	int ret;
 
+	if (sai->slots == 0)
+		slots = (channels == 1) ? 2 : channels;
+	else
+		slots = sai->slots;
+
+	if (sai->slot_width == 0)
+		slot_width = word_width;
+	else
+		slot_width = sai->slot_width;
+
 	if (!sai->is_slave_mode) {
 		ret = fsl_sai_set_bclk(cpu_dai, tx,
-			2 * word_width * params_rate(params));
+				slots * slot_width * params_rate(params));
 		if (ret)
 			return ret;
 
@@ -388,21 +410,20 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 			sai->mclk_streams |= BIT(substream->stream);
 		}
-
 	}
 
 	if (!sai->is_dsp_mode)
-		val_cr4 |= FSL_SAI_CR4_SYWD(word_width);
+		val_cr4 |= FSL_SAI_CR4_SYWD(slot_width);
 
-	val_cr5 |= FSL_SAI_CR5_WNW(word_width);
-	val_cr5 |= FSL_SAI_CR5_W0W(word_width);
+	val_cr5 |= FSL_SAI_CR5_WNW(slot_width);
+	val_cr5 |= FSL_SAI_CR5_W0W(slot_width);
 
 	if (sai->is_lsb_first)
 		val_cr5 |= FSL_SAI_CR5_FBT(0);
 	else
 		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
 
-	val_cr4 |= FSL_SAI_CR4_FRSZ(channels);
+	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
@@ -536,6 +557,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt,
+	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
 	.hw_params	= fsl_sai_hw_params,
 	.hw_free	= fsl_sai_hw_free,
 	.trigger	= fsl_sai_trigger,
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 0662809..1ec09d6 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -142,6 +142,9 @@ struct fsl_sai {
 
 	unsigned int mclk_id[2];
 	unsigned int mclk_streams;
+	unsigned int slots;
+	unsigned int slot_width;
+
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
-- 
1.9.1
