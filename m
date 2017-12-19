Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1PLn0Dn0zF06F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 04:01:21 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id d21so7317899pll.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 09:01:20 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: timur@tabi.org,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com,
 mail@maciej.szmigiero.name, caleb@crome.org, arnaud.mouiche@invoxia.com,
 lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v1 10/15] ASoC: fsl_ssi: Move one-time configurations to
 dai_probe()
Date: Tue, 19 Dec 2017 09:00:14 -0800
Message-Id: <1513702819-42310-11-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The dai_probe() could handle some one-time configurations since
they will not be changed once being configured.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fd756dd..4673709 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -855,7 +855,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 {
 	struct regmap *regs = ssi->regs;
 	u32 strcr = 0, stcr, srcr, scr, mask;
-	u8 wm;
 
 	ssi->dai_fmt = fmt;
 
@@ -864,8 +863,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		return -EINVAL;
 	}
 
-	fsl_ssi_setup_regvals(ssi);
-
 	regmap_read(regs, REG_SSI_SCR, &scr);
 	scr &= ~(SSI_SCR_SYN | SSI_SCR_I2S_MODE_MASK);
 	/* Synchronize frame sync clock for TE to avoid data slipping */
@@ -980,16 +977,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, REG_SSI_SRCR, srcr);
 	regmap_write(regs, REG_SSI_SCR, scr);
 
-	wm = ssi->fifo_watermark;
-
-	regmap_write(regs, REG_SSI_SFCSR,
-		     SSI_SFCSR_TFWM0(wm) | SSI_SFCSR_RFWM0(wm) |
-		     SSI_SFCSR_TFWM1(wm) | SSI_SFCSR_RFWM1(wm));
-
-	if (ssi->use_dual_fifo)
-		regmap_update_bits(regs, REG_SSI_SCR,
-				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
-
 	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi);
 
@@ -1096,14 +1083,31 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
+/**
+ * Set DMA data and one-time configurations
+ */
 static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
+	u32 wm = ssi->fifo_watermark;
 
 	if (ssi->soc->imx && ssi->use_dma)
 		snd_soc_dai_init_dma_data(dai, &ssi->dma_params_tx,
 					  &ssi->dma_params_rx);
 
+	/* Initialize regvals */
+	fsl_ssi_setup_regvals(ssi);
+
+	/* Set watermarks */
+	regmap_write(ssi->regs, REG_SSI_SFCSR,
+		     SSI_SFCSR_TFWM0(wm) | SSI_SFCSR_RFWM0(wm) |
+		     SSI_SFCSR_TFWM1(wm) | SSI_SFCSR_RFWM1(wm));
+
+	/* Enable Dual FIFO mode */
+	if (ssi->use_dual_fifo)
+		regmap_update_bits(ssi->regs, REG_SSI_SCR,
+				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
+
 	return 0;
 }
 
-- 
2.7.4
