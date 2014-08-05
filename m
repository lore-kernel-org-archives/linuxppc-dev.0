Return-Path: <nicoleotsuka@gmail.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0203.outbound.protection.outlook.com [207.46.163.203])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E21FD1A008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 17:29:37 +1000 (EST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Date: Tue, 5 Aug 2014 15:32:05 +0800
Message-ID: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicolin Chen <Guangyu.Chen@freescale.com>

SAI supports these operation modes:
1) asynchronous mode
   Both Tx and Rx are set to be asynchronous.
2) synchronous mode (Rx sync with Tx)
   Tx is set to be asynchronous, Rx is set to be synchronous.
3) synchronous mode (Tx sync with Rx)
   Rx is set to be asynchronous, Tx is set to be synchronous.
4) synchronous mode (Tx/Rx sync with another SAI's Tx)
5) synchronous mode (Tx/Rx sync with another SAI's Rx)

* 4) and 5) are beyond this patch because they are related with another SAI.

As the initial version of this SAI driver, it supported 2) as default while
the others were totally missing.

So this patch just adds supports for 1) and 3).

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 .../devicetree/bindings/sound/fsl-sai.txt          | 16 ++++++++++++
 sound/soc/fsl/fsl_sai.c                            | 30 +++++++++++++++++++---
 sound/soc/fsl/fsl_sai.h                            |  4 +++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 0f4e238..77864f4 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -24,6 +24,22 @@ Required properties:
 - big-endian-data: If this property is absent, the little endian mode will
   be in use as default, or the big endian mode will be in use for all the
   fifo data.
+- fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
+  that SAI will work in the synchronous mode (sync Tx with Rx) which means
+  both the transimitter and receiver will send and receive data by following
+  receiver's bit clocks and frame sync clocks.
+- fsl,sai-asynchronous: This is a boolean property. If present, indicating
+  that SAI will work in the asynchronous mode, which means both transimitter
+  and receiver will send and receive data by following their own bit clocks
+  and frame sync clocks separately.
+
+Note:
+- If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
+  default synchronous mode (sync Rx with Tx) will be used, which means both
+  transimitter and receiver will send and receive data by following clocks
+  of transimitter.
+- fsl,sai-asynchronous will be ignored if fsl,sai-synchronous-rx property is
+  already present.
 
 Example:
 sai2: sai@40031000 {
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 9f10575..dc84f98 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -330,12 +330,14 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	u32 xcsr, count = 100;
 
 	/*
-	 * The transmitter bit clock and frame sync are to be
-	 * used by both the transmitter and receiver.
+	 * Asynchronous mode: Clear SYNC for both Tx and Rx.
+	 * Rx sync with Tx clocks: Clear SYNC for Tx, set it for Rx.
+	 * Tx sync with Rx clocks: Clear SYNC for Rx, set it for Tx.
 	 */
-	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC, 0);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCR2, FSL_SAI_CR2_SYNC,
+			   sai->synchronous[TX] ? FSL_SAI_CR2_SYNC : 0);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR2, FSL_SAI_CR2_SYNC,
-			   FSL_SAI_CR2_SYNC);
+			   sai->synchronous[RX] ? FSL_SAI_CR2_SYNC : 0);
 
 	/*
 	 * It is recommended that the transmitter is the last enabled
@@ -620,6 +622,26 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Sync Tx with Rx as default by following old DT binding */
+	sai->synchronous[RX] = true;
+	sai->synchronous[TX] = false;
+	fsl_sai_dai.symmetric_rates = 1;
+	fsl_sai_dai.symmetric_channels = 1;
+	fsl_sai_dai.symmetric_samplebits = 1;
+
+	if (of_find_property(np, "fsl,sai-synchronous-rx", NULL)) {
+		/* Sync Rx with Tx */
+		sai->synchronous[RX] = false;
+		sai->synchronous[TX] = true;
+	} else if (of_find_property(np, "fsl,sai-asynchronous", NULL)) {
+		/* Discard all settings for asynchronous mode */
+		sai->synchronous[RX] = false;
+		sai->synchronous[TX] = false;
+		fsl_sai_dai.symmetric_rates = 0;
+		fsl_sai_dai.symmetric_channels = 0;
+		fsl_sai_dai.symmetric_samplebits = 0;
+	}
+
 	sai->dma_params_rx.addr = res->start + FSL_SAI_RDR;
 	sai->dma_params_tx.addr = res->start + FSL_SAI_TDR;
 	sai->dma_params_rx.maxburst = FSL_SAI_MAXBURST_RX;
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 0e6c9f5..c24d3fd 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -135,9 +135,13 @@ struct fsl_sai {
 	bool big_endian_data;
 	bool is_dsp_mode;
 	bool sai_on_imx;
+	bool synchronous[2];
 
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
 
+#define TX 1
+#define RX 0
+
 #endif /* __FSL_SAI_H */
-- 
1.8.4
