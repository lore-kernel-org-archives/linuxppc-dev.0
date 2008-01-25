Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EF41DDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 13:47:19 +1100 (EST)
Date: Thu, 24 Jan 2008 20:47:11 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 7/9] powerpc: add MPC837x RDB platform support
Message-Id: <20080124204711.02ba14f0.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Joe D'Abbraccio <ljd015@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

primarily based on mpc837x mds code.

Signed-off-by: Joe D'Abbraccio <ljd015@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/platforms/83xx/Kconfig       |    8 ++-
 arch/powerpc/platforms/83xx/Makefile      |    1 +
 arch/powerpc/platforms/83xx/mpc837x_rdb.c |   99 +++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/platforms/83xx/mpc837x_rdb.c

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index b478312..bfdcf89 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -55,6 +55,12 @@ config MPC837x_MDS
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC837x MDS Processor Board.
+
+config MPC837x_RDB
+	bool "Freescale MPC837x RDB"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the MPC837x RDB Board.
 endchoice
 
 config PPC_MPC831x
@@ -85,4 +91,4 @@ config PPC_MPC837x
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
-	default y if MPC837x_MDS
+	default y if MPC837x_MDS || MPC837x_RDB
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 1111a50..e5ba0fb 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
 obj-$(CONFIG_MPC836x_MDS)	+= mpc836x_mds.o
 obj-$(CONFIG_MPC832x_MDS)	+= mpc832x_mds.o
 obj-$(CONFIG_MPC837x_MDS)	+= mpc837x_mds.o
+obj-$(CONFIG_MPC837x_RDB)	+= mpc837x_rdb.o
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
new file mode 100644
index 0000000..2293ae5
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -0,0 +1,99 @@
+/*
+ * arch/powerpc/platforms/83xx/mpc837x_rdb.c
+ *
+ * Copyright (C) 2007 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * MPC837x RDB board specific routines
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/pci.h>
+#include <linux/of_platform.h>
+
+#include <asm/time.h>
+#include <asm/ipic.h>
+#include <asm/udbg.h>
+
+#include "mpc83xx.h"
+
+extern int mpc837x_usb_cfg(void);
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+static void __init mpc837x_rdb_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc837x_rdb_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
+		mpc83xx_add_bridge(np);
+#endif
+	mpc837x_usb_cfg();
+}
+
+static struct of_device_id mpc837x_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{},
+};
+
+static int __init mpc837x_declare_of_platform_devices(void)
+{
+	/* Publish of_device */
+	of_platform_bus_probe(NULL, mpc837x_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(mpc837x_rdb, mpc837x_declare_of_platform_devices);
+
+static void __init mpc837x_rdb_init_IRQ(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ipic");
+	if (!np)
+		return;
+
+	ipic_init(np, 0);
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc837x_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,mpc8377rdb") ||
+	       of_flat_dt_is_compatible(root, "fsl,mpc8378rdb") ||
+	       of_flat_dt_is_compatible(root, "fsl,mpc8379rdb");
+}
+
+define_machine(mpc837x_rdb) {
+	.name			= "MPC837x RDB",
+	.probe			= mpc837x_rdb_probe,
+	.setup_arch		= mpc837x_rdb_setup_arch,
+	.init_IRQ		= mpc837x_rdb_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.restart		= mpc83xx_restart,
+	.time_init		= mpc83xx_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.2.2
