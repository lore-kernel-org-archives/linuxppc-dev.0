Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxRll5qCgzDrbW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 17:35:47 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id e3so924612pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:35:47 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 timur@tabi.org, mail@maciej.szmigiero.name, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v2 11/11] ASoC: fsl_ssi: Define ternary macros to simplify code
Date: Tue, 12 Dec 2017 22:34:34 -0800
Message-Id: <1513146874-25476-12-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513146874-25476-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some regmap code looks redudant. So simplify it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 27 +++++++++++----------------
 sound/soc/fsl/fsl_ssi.h |  4 ++++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index dd091eb..5b4fa43 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -405,13 +405,10 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
  */
 static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 {
-	if (is_rx) {
-		regmap_update_bits(ssi->regs, REG_SSI_SOR,
-				   SSI_SOR_RX_CLR, SSI_SOR_RX_CLR);
-	} else {
-		regmap_update_bits(ssi->regs, REG_SSI_SOR,
-				   SSI_SOR_TX_CLR, SSI_SOR_TX_CLR);
-	}
+	bool tx = !is_rx;
+
+	regmap_update_bits(ssi->regs, REG_SSI_SOR,
+			   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 }
 
 /**
@@ -666,6 +663,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai,
 			    struct snd_pcm_hw_params *hw_params)
 {
+	bool tx2, tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	int synchronous = ssi->cpu_dai_drv.symmetric_rates, ret;
@@ -753,10 +751,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		(psr ? SSI_SxCCR_PSR : 0);
 	mask = SSI_SxCCR_PM_MASK | SSI_SxCCR_DIV2 | SSI_SxCCR_PSR;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK || synchronous)
-		regmap_update_bits(regs, REG_SSI_STCCR, mask, stccr);
-	else
-		regmap_update_bits(regs, REG_SSI_SRCCR, mask, stccr);
+	/* STCCR is used for RX in synchronous mode */
+	tx2 = tx || synchronous;
+	regmap_update_bits(regs, REG_SSI_SxCCR(tx2), mask, stccr);
 
 	if (!baudclk_is_used) {
 		ret = clk_set_rate(ssi->baudclk, baudrate);
@@ -784,6 +781,7 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params,
 			     struct snd_soc_dai *dai)
 {
+	bool tx2, tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
 	struct regmap *regs = ssi->regs;
 	unsigned int channels = params_channels(hw_params);
@@ -829,11 +827,8 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
-	if ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ||
-	    ssi->cpu_dai_drv.symmetric_rates)
-		regmap_update_bits(regs, REG_SSI_STCCR, SSI_SxCCR_WL_MASK, wl);
-	else
-		regmap_update_bits(regs, REG_SSI_SRCCR, SSI_SxCCR_WL_MASK, wl);
+	tx2 = tx || ssi->cpu_dai_drv.symmetric_rates;
+	regmap_update_bits(regs, REG_SSI_SxCCR(tx2), SSI_SxCCR_WL_MASK, wl);
 
 	return 0;
 }
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index b610087..de2fdc5 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -35,10 +35,12 @@
 #define REG_SSI_STCR			0x1c
 /* SSI Receive Configuration Register */
 #define REG_SSI_SRCR			0x20
+#define REG_SSI_SxCR(tx)		((tx) ? REG_SSI_STCR : REG_SSI_SRCR)
 /* SSI Transmit Clock Control Register */
 #define REG_SSI_STCCR			0x24
 /* SSI Receive Clock Control Register */
 #define REG_SSI_SRCCR			0x28
+#define REG_SSI_SxCCR(tx)		((tx) ? REG_SSI_STCCR : REG_SSI_SRCCR)
 /* SSI FIFO Control/Status Register */
 #define REG_SSI_SFCSR			0x2c
 /*
@@ -67,6 +69,7 @@
 #define REG_SSI_STMSK			0x48
 /* SSI  Receive Time Slot Mask Register */
 #define REG_SSI_SRMSK			0x4c
+#define REG_SSI_SxMSK(tx)		((tx) ? REG_SSI_STMSK : REG_SSI_SRMSK)
 /*
  * SSI AC97 Channel Status Register
  *
@@ -249,6 +252,7 @@
 #define SSI_SOR_CLKOFF			0x00000040
 #define SSI_SOR_RX_CLR			0x00000020
 #define SSI_SOR_TX_CLR			0x00000010
+#define SSI_SOR_xX_CLR(tx)		((tx) ? SSI_SOR_TX_CLR : SSI_SOR_RX_CLR)
 #define SSI_SOR_INIT			0x00000008
 #define SSI_SOR_WAIT_SHIFT		1
 #define SSI_SOR_WAIT_MASK		0x00000006
-- 
2.7.4
