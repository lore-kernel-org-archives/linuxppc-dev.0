Return-Path: <guangyu.chen@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7139714014E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 14:16:00 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>
Subject: [PATCH bisect 1/2] ASoC: fsl_sai: Fix buggy configurations in
 trigger()
Date: Tue, 1 Apr 2014 11:17:06 +0800
Message-ID: <1396322227-482-2-git-send-email-Guangyu.Chen@freescale.com>
In-Reply-To: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
References: <1396322227-482-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, Li.Xiubo@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@tabi.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current trigger() has two crucial problems:
1) The DMA request enabling operations (FSL_SAI_CSR_FRDE) for Tx and Rx are
   now totally exclusive: It would fail to run simultaneous Tx-Rx cases.
2) The TERE disabling operation depends on an incorrect condition -- active
   reference count that only gets increased in snd_pcm_open() and decreased
   in snd_pcm_close(): The TERE would never get cleared.

So this patch overwrites the trigger function by following these rules:
A) We continue to support tx-async-while-rx-sync-to-tx case alone, which's
   originally limited by this fsl_sai driver, but we make the code easy to
   modify for the further support of the opposite case.
B) We enable both TE and RE for PLAYBACK stream or CAPTURE stream but only
   enabling the DMA request bit (FSL_SAI_CSR_FRDE) of the current direction
   due to the requirement of SAI -- For tx-async-while-rx-sync-to-tx case,
   the receiver is enabled only when both the transmitter and receiver are
   enabled.

Tested cases:
a) aplay test.wav -d5
b) arecord -r44100 -c2 -fS16_LE test.wav -d5
c) arecord -r44100 -c2 -fS16_LE -d5 | aplay
d) (aplay test2.wav &); sleep 1; arecord -r44100 -c2 -fS16_LE test.wav -d1
e) (arecord -r44100 -c2 -fS16_LE test.wav -d5 &); sleep 1; aplay test.wav -d1

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
Acked-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 35 +++++++++++++++++------------------
 sound/soc/fsl/fsl_sai.h | 10 ++++++++++
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index f088545..bdfd497 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -366,4 +366,5 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u32 tcsr, rcsr;
 
@@ -380,12 +381,4 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	regmap_read(sai->regmap, FSL_SAI_RCSR, &rcsr);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		tcsr |= FSL_SAI_CSR_FRDE;
-		rcsr &= ~FSL_SAI_CSR_FRDE;
-	} else {
-		rcsr |= FSL_SAI_CSR_FRDE;
-		tcsr &= ~FSL_SAI_CSR_FRDE;
-	}
-
 	/*
 	 * It is recommended that the transmitter is the last enabled
@@ -396,20 +389,26 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		tcsr |= FSL_SAI_CSR_TERE;
-		rcsr |= FSL_SAI_CSR_TERE;
+		if (!(tcsr & FSL_SAI_CSR_FRDE || rcsr & FSL_SAI_CSR_FRDE)) {
+			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
+					   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
+			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
+					   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
+		}
 
-		regmap_write(sai->regmap, FSL_SAI_RCSR, rcsr);
-		regmap_write(sai->regmap, FSL_SAI_TCSR, tcsr);
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
+				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (!(cpu_dai->playback_active || cpu_dai->capture_active)) {
-			tcsr &= ~FSL_SAI_CSR_TERE;
-			rcsr &= ~FSL_SAI_CSR_TERE;
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
+				   FSL_SAI_CSR_FRDE, 0);
+
+		if (!(tcsr & FSL_SAI_CSR_FRDE || rcsr & FSL_SAI_CSR_FRDE)) {
+			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
+					   FSL_SAI_CSR_TERE, 0);
+			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
+					   FSL_SAI_CSR_TERE, 0);
 		}
-
-		regmap_write(sai->regmap, FSL_SAI_TCSR, tcsr);
-		regmap_write(sai->regmap, FSL_SAI_RCSR, rcsr);
 		break;
 	default:
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index a264185..64b6fe7 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -36,4 +36,14 @@
 #define FSL_SAI_RMR	0xe0 /* SAI Receive Mask */
 
+#define FSL_SAI_xCSR(tx)	(tx ? FSL_SAI_TCSR : FSL_SAI_RCSR)
+#define FSL_SAI_xCR1(tx)	(tx ? FSL_SAI_TCR1 : FSL_SAI_RCR1)
+#define FSL_SAI_xCR2(tx)	(tx ? FSL_SAI_TCR2 : FSL_SAI_RCR2)
+#define FSL_SAI_xCR3(tx)	(tx ? FSL_SAI_TCR3 : FSL_SAI_RCR3)
+#define FSL_SAI_xCR4(tx)	(tx ? FSL_SAI_TCR4 : FSL_SAI_RCR4)
+#define FSL_SAI_xCR5(tx)	(tx ? FSL_SAI_TCR5 : FSL_SAI_RCR5)
+#define FSL_SAI_xDR(tx)		(tx ? FSL_SAI_TDR : FSL_SAI_RDR)
+#define FSL_SAI_xFR(tx)		(tx ? FSL_SAI_TFR : FSL_SAI_RFR)
+#define FSL_SAI_xMR(tx)		(tx ? FSL_SAI_TMR : FSL_SAI_RMR)
+
 /* SAI Transmit/Recieve Control Register */
 #define FSL_SAI_CSR_TERE	BIT(31)
-- 
1.8.4
