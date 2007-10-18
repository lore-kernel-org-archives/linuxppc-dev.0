Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7730DDF38
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 00:53:49 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9IErjV4006022
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 07:53:45 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9IErdEJ011591
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 09:53:44 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v6 4/9] add platform support for MPC837x MDS board
Date: Thu, 18 Oct 2007 23:04:02 +0800
Message-Id: <1192719847-25045-4-git-send-email-leoli@freescale.com>
In-Reply-To: <1192719847-25045-3-git-send-email-leoli@freescale.com>
References: <1192719847-25045-1-git-send-email-leoli@freescale.com>
	<1192719847-25045-2-git-send-email-leoli@freescale.com>
	<1192719847-25045-3-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The MPC837x MDS is a new member of Freescale MDS reference system.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/83xx/Kconfig       |   12 ++++
 arch/powerpc/platforms/83xx/Makefile      |    1 +
 arch/powerpc/platforms/83xx/mpc837x_mds.c |  103 +++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/83xx/mpc837x_mds.c

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index ec305f1..0c61e7a 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -50,6 +50,11 @@ config MPC836x_MDS
 	help
 	  This option enables support for the MPC836x MDS Processor Board.
 
+config MPC837x_MDS
+	bool "Freescale MPC837x MDS"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the MPC837x MDS Processor Board.
 endchoice
 
 config PPC_MPC831x
@@ -75,3 +80,10 @@ config PPC_MPC836x
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
 	default y if MPC836x_MDS
+
+config PPC_MPC837x
+	bool
+	select PPC_UDBG_16550
+	select PPC_INDIRECT_PCI
+	select FSL_SERDES
+	default y if MPC837x_MDS
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index 5a98f88..df46629 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MPC834x_MDS)	+= mpc834x_mds.o
 obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
 obj-$(CONFIG_MPC836x_MDS)	+= mpc836x_mds.o
 obj-$(CONFIG_MPC832x_MDS)	+= mpc832x_mds.o
+obj-$(CONFIG_MPC837x_MDS)	+= mpc837x_mds.o
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
new file mode 100644
index 0000000..6f1f9e5
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -0,0 +1,103 @@
+/*
+ * arch/powerpc/platforms/83xx/mpc837x_mds.c
+ *
+ * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * MPC837x MDS board specific routines
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+#include <asm/time.h>
+#include <asm/ipic.h>
+#include <asm/udbg.h>
+
+#include "mpc83xx.h"
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+#endif
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+static void __init mpc837x_mds_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc837x_mds_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+		mpc83xx_add_bridge(np);
+#endif
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
+	if (!machine_is(mpc837x_mds))
+		return 0;
+
+	/* Publish of_device */
+	of_platform_bus_probe(NULL, mpc837x_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc837x_declare_of_platform_devices);
+
+static void __init mpc837x_mds_init_IRQ(void)
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
+static int __init mpc837x_mds_probe(void)
+{
+        unsigned long root = of_get_flat_dt_root();
+
+        return of_flat_dt_is_compatible(root, "fsl,mpc837xmds");
+}
+
+define_machine(mpc837x_mds) {
+	.name			= "MPC837x MDS",
+	.probe			= mpc837x_mds_probe,
+	.setup_arch		= mpc837x_mds_setup_arch,
+	.init_IRQ		= mpc837x_mds_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.restart		= mpc83xx_restart,
+	.time_init		= mpc83xx_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.3.2.104.g41ef
