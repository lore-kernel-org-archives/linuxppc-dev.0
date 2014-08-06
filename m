Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 558811A08B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 20:38:21 +1000 (EST)
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <timur@tabi.org>,
 <perex@perex.cz>, <tiwai@suse.de>, <nicoleotsuka@gmail.com>,
 <Li.Xiubo@freescale.com>, <shc_work@mail.ru>, <fabio.estevam@freescale.com>,
 <arnd@arndb.de>
Subject: [PATCH V1 1/2] ASoC: fsl: esai: refine esai for tdm support
Date: Wed, 6 Aug 2014 18:23:03 +0800
Message-ID: <e68d8fbaaed7000b13688b0f1757b5b9557889d7.1407320232.git.shengjiu.wang@freescale.com>
In-Reply-To: <cover.1407320232.git.shengjiu.wang@freescale.com>
References: <cover.1407320232.git.shengjiu.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add parameter for slots, and caculate the number of TX/RX pins and bclk with
slots. Then driver will be compatible with slots > 2 in TDM mode.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 sound/soc/fsl/fsl_esai.c |   10 +++++++---
 sound/soc/fsl/fsl_esai.h |    8 ++++----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 72d154e..89aa531 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -56,6 +56,7 @@ struct fsl_esai {
 	struct clk *fsysclk;
 	u32 fifo_depth;
 	u32 slot_width;
+	u32 slots;
 	u32 hck_rate[2];
 	u32 sck_rate[2];
 	bool hck_dir[2];
@@ -363,6 +364,7 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask,
 			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(rx_mask));
 
 	esai_priv->slot_width = slot_width;
+	esai_priv->slots      = slots;
 
 	return 0;
 }
@@ -510,10 +512,11 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u32 width = snd_pcm_format_width(params_format(params));
 	u32 channels = params_channels(params);
+	u32 pin = DIV_ROUND_UP(channels, esai_priv->slots);
 	u32 bclk, mask, val;
 	int ret;
 
-	bclk = params_rate(params) * esai_priv->slot_width * 2;
+	bclk = params_rate(params) * esai_priv->slot_width * esai_priv->slots;
 
 	ret = fsl_esai_set_bclk(dai, tx, bclk);
 	if (ret)
@@ -530,7 +533,7 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
 	mask = ESAI_xFCR_xFR_MASK | ESAI_xFCR_xWA_MASK | ESAI_xFCR_xFWM_MASK |
 	      (tx ? ESAI_xFCR_TE_MASK | ESAI_xFCR_TIEN : ESAI_xFCR_RE_MASK);
 	val = ESAI_xFCR_xWA(width) | ESAI_xFCR_xFWM(esai_priv->fifo_depth) |
-	     (tx ? ESAI_xFCR_TE(channels) | ESAI_xFCR_TIEN : ESAI_xFCR_RE(channels));
+	     (tx ? ESAI_xFCR_TE(pin) | ESAI_xFCR_TIEN : ESAI_xFCR_RE(pin));
 
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx), mask, val);
 
@@ -565,6 +568,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct fsl_esai *esai_priv = snd_soc_dai_get_drvdata(dai);
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u8 i, channels = substream->runtime->channels;
+	u32 pin = DIV_ROUND_UP(channels, esai_priv->slots);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -579,7 +583,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK,
-				   tx ? ESAI_xCR_TE(channels) : ESAI_xCR_RE(channels));
+				   tx ? ESAI_xCR_TE(pin) : ESAI_xCR_RE(pin));
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
index 75e1403..91a550f 100644
--- a/sound/soc/fsl/fsl_esai.h
+++ b/sound/soc/fsl/fsl_esai.h
@@ -130,8 +130,8 @@
 #define ESAI_xFCR_RE_WIDTH	4
 #define ESAI_xFCR_TE_MASK	(((1 << ESAI_xFCR_TE_WIDTH) - 1) << ESAI_xFCR_xE_SHIFT)
 #define ESAI_xFCR_RE_MASK	(((1 << ESAI_xFCR_RE_WIDTH) - 1) << ESAI_xFCR_xE_SHIFT)
-#define ESAI_xFCR_TE(x) 	((ESAI_xFCR_TE_MASK >> (ESAI_xFCR_TE_WIDTH - ((x + 1) >> 1))) & ESAI_xFCR_TE_MASK)
-#define ESAI_xFCR_RE(x) 	((ESAI_xFCR_RE_MASK >> (ESAI_xFCR_RE_WIDTH - ((x + 1) >> 1))) & ESAI_xFCR_RE_MASK)
+#define ESAI_xFCR_TE(x) 	((ESAI_xFCR_TE_MASK >> (ESAI_xFCR_TE_WIDTH - x)) & ESAI_xFCR_TE_MASK)
+#define ESAI_xFCR_RE(x) 	((ESAI_xFCR_RE_MASK >> (ESAI_xFCR_RE_WIDTH - x)) & ESAI_xFCR_RE_MASK)
 #define ESAI_xFCR_xFR_SHIFT	1
 #define ESAI_xFCR_xFR_MASK	(1 << ESAI_xFCR_xFR_SHIFT)
 #define ESAI_xFCR_xFR		(1 << ESAI_xFCR_xFR_SHIFT)
@@ -272,8 +272,8 @@
 #define ESAI_xCR_RE_WIDTH	4
 #define ESAI_xCR_TE_MASK	(((1 << ESAI_xCR_TE_WIDTH) - 1) << ESAI_xCR_xE_SHIFT)
 #define ESAI_xCR_RE_MASK	(((1 << ESAI_xCR_RE_WIDTH) - 1) << ESAI_xCR_xE_SHIFT)
-#define ESAI_xCR_TE(x) 		((ESAI_xCR_TE_MASK >> (ESAI_xCR_TE_WIDTH - ((x + 1) >> 1))) & ESAI_xCR_TE_MASK)
-#define ESAI_xCR_RE(x) 		((ESAI_xCR_RE_MASK >> (ESAI_xCR_RE_WIDTH - ((x + 1) >> 1))) & ESAI_xCR_RE_MASK)
+#define ESAI_xCR_TE(x) 		((ESAI_xCR_TE_MASK >> (ESAI_xCR_TE_WIDTH - x)) & ESAI_xCR_TE_MASK)
+#define ESAI_xCR_RE(x) 		((ESAI_xCR_RE_MASK >> (ESAI_xCR_RE_WIDTH - x)) & ESAI_xCR_RE_MASK)
 
 /*
  * Transmit Clock Control Register -- REG_ESAI_TCCR 0xD8
-- 
1.7.9.5
