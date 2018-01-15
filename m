Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKgDm6T2WzF0Z6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 15:22:32 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id k19so7475550pfj.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jan 2018 20:22:32 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org,
	mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de,
 kernel@pengutronix.de
Subject: [PATCH v3 14/17] ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
Date: Sun, 14 Jan 2018 20:21:24 -0800
Message-Id: <1515990087-11598-15-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The _fsl_ssi_set_dai_fmt() is a helper function being called from
fsl_ssi_set_dai_fmt() as an ASoC operation and fsl_ssi_hw_init()
mainly for AC97 format initialization.

This patch cleans the _fsl_ssi_set_dai_fmt() in following ways:
* Removing *dev pointer in the parameters as it's included in the
  *ssi pointer of struct fsl_ssi.
* Using regmap_update_bits() instead of regmap_read() with masking
  the value manually.
* Removing TXBIT0 configurations since this bit is set to 1 as its
  reset value and there is no use case so far to unset it. And it
  is safe to remove since regmap_update_bits() won't touch it.
* Moving baudclk check to the switch-case routine to skip the I2S
  master check. And moving SxCCR.DC settings after baudclk check.
* Adding format settings for SND_SOC_DAIFMT_AC97 like others.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
Changelog
v3
 * Put CBM_CFS behind the baudclk check to keep the same program
   flow as before

 sound/soc/fsl/fsl_ssi.c | 73 ++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 40 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ebb3eb9..9ff6734 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -860,42 +860,28 @@ static int fsl_ssi_hw_free(struct snd_pcm_substream *substream,
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
-
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
@@ -905,30 +891,34 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
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
@@ -962,20 +952,17 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
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
@@ -983,9 +970,15 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		scr |= SSI_SCR_SYN;
 	}
 
-	regmap_write(regs, REG_SSI_STCR, stcr);
-	regmap_write(regs, REG_SSI_SRCR, srcr);
-	regmap_write(regs, REG_SSI_SCR, scr);
+	mask = SSI_STCR_TFDIR | SSI_STCR_TXDIR | SSI_STCR_TSCKP |
+	       SSI_STCR_TFSI | SSI_STCR_TFSL | SSI_STCR_TEFS;
+
+	regmap_update_bits(ssi->regs, REG_SSI_STCR, mask, stcr);
+	regmap_update_bits(ssi->regs, REG_SSI_SRCR, mask, srcr);
+
+	mask = SSI_SCR_SYNC_TX_FS | SSI_SCR_I2S_MODE_MASK |
+	       SSI_SCR_SYS_CLK_EN | SSI_SCR_SYN;
+	regmap_update_bits(ssi->regs, REG_SSI_SCR, mask, scr);
 
 	return 0;
 }
@@ -1001,7 +994,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (fsl_ssi_is_ac97(ssi))
 		return 0;
 
-	return _fsl_ssi_set_dai_fmt(dai->dev, ssi, fmt);
+	return _fsl_ssi_set_dai_fmt(ssi, fmt);
 }
 
 /**
@@ -1254,7 +1247,7 @@ static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
 
 	/* AC97 should start earlier to communicate with CODECs */
 	if (fsl_ssi_is_ac97(ssi)) {
-		_fsl_ssi_set_dai_fmt(ssi->dev, ssi, ssi->dai_fmt);
+		_fsl_ssi_set_dai_fmt(ssi, ssi->dai_fmt);
 		fsl_ssi_setup_ac97(ssi);
 	}
 
-- 
2.7.4
