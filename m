Return-Path: <zidan.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA2331A0D75
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 19:49:07 +1000 (AEST)
From: Zidan Wang <zidan.wang@freescale.com>
To: <timur@tabi.org>
CC: <nicoleotsuka@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.de>, <alsa-devel@alsa-project.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Zidan Wang
 <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 1/3] ASoC: fsl_esai: Add driver suspend and resume
 to support MEGA Fast
Date: Mon, 6 Jul 2015 17:50:34 +0800
Message-ID: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
modules during system suspend and resume procedure. Thus, SAI needs to save
all the values of registers before the system suspend and restore them after
the system resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 5c75971..b749a29 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -684,6 +684,32 @@ static bool fsl_esai_readable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool fsl_esai_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case REG_ESAI_ETDR:
+	case REG_ESAI_ERDR:
+	case REG_ESAI_ESR:
+	case REG_ESAI_TFSR:
+	case REG_ESAI_RFSR:
+	case REG_ESAI_TX0:
+	case REG_ESAI_TX1:
+	case REG_ESAI_TX2:
+	case REG_ESAI_TX3:
+	case REG_ESAI_TX4:
+	case REG_ESAI_TX5:
+	case REG_ESAI_RX0:
+	case REG_ESAI_RX1:
+	case REG_ESAI_RX2:
+	case REG_ESAI_RX3:
+	case REG_ESAI_SAISR:
+		return true;
+	default:
+		return false;
+	}
+
+}
+
 static bool fsl_esai_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -722,7 +748,9 @@ static const struct regmap_config fsl_esai_regmap_config = {
 
 	.max_register = REG_ESAI_PCRC,
 	.readable_reg = fsl_esai_readable_reg,
+	.volatile_reg = fsl_esai_volatile_reg,
 	.writeable_reg = fsl_esai_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int fsl_esai_probe(struct platform_device *pdev)
@@ -853,10 +881,51 @@ static const struct of_device_id fsl_esai_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
 
+#if CONFIG_PM_SLEEP
+static int fsl_esai_suspend(struct device *dev)
+{
+	struct fsl_esai *esai = dev_get_drvdata(dev);
+
+	regcache_cache_only(esai->regmap, true);
+	regcache_mark_dirty(esai->regmap);
+
+	return 0;
+}
+
+static int fsl_esai_resume(struct device *dev)
+{
+	struct fsl_esai *esai = dev_get_drvdata(dev);
+	int ret;
+
+	regcache_cache_only(esai->regmap, false);
+
+	/* FIFO reset for safety */
+	regmap_update_bits(esai->regmap, REG_ESAI_TFCR,
+			   ESAI_xFCR_xFR, ESAI_xFCR_xFR);
+	regmap_update_bits(esai->regmap, REG_ESAI_RFCR,
+			   ESAI_xFCR_xFR, ESAI_xFCR_xFR);
+
+	ret = regcache_sync(esai->regmap);
+	if (ret)
+		return ret;
+
+	/* FIFO reset done */
+	regmap_update_bits(esai->regmap, REG_ESAI_TFCR, ESAI_xFCR_xFR, 0);
+	regmap_update_bits(esai->regmap, REG_ESAI_RFCR, ESAI_xFCR_xFR, 0);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_esai_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_esai_suspend, fsl_esai_resume)
+};
+
 static struct platform_driver fsl_esai_driver = {
 	.probe = fsl_esai_probe,
 	.driver = {
 		.name = "fsl-esai-dai",
+		.pm = &fsl_esai_pm_ops,
 		.of_match_table = fsl_esai_dt_ids,
 	},
 };
-- 
1.9.1
