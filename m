Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Fwd: [PATCH] Add QPACE as a separated Cell platform
Date: Thu, 27 Nov 2008 16:40:42 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200811271640.43496.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Krill <ben@codiert.org>

Since the QPACE (Chromodynamics Parallel Computing on the
Cell Broadband Engine) platform doesn't use a iommu, doesn't
have PCI devices and a MPIC much lesser setup and
configurations are needed. So far all devices are detected
as OF device. A notifier function is used to set the dma_ops
for the of_platform bus. Further this patch splits the
PPC_CELL_NATIVE into PPC_CELL_COMMON which are parts that are
shared with the QPACE platform and the rest.

Signed-off-by: Benjamin Krill <ben@codiert.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/boot/Makefile                |    1 +
 arch/powerpc/platforms/cell/Kconfig       |   19 +++--
 arch/powerpc/platforms/cell/Makefile      |   17 ++--
 arch/powerpc/platforms/cell/qpace_setup.c |  141 +++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+), 15 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/qpace_setup.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8fc6d72..75412aa 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -193,6 +193,7 @@ image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
 image-$(CONFIG_PPC_PS3)			+= dtbImage.ps3
 image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
+image-$(CONFIG_PPC_CELL_QPACE)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index c14d7d8..56ae9c5 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -2,13 +2,18 @@ config PPC_CELL
 	bool
 	default n
 
-config PPC_CELL_NATIVE
+config PPC_CELL_COMMON
 	bool
 	select PPC_CELL
 	select PPC_DCR_MMIO
-	select PPC_OF_PLATFORM_PCI
 	select PPC_INDIRECT_IO
 	select PPC_NATIVE
+	select PPC_RTAS
+
+config PPC_CELL_NATIVE
+	bool
+	select PPC_CELL_COMMON
+	select PPC_OF_PLATFORM_PCI
 	select MPIC
 	select IBM_NEW_EMAC_EMAC4
 	select IBM_NEW_EMAC_RGMII
@@ -20,7 +25,6 @@ config PPC_IBM_CELL_BLADE
 	bool "IBM Cell Blade"
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL_NATIVE
-	select PPC_RTAS
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
@@ -28,16 +32,17 @@ config PPC_IBM_CELL_BLADE
 config PPC_CELLEB
 	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
 	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_CELL
 	select PPC_CELL_NATIVE
-	select PPC_RTAS
-	select PPC_INDIRECT_IO
-	select PPC_OF_PLATFORM_PCI
 	select HAS_TXX9_SERIAL
 	select PPC_UDBG_BEAT
 	select USB_OHCI_BIG_ENDIAN_MMIO
 	select USB_EHCI_BIG_ENDIAN_MMIO
 
+config PPC_CELL_QPACE
+	bool "IBM Cell - QPACE"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL_COMMON
+
 menu "Cell Broadband Engine options"
 	depends on PPC_CELL
 
diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index 7fd8308..43eccb2 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -1,7 +1,7 @@
-obj-$(CONFIG_PPC_CELL_NATIVE)		+= interrupt.o iommu.o setup.o \
-					   cbe_regs.o spider-pic.o \
-					   pervasive.o pmu.o io-workarounds.o \
-					   spider-pci.o
+obj-$(CONFIG_PPC_CELL_COMMON)		+= cbe_regs.o interrupt.o pervasive.o
+
+obj-$(CONFIG_PPC_CELL_NATIVE)		+= iommu.o setup.o spider-pic.o \
+					   pmu.o io-workarounds.o spider-pci.o
 obj-$(CONFIG_CBE_RAS)			+= ras.o
 
 obj-$(CONFIG_CBE_THERM)			+= cbe_thermal.o
@@ -14,13 +14,12 @@ obj-$(CONFIG_PPC_IBM_CELL_POWERBUTTON)	+= cbe_powerbutton.o
 
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
+obj-$(CONFIG_PPC_CELL_QPACE)		+= smp.o
 endif
 
 # needed only when building loadable spufs.ko
-spu-priv1-$(CONFIG_PPC_CELL_NATIVE)	+= spu_priv1_mmio.o
-
-spu-manage-$(CONFIG_PPC_CELLEB)		+= spu_manage.o
-spu-manage-$(CONFIG_PPC_CELL_NATIVE)	+= spu_manage.o
+spu-priv1-$(CONFIG_PPC_CELL_COMMON)	+= spu_priv1_mmio.o
+spu-manage-$(CONFIG_PPC_CELL_COMMON)	+= spu_manage.o
 
 obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
 					   spu_notify.o \
@@ -31,6 +30,8 @@ obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
 
 obj-$(CONFIG_PCI_MSI)			+= axon_msi.o
 
+# qpace setup
+obj-$(CONFIG_PPC_CELL_QPACE)		+= qpace_setup.o
 
 # celleb stuff
 ifeq ($(CONFIG_PPC_CELLEB),y)
diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
new file mode 100644
index 0000000..c724fb2
--- /dev/null
+++ b/arch/powerpc/platforms/cell/qpace_setup.c
@@ -0,0 +1,141 @@
+/*
+ *  linux/arch/powerpc/platforms/cell/qpace_setup.c
+ *
+ *  Copyright (C) 1995  Linus Torvalds
+ *  Adapted from 'alpha' version by Gary Thomas
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  Modified by PPC64 Team, IBM Corp
+ *  Modified by Cell Team, IBM Deutschland Entwicklung GmbH
+ *  Modified by Benjamin Krill <ben@codiert.org>, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/console.h>
+#include <linux/of_platform.h>
+
+#include <asm/mmu.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/kexec.h>
+#include <asm/pgtable.h>
+#include <asm/prom.h>
+#include <asm/rtas.h>
+#include <asm/dma.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+#include <asm/cputable.h>
+#include <asm/irq.h>
+#include <asm/spu.h>
+#include <asm/spu_priv1.h>
+#include <asm/udbg.h>
+#include <asm/cell-regs.h>
+
+#include "interrupt.h"
+#include "pervasive.h"
+#include "ras.h"
+#include "io-workarounds.h"
+
+static void qpace_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	const char *model = "";
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = of_get_property(root, "model", NULL);
+	seq_printf(m, "machine\t\t: CHRP %s\n", model);
+	of_node_put(root);
+}
+
+static void qpace_progress(char *s, unsigned short hex)
+{
+	printk("*** %04x : %s\n", hex, s ? s : "");
+}
+
+static int __init qpace_publish_devices(void)
+{
+	/* Publish OF platform devices for southbridge IOs */
+	of_platform_bus_probe(NULL, NULL, NULL);
+
+	return 0;
+}
+machine_subsys_initcall(qpace, qpace_publish_devices);
+
+extern int qpace_notify(struct device *dev)
+{
+	/* set dma_ops for of_platform bus */
+	if (dev->bus && dev->bus->name
+			&& !strcmp(dev->bus->name, "of_platform"))
+		set_dma_ops(dev, &dma_direct_ops);
+
+	return 0;
+}
+
+static void __init qpace_setup_arch(void)
+{
+#ifdef CONFIG_SPU_BASE
+	spu_priv1_ops = &spu_priv1_mmio_ops;
+	spu_management_ops = &spu_management_of_ops;
+#endif
+
+	cbe_regs_init();
+
+#ifdef CONFIG_CBE_RAS
+	cbe_ras_init();
+#endif
+
+#ifdef CONFIG_SMP
+	smp_init_cell();
+#endif
+
+	/* init to some ~sane value until calibrate_delay() runs */
+	loops_per_jiffy = 50000000;
+
+	cbe_pervasive_init();
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
+	/* set notifier function */
+	platform_notify = &qpace_notify;
+}
+
+static int __init qpace_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "IBM,QPACE"))
+		return 0;
+
+	hpte_init_native();
+
+	return 1;
+}
+
+define_machine(qpace) {
+	.name			= "QPACE",
+	.probe			= qpace_probe,
+	.setup_arch		= qpace_setup_arch,
+	.show_cpuinfo		= qpace_show_cpuinfo,
+	.restart		= rtas_restart,
+	.power_off		= rtas_power_off,
+	.halt			= rtas_halt,
+	.get_boot_time		= rtas_get_boot_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= qpace_progress,
+	.init_IRQ		= iic_init_IRQ,
+#ifdef CONFIG_KEXEC
+	.machine_kexec		= default_machine_kexec,
+	.machine_kexec_prepare	= default_machine_kexec_prepare,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
+};
-- 
1.6.0.3


-------------------------------------------------------
