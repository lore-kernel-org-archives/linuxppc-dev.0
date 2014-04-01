Return-Path: <guangyu.chen@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8970814013A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 14:15:54 +1100 (EST)
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: <broonie@kernel.org>
Subject: [PATCH bisect 2/2] ASoC: fsl_sai: Separately enable interrupts for Tx
 and Rx streams
Date: Tue, 1 Apr 2014 11:17:07 +0800
Message-ID: <1396322227-482-3-git-send-email-Guangyu.Chen@freescale.com>
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

We only enable one side interrupt for each stream since over/underrun
on the opposite stream would be resulted from what we previously did,
enabling TERE but remaining FRDE disabled, even though the xrun on the
opposite direction will not break the current stream.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
Acked-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 8 ++++++--
 sound/soc/fsl/fsl_sai.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index bdfd497..d64c33f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -397,4 +397,6 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
+				   FSL_SAI_CSR_xIE_MASK, FSL_SAI_FLAGS);
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
 		break;
@@ -404,4 +406,6 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_FRDE, 0);
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
+				   FSL_SAI_CSR_xIE_MASK, 0);
 
 		if (!(tcsr & FSL_SAI_CSR_FRDE || rcsr & FSL_SAI_CSR_FRDE)) {
@@ -464,6 +468,6 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	struct fsl_sai *sai = dev_get_drvdata(cpu_dai->dev);
 
-	regmap_update_bits(sai->regmap, FSL_SAI_TCSR, 0xffffffff, FSL_SAI_FLAGS);
-	regmap_update_bits(sai->regmap, FSL_SAI_RCSR, 0xffffffff, FSL_SAI_FLAGS);
+	regmap_update_bits(sai->regmap, FSL_SAI_TCSR, 0xffffffff, 0x0);
+	regmap_update_bits(sai->regmap, FSL_SAI_RCSR, 0xffffffff, 0x0);
 	regmap_update_bits(sai->regmap, FSL_SAI_TCR1, FSL_SAI_CR1_RFW_MASK,
 			   FSL_SAI_MAXBURST_TX * 2);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 64b6fe7..be26d46 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -59,4 +59,5 @@
 #define FSL_SAI_CSR_FRF		BIT(16)
 #define FSL_SAI_CSR_xIE_SHIFT	8
+#define FSL_SAI_CSR_xIE_MASK	(0x1f << FSL_SAI_CSR_xIE_SHIFT)
 #define FSL_SAI_CSR_WSIE	BIT(12)
 #define FSL_SAI_CSR_SEIE	BIT(11)
-- 
1.8.4
