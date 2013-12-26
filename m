Return-Path: <Li.Xiubo@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0A1122C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 14:50:47 +1100 (EST)
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_sai: Fix one bug for hardware limitation.
Date: Thu, 26 Dec 2013 10:57:22 +0800
Message-ID: <1388026642-1464-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 linux-kernel@vger.kernel.org, timur@tabi.org, perex@perex.cz,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org, b47053@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is maybe one bug or a limitation of the hardware that the {T,R}CR2's
Synchronous Mode bits must be set as late as possible, or the SAI device
maybe hanged up, and there has not any explaination about this limitation
in the SAI Data Sheet.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index af80246..59228a10 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -62,6 +62,7 @@ static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 		reg_cr2 = FSL_SAI_RCR2;
 
 	val_cr2 = sai_readl(sai, sai->base + reg_cr2);
+
 	switch (clk_id) {
 	case FSL_SAI_CLK_BUS:
 		val_cr2 &= ~FSL_SAI_CR2_MSEL_MASK;
@@ -82,6 +83,7 @@ static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 	default:
 		return -EINVAL;
 	}
+
 	sai_writel(sai, val_cr2, sai->base + reg_cr2);
 
 	return 0;
@@ -138,14 +140,13 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 	val_cr4 = sai_readl(sai, sai->base + reg_cr4);
 
 	if (sai->big_endian_data)
-		val_cr4 |= FSL_SAI_CR4_MF;
-	else
 		val_cr4 &= ~FSL_SAI_CR4_MF;
+	else
+		val_cr4 |= FSL_SAI_CR4_MF;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		val_cr4 |= FSL_SAI_CR4_FSE;
-		val_cr4 |= FSL_SAI_CR4_FSP;
 		break;
 	default:
 		return -EINVAL;
@@ -185,9 +186,6 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
-	if (fsl_dir == FSL_FMT_RECEIVER)
-		val_cr2 |= FSL_SAI_CR2_SYNC;
-
 	sai_writel(sai, val_cr2, sai->base + reg_cr2);
 	sai_writel(sai, val_cr4, sai->base + reg_cr4);
 
@@ -253,10 +251,11 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	val_cr5 |= FSL_SAI_CR5_WNW(word_width);
 	val_cr5 |= FSL_SAI_CR5_W0W(word_width);
 
+	val_cr5 &= ~FSL_SAI_CR5_FBT_MASK;
 	if (sai->big_endian_data)
-		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
-	else
 		val_cr5 |= FSL_SAI_CR5_FBT(0);
+	else
+		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(channels);
 	val_mr = ~0UL - ((1 << channels) - 1);
@@ -327,8 +326,22 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 val_cr2;
+	int ret;
+
+	ret = clk_prepare_enable(sai->clk);
+	if (ret)
+		return ret;
+
+	val_cr2 = sai_readl(sai, sai->base + FSL_SAI_TCR2);
+	val_cr2 &= ~FSL_SAI_CR2_SYNC;
+	sai_writel(sai, val_cr2, sai->base + FSL_SAI_TCR2);
 
-	return clk_prepare_enable(sai->clk);
+	val_cr2 = sai_readl(sai, sai->base + FSL_SAI_RCR2);
+	val_cr2 |= FSL_SAI_CR2_SYNC;
+	sai_writel(sai, val_cr2, sai->base + FSL_SAI_RCR2);
+
+	return 0;
 }
 
 static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
-- 
1.8.4
