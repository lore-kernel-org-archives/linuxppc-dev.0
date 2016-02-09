Return-Path: <raghav.dogra@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0090.outbound.protection.outlook.com [65.55.169.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 935BD1A0399
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 21:12:50 +1100 (AEDT)
From: Raghav Dogra <raghav.dogra@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <oss@buserror.net>, <prabhakar.kushwaha@nxp.com>, Raghav Dogra
 <raghav.dogra@nxp.com>
Subject: [PATCH][v3] mpc85xx/lbc: modify suspend/resume entry sequence
Date: Tue, 9 Feb 2016 15:09:08 +0530
Message-ID: <1455010748-6316-1-git-send-email-raghav.dogra@nxp.com>
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

Modify platform driver suspend/resume to syscore
suspend/resume. This is because p1022ds needs to use
localbus when entering the PCIE resume.

Signed-off-by: Raghav Dogra <raghav.dogra@nxp.com>
---
Changes for v3: rebased to linux.git main branch

 arch/powerpc/sysdev/Makefile  |  2 +-
 arch/powerpc/sysdev/fsl_lbc.c | 49 +++++++++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index bd6bd72..ee972aa 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -18,9 +18,9 @@ obj-$(CONFIG_PPC_PMI)		+= pmi.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o fsl_mpic_err.o
+obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
 obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
-obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
 obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 47f7810..424b67f 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/mod_devicetable.h>
+#include <linux/syscore_ops.h>
 #include <asm/prom.h>
 #include <asm/fsl_lbc.h>
 
@@ -352,24 +353,42 @@ err:
 #ifdef CONFIG_SUSPEND
 
 /* save lbc registers */
-static int fsl_lbc_suspend(struct platform_device *pdev, pm_message_t state)
+static int fsl_lbc_syscore_suspend(void)
 {
-	struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
-	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+	struct fsl_lbc_ctrl *ctrl;
+	struct fsl_lbc_regs __iomem *lbc;
+
+	ctrl = fsl_lbc_ctrl_dev;
+	if (!ctrl)
+		goto out;
+
+	lbc = ctrl->regs;
+	if (!lbc)
+		goto out;
 
 	ctrl->saved_regs = kmalloc(sizeof(struct fsl_lbc_regs), GFP_KERNEL);
 	if (!ctrl->saved_regs)
 		return -ENOMEM;
 
 	_memcpy_fromio(ctrl->saved_regs, lbc, sizeof(struct fsl_lbc_regs));
+
+out:
 	return 0;
 }
 
 /* restore lbc registers */
-static int fsl_lbc_resume(struct platform_device *pdev)
+static void fsl_lbc_syscore_resume(void)
 {
-	struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
-	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+	struct fsl_lbc_ctrl *ctrl;
+	struct fsl_lbc_regs __iomem *lbc;
+
+	ctrl = fsl_lbc_ctrl_dev;
+	if (!ctrl)
+		goto out;
+
+	lbc = ctrl->regs;
+	if (!lbc)
+		goto out;
 
 	if (ctrl->saved_regs) {
 		_memcpy_toio(lbc, ctrl->saved_regs,
@@ -377,7 +396,9 @@ static int fsl_lbc_resume(struct platform_device *pdev)
 		kfree(ctrl->saved_regs);
 		ctrl->saved_regs = NULL;
 	}
-	return 0;
+
+out:
+	return;
 }
 #endif /* CONFIG_SUSPEND */
 
@@ -389,20 +410,26 @@ static const struct of_device_id fsl_lbc_match[] = {
 	{},
 };
 
+#ifdef CONFIG_SUSPEND
+static struct syscore_ops lbc_syscore_pm_ops = {
+	.suspend = fsl_lbc_syscore_suspend,
+	.resume = fsl_lbc_syscore_resume,
+};
+#endif
+
 static struct platform_driver fsl_lbc_ctrl_driver = {
 	.driver = {
 		.name = "fsl-lbc",
 		.of_match_table = fsl_lbc_match,
 	},
 	.probe = fsl_lbc_ctrl_probe,
-#ifdef CONFIG_SUSPEND
-	.suspend     = fsl_lbc_suspend,
-	.resume      = fsl_lbc_resume,
-#endif
 };
 
 static int __init fsl_lbc_init(void)
 {
+#ifdef CONFIG_SUSPEND
+	register_syscore_ops(&lbc_syscore_pm_ops);
+#endif
 	return platform_driver_register(&fsl_lbc_ctrl_driver);
 }
 subsys_initcall(fsl_lbc_init);
-- 
1.9.1
