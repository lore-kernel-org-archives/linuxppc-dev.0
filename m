Return-Path: <jwboyer@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by ozlabs.org (Postfix) with ESMTP id BEA81DEDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:42:02 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so25503wxd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:42:00 -0700 (PDT)
Message-Id: <5249308a3829886b871f2cdcf42cabde9d9a5b37.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:26:48 -0400
Subject: [PATCH 6/9] powerpc/44x: Migrate Sequoia support to ppc44x_simple
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

Migrate the AMCC Sequoia board to use the ppc44x_simple platform file.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/44x/Kconfig   |    1 +
 arch/powerpc/platforms/44x/Makefile  |    1 -
 arch/powerpc/platforms/44x/sequoia.c |   63 ----------------------------------
 3 files changed, 1 insertions(+), 64 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/sequoia.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 89e7f1f..84e2a70 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -31,6 +31,7 @@ config SEQUOIA
 	bool "Sequoia"
 	depends on 44x
 	default n
+	select PPC44x_SIMPLE
 	select 440EPX
 	help
 	  This option enables support for the AMCC PPC440EPX evaluation board.
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index c201af6..a8a92c1 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -3,7 +3,6 @@ obj-$(CONFIG_PPC44x_SIMPLE) += ppc44x_simple.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
-obj-$(CONFIG_SEQUOIA)	+= sequoia.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_WARP)	+= warp-nand.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
diff --git a/arch/powerpc/platforms/44x/sequoia.c b/arch/powerpc/platforms/44x/sequoia.c
deleted file mode 100644
index 49eb73d..0000000
--- a/arch/powerpc/platforms/44x/sequoia.c
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Sequoia board specific routines
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
-
-#include <asm/ppc4xx.h>
-
-static __initdata struct of_device_id sequoia_of_bus[] = {
-	{ .compatible = "ibm,plb4", },
-	{ .compatible = "ibm,opb", },
-	{ .compatible = "ibm,ebc", },
-	{},
-};
-
-static int __init sequoia_device_probe(void)
-{
-	of_platform_bus_probe(NULL, sequoia_of_bus, NULL);
-
-	return 0;
-}
-machine_device_initcall(sequoia, sequoia_device_probe);
-
-static int __init sequoia_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "amcc,sequoia"))
-		return 0;
-
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
-
-	return 1;
-}
-
-define_machine(sequoia) {
-	.name 				= "Sequoia",
-	.probe 				= sequoia_probe,
-	.progress 			= udbg_progress,
-	.init_IRQ 			= uic_init_tree,
-	.get_irq 			= uic_get_irq,
-	.restart			= ppc4xx_reset_system,
-	.calibrate_decr			= generic_calibrate_decr,
-};
-- 
1.5.5.1
