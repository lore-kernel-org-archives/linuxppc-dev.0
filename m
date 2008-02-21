Return-Path: <SRS0=7Uz3=TK=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id B127DDDEC8
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 01:01:02 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] [POWERPC] Add AMCC Canyonlands 460EX eval board support
	to platforms/44x
Date: Thu, 21 Feb 2008 15:00:46 +0100
Message-Id: <1203602446-11330-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/platforms/44x/Kconfig       |   18 ++++++++
 arch/powerpc/platforms/44x/Makefile      |    1 +
 arch/powerpc/platforms/44x/canyonlands.c |   64 ++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/44x/canyonlands.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index c062c4c..b56690c 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -67,6 +67,16 @@ config WARP
 	  See http://www.pikatechnologies.com/ and follow the "PIKA for Computer
 	  Telephony Developers" link for more information.
 
+config CANYONLANDS
+	bool "Canyonlands"
+	depends on 44x
+	default n
+	select 460EX
+	select PCI
+	select PPC4xx_PCI_EXPRESS
+	help
+	  This option enables support for the AMCC PPC460EX evaluation board.
+
 #config LUAN
 #	bool "Luan"
 #	depends on 44x
@@ -122,6 +132,14 @@ config 440SPe
         select IBM_NEW_EMAC_EMAC4
 	bool
 
+config 460EX
+	bool
+	select PPC_FPU
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
+	select IBM_NEW_EMAC_TAH
+
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 0864d4f..d70eb03 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_KATMAI)	+= katmai.o
 obj-$(CONFIG_RAINIER)	+= rainier.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_WARP)	+= warp-nand.o
+obj-$(CONFIG_CANYONLANDS) += canyonlands.o
diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
new file mode 100644
index 0000000..dac5b32
--- /dev/null
+++ b/arch/powerpc/platforms/44x/canyonlands.c
@@ -0,0 +1,64 @@
+/*
+ * Canyonlands board specific routines
+ *
+ * Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * Based on the Katmai code by
+ * Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ * Copyright 2007 IBM Corp.
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ * Copyright 2007 IBM Corporation
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/pci-bridge.h>
+
+#include "44x.h"
+
+static __initdata struct of_device_id canyonlands_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init canyonlands_device_probe(void)
+{
+	of_platform_bus_probe(NULL, canyonlands_of_bus, NULL);
+
+	return 0;
+}
+machine_device_initcall(canyonlands, canyonlands_device_probe);
+
+static int __init canyonlands_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "amcc,canyonlands"))
+		return 0;
+
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
+	return 1;
+}
+
+define_machine(canyonlands) {
+	.name 				= "Canyonlands",
+	.probe 				= canyonlands_probe,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.restart			= ppc44x_reset_system,
+	.calibrate_decr			= generic_calibrate_decr,
+};
-- 
1.5.4.2
