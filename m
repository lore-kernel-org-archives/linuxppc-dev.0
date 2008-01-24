Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 8E337DDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 10:41:40 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/10] sbc834x: Add support for Wind River SBC834x boards
Date: Thu, 24 Jan 2008 18:41:30 -0500
Message-Id: <120121809863-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <120121809839-git-send-email-paul.gortmaker@windriver.com>
References: <12012180922447-git-send-email-paul.gortmaker@windriver.com>
	<12012180943940-git-send-email-paul.gortmaker@windriver.com>
	<12012180944056-git-send-email-paul.gortmaker@windriver.com>
	<12012180951674-git-send-email-paul.gortmaker@windriver.com>
	<12012180961689-git-send-email-paul.gortmaker@windriver.com>
	<1201218096476-git-send-email-paul.gortmaker@windriver.com>
	<12012180971068-git-send-email-paul.gortmaker@windriver.com>
	<120121809839-git-send-email-paul.gortmaker@windriver.com>
Message-Id: <14dfe83746b13d3704894f8198001bd5f704df05.1201217172.git.paul.gortmaker@windriver.com>
In-Reply-To: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
References: <e3ccba7097a77e66f07663fe9d1f174c06183528.1201217172.git.paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the basic support for the Wind River SBC834x boards.  The
SBC8349 is more common, although it should work on the SBC8347 board
as well.  Support is heavily based on the existing MPC834x_MDS code.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/platforms/83xx/Kconfig   |    9 ++-
 arch/powerpc/platforms/83xx/Makefile  |    1 +
 arch/powerpc/platforms/83xx/sbc834x.c |  115 +++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 2430ac8..782bff0 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -55,6 +55,13 @@ config MPC837x_MDS
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC837x MDS Processor Board.
+
+config SBC834x
+	bool "Wind River SBC834x"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the Wind River SBC834x board.
+
 endchoice
 
 config PPC_MPC831x
@@ -73,7 +80,7 @@ config MPC834x
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
-	default y if MPC834x_MDS || MPC834x_ITX
+	default y if MPC834x_MDS || MPC834x_ITX || SBC834x
 
 config PPC_MPC836x
 	bool
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
index df46629..3a35242 100644
--- a/arch/powerpc/platforms/83xx/Makefile
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_MPC834x_ITX)	+= mpc834x_itx.o
 obj-$(CONFIG_MPC836x_MDS)	+= mpc836x_mds.o
 obj-$(CONFIG_MPC832x_MDS)	+= mpc832x_mds.o
 obj-$(CONFIG_MPC837x_MDS)	+= mpc837x_mds.o
+obj-$(CONFIG_SBC834x)		+= sbc834x.o
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
new file mode 100644
index 0000000..cf38247
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -0,0 +1,115 @@
+/*
+ * arch/powerpc/platforms/83xx/sbc834x.c
+ *
+ * Wind River SBC834x board specific routines
+ *
+ * By Paul Gortmaker (see MAINTAINERS for contact information)
+ *
+ * Based largely on the mpc834x_mds.c support by Kumar Gala.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/of_platform.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <sysdev/fsl_soc.h>
+
+#include "mpc83xx.h"
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+static void __init sbc834x_setup_arch(void)
+{
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("sbc834x_setup_arch()", 0);
+
+#ifdef CONFIG_PCI
+	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
+		mpc83xx_add_bridge(np);
+#endif
+
+}
+
+static void __init sbc834x_init_IRQ(void)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_type(NULL, "ipic");
+	if (!np)
+		return;
+
+	ipic_init(np, 0);
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	ipic_set_default_priority();
+
+	of_node_put(np);
+}
+
+static struct __initdata of_device_id sbc834x_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{},
+};
+
+static int __init sbc834x_declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, sbc834x_ids, NULL);
+	return 0;
+}
+machine_device_initcall(sbc834x, sbc834x_declare_of_platform_devices);
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init sbc834x_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "SBC834x");
+}
+
+define_machine(sbc834x) {
+	.name			= "SBC834x",
+	.probe			= sbc834x_probe,
+	.setup_arch		= sbc834x_setup_arch,
+	.init_IRQ		= sbc834x_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.restart		= mpc83xx_restart,
+	.time_init		= mpc83xx_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.5.0.rc1.gf4b6c
