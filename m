Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 67FEDDDE02
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 21:16:27 +1100 (EST)
Message-ID: <479EFE02.3040303@denx.de>
Date: Tue, 29 Jan 2008 11:20:50 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] 82xx: MGCOGE support
References: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
In-Reply-To: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

The following Patch adds basic files for supporting the MGCOGE
plattform from keymile.

Signed-off-by: Heiko Schocher <hs@denx.de>
---
 arch/powerpc/platforms/82xx/Kconfig  |    9 +++
 arch/powerpc/platforms/82xx/Makefile |    1 +
 arch/powerpc/platforms/82xx/mgcoge.c |  130 ++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/82xx/mgcoge.c

diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 4fad6c7..f2ea477 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -39,6 +39,15 @@ config EP8248E
 	  This board is also resold by Freescale as the QUICCStart
 	  MPC8248 Evaluation System and/or the CWH-PPC-8248N-VE.

+config MGCOGE
+	bool "Keymile MGCOGE"
+	select 8272
+	select 8260
+	select FSL_SOC
+	select PPC_CPM_NEW_BINDING
+	help
+	  This enables support for the Keymile MGCOGE board.
+
 endchoice

 config PQ2ADS
diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index 6cd5cd5..d982793 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_CPM2) += pq2.o
 obj-$(CONFIG_PQ2_ADS_PCI_PIC) += pq2ads-pci-pic.o
 obj-$(CONFIG_PQ2FADS) += pq2fads.o
 obj-$(CONFIG_EP8248E) += ep8248e.o
+obj-$(CONFIG_MGCOGE) += mgcoge.o
diff --git a/arch/powerpc/platforms/82xx/mgcoge.c b/arch/powerpc/platforms/82xx/mgcoge.c
new file mode 100644
index 0000000..a8f2956
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/mgcoge.c
@@ -0,0 +1,130 @@
+/*
+ * Keymile mgcoge support
+ * Copyright 2008 DENX Software Engineering GmbH
+ * Author: Heiko Schocher <hs@denx.de>
+ *
+ * based on code from:
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
+
+#include <asm/io.h>
+#include <asm/cpm2.h>
+#include <asm/udbg.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+#include <asm/mpc8260.h>
+#include <asm/prom.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/cpm2_pic.h>
+
+#include "pq2.h"
+
+static void __init mgcoge_pic_init(void)
+{
+	struct device_node *np = of_find_compatible_node(NULL, NULL, "fsl,pq2-pic");
+	if (!np) {
+		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
+		return;
+	}
+
+	cpm2_pic_init(np);
+	of_node_put(np);
+}
+
+struct cpm_pin {
+	int port, pin, flags;
+};
+
+static __initdata struct cpm_pin mgcoge_pins[] = {
+
+	/* SMC2 */
+	{1, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 9, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+
+	/* SCC4 */
+	{3, 25, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{3, 24, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{3,  9, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3,  8, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{4, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{4, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{4, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+};
+
+static void __init init_ioports(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mgcoge_pins); i++) {
+		const struct cpm_pin *pin = &mgcoge_pins[i];
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
+	}
+
+	cpm2_smc_clk_setup(CPM_CLK_SMC2, CPM_BRG8);
+	cpm2_clk_setup(CPM_CLK_SCC4, CPM_CLK7, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC4, CPM_CLK8, CPM_CLK_TX);
+}
+
+static void __init mgcoge_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mgcoge_setup_arch()", 0);
+
+	cpm2_reset();
+
+	/* When this is set, snooping CPM DMA from RAM causes
+	 * machine checks.  See erratum SIU18.
+	 */
+	clrbits32(&cpm2_immr->im_siu_conf.siu_82xx.sc_bcr, MPC82XX_BCR_PLDP);
+
+	init_ioports();
+
+	if (ppc_md.progress)
+		ppc_md.progress("mgcoge_setup_arch(), finish", 0);
+}
+
+static  __initdata struct of_device_id of_bus_ids[] = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(mgcoge, declare_of_platform_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mgcoge_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,mgcoge");
+}
+
+define_machine(mgcoge)
+{
+	.name = "Keymile MGCOGE",
+	.probe = mgcoge_probe,
+	.setup_arch = mgcoge_setup_arch,
+	.init_IRQ = mgcoge_pic_init,
+	.get_irq = cpm2_get_irq,
+	.calibrate_decr = generic_calibrate_decr,
+	.restart = pq2_restart,
+	.progress = udbg_progress,
+};
-- 
1.5.2.2

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
