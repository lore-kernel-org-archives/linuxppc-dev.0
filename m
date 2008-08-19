Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id E147BDEE03
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:41:59 +1000 (EST)
Received: by gxk14 with SMTP id 14so4909618gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:41:58 -0700 (PDT)
Message-Id: <9320249e4a6b8cc62765ea9a12818fb340b8de2d.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:26:44 -0400
Subject: [PATCH 5/9] powerpc/44x: Migrate Rainier support to ppc44x_simple
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

Migrate the AMCC Rainier board to use the ppc44x_simple platform file.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/44x/Kconfig   |    1 +
 arch/powerpc/platforms/44x/Makefile  |    1 -
 arch/powerpc/platforms/44x/rainier.c |   62 ----------------------------------
 3 files changed, 1 insertions(+), 63 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/rainier.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 66d4499..89e7f1f 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -60,6 +60,7 @@ config RAINIER
 	bool "Rainier"
 	depends on 44x
 	default n
+	select PPC44x_SIMPLE
 	select 440GRX
 	select PCI
 	help
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 2eb1cbe..c201af6 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
-obj-$(CONFIG_RAINIER)	+= rainier.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_WARP)	+= warp-nand.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
diff --git a/arch/powerpc/platforms/44x/rainier.c b/arch/powerpc/platforms/44x/rainier.c
deleted file mode 100644
index 4f1ff84..0000000
--- a/arch/powerpc/platforms/44x/rainier.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Rainier board specific routines
- *
- * Valentine Barshak <vbarshak@ru.mvista.com>
- * Copyright 2007 MontaVista Software Inc.
- *
- * Based on the Bamboo code by
- * Josh Boyer <jwboyer@linux.vnet.ibm.com>
- * Copyright 2007 IBM Corporation
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-#include <linux/init.h>
-#include <linux/of_platform.h>
-
-#include <asm/machdep.h>
-#include <asm/prom.h>
-#include <asm/udbg.h>
-#include <asm/time.h>
-#include <asm/uic.h>
-#include <asm/pci-bridge.h>
-#include <asm/ppc4xx.h>
-
-static __initdata struct of_device_id rainier_of_bus[] = {
-	{ .compatible = "ibm,plb4", },
-	{ .compatible = "ibm,opb", },
-	{ .compatible = "ibm,ebc", },
-	{},
-};
-
-static int __init rainier_device_probe(void)
-{
-	of_platform_bus_probe(NULL, rainier_of_bus, NULL);
-
-	return 0;
-}
-machine_device_initcall(rainier, rainier_device_probe);
-
-static int __init rainier_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "amcc,rainier"))
-		return 0;
-
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
-
-	return 1;
-}
-
-define_machine(rainier) {
-	.name 				= "Rainier",
-	.probe 				= rainier_probe,
-	.progress 			= udbg_progress,
-	.init_IRQ 			= uic_init_tree,
-	.get_irq 			= uic_get_irq,
-	.restart			= ppc4xx_reset_system,
-	.calibrate_decr			= generic_calibrate_decr,
-};
-- 
1.5.5.1
