Return-Path: <zidan.wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0125.outbound.protection.outlook.com [65.55.169.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C112A1A024F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 17:06:16 +1000 (AEST)
From: Zidan Wang <zidan.wang@freescale.com>
To: <nicoleotsuka@gmail.com>
Subject: [alsa-devel][PATCH 2/3] ASoC: fsl_sai: Add tdm slots operation for
 SAI master mode
Date: Tue, 12 May 2015 15:07:40 +0800
Message-ID: <d2d07bb90912cbcc48d18de986a11591b12a91b2.1431414110.git.zidan.wang@freescale.com>
In-Reply-To: <a60e5babb208b08fb4cd8188573606eb745cc1c4.1431414110.git.zidan.wang@freescale.com>
References: <a60e5babb208b08fb4cd8188573606eb745cc1c4.1431414110.git.zidan.wang@freescale.com>
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

Add tdm slot operation for SAI master mode. When using SAI as master
mode, we should use set_tdm_slot() helper function to set tdm slots
in machine driver, or it will using default value of slots and slot
width.

SAI will generate BCLK depends on sample rate, slots and slot width.
And there may be unused BCLK cycles before each LRCLK transition.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 28 ++++++++++++++++++++++------
 sound/soc/fsl/fsl_sai.h |  3 +++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 1ccc10d1..88f5861 100644
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
@@ -372,11 +383,13 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	u32 word_width = snd_pcm_format_width(params_format(params));
 	u32 val_cr4 = 0, val_cr5 = 0;
+	u32 slot_width = word_width;
 	int ret;
 
 	if (!sai->is_slave_mode) {
+		slot_width = sai->slot_width;
 		ret = fsl_sai_set_bclk(cpu_dai, tx,
-			2 * word_width * params_rate(params));
+				sai->slots * slot_width * params_rate(params));
 		if (ret)
 			return ret;
 
@@ -388,21 +401,20 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
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
+	val_cr4 |= FSL_SAI_CR4_FRSZ(sai->slots);
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
@@ -536,6 +548,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt,
+	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
 	.hw_params	= fsl_sai_hw_params,
 	.hw_free	= fsl_sai_hw_free,
 	.trigger	= fsl_sai_trigger,
@@ -721,6 +734,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		}
 	}
 
+	sai->slots = 2;
+	sai->slot_width = 32;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
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
