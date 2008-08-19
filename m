Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 9A627DEDC8
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:41:46 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1678anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:41:46 -0700 (PDT)
Message-Id: <298f818ce8359fbcd5763a9783882e6bec791a77.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:26:40 -0400
Subject: [PATCH 4/9] powerpc/44x: Migrate Katmai support to ppc44x_simple
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

Migrate the AMCC Katmai board to use the ppc44x_simple platform file.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/44x/Kconfig  |    1 +
 arch/powerpc/platforms/44x/Makefile |    1 -
 arch/powerpc/platforms/44x/katmai.c |   62 -----------------------------------
 3 files changed, 1 insertions(+), 63 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/katmai.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 92ba2d8..66d4499 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -49,6 +49,7 @@ config KATMAI
 	bool "Katmai"
 	depends on 44x
 	default n
+	select PPC44x_SIMPLE
 	select 440SPe
 	select PCI
 	select PPC4xx_PCI_EXPRESS
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 0ab626d..2eb1cbe 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
-obj-$(CONFIG_KATMAI)	+= katmai.o
 obj-$(CONFIG_RAINIER)	+= rainier.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_WARP)	+= warp-nand.o
diff --git a/arch/powerpc/platforms/44x/katmai.c b/arch/powerpc/platforms/44x/katmai.c
deleted file mode 100644
index 44f4b3a..0000000
--- a/arch/powerpc/platforms/44x/katmai.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Katmai board specific routines
- *
- * Benjamin Herrenschmidt <benh@kernel.crashing.org>
- * Copyright 2007 IBM Corp.
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
-static __initdata struct of_device_id katmai_of_bus[] = {
-	{ .compatible = "ibm,plb4", },
-	{ .compatible = "ibm,opb", },
-	{ .compatible = "ibm,ebc", },
-	{},
-};
-
-static int __init katmai_device_probe(void)
-{
-	of_platform_bus_probe(NULL, katmai_of_bus, NULL);
-
-	return 0;
-}
-machine_device_initcall(katmai, katmai_device_probe);
-
-static int __init katmai_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "amcc,katmai"))
-		return 0;
-
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
-
-	return 1;
-}
-
-define_machine(katmai) {
-	.name 				= "Katmai",
-	.probe 				= katmai_probe,
-	.progress 			= udbg_progress,
-	.init_IRQ 			= uic_init_tree,
-	.get_irq 			= uic_get_irq,
-	.restart			= ppc4xx_reset_system,
-	.calibrate_decr			= generic_calibrate_decr,
-};
-- 
1.5.5.1
