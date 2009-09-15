Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A8841B7C82
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 07:43:59 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id AA8ECDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 07:43:58 +1000 (EST)
Date: Wed, 16 Sep 2009 01:43:57 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/7] powerpc/85xx/86xx: Add suspend/resume support
Message-ID: <20090915214357.GD24821@oksana.dev.rtsoft.ru>
References: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090915214321.GA19377@oksana.dev.rtsoft.ru>
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

This patch adds suspend/resume support for MPC8540 and MPC8641D-
compatible CPUs. To reach sleep state, we just write the SLP bit
into the PM control and status register.

So far we don't support Deep Sleep mode as found in newer MPC85xx
CPUs (i.e. MPC8536). It can be relatively easy implemented though,
and for it we reserve 'mem' suspend type.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig          |   11 +++++-
 arch/powerpc/sysdev/Makefile  |    1 +
 arch/powerpc/sysdev/fsl_pmc.c |   88 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_pmc.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d00131c..a0743a7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -212,7 +212,8 @@ config ARCH_HIBERNATION_POSSIBLE
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
-	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx
+	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
+		   PPC_85xx || PPC_86xx
 
 config PPC_DCR_NATIVE
 	bool
@@ -642,6 +643,14 @@ config FSL_PCI
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
 
+config FSL_PMC
+	bool
+	default y
+	depends on SUSPEND && (PPC_85xx || PPC_86xx)
+	help
+	  Freescale MPC85xx/MPC86xx power management controller support
+	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
+
 config 4xx_SOC
 	bool
 
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 9d4b174..5642924 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
+obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
diff --git a/arch/powerpc/sysdev/fsl_pmc.c b/arch/powerpc/sysdev/fsl_pmc.c
new file mode 100644
index 0000000..a7635a9
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_pmc.c
@@ -0,0 +1,88 @@
+/*
+ * Suspend/resume support
+ *
+ * Copyright 2009  MontaVista Software, Inc.
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
+#include <linux/errno.h>
+#include <linux/suspend.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/of_platform.h>
+
+struct pmc_regs {
+	__be32 devdisr;
+	__be32 devdisr2;
+	__be32 :32;
+	__be32 :32;
+	__be32 pmcsr;
+#define PMCSR_SLP	(1 << 17)
+};
+
+static struct device *pmc_dev;
+static struct pmc_regs __iomem *pmc_regs;
+
+static int pmc_suspend_enter(suspend_state_t state)
+{
+	int ret;
+
+	setbits32(&pmc_regs->pmcsr, PMCSR_SLP);
+	/* At this point, the CPU is asleep. */
+
+	/* Upon resume, wait for SLP bit to be clear. */
+	ret = spin_event_timeout((in_be32(&pmc_regs->pmcsr) & PMCSR_SLP) == 0,
+				 10000, 10) ? 0 : -ETIMEDOUT;
+	if (ret)
+		dev_err(pmc_dev, "tired waiting for SLP bit to clear\n");
+	return ret;
+}
+
+static int pmc_suspend_valid(suspend_state_t state)
+{
+	if (state != PM_SUSPEND_STANDBY)
+		return 0;
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
+	suspend_set_ops(&pmc_suspend_ops);
+	return 0;
+}
+
+static const struct of_device_id pmc_ids[] = {
+	{ .compatible = "fsl,mpc8548-pmc", },
+	{ .compatible = "fsl,mpc8641d-pmc", },
+	{ },
+};
+
+static struct of_platform_driver pmc_driver = {
+	.driver.name = "fsl-pmc",
+	.match_table = pmc_ids,
+	.probe = pmc_probe,
+};
+
+static int __init pmc_init(void)
+{
+	return of_register_platform_driver(&pmc_driver);
+}
+device_initcall(pmc_init);
-- 
1.6.3.3
