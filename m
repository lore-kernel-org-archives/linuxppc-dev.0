Return-Path: <jwboyer@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190])
	by ozlabs.org (Postfix) with ESMTP id 6E8C1DEDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:42:04 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so9758rnf.16
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:42:02 -0700 (PDT)
Message-Id: <293360f318b37c4c42318ca84fede9cd23d5d798.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:26:53 -0400
Subject: [PATCH 7/9] powerpc/44x: Migrate Taishan support to ppc44x_simple
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

Migrate the AMCC Taishan board to use the ppc44x_simple platform file.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/44x/Kconfig   |    1 +
 arch/powerpc/platforms/44x/Makefile  |    1 -
 arch/powerpc/platforms/44x/taishan.c |   72 ----------------------------------
 3 files changed, 1 insertions(+), 73 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/taishan.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 84e2a70..e0bea83 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -40,6 +40,7 @@ config TAISHAN
 	bool "Taishan"
 	depends on 44x
 	default n
+	select PPC44x_SIMPLE
 	select 440GX
 	select PCI
 	help
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index a8a92c1..6981331 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -1,7 +1,6 @@
 obj-$(CONFIG_44x)	:= misc_44x.o idle.o
 obj-$(CONFIG_PPC44x_SIMPLE) += ppc44x_simple.o
 obj-$(CONFIG_EBONY)	+= ebony.o
-obj-$(CONFIG_TAISHAN)	+= taishan.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_WARP)	+= warp-nand.o
diff --git a/arch/powerpc/platforms/44x/taishan.c b/arch/powerpc/platforms/44x/taishan.c
deleted file mode 100644
index 49c78b2..0000000
--- a/arch/powerpc/platforms/44x/taishan.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/*
- * Taishan board specific routines based off ebony.c code
- * original copyrights below
- *
- * Matt Porter <mporter@kernel.crashing.org>
- * Copyright 2002-2005 MontaVista Software Inc.
- *
- * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
- * Copyright (c) 2003-2005 Zultys Technologies
- *
- * Rewritten and ported to the merged powerpc tree:
- * Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
- *
- * Modified from ebony.c for taishan:
- * Copyright 2007 Hugh Blemings <hugh@au.ibm.com>, IBM Corporation.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
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
-static __initdata struct of_device_id taishan_of_bus[] = {
-	{ .compatible = "ibm,plb4", },
-	{ .compatible = "ibm,opb", },
-	{ .compatible = "ibm,ebc", },
-	{},
-};
-
-static int __init taishan_device_probe(void)
-{
-	of_platform_bus_probe(NULL, taishan_of_bus, NULL);
-
-	return 0;
-}
-machine_device_initcall(taishan, taishan_device_probe);
-
-/*
- * Called very early, MMU is off, device-tree isn't unflattened
- */
-static int __init taishan_probe(void)
-{
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "amcc,taishan"))
-		return 0;
-
-	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
-
-	return 1;
-}
-
-define_machine(taishan) {
-	.name			= "Taishan",
-	.probe			= taishan_probe,
-	.progress		= udbg_progress,
-	.init_IRQ		= uic_init_tree,
-	.get_irq		= uic_get_irq,
-	.restart		= ppc4xx_reset_system,
-	.calibrate_decr		= generic_calibrate_decr,
-};
-- 
1.5.5.1
