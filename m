Return-Path: <guangyu.chen@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2E9E4140089
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 22:38:11 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_sai: Fix buggy configurations in trigger()
Date: Mon, 31 Mar 2014 19:39:22 +0800
Message-ID: <1396265962-19343-1-git-send-email-Guangyu.Chen@freescale.com>
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
C) We only enable one side interrupt for each stream since over/underrun
   on the opposite stream would be resulted from what we've done in rule B:
   enabling TERE but remaining FRDE disabled, even though the xrun on the
   opposite direction will not break the current stream.

Tested cases:
a) aplay test.wav -d5
b) arecord -r44100 -c2 -fS16_LE test.wav -d5
c) arecord -r44100 -c2 -fS16_LE -d5 | aplay
d) (aplay test2.wav &); sleep 1; arecord -r44100 -c2 -fS16_LE test.wav -d1
e) (arecord -r44100 -c2 -fS16_LE test.wav -d5 &); sleep 1; aplay test.wav -d1

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 43 +++++++++++++++++++++++--------------------
 sound/soc/fsl/fsl_sai.h | 11 +++++++++++
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index f088545..d64c33f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -365,6 +365,7 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u32 tcsr, rcsr;
 
 	/*
@@ -379,14 +380,6 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	regmap_read(sai->regmap, FSL_SAI_TCSR, &tcsr);
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
 	 * and the first disabled.
@@ -395,22 +388,32 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
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
+				   FSL_SAI_CSR_xIE_MASK, FSL_SAI_FLAGS);
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
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
+				   FSL_SAI_CSR_xIE_MASK, 0);
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
 		return -EINVAL;
@@ -464,8 +467,8 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
 
-	regmap_update_bits(sai->regmap, FSL_SAI_TCSR, 0xffffffff, FSL_SAI_FLAGS);
-	regmap_update_bits(sai->regmap, FSL_SAI_RCSR, 0xffffffff, FSL_SAI_FLAGS);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCSR, 0xffffffff, 0x0);
+	regmap_update_bits(sai->regmap, FSL_SAI_RCSR, 0xffffffff, 0x0);
 	regmap_update_bits(sai->regmap, FSL_SAI_TCR1, FSL_SAI_CR1_RFW_MASK,
 			   FSL_SAI_MAXBURST_TX * 2);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR1, FSL_SAI_CR1_RFW_MASK,
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index a264185..be26d46 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -35,6 +35,16 @@
 #define FSL_SAI_RFR	0xc0 /* SAI Receive FIFO */
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
 #define FSL_SAI_CSR_FR		BIT(25)
@@ -48,6 +58,7 @@
 #define FSL_SAI_CSR_FWF		BIT(17)
 #define FSL_SAI_CSR_FRF		BIT(16)
 #define FSL_SAI_CSR_xIE_SHIFT	8
+#define FSL_SAI_CSR_xIE_MASK	(0x1f << FSL_SAI_CSR_xIE_SHIFT)
 #define FSL_SAI_CSR_WSIE	BIT(12)
 #define FSL_SAI_CSR_SEIE	BIT(11)
 #define FSL_SAI_CSR_FEIE	BIT(10)
-- 
1.8.4
