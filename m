Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgKRM048GzF0qD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:02:55 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id v3so5642297plg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:02:54 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 12/17] ASoC: fsl_ssi: Move one-time configurations to
 probe()
Date: Mon, 12 Feb 2018 14:03:20 -0800
Message-Id: <1518473005-14090-13-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The probe() could handle some one-time configurations since
they will not be changed once being configured.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7e15b30..36f3d51 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -865,7 +865,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 {
 	struct regmap *regs = ssi->regs;
 	u32 strcr = 0, stcr, srcr, scr, mask;
-	u8 wm;
 
 	ssi->dai_fmt = fmt;
 
@@ -874,8 +873,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 		return -EINVAL;
 	}
 
-	fsl_ssi_setup_regvals(ssi);
-
 	regmap_read(regs, REG_SSI_SCR, &scr);
 	scr &= ~(SSI_SCR_SYN | SSI_SCR_I2S_MODE_MASK);
 	/* Synchronize frame sync clock for TE to avoid data slipping */
@@ -990,16 +987,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
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
 
@@ -1249,6 +1236,29 @@ static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
 };
 
 /**
+ * Initialize SSI registers
+ */
+static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
+{
+	u32 wm = ssi->fifo_watermark;
+
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
+	return 0;
+}
+
+/**
  * Make every character in a string lower-case
  */
 static void make_lowercase(char *s)
@@ -1533,6 +1543,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	if (ssi->dai_fmt)
 		_fsl_ssi_set_dai_fmt(dev, ssi, ssi->dai_fmt);
 
+	/* Initially configures SSI registers */
+	fsl_ssi_hw_init(ssi);
+
 	if (fsl_ssi_is_ac97(ssi)) {
 		u32 ssi_idx;
 
-- 
2.1.4
