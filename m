Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znFHS6vc3zF0W8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 00:16:36 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Caleb Crome <caleb@crome.org>,
 Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Mark Brown <broonie@kernel.org>, timur@tabi.org, broonie@kernel.org,
 mail@maciej.szmigiero.name, alsa-devel@alsa-project.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()" to the asoc
 tree
In-Reply-To: <1516058192-65519-15-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eoqjZ-0006Fu-Ku@debutante>
Date: Thu, 22 Feb 2018 13:16:25 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()

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

>From 26b31f4f7d7905f67b6faa52ef147595341134c5 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:22 -0800
Subject: [PATCH] ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()

The _fsl_ssi_set_dai_fmt() is a helper function being called from
fsl_ssi_set_dai_fmt() as an ASoC operation and fsl_ssi_hw_init()
mainly for AC97 format initialization.

This patch cleans the _fsl_ssi_set_dai_fmt() in following ways:
* Removing *dev pointer in the parameters as it's included in the
  *ssi pointer of struct fsl_ssi.
* Using regmap_update_bits() instead of regmap_read() with masking
  the value manually.
* Moving baudclk check to the switch-case routine to skip the I2S
  master check. And moving SxCCR.DC settings after baudclk check.
* Adding format settings for SND_SOC_DAIFMT_AC97 like others.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 74 +++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index dfb0da3cedda..ed9102d91cf5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -860,42 +860,31 @@ static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int _fsl_ssi_set_dai_fmt(struct device *dev,
-				struct fsl_ssi *ssi, unsigned int fmt)
+static int _fsl_ssi_set_dai_fmt(struct fsl_ssi *ssi, unsigned int fmt)
 {
-	struct regmap *regs = ssi->regs;
-	u32 strcr = 0, stcr, srcr, scr, mask;
+	u32 strcr = 0, scr = 0, stcr, srcr, mask;
 
 	ssi->dai_fmt = fmt;
 
-	if (fsl_ssi_is_i2s_master(ssi) && IS_ERR(ssi->baudclk)) {
-		dev_err(dev, "missing baudclk for master mode\n");
-		return -EINVAL;
-	}
-
-	regmap_read(regs, REG_SSI_SCR, &scr);
-	scr &= ~(SSI_SCR_SYN | SSI_SCR_I2S_MODE_MASK);
 	/* Synchronize frame sync clock for TE to avoid data slipping */
 	scr |= SSI_SCR_SYNC_TX_FS;
 
-	mask = SSI_STCR_TXBIT0 | SSI_STCR_TFDIR | SSI_STCR_TXDIR |
-	       SSI_STCR_TSCKP | SSI_STCR_TFSI | SSI_STCR_TFSL | SSI_STCR_TEFS;
-	regmap_read(regs, REG_SSI_STCR, &stcr);
-	regmap_read(regs, REG_SSI_SRCR, &srcr);
-	stcr &= ~mask;
-	srcr &= ~mask;
+	/* Set to default shifting settings: LSB_ALIGNED */
+	strcr |= SSI_STCR_TXBIT0;
 
 	/* Use Network mode as default */
 	ssi->i2s_net = SSI_SCR_NET;
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		regmap_update_bits(regs, REG_SSI_STCCR,
-				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
-		regmap_update_bits(regs, REG_SSI_SRCCR,
-				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
 		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-		case SND_SOC_DAIFMT_CBM_CFS:
 		case SND_SOC_DAIFMT_CBS_CFS:
+			if (IS_ERR(ssi->baudclk)) {
+				dev_err(ssi->dev,
+					"missing baudclk for master mode\n");
+				return -EINVAL;
+			}
+			/* fall through */
+		case SND_SOC_DAIFMT_CBM_CFS:
 			ssi->i2s_net |= SSI_SCR_I2S_MODE_MASTER;
 			break;
 		case SND_SOC_DAIFMT_CBM_CFM:
@@ -905,30 +894,34 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 			return -EINVAL;
 		}
 
+		regmap_update_bits(ssi->regs, REG_SSI_STCCR,
+				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
+		regmap_update_bits(ssi->regs, REG_SSI_SRCCR,
+				   SSI_SxCCR_DC_MASK, SSI_SxCCR_DC(2));
+
 		/* Data on rising edge of bclk, frame low, 1clk before data */
-		strcr |= SSI_STCR_TFSI | SSI_STCR_TSCKP |
-			 SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
+		strcr |= SSI_STCR_TFSI | SSI_STCR_TSCKP | SSI_STCR_TEFS;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		/* Data on rising edge of bclk, frame high */
-		strcr |= SSI_STCR_TXBIT0 | SSI_STCR_TSCKP;
+		strcr |= SSI_STCR_TSCKP;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* Data on rising edge of bclk, frame high, 1clk before data */
-		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP |
-			 SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP | SSI_STCR_TEFS;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		/* Data on rising edge of bclk, frame high */
-		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP | SSI_STCR_TXBIT0;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TSCKP;
 		break;
 	case SND_SOC_DAIFMT_AC97:
 		/* Data on falling edge of bclk, frame high, 1clk before data */
-		ssi->i2s_net |= SSI_SCR_I2S_MODE_NORMAL;
+		strcr |= SSI_STCR_TEFS;
 		break;
 	default:
 		return -EINVAL;
 	}
+
 	scr |= ssi->i2s_net;
 
 	/* DAI clock inversion */
@@ -962,20 +955,17 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* Input bit or frame sync clocks */
-		scr &= ~SSI_SCR_SYS_CLK_EN;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* Input bit clock but output frame sync clock */
-		strcr &= ~SSI_STCR_TXDIR;
 		strcr |= SSI_STCR_TFDIR;
-		scr &= ~SSI_SCR_SYS_CLK_EN;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	stcr |= strcr;
-	srcr |= strcr;
+	stcr = strcr;
+	srcr = strcr;
 
 	/* Set SYN mode and clear RXDIR bit when using SYN or AC97 mode */
 	if (ssi->cpu_dai_drv.symmetric_rates || fsl_ssi_is_ac97(ssi)) {
@@ -983,9 +973,15 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr |= SSI_SCR_SYN;
 	}
 
-	regmap_write(regs, REG_SSI_STCR, stcr);
-	regmap_write(regs, REG_SSI_SRCR, srcr);
-	regmap_write(regs, REG_SSI_SCR, scr);
+	mask = SSI_STCR_TFDIR | SSI_STCR_TXDIR | SSI_STCR_TSCKP |
+	       SSI_STCR_TFSL | SSI_STCR_TFSI | SSI_STCR_TEFS | SSI_STCR_TXBIT0;
+
+	regmap_update_bits(ssi->regs, REG_SSI_STCR, mask, stcr);
+	regmap_update_bits(ssi->regs, REG_SSI_SRCR, mask, srcr);
+
+	mask = SSI_SCR_SYNC_TX_FS | SSI_SCR_I2S_MODE_MASK |
+	       SSI_SCR_SYS_CLK_EN | SSI_SCR_SYN;
+	regmap_update_bits(ssi->regs, REG_SSI_SCR, mask, scr);
 
 	return 0;
 }
@@ -1001,7 +997,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (fsl_ssi_is_ac97(ssi))
 		return 0;
 
-	return _fsl_ssi_set_dai_fmt(dai->dev, ssi, fmt);
+	return _fsl_ssi_set_dai_fmt(ssi, fmt);
 }
 
 /**
@@ -1254,7 +1250,7 @@ static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
 
 	/* AC97 should start earlier to communicate with CODECs */
 	if (fsl_ssi_is_ac97(ssi)) {
-		_fsl_ssi_set_dai_fmt(ssi->dev, ssi, ssi->dai_fmt);
+		_fsl_ssi_set_dai_fmt(ssi, ssi->dai_fmt);
 		fsl_ssi_setup_ac97(ssi);
 	}
 
-- 
2.16.1
