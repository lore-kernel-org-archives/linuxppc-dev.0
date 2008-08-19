Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id D82D3DE9D4
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:41:39 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1678anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:41:39 -0700 (PDT)
Message-Id: <2e040756cf581e197f781cdf6fd40f46018e170b.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:26:24 -0400
Subject: [PATCH 2/9] powerpc/44x: Migrate Bamboo support to ppc44x_simple
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

Migrate the AMCC Bamboo board to use the ppc44x_simple platform file.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/44x/Kconfig  |    2 +
 arch/powerpc/platforms/44x/Makefile |    2 -
 arch/powerpc/platforms/44x/bamboo.c |   62 -----------------------------------
 3 files changed, 2 insertions(+), 64 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/bamboo.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 97c634c..0958285 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -2,6 +2,7 @@ config BAMBOO
 	bool "Bamboo"
 	depends on 44x
 	default n
+	select PPC44x_SIMPLE
 	select 440EP
 	select PCI
 	help
@@ -90,6 +91,7 @@ config YOSEMITE
 	bool "Yosemite"
 	depends on 44x
 	default n
+	select PPC44x_SIMPLE
 	select 440EP
 	select PCI
 	help
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 73c1df5..ca18a32 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -2,8 +2,6 @@ obj-$(CONFIG_44x)	:= misc_44x.o idle.o
 obj-$(CONFIG_PPC44x_SIMPLE) += ppc44x_simple.o
 obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_TAISHAN)	+= taishan.o
-obj-$(CONFIG_BAMBOO)	+= bamboo.o
-obj-$(CONFIG_YOSEMITE)	+= bamboo.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_SEQUOIA)	+= sequoia.o
 obj-$(CONFIG_KATMAI)	+= katmai.o
diff --git a/arch/powerpc/platforms/44x/bamboo.c b/arch/powerpc/platforms/44x/bamboo.c
deleted file mode 100644
index cef169e..0000000
--- a/arch/powerpc/platforms/44x/bamboo.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Bamboo board specific routines
- *
- * Wade Farnsworth <wfarnsworth@mvista.com>
- * Copyright 2004 MontaVista Software Inc.
- *
- * Rewritten and ported to the merged powerpc tree:
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
-static __initdata struct of_device_id bamboo_of_bus[] = {
-	{ .compatible = "ibm,plb4", },
-	{ .compatible = "ibm,opb", },
-	{ .compatible = "ibm,ebc", },
-	{},
-};
-
-static int __init bamboo_device_probe(void)
-{
-	of_platform_bus_probe(NULL, bamboo_of_bus, NULL);
-
-	return 0;
-}
-machine_device_initcall(bamboo, bamboo_device_probe);
-
-static int __init bamboo_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "amcc,bamboo"))
-		return 0;
-
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
-
-	return 1;
-}
-
-define_machine(bamboo) {
-	.name 			= "Bamboo",
-	.probe 			= bamboo_probe,
-	.progress 		= udbg_progress,
-	.init_IRQ 		= uic_init_tree,
-	.get_irq 		= uic_get_irq,
-	.restart		= ppc4xx_reset_system,
-	.calibrate_decr 	= generic_calibrate_decr,
-};
-- 
1.5.5.1
