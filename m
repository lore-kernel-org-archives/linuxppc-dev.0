Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D2BEAB7E6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 03:30:23 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 088BFDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 03:30:23 +1000 (EST)
Date: Thu, 27 Aug 2009 21:30:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/5] powerpc/85xx: Add suspend/resume support
Message-ID: <20090827173021.GD739@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds suspend/resume support for MPC8540-compatible and
MPC8569 CPUs.

MPC8540-compatible PMCs are trivial: we just write SLP bit into PM
control and status register.

MPC8569 is a bit trickier, QE turns off during suspend and so on
resume we must reload QE microcode firmware and reset QE.

So far we don't support Deep Sleep mode as found in newer MPC85xx
CPUs (i.e. MPC8536). It can be relatively easy implemented though,
and for it we reserve 'mem' suspend type.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/Kconfig                  |    2 +-
 arch/powerpc/platforms/85xx/Makefile  |    1 +
 arch/powerpc/platforms/85xx/suspend.c |  115 +++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/suspend.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d00131c..46ebfe6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -212,7 +212,7 @@ config ARCH_HIBERNATION_POSSIBLE
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
-	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx
+	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || PPC_85xx
 
 config PPC_DCR_NATIVE
 	bool
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 835733f..cd1ad6e 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the PowerPC 85xx linux kernel.
 #
 obj-$(CONFIG_SMP) += smp.o
+obj-$(CONFIG_SUSPEND) += suspend.o
 
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
diff --git a/arch/powerpc/platforms/85xx/suspend.c b/arch/powerpc/platforms/85xx/suspend.c
new file mode 100644
index 0000000..d4ca5e2
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/suspend.c
@@ -0,0 +1,115 @@
+/*
+ * Suspend/resume support
+ *
+ * Copyright © 2009  MontaVista Software, Inc.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/suspend.h>
+#include <linux/device.h>
+#include <linux/of_platform.h>
+#include <linux/firmware.h>
+#include <asm/qe.h>
+
+struct pmc_regs {
+	__be32 pmcsr;
+#define PMCSR_SLP	(1 << 17)
+};
+
+struct pmc_data {
+	unsigned int flags;
+#define PMC_NEED_QE_RELOAD (1 << 0)
+
+	const char *fw_name;
+};
+
+static struct device *pmc_dev;
+static struct pmc_regs __iomem *pmc_regs;
+static const struct pmc_data *pmc_data;
+static struct qe_firmware *pmc_qefw;
+
+static int pmc_suspend_enter(suspend_state_t state)
+{
+	out_be32(&pmc_regs->pmcsr, PMCSR_SLP);
+
+	if (pmc_qefw) {
+		int ret;
+
+		ret = qe_upload_firmware(pmc_qefw);
+		if (ret)
+			dev_err(pmc_dev, "could not upload firmware\n");
+
+		qe_reset();
+	}
+	return 0;
+}
+
+static int pmc_suspend_valid(suspend_state_t state)
+{
+	if (state != PM_SUSPEND_STANDBY)
+		return 0;
+
+	if (pmc_data && pmc_data->flags & PMC_NEED_QE_RELOAD && !pmc_qefw) {
+		const struct firmware *fw;
+		int ret;
+
+		ret = request_firmware(&fw, pmc_data->fw_name, pmc_dev);
+		if (ret) {
+			dev_err(pmc_dev, "could not request firmware %s\n",
+				pmc_data->fw_name);
+			return 0;
+		}
+
+		pmc_qefw = (struct qe_firmware *)fw->data;
+	}
+
+	return 1;
+}
+
+static struct platform_suspend_ops pmc_suspend_ops = {
+	.valid = pmc_suspend_valid,
+	.enter = pmc_suspend_enter,
+};
+
+static int pmc_probe(struct of_device *ofdev, const struct of_device_id *id)
+{
+	pmc_regs = of_iomap(ofdev->node, 0);
+	if (!pmc_regs)
+		return -ENOMEM;
+
+	pmc_dev = &ofdev->dev;
+	pmc_data = id->data;
+	suspend_set_ops(&pmc_suspend_ops);
+	return 0;
+}
+
+static struct pmc_data mpc8569_pmc_data = {
+	.flags = PMC_NEED_QE_RELOAD,
+	.fw_name = "fsl_qe_ucode_8569.bin",
+};
+
+static const struct of_device_id pmc_ids[] = {
+	{ .compatible = "fsl,mpc8569-pmc", .data = &mpc8569_pmc_data, },
+	{ .compatible = "fsl,mpc8548-pmc", },
+	{ },
+};
+
+static struct of_platform_driver pmc_driver = {
+	.driver.name = "mpc85xx-pmc",
+	.match_table = pmc_ids,
+	.probe = pmc_probe,
+};
+
+static int pmc_init(void)
+{
+	return of_register_platform_driver(&pmc_driver);
+}
+device_initcall(pmc_init);
-- 
1.6.3.3
