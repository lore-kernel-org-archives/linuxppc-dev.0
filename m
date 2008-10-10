Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.233])
	by ozlabs.org (Postfix) with ESMTP id 36647DE66A
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 23:38:24 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so275687wra.1
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 05:38:24 -0700 (PDT)
Message-Id: <071a0947286c71852506d8d5c63cc9c88d5f4191.1223642006.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH 2/5] powerpc/40x: Add support for PowerPC 405EZ Acadia board
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Date: Fri, 10 Oct 2008 12:38:26 -0000

Add base support for the AMCC PowerPC 405EZ Acadia evalution board.  In addition
to some of the normal PPC 40x peripherals, the Acadia board has:
 - 64 MiB PSRAM
 - NOR and NAND flash
 - Two USB 1.1 host ports
 - Two CAN 2.0 ports
 - ADC and DAC connectors
 - LCD display

This adds the basic platform support to build from.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/40x/Kconfig  |   14 +++++++++
 arch/powerpc/platforms/40x/Makefile |    1 +
 arch/powerpc/platforms/40x/acadia.c |   56 +++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/40x/acadia.c

diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index a9260e2..fe59060 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -14,6 +14,14 @@
 #	help
 #	  This option enables support for the CPCI405 board.
 
+config ACADIA
+	bool "Acadia"
+	depends on 40x
+	default n
+	select 405EZ
+	help
+	  This option enables support for the AMCC 405EZ Acadia evaluation board.
+
 config EP405
 	bool "EP405/EP405PC"
 	depends on 40x
@@ -118,6 +126,12 @@ config 405EX
 	select IBM_NEW_EMAC_EMAC4
 	select IBM_NEW_EMAC_RGMII
 
+config 405EZ
+	bool
+	select IBM_NEW_EMAC_NO_FLOW_CTRL
+	select IBM_NEW_EMAC_MAL_CLR_ICINTSTAT
+	select IBM_NEW_EMAC_MAL_COMMON_ERR
+
 config 405GPR
 	bool
 
diff --git a/arch/powerpc/platforms/40x/Makefile b/arch/powerpc/platforms/40x/Makefile
index 5533a5c..ff483c0 100644
--- a/arch/powerpc/platforms/40x/Makefile
+++ b/arch/powerpc/platforms/40x/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_MAKALU)				+= makalu.o
 obj-$(CONFIG_WALNUT)				+= walnut.o
 obj-$(CONFIG_XILINX_VIRTEX_GENERIC_BOARD)	+= virtex.o
 obj-$(CONFIG_EP405)				+= ep405.o
+obj-$(CONFIG_ACADIA)			+= acadia.o
diff --git a/arch/powerpc/platforms/40x/acadia.c b/arch/powerpc/platforms/40x/acadia.c
new file mode 100644
index 0000000..9a4419b
--- /dev/null
+++ b/arch/powerpc/platforms/40x/acadia.c
@@ -0,0 +1,56 @@
+/*
+ * Acadia board support
+ *
+ * Copyright 2008 IBM Corporation
+ * Based on the Walnut code
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
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
+#include <asm/ppc4xx.h>
+
+static __initdata struct of_device_id acadia_of_bus[] = {
+	{ .compatible = "ibm,plb3", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init acadia_device_probe(void)
+{
+	of_platform_bus_probe(NULL, acadia_of_bus, NULL);
+
+	return 0;
+}
+machine_device_initcall(acadia, acadia_device_probe);
+
+static int __init acadia_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "amcc,acadia"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(acadia) {
+	.name 				= "Acadia",
+	.probe 				= acadia_probe,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.restart			= ppc4xx_reset_system,
+	.calibrate_decr			= generic_calibrate_decr,
+};
-- 
1.5.5.1
