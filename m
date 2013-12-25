Return-Path: <Li.Xiubo@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D16F22C009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Dec 2013 16:33:23 +1100 (EST)
From: Xiubo Li <Li.Xiubo@freescale.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_sai: Add disable operation for the corresponding
 data channel.
Date: Wed, 25 Dec 2013 12:40:04 +0800
Message-ID: <1387946404-24029-1-git-send-email-Li.Xiubo@freescale.com>
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

Enables/Disables the corresponding data channel for tx/rx operation.
A channel must be enabled before its FIFO is accessed, and then disable
it when tx/rx is stopped or idle.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 596aabb..af80246 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -124,20 +124,17 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 				unsigned int fmt, int fsl_dir)
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	u32 val_cr2, val_cr3, val_cr4, reg_cr2, reg_cr3, reg_cr4;
+	u32 val_cr2, val_cr4, reg_cr2, reg_cr4;
 
 	if (fsl_dir == FSL_FMT_TRANSMITTER) {
 		reg_cr2 = FSL_SAI_TCR2;
-		reg_cr3 = FSL_SAI_TCR3;
 		reg_cr4 = FSL_SAI_TCR4;
 	} else {
 		reg_cr2 = FSL_SAI_RCR2;
-		reg_cr3 = FSL_SAI_RCR3;
 		reg_cr4 = FSL_SAI_RCR4;
 	}
 
 	val_cr2 = sai_readl(sai, sai->base + reg_cr2);
-	val_cr3 = sai_readl(sai, sai->base + reg_cr3);
 	val_cr4 = sai_readl(sai, sai->base + reg_cr4);
 
 	if (sai->big_endian_data)
@@ -188,13 +185,10 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
-	val_cr3 |= FSL_SAI_CR3_TRCE;
-
 	if (fsl_dir == FSL_FMT_RECEIVER)
 		val_cr2 |= FSL_SAI_CR2_SYNC;
 
 	sai_writel(sai, val_cr2, sai->base + reg_cr2);
-	sai_writel(sai, val_cr3, sai->base + reg_cr3);
 	sai_writel(sai, val_cr4, sai->base + reg_cr4);
 
 	return 0;
@@ -278,7 +272,7 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
-	unsigned int tcsr, rcsr;
+	u32 tcsr, rcsr, val_cr3, reg_cr3;
 
 	tcsr = sai_readl(sai, sai->base + FSL_SAI_TCSR);
 	rcsr = sai_readl(sai, sai->base + FSL_SAI_RCSR);
@@ -286,17 +280,24 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		tcsr |= FSL_SAI_CSR_FRDE;
 		rcsr &= ~FSL_SAI_CSR_FRDE;
+		reg_cr3 = FSL_SAI_TCR3;
 	} else {
 		rcsr |= FSL_SAI_CSR_FRDE;
 		tcsr &= ~FSL_SAI_CSR_FRDE;
+		reg_cr3 = FSL_SAI_RCR3;
 	}
 
+	val_cr3 = sai_readl(sai, sai->base + reg_cr3);
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		tcsr |= FSL_SAI_CSR_TERE;
 		rcsr |= FSL_SAI_CSR_TERE;
+		val_cr3 |= FSL_SAI_CR3_TRCE;
+
+		sai_writel(sai, val_cr3, sai->base + reg_cr3);
 		sai_writel(sai, rcsr, sai->base + FSL_SAI_RCSR);
 		sai_writel(sai, tcsr, sai->base + FSL_SAI_TCSR);
 		break;
@@ -308,8 +309,12 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 			tcsr &= ~FSL_SAI_CSR_TERE;
 			rcsr &= ~FSL_SAI_CSR_TERE;
 		}
+
+		val_cr3 &= ~FSL_SAI_CR3_TRCE;
+
 		sai_writel(sai, tcsr, sai->base + FSL_SAI_TCSR);
 		sai_writel(sai, rcsr, sai->base + FSL_SAI_RCSR);
+		sai_writel(sai, val_cr3, sai->base + reg_cr3);
 		break;
 	default:
 		return -EINVAL;
-- 
1.8.4
