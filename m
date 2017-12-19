Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1FK85fFWzDwP3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 21:59:24 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 broonie@kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de,
 lgirdwood@gmail.com, timur@tabi.org, caleb@crome.org,
 linux-kernel@vger.kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 fabio.estevam@nxp.com, mail@maciej.szmigiero.name,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Rename i2smode to i2s_net" to the asoc tree
In-Reply-To: <1513146874-25476-11-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eRFcD-0000pZ-50@debutante>
Date: Tue, 19 Dec 2017 10:59:17 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Rename i2smode to i2s_net

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8bc84a3344ca27836cff29bfbb42365753c9c557 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sun, 17 Dec 2017 18:52:09 -0800
Subject: [PATCH] ASoC: fsl_ssi: Rename i2smode to i2s_net

Since this i2smode also includes the setting of Network mode, it
should have it in the name. This patch also adds its MASK define.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Timur Tabi <timur@tabi.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 24 ++++++++++++------------
 sound/soc/fsl/fsl_ssi.h |  1 +
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index aef014c46d96..2b3915c45199 100644
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
@@ -836,16 +836,16 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
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
@@ -902,7 +902,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	srcr &= ~mask;
 
 	/* Use Network mode as default */
-	ssi->i2s_mode = SSI_SCR_NET;
+	ssi->i2s_net = SSI_SCR_NET;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		regmap_update_bits(regs, REG_SSI_STCCR,
@@ -912,10 +912,10 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
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
@@ -940,12 +940,12 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
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
index 52b88f1d6c6f..b61008779e3c 100644
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
2.15.1
