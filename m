Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0838EDDE3B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 00:15:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6BEFqNI015723
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 10:15:52 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BE7B8B128470
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 08:15:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BE3AjE007034
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 08:03:10 -0600
Subject: [RFC][PATCH 8/8] Walnut board support
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 09:03:09 -0500
Message-Id: <1184162589.32199.69.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Board support for the PPC405 Walnut evaluation board

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/platforms/4xx/Kconfig  |   14 +++----
 arch/powerpc/platforms/4xx/Makefile |    2 -
 arch/powerpc/platforms/4xx/walnut.c |   68 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig      |    2 -
 arch/powerpc/platforms/Makefile     |    2 -
 5 files changed, 78 insertions(+), 10 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/4xx/Makefile
+++ linux-2.6/arch/powerpc/platforms/4xx/Makefile
@@ -1 +1 @@
-# empty makefile so make clean works
\ No newline at end of file
+obj-$(CONFIG_WALNUT) += walnut.o
--- /dev/null
+++ linux-2.6/arch/powerpc/platforms/4xx/walnut.c
@@ -0,0 +1,68 @@
+/*
+ * Architecture- / platform-specific boot-time initialization code for
+ * IBM PowerPC 4xx based boards. Adapted from original
+ * code by Gary Thomas, Cort Dougan <cort@fsmlabs.com>, and Dan Malek
+ * <dan@net4x.com>.
+ *
+ * Copyright(c) 1999-2000 Grant Erickson <grant@lcse.umn.edu>
+ *
+ * Rewritten and ported to the merged powerpc tree:
+ * Copyright 2007 IBM Corporation
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * 2002 (c) MontaVista, Software, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/init.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/of_platform.h>
+
+static struct of_device_id walnut_of_bus[] = {
+	{ .compatible = "ibm,plb", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init walnut_device_probe(void)
+{
+	if (!machine_is(walnut))
+		return 0;
+
+	/* FIXME: do bus probe here */
+	of_platform_bus_probe(NULL, walnut_of_bus, NULL);
+
+	return 0;
+}
+device_initcall(walnut_device_probe);
+
+static int __init walnut_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ibm,walnut"))
+		return 0;
+
+	return 1;
+}
+
+static void __init walnut_setup_arch(void)
+{
+}
+
+define_machine(walnut) {
+	.name			= "Walnut",
+	.probe			= walnut_probe,
+	.setup_arch		= walnut_setup_arch,
+	.progress		= udbg_progress,
+	.init_IRQ		= uic_init_tree,
+	.get_irq		= uic_get_irq,
+	.calibrate_decr	= generic_calibrate_decr,
+};
--- linux-2.6.orig/arch/powerpc/platforms/4xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/4xx/Kconfig
@@ -53,13 +53,13 @@
 #	help
 #	  This option enables support for the IBM PPC405GPr evaluation board.
 
-#config WALNUT
-#	bool "Walnut"
-#	depends on 40x
-#	default y
-#	select 405GP
-#	help
-#	  This option enables support for the IBM PPC405GP evaluation board.
+config WALNUT
+	bool "Walnut"
+	depends on 40x
+	default y
+	select 405GP
+	help
+	  This option enables support for the IBM PPC405GP evaluation board.
 
 #config XILINX_ML300
 #	bool "Xilinx-ML300"
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -58,7 +58,7 @@ source "arch/powerpc/platforms/85xx/Kcon
 source "arch/powerpc/platforms/86xx/Kconfig"
 source "arch/powerpc/platforms/embedded6xx/Kconfig"
 source "arch/powerpc/platforms/44x/Kconfig"
-#source "arch/powerpc/platforms/4xx/Kconfig
+source "arch/powerpc/platforms/4xx/Kconfig"
 
 config PPC_NATIVE
 	bool
--- linux-2.6.orig/arch/powerpc/platforms/Makefile
+++ linux-2.6/arch/powerpc/platforms/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_PPC_PMAC)		+= powermac/
 endif
 endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
-#obj-$(CONFIG_4xx)		+= 4xx/
+obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_44x)		+= 44x/
 obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
 obj-$(CONFIG_PPC_8xx)		+= 8xx/
