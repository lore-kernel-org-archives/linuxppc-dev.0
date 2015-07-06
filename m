Return-Path: <zidan.wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0137.outbound.protection.outlook.com [65.55.169.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0FC71A06F8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 18:47:49 +1000 (AEST)
From: Zidan Wang <zidan.wang@freescale.com>
To: <timur@tabi.org>
CC: <nicoleotsuka@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.de>, <alsa-devel@alsa-project.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Zidan Wang
 <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 1/2] ASoC: fsl_ssi: Add driver suspend and resume
 to support MEGA Fast
Date: Mon, 6 Jul 2015 16:49:16 +0800
Message-ID: <dc75cce800ec7465303b94e6a18abe616a35d739.1436172253.git.zidan.wang@freescale.com>
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

For i.MX6 SoloX, there is a mode of the SoC to shutdown all power
source of modules during system suspend and resume procedure. Thus,
SSI needs to save all the values of registers before the system
suspend and restore them after the system resume.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c7647e0..52b894f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -111,12 +111,98 @@ struct fsl_ssi_rxtx_reg_val {
 	struct fsl_ssi_reg_val rx;
 	struct fsl_ssi_reg_val tx;
 };
+
+static bool fsl_ssi_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CCSR_SSI_STX0:
+	case CCSR_SSI_STX1:
+	case CCSR_SSI_SRX0:
+	case CCSR_SSI_SRX1:
+	case CCSR_SSI_SCR:
+	case CCSR_SSI_SISR:
+	case CCSR_SSI_SIER:
+	case CCSR_SSI_STCR:
+	case CCSR_SSI_SRCR:
+	case CCSR_SSI_STCCR:
+	case CCSR_SSI_SRCCR:
+	case CCSR_SSI_SFCSR:
+	case CCSR_SSI_STR:
+	case CCSR_SSI_SOR:
+	case CCSR_SSI_SACNT:
+	case CCSR_SSI_SACADD:
+	case CCSR_SSI_SACDAT:
+	case CCSR_SSI_SATAG:
+	case CCSR_SSI_STMSK:
+	case CCSR_SSI_SRMSK:
+	case CCSR_SSI_SACCST:
+	case CCSR_SSI_SACCEN:
+	case CCSR_SSI_SACCDIS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CCSR_SSI_STX0:
+	case CCSR_SSI_STX1:
+	case CCSR_SSI_SRX0:
+	case CCSR_SSI_SRX1:
+	case CCSR_SSI_SISR:
+	case CCSR_SSI_SFCSR:
+	case CCSR_SSI_SACADD:
+	case CCSR_SSI_SACDAT:
+	case CCSR_SSI_SATAG:
+	case CCSR_SSI_SACCST:
+		return true;
+	default:
+		return false;
+	}
+
+}
+
+static bool fsl_ssi_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CCSR_SSI_STX0:
+	case CCSR_SSI_STX1:
+	case CCSR_SSI_SCR:
+	case CCSR_SSI_SISR:
+	case CCSR_SSI_SIER:
+	case CCSR_SSI_STCR:
+	case CCSR_SSI_SRCR:
+	case CCSR_SSI_STCCR:
+	case CCSR_SSI_SRCCR:
+	case CCSR_SSI_SFCSR:
+	case CCSR_SSI_STR:
+	case CCSR_SSI_SOR:
+	case CCSR_SSI_SACNT:
+	case CCSR_SSI_SACADD:
+	case CCSR_SSI_SACDAT:
+	case CCSR_SSI_SATAG:
+	case CCSR_SSI_STMSK:
+	case CCSR_SSI_SRMSK:
+	case CCSR_SSI_SACCEN:
+	case CCSR_SSI_SACCDIS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static const struct regmap_config fsl_ssi_regconfig = {
 	.max_register = CCSR_SSI_SACCDIS,
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+	.readable_reg = fsl_ssi_readable_reg,
+	.volatile_reg = fsl_ssi_volatile_reg,
+	.writeable_reg = fsl_ssi_writeable_reg,
+	.cache_type = REGCACHE_RBTREE,
 };
 
 struct fsl_ssi_soc_data {
@@ -1461,10 +1547,37 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int fsl_ssi_suspend(struct device *dev)
+{
+	struct fsl_ssi_private *ssi_private = dev_get_drvdata(dev);
+	struct regmap *regs = ssi_private->regs;
+
+	regcache_cache_only(regs, true);
+	regcache_mark_dirty(regs);
+
+	return 0;
+}
+
+static int fsl_ssi_resume(struct device *dev)
+{
+	struct fsl_ssi_private *ssi_private = dev_get_drvdata(dev);
+	struct regmap *regs = ssi_private->regs;
+
+	regcache_cache_only(regs, false);
+	return regcache_sync(regs);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_ssi_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_ssi_suspend, fsl_ssi_resume)
+};
+
 static struct platform_driver fsl_ssi_driver = {
 	.driver = {
 		.name = "fsl-ssi-dai",
 		.of_match_table = fsl_ssi_ids,
+		.pm = &fsl_ssi_pm,
 	},
 	.probe = fsl_ssi_probe,
 	.remove = fsl_ssi_remove,
-- 
1.9.1
