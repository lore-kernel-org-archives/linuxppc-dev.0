Return-Path: <tie-fei.zang@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id CE359B70CE
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 15:15:34 +1000 (EST)
Received: from mail55-tx2 (localhost.localdomain [127.0.0.1])	by
	mail55-tx2-R.bigfish.com (Postfix) with ESMTP id 74A5417A03C7	for
	<linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 05:00:27 +0000 (UTC)
Received: from TX2EHSMHS043.bigfish.com (unknown [10.9.14.244])	by
	mail55-tx2.bigfish.com (Postfix) with ESMTP id 17CAB2A804C	for
	<linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 05:00:26 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7350P6j011744	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 22:00:25 -0700 (MST)
From: Roy Zang <tie-fei.zang@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] P4080/eLBC: Make Freescale elbc interrupt common to elbc
	devices
Date: Tue, 3 Aug 2010 12:45:12 +0800
Message-ID: <1280810714-30639-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B25806@freescale.com, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Lan Chunhe-B25806 <b25806@freescale.com>

Move Freescale elbc interrupt from nand dirver to elbc driver.
Then all elbc devices can use the interrupt instead of ONLY nand.

Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/Kconfig               |    7 +-
 arch/powerpc/include/asm/fsl_lbc.h |   34 +++++-
 arch/powerpc/sysdev/fsl_lbc.c      |  254 ++++++++++++++++++++++++++++++------
 3 files changed, 253 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2031a28..5155b53 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -703,9 +703,12 @@ config 4xx_SOC
 	bool
 
 config FSL_LBC
-	bool
+	bool "Freescale Local Bus support"
+	depends on FSL_SOC
 	help
-	  Freescale Localbus support
+	  Enables reporting of errors from the Freescale local bus
+	  controller.  Also contains some common code used by
+	  drivers for specific local bus peripherals.
 
 config FSL_GTM
 	bool
diff --git a/arch/powerpc/include/asm/fsl_lbc.h b/arch/powerpc/include/asm/fsl_lbc.h
index 1b5a210..9b95eab 100644
--- a/arch/powerpc/include/asm/fsl_lbc.h
+++ b/arch/powerpc/include/asm/fsl_lbc.h
@@ -1,9 +1,10 @@
 /* Freescale Local Bus Controller
  *
- * Copyright (c) 2006-2007 Freescale Semiconductor
+ * Copyright (c) 2006-2007, 2010 Freescale Semiconductor
  *
  * Authors: Nick Spence <nick.spence@freescale.com>,
  *          Scott Wood <scottwood@freescale.com>
+ *          Jack Lan <jack.lan@freescale.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -27,6 +28,9 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
+#include <linux/of_platform.h>
+#include <linux/interrupt.h>
+
 struct fsl_lbc_bank {
 	__be32 br;             /**< Base Register  */
 #define BR_BA           0xFFFF8000
@@ -125,13 +129,23 @@ struct fsl_lbc_regs {
 #define LTESR_ATMW 0x00800000
 #define LTESR_ATMR 0x00400000
 #define LTESR_CS   0x00080000
+#define LTESR_UPM  0x00000002
 #define LTESR_CC   0x00000001
 #define LTESR_NAND_MASK (LTESR_FCT | LTESR_PAR | LTESR_CC)
+#define LTESR_MASK      (LTESR_BM | LTESR_FCT | LTESR_PAR | LTESR_WP \
+			 | LTESR_ATMW | LTESR_ATMR | LTESR_CS | LTESR_UPM \
+			 | LTESR_CC)
+#define LTESR_CLEAR	0xFFFFFFFF
+#define LTECCR_CLEAR	0xFFFFFFFF
+#define LTESR_STATUS	LTESR_MASK
+#define LTEIR_ENABLE	LTESR_MASK
+#define LTEDR_ENABLE	0x00000000
 	__be32 ltedr;           /**< Transfer Error Disable Register */
 	__be32 lteir;           /**< Transfer Error Interrupt Register */
 	__be32 lteatr;          /**< Transfer Error Attributes Register */
 	__be32 ltear;           /**< Transfer Error Address Register */
-	u8 res6[0xC];
+	__be32 lteccr;          /**< Transfer Error ECC Register */
+	u8 res6[0x8];
 	__be32 lbcr;            /**< Configuration Register */
 #define LBCR_LDIS  0x80000000
 #define LBCR_LDIS_SHIFT    31
@@ -265,7 +279,23 @@ static inline void fsl_upm_end_pattern(struct fsl_upm *upm)
 		cpu_relax();
 }
 
+/* overview of the fsl lbc controller */
+
+struct fsl_lbc_ctrl {
+	/* device info */
+	struct device			*dev;
+	struct fsl_lbc_regs __iomem	*regs;
+	int				irq;
+	wait_queue_head_t		irq_wait;
+	spinlock_t			lock;
+	void				*nand;
+
+	/* status read from LTESR by irq handler */
+	unsigned int			irq_status;
+};
+
 extern int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base,
 			       u32 mar);
+extern struct fsl_lbc_ctrl *fsl_lbc_ctrl_dev;
 
 #endif /* __ASM_FSL_LBC_H */
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index dceb8d1..9c9e44f 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -5,6 +5,10 @@
  *
  * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
  *
+ * Copyright (c) 2010 Freescale Semiconductor
+ *
+ * Authors: Jack Lan <Jack.Lan@freescale.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -23,35 +27,8 @@
 #include <asm/fsl_lbc.h>
 
 static spinlock_t fsl_lbc_lock = __SPIN_LOCK_UNLOCKED(fsl_lbc_lock);
-static struct fsl_lbc_regs __iomem *fsl_lbc_regs;
-
-static char __initdata *compat_lbc[] = {
-	"fsl,pq2-localbus",
-	"fsl,pq2pro-localbus",
-	"fsl,pq3-localbus",
-	"fsl,elbc",
-};
-
-static int __init fsl_lbc_init(void)
-{
-	struct device_node *lbus;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(compat_lbc); i++) {
-		lbus = of_find_compatible_node(NULL, NULL, compat_lbc[i]);
-		if (lbus)
-			goto found;
-	}
-	return -ENODEV;
-
-found:
-	fsl_lbc_regs = of_iomap(lbus, 0);
-	of_node_put(lbus);
-	if (!fsl_lbc_regs)
-		return -ENOMEM;
-	return 0;
-}
-arch_initcall(fsl_lbc_init);
+struct fsl_lbc_ctrl *fsl_lbc_ctrl_dev;
+EXPORT_SYMBOL(fsl_lbc_ctrl_dev);
 
 /**
  * fsl_lbc_find - find Localbus bank
@@ -66,12 +43,12 @@ int fsl_lbc_find(phys_addr_t addr_base)
 {
 	int i;
 
-	if (!fsl_lbc_regs)
+	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
 		return -ENODEV;
 
-	for (i = 0; i < ARRAY_SIZE(fsl_lbc_regs->bank); i++) {
-		__be32 br = in_be32(&fsl_lbc_regs->bank[i].br);
-		__be32 or = in_be32(&fsl_lbc_regs->bank[i].or);
+	for (i = 0; i < ARRAY_SIZE(fsl_lbc_ctrl_dev->regs->bank); i++) {
+		__be32 br = in_be32(&fsl_lbc_ctrl_dev->regs->bank[i].br);
+		__be32 or = in_be32(&fsl_lbc_ctrl_dev->regs->bank[i].or);
 
 		if (br & BR_V && (br & or & BR_BA) == addr_base)
 			return i;
@@ -99,17 +76,20 @@ int fsl_upm_find(phys_addr_t addr_base, struct fsl_upm *upm)
 	if (bank < 0)
 		return bank;
 
-	br = in_be32(&fsl_lbc_regs->bank[bank].br);
+	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
+		return -ENODEV;
+
+	br = in_be32(&fsl_lbc_ctrl_dev->regs->bank[bank].br);
 
 	switch (br & BR_MSEL) {
 	case BR_MS_UPMA:
-		upm->mxmr = &fsl_lbc_regs->mamr;
+		upm->mxmr = &fsl_lbc_ctrl_dev->regs->mamr;
 		break;
 	case BR_MS_UPMB:
-		upm->mxmr = &fsl_lbc_regs->mbmr;
+		upm->mxmr = &fsl_lbc_ctrl_dev->regs->mbmr;
 		break;
 	case BR_MS_UPMC:
-		upm->mxmr = &fsl_lbc_regs->mcmr;
+		upm->mxmr = &fsl_lbc_ctrl_dev->regs->mcmr;
 		break;
 	default:
 		return -EINVAL;
@@ -143,14 +123,18 @@ EXPORT_SYMBOL(fsl_upm_find);
  * thus UPM pattern actually executed. Note that mar usage depends on the
  * pre-programmed AMX bits in the UPM RAM.
  */
+
 int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base, u32 mar)
 {
 	int ret = 0;
 	unsigned long flags;
 
+	if (!fsl_lbc_ctrl_dev || !fsl_lbc_ctrl_dev->regs)
+		return -ENODEV;
+
 	spin_lock_irqsave(&fsl_lbc_lock, flags);
 
-	out_be32(&fsl_lbc_regs->mar, mar);
+	out_be32(&fsl_lbc_ctrl_dev->regs->mar, mar);
 
 	switch (upm->width) {
 	case 8:
@@ -172,3 +156,197 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base, u32 mar)
 	return ret;
 }
 EXPORT_SYMBOL(fsl_upm_run_pattern);
+
+static int __devinit fsl_lbc_ctrl_init(struct fsl_lbc_ctrl *ctrl)
+{
+	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+
+	/* clear event registers */
+	setbits32(&lbc->ltesr, LTESR_CLEAR);
+	out_be32(&lbc->lteatr, 0);
+	out_be32(&lbc->ltear, 0);
+	out_be32(&lbc->lteccr, LTECCR_CLEAR);
+	out_be32(&lbc->ltedr, LTEDR_ENABLE);
+
+	/* Enable interrupts for any detected events */
+	out_be32(&lbc->lteir, LTEIR_ENABLE);
+
+	return 0;
+}
+
+static int __devexit fsl_lbc_ctrl_remove(struct of_device *ofdev)
+{
+	struct fsl_lbc_ctrl *ctrl = dev_get_drvdata(&ofdev->dev);
+
+	if (ctrl->irq)
+		free_irq(ctrl->irq, ctrl);
+
+	if (ctrl->regs)
+		iounmap(ctrl->regs);
+
+	dev_set_drvdata(&ofdev->dev, NULL);
+	kfree(ctrl);
+
+	return 0;
+}
+
+/* NOTE: This interrupt is used to report localbus events of various kinds,
+ * such as transaction errors on the chipselects.
+ */
+
+static irqreturn_t fsl_lbc_ctrl_irq(int irqno, void *data)
+{
+	struct fsl_lbc_ctrl *ctrl = data;
+	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
+	u32 status;
+
+	status = in_be32(&lbc->ltesr);
+
+	if (status) {
+		out_be32(&lbc->ltesr, LTESR_CLEAR);
+		out_be32(&lbc->lteatr, 0);
+		out_be32(&lbc->ltear, 0);
+		ctrl->irq_status = status;
+
+		if (status & LTESR_BM)
+			dev_err(ctrl->dev, "Local bus monitor time-out: "
+				"LTESR 0x%08X\n", status);
+		if (status & LTESR_WP)
+			dev_err(ctrl->dev, "Write protect error: "
+				"LTESR 0x%08X\n", status);
+		if (status & LTESR_ATMW)
+			dev_err(ctrl->dev, "Atomic write error: "
+				"LTESR 0x%08X\n", status);
+		if (status & LTESR_ATMR)
+			dev_err(ctrl->dev, "Atomic read error: "
+				"LTESR 0x%08X\n", status);
+		if (status & LTESR_CS)
+			dev_err(ctrl->dev, "Chip select error: "
+				"LTESR 0x%08X\n", status);
+		if (status & LTESR_UPM)
+			;
+		if (status & LTESR_FCT) {
+			dev_err(ctrl->dev, "FCM command time-out: "
+				"LTESR 0x%08X\n", status);
+			smp_wmb();
+			wake_up(&ctrl->irq_wait);
+		}
+		if (status & LTESR_PAR) {
+			dev_err(ctrl->dev, "Parity or Uncorrectable ECC error: "
+				"LTESR 0x%08X\n", status);
+			smp_wmb();
+			wake_up(&ctrl->irq_wait);
+		}
+		if (status & LTESR_CC) {
+			smp_wmb();
+			wake_up(&ctrl->irq_wait);
+		}
+		if (status & ~LTESR_MASK)
+			dev_err(ctrl->dev, "Unknown error: "
+				"LTESR 0x%08X\n", status);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+/* fsl_lbc_ctrl_probe
+ *
+ * called by device layer when it finds a device matching
+ * one our driver can handled. This code allocates all of
+ * the resources needed for the controller only.  The
+ * resources for the NAND banks themselves are allocated
+ * in the chip probe function.
+*/
+
+static int __devinit fsl_lbc_ctrl_probe(struct of_device *ofdev,
+					 const struct of_device_id *match)
+{
+	int ret = 0;
+
+	fsl_lbc_ctrl_dev = kzalloc(sizeof(*fsl_lbc_ctrl_dev), GFP_KERNEL);
+	if (!fsl_lbc_ctrl_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(&ofdev->dev, fsl_lbc_ctrl_dev);
+
+	spin_lock_init(&fsl_lbc_ctrl_dev->lock);
+	init_waitqueue_head(&fsl_lbc_ctrl_dev->irq_wait);
+
+	fsl_lbc_ctrl_dev->regs = of_iomap(ofdev->dev.of_node, 0);
+	if (!fsl_lbc_ctrl_dev->regs) {
+		dev_err(&ofdev->dev, "failed to get memory region\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	fsl_lbc_ctrl_dev->irq = of_irq_to_resource(ofdev->dev.of_node, 0, NULL);
+	if (fsl_lbc_ctrl_dev->irq == NO_IRQ) {
+		dev_err(&ofdev->dev, "failed to get irq resource\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	fsl_lbc_ctrl_dev->dev = &ofdev->dev;
+
+	ret = fsl_lbc_ctrl_init(fsl_lbc_ctrl_dev);
+	if (ret < 0)
+		goto err;
+
+	ret = request_irq(fsl_lbc_ctrl_dev->irq, fsl_lbc_ctrl_irq, 0,
+				"fsl-lbc", fsl_lbc_ctrl_dev);
+	if (ret != 0) {
+		dev_err(&ofdev->dev, "failed to install irq (%d)\n",
+			fsl_lbc_ctrl_dev->irq);
+		ret = fsl_lbc_ctrl_dev->irq;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	return ret;
+}
+
+static const struct of_device_id fsl_lbc_match[] = {
+	{
+		.compatible = "fsl,elbc",
+	},
+	{
+		.compatible = "fsl,pq3-localbus",
+	},
+	{
+		.compatible = "fsl,pq2-localbus",
+	},
+	{
+		.compatible = "fsl,pq2pro-localbus",
+	},
+	{},
+};
+
+static struct of_platform_driver fsl_lbc_ctrl_driver = {
+	.driver = {
+		.name = "fsl-lbc",
+		.of_match_table = fsl_lbc_match,
+	},
+	.probe = fsl_lbc_ctrl_probe,
+	.remove = __devexit_p(fsl_lbc_ctrl_remove),
+};
+
+static int __init fsl_lbc_init(void)
+{
+	return of_register_platform_driver(&fsl_lbc_ctrl_driver);
+}
+
+static void __exit fsl_lbc_exit(void)
+{
+	of_unregister_platform_driver(&fsl_lbc_ctrl_driver);
+}
+
+module_init(fsl_lbc_init);
+module_exit(fsl_lbc_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Freescale Semiconductor");
+MODULE_DESCRIPTION("Freescale Enhanced Local Bus Controller driver");
-- 
1.5.6.5
