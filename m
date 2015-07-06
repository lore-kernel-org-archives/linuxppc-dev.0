Return-Path: <zidan.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0148.outbound.protection.outlook.com [157.56.110.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AEAF1A0DA8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 19:49:14 +1000 (AEST)
From: Zidan Wang <zidan.wang@freescale.com>
To: <timur@tabi.org>
CC: <nicoleotsuka@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.de>, <alsa-devel@alsa-project.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Zidan Wang
 <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 3/3] ASoC: fsl_sai: Add driver suspend and resume
 to support MEGA Fast
Date: Mon, 6 Jul 2015 17:50:36 +0800
Message-ID: <2413b8455682d5a245110dba0c12f7c40b68bbba.1436176158.git.zidan.wang@freescale.com>
In-Reply-To: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
References: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
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
 sound/soc/fsl/fsl_sai.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5c73bea..62187e4 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -637,6 +637,8 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
 static bool fsl_sai_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case FSL_SAI_TCSR:
+	case FSL_SAI_RCSR:
 	case FSL_SAI_TFR:
 	case FSL_SAI_RFR:
 	case FSL_SAI_TDR:
@@ -681,6 +683,7 @@ static const struct regmap_config fsl_sai_regmap_config = {
 	.readable_reg = fsl_sai_readable_reg,
 	.volatile_reg = fsl_sai_volatile_reg,
 	.writeable_reg = fsl_sai_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 static int fsl_sai_probe(struct platform_device *pdev)
@@ -802,10 +805,40 @@ static const struct of_device_id fsl_sai_ids[] = {
 	{ /* sentinel */ }
 };
 
+#if CONFIG_PM_SLEEP
+static int fsl_sai_suspend(struct device *dev)
+{
+	struct fsl_sai *sai = dev_get_drvdata(dev);
+
+	regcache_cache_only(sai->regmap, true);
+	regcache_mark_dirty(sai->regmap);
+
+	return 0;
+}
+
+static int fsl_sai_resume(struct device *dev)
+{
+	struct fsl_sai *sai = dev_get_drvdata(dev);
+
+	regcache_cache_only(sai->regmap, false);
+	regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
+	regmap_write(sai->regmap, FSL_SAI_RCSR, FSL_SAI_CSR_SR);
+	msleep(1);
+	regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
+	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
+	return regcache_sync(sai->regmap);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_sai_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_sai_suspend, fsl_sai_resume)
+};
+
 static struct platform_driver fsl_sai_driver = {
 	.probe = fsl_sai_probe,
 	.driver = {
 		.name = "fsl-sai",
+		.pm = &fsl_sai_pm_ops,
 		.of_match_table = fsl_sai_ids,
 	},
 };
-- 
1.9.1
