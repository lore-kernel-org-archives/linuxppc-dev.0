Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxt1Q51nwzDsM6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 10:19:06 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id k15so2117744pgr.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 15:19:06 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org,
 mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v3 10/11] ASoC: fsl_ssi: Rename i2smode to i2s_net
Date: Wed, 13 Dec 2017 15:18:27 -0800
Message-Id: <1513207108-30430-11-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513207108-30430-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since this i2smode also includes the setting of Network mode, it
should have it in the name. This patch also adds its MASK define.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 24 ++++++++++++------------
 sound/soc/fsl/fsl_ssi.h |  1 +
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 1cdc62a..4a2438c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -201,7 +201,7 @@ struct fsl_ssi_soc_data {
  * @cpu_dai_drv: CPU DAI driver for this device
  *
  * @dai_fmt: DAI configuration this device is currently used with
- * @i2s_mode: I2S and Network mode configuration of SCR register
+ * @i2s_net: I2S and Network mode configurations of SCR register
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for dual FIFO mode
  * @has_ipg_clk_name: If "ipg" is in the clock name list of device tree
@@ -245,7 +245,7 @@ struct fsl_ssi {
 	struct snd_soc_dai_driver cpu_dai_drv;
 
 	unsigned int dai_fmt;
-	u8 i2s_mode;
+	u8 i2s_net;
 	bool use_dma;
 	bool use_dual_fifo;
 	bool has_ipg_clk_name;
@@ -821,16 +821,16 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!fsl_ssi_is_ac97(ssi)) {
-		u8 i2smode;
+		u8 i2s_net;
 		/* Normal + Network mode to send 16-bit data in 32-bit frames */
 		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
-			i2smode = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
+			i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
 		else
-			i2smode = ssi->i2s_mode;
+			i2s_net = ssi->i2s_net;
 
 		regmap_update_bits(regs, REG_SSI_SCR,
-				   SSI_SCR_NET | SSI_SCR_I2S_MODE_MASK,
-				   channels == 1 ? 0 : i2smode);
+				   SSI_SCR_I2S_NET_MASK,
+				   channels == 1 ? 0 : i2s_net);
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
@@ -887,7 +887,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	srcr &= ~mask;
 
 	/* Use Network mode as default */
-	ssi->i2s_mode = SSI_SCR_NET;
+	ssi->i2s_net = SSI_SCR_NET;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		regmap_update_bits(regs, REG_SSI_STCCR,
@@ -897,10 +897,10 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 		case SND_SOC_DAIFMT_CBM_CFS:
 		case SND_SOC_DAIFMT_CBS_CFS:
-			ssi->i2s_mode |= SSI_SCR_I2S_MODE_MASTER;
+			ssi->i2s_net |= SSI_SCR_I2S_MODE_MASTER;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
-			ssi->i2s_mode |= SSI_SCR_I2S_MODE_SLAVE;
+			ssi->i2s_net |= SSI_SCR_I2S_MODE_SLAVE;
 			break;
 		default:
 			return -EINVAL;
@@ -925,12 +925,12 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		break;
 	case SND_SOC_DAIFMT_AC97:
 		/* Data on falling edge of bclk, frame high, 1clk before data */
-		ssi->i2s_mode |= SSI_SCR_I2S_MODE_NORMAL;
+		ssi->i2s_net |= SSI_SCR_I2S_MODE_NORMAL;
 		break;
 	default:
 		return -EINVAL;
 	}
-	scr |= ssi->i2s_mode;
+	scr |= ssi->i2s_net;
 
 	/* DAI clock inversion */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 52b88f1..b610087 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -95,6 +95,7 @@
 #define SSI_SCR_I2S_MODE_SLAVE		0x00000040
 #define SSI_SCR_SYN			0x00000010
 #define SSI_SCR_NET			0x00000008
+#define SSI_SCR_I2S_NET_MASK		(SSI_SCR_NET | SSI_SCR_I2S_MODE_MASK)
 #define SSI_SCR_RE			0x00000004
 #define SSI_SCR_TE			0x00000002
 #define SSI_SCR_SSIEN			0x00000001
-- 
2.1.4
