Return-Path: <B42378@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA4482C04DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:04:51 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <broonie@kernel.org>, <timur@tabi.org>
Subject: [PATCH] ASoC: fsl_ssi: separately enable and disable TIE/RIE in
 trigger()
Date: Tue, 29 Oct 2013 19:04:48 +0800
Message-ID: <1383044688-28596-1-git-send-email-b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables Tx-related SIER_FLAGS only when direction is PLAYBACK
and does same thing for CAPTURE. Also, after TRIGGER_STOP/PAUSE, it will
disable SIER_xFLAGS for symmetric.

[ Passed compile-test with mpc85xx_defconfig ]

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 35e2773..3797bf0 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -107,11 +107,14 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
 #endif
 
 /* SIER bitflag of interrupts to enable */
-#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
+#define SIER_TFLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
 		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
-		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
-		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
-		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
+		    CCSR_SSI_SIER_TUE1_EN)
+#define SIER_RFLAGS (CCSR_SSI_SIER_RFRC_EN | CCSR_SSI_SIER_RDMAE | \
+		    CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_ROE0_EN | \
+		    CCSR_SSI_SIER_ROE1_EN)
+
+#define SIER_FLAGS (SIER_TFLAGS | SIER_RFLAGS)
 
 /**
  * fsl_ssi_private: per-SSI private data
@@ -560,12 +563,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (ssi_private->use_dma)
-			sier_bits = SIER_FLAGS;
+			sier_bits = SIER_TFLAGS;
 		else
 			sier_bits = CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN;
 	} else {
 		if (ssi_private->use_dma)
-			sier_bits = SIER_FLAGS;
+			sier_bits = SIER_RFLAGS;
 		else
 			sier_bits = CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_RFF0_EN;
 	}
@@ -579,6 +582,8 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		else
 			write_ssi_mask(&ssi->scr, 0,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
+
+		write_ssi_mask(&ssi->sier, 0, sier_bits);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
@@ -591,14 +596,14 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (!ssi_private->imx_ac97 && (read_ssi(&ssi->scr) &
 					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
+
+		write_ssi_mask(&ssi->sier, sier_bits, 0);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	write_ssi(sier_bits, &ssi->sier);
-
 	return 0;
 }
 
-- 
1.8.4
