Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id D65C9DED98
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:41:43 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1678anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:41:43 -0700 (PDT)
Message-Id: <e4629b0ef407347130d9bab216c98c7095426e40.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:26:35 -0400
Subject: [PATCH 3/9] powerpc/44x: Migrate Canyonlands support to ppc44x_simple
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

Migrate the AMCC Canyonlands board to use the ppc44x_simple platform file.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/44x/Kconfig       |    1 +
 arch/powerpc/platforms/44x/Makefile      |    1 -
 arch/powerpc/platforms/44x/canyonlands.c |   63 ------------------------------
 3 files changed, 1 insertions(+), 64 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/canyonlands.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 0958285..92ba2d8 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -81,6 +81,7 @@ config CANYONLANDS
 	bool "Canyonlands"
 	depends on 44x
 	default n
+	select PPC44x_SIMPLE
 	select 460EX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index ca18a32..0ab626d 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -8,5 +8,4 @@ obj-$(CONFIG_KATMAI)	+= katmai.o
 obj-$(CONFIG_RAINIER)	+= rainier.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_WARP)	+= warp-nand.o
-obj-$(CONFIG_CANYONLANDS) += canyonlands.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
diff --git a/arch/powerpc/platforms/44x/canyonlands.c b/arch/powerpc/platforms/44x/canyonlands.c
deleted file mode 100644
index 3949289..0000000
--- a/arch/powerpc/platforms/44x/canyonlands.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Canyonlands board specific routines
- *
- * Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
- *
- * Based on the Katmai code by
- * Benjamin Herrenschmidt <benh@kernel.crashing.org>
- * Copyright 2007 IBM Corp.
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
-static __initdata struct of_device_id canyonlands_of_bus[] = {
-	{ .compatible = "ibm,plb4", },
-	{ .compatible = "ibm,opb", },
-	{ .compatible = "ibm,ebc", },
-	{},
-};
-
-static int __init canyonlands_device_probe(void)
-{
-	of_platform_bus_probe(NULL, canyonlands_of_bus, NULL);
-
-	return 0;
-}
-machine_device_initcall(canyonlands, canyonlands_device_probe);
-
-static int __init canyonlands_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "amcc,canyonlands"))
-		return 0;
-
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
-
-	return 1;
-}
-
-define_machine(canyonlands) {
-	.name 				= "Canyonlands",
-	.probe 				= canyonlands_probe,
-	.progress 			= udbg_progress,
-	.init_IRQ 			= uic_init_tree,
-	.get_irq 			= uic_get_irq,
-	.restart			= ppc4xx_reset_system,
-	.calibrate_decr			= generic_calibrate_decr,
-};
-- 
1.5.5.1
