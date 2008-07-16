Return-Path: <fkan@amcc.com>
Received: from svdc-dhcp-10-66-6-110.amcc.com (unknown [76.195.33.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6C11DDED3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jul 2008 15:56:22 +1000 (EST)
From: fkan@amcc.com
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Date: Tue, 15 Jul 2008 22:33:26 -0700
Message-Id: <1216186406-27993-1-git-send-email-fkan@amcc.com>
Cc: Victor Gallardo <vgallard@amcc.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Victor Gallardo <vgallard@amcc.com>

ppc4xx: Add AMCC Arches 460GT eval board support 

Signed-off-by: Victor Gallardo <vgallard@amcc.com>
---
 arch/powerpc/platforms/44x/Kconfig  |   18 ++++++++
 arch/powerpc/platforms/44x/Makefile |    1 +
 arch/powerpc/platforms/44x/arches.c |   76 +++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/44x/arches.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 6abe913..95d1217 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -77,6 +77,16 @@ config CANYONLANDS
 	help
 	  This option enables support for the AMCC PPC460EX evaluation board.
 
+config ARCHES
+	bool "Arches"
+	depends on 44x
+	default n
+	select 460GT
+	select PCI
+	select PPC4xx_PCI_EXPRESS
+	help
+	  This option enables support for the AMCC PPC460GT Arches board.
+
 config YOSEMITE
 	bool "Yosemite"
 	depends on 44x
@@ -149,6 +159,14 @@ config 460EX
 	select IBM_NEW_EMAC_ZMII
 	select IBM_NEW_EMAC_TAH
 
+config 460GT
+	bool
+	select PPC_FPU
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
+	select IBM_NEW_EMAC_TAH
+
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 774165f..86a4823 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_RAINIER)	+= rainier.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_WARP)	+= warp-nand.o
 obj-$(CONFIG_CANYONLANDS) += canyonlands.o
+obj-$(CONFIG_ARCHES)	+= arches.o
diff --git a/arch/powerpc/platforms/44x/arches.c b/arch/powerpc/platforms/44x/arches.c
new file mode 100644
index 0000000..6d6aa66
--- /dev/null
+++ b/arch/powerpc/platforms/44x/arches.c
@@ -0,0 +1,76 @@
+/*
+ * Arches board specific routines
+ *
+ * (C) Copyright 2008
+ * Victor Gallardo, Applied Micro Circuits Corp., vgallardo@amcc.com.
+ * Adam Graham, Applied Micro Circuits Corp., agraham@amcc.com.
+ *
+ * Based on the Canyonlands code by
+ * Stefan Roese <sr@denx.de>
+ * Copyright 2008 DENX Software Engineering
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc4xx.h>
+
+static __initdata struct of_device_id arches_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init arches_device_probe(void)
+{
+	of_platform_bus_probe(NULL, arches_of_bus, NULL);
+
+	return 0;
+}
+machine_device_initcall(arches, arches_device_probe);
+
+static int __init arches_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "amcc,arches"))
+		return 0;
+
+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+
+	return 1;
+}
+
+define_machine(arches) {
+	.name 				= "Arches",
+	.probe 				= arches_probe,
+	.progress 			= udbg_progress,
+	.init_IRQ 			= uic_init_tree,
+	.get_irq 			= uic_get_irq,
+	.restart			= ppc4xx_reset_system,
+	.calibrate_decr			= generic_calibrate_decr,
+};
-- 
1.5.5
