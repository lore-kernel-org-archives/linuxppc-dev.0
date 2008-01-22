Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B680DDE45
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:38:05 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JHRkl-0005e5-RX
	for linuxppc-dev@ozlabs.org; Tue, 22 Jan 2008 16:38:02 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3 v3] Add initial iomega StorCenter board port.
Date: Tue, 22 Jan 2008 16:37:59 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JHRkl-0005e5-RX@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Use cuImage bootwrapper until U-Boot port is completed.
Derived heavily from Linkstation port.

Signed-off-by: Andy Wilcox <andy@protium.com>
Signed-off-by: Jon Loeliger <jdl@jdl.com>
---
 arch/powerpc/boot/Makefile                      |    3 +-
 arch/powerpc/boot/cuboot-824x.c                 |   53 +++++++
 arch/powerpc/platforms/embedded6xx/Kconfig      |   23 ++-
 arch/powerpc/platforms/embedded6xx/Makefile     |    1 +
 arch/powerpc/platforms/embedded6xx/storcenter.c |  188 +++++++++++++++++++++++
 5 files changed, 261 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-824x.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/storcenter.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d1e625c..a59b176 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -57,7 +57,7 @@ src-wlib := string.S crt0.S stdio.c main.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
 		fsl-soc.c mpc8xx.c pq2.c
-src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
+src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
@@ -196,6 +196,7 @@ image-$(CONFIG_PPC_EP88XC)		+= zImage.ep88xc
 image-$(CONFIG_EP405)			+= zImage.ep405
 image-$(CONFIG_8260)			+= cuImage.pq2
 image-$(CONFIG_PPC_MPC52xx)		+= cuImage.52xx
+image-$(CONFIG_STORCENTER)		+= cuImage.824x
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_MPC7448HPC2)		+= cuImage.hpc2
diff --git a/arch/powerpc/boot/cuboot-824x.c b/arch/powerpc/boot/cuboot-824x.c
new file mode 100644
index 0000000..ced90c5
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-824x.c
@@ -0,0 +1,53 @@
+/*
+ * Old U-boot compatibility for 824x
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "cuboot.h"
+
+#define TARGET_824x
+#include "ppcboot.h"
+
+static bd_t bd;
+
+
+static void platform_fixups(void)
+{
+	void *soc;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_addresses(bd.bi_enetaddr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
+
+	soc = find_node_by_devtype(NULL, "soc");
+	if (soc) {
+		void *serial = NULL;
+
+		setprop(soc, "bus-frequency", &bd.bi_busfreq,
+		        sizeof(bd.bi_busfreq));
+
+		while ((serial = find_node_by_devtype(serial, "serial"))) {
+			if (get_parent(serial) != soc)
+				continue;
+
+			setprop(serial, "clock-frequency", &bd.bi_busfreq,
+			        sizeof(bd.bi_busfreq));
+		}
+	}
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	fdt_init(_dtb_start);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 8924095..6c80837 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -9,6 +9,8 @@ config LINKSTATION
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
 	select DEFAULT_UIMAGE
+	select MPC10X_OPENPIC
+	select MPC10X_BRIDGE
 	help
 	  Select LINKSTATION if configuring for one of PPC- (MPC8241)
 	  based NAS systems from Buffalo Technology. So far only
@@ -16,6 +18,19 @@ config LINKSTATION
 	  Linkstation-I HD-HLAN and HD-HGLAN versions, and PPC-based
 	  Terastation systems should be supported too.
 
+config STORCENTER
+	bool "IOMEGA StorCenter"
+	depends on EMBEDDED6xx
+	select MPIC
+	select FSL_SOC
+	select PPC_UDBG_16550 if SERIAL_8250
+	select WANT_DEVICE_TREE
+	select MPC10X_OPENPIC
+	select MPC10X_BRIDGE
+	help
+	  Select STORCENTER if configuring for the iomega StorCenter
+	  with an 8241 CPU in it.
+
 config MPC7448HPC2
 	bool "Freescale MPC7448HPC2(Taiga)"
 	depends on EMBEDDED6xx
@@ -23,6 +38,7 @@ config MPC7448HPC2
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
 	select WANT_DEVICE_TREE
+	select TSI108_BRIDGE
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
@@ -33,6 +49,7 @@ config PPC_HOLLY
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
 	select WANT_DEVICE_TREE
+	select TSI108_BRIDGE
 	help
 	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
 	  Board with TSI108/9 bridge (Hickory/Holly)
@@ -48,17 +65,13 @@ config PPC_PRPMC2800
 
 config TSI108_BRIDGE
 	bool
-	depends on MPC7448HPC2 || PPC_HOLLY
 	select PCI
 	select MPIC
 	select MPIC_WEIRD
-	default y
 
 config MPC10X_BRIDGE
 	bool
-	depends on LINKSTATION
 	select PPC_INDIRECT_PCI
-	default y
 
 config MV64X60
 	bool
@@ -67,8 +80,6 @@ config MV64X60
 
 config MPC10X_OPENPIC
 	bool
-	depends on LINKSTATION
-	default y
 
 config MPC10X_STORE_GATHERING
 	bool "Enable MPC10x store gathering"
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index 844947c..06524d3 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -3,5 +3,6 @@
 #
 obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
 obj-$(CONFIG_LINKSTATION)	+= linkstation.o ls_uart.o
+obj-$(CONFIG_STORCENTER)	+= storcenter.o
 obj-$(CONFIG_PPC_HOLLY)		+= holly.o
 obj-$(CONFIG_PPC_PRPMC2800)	+= prpmc2800.o
diff --git a/arch/powerpc/platforms/embedded6xx/storcenter.c b/arch/powerpc/platforms/embedded6xx/storcenter.c
new file mode 100644
index 0000000..c83aef4
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/storcenter.c
@@ -0,0 +1,188 @@
+/*
+ * Board setup routines for the storcenter
+ *
+ * Copyright 2007 (C) Oyvind Repvik (nail@nslu2-linux.org)
+ * Copyright 2007 Andy Wilcox, Jon Loeliger
+ *
+ * Based on linkstation.c by G. Liakhovetski
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/initrd.h>
+#include <linux/mtd/physmap.h>
+#include <linux/of_platform.h>
+
+#include <asm/time.h>
+#include <asm/prom.h>
+#include <asm/mpic.h>
+#include <asm/pci-bridge.h>
+
+#include "mpc10x.h"
+
+extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
+
+
+#ifdef CONFIG_MTD_PHYSMAP
+static struct mtd_partition storcenter_physmap_partitions[] = {
+	{
+		.name   = "kernel",
+		.offset = 0x000000,
+		.size   = 0x170000,
+	},
+	{
+		.name   = "rootfs",
+		.offset = 0x170000,
+		.size   = 0x590000,
+	},
+	{
+		.name   = "uboot",
+		.offset = 0x700000,
+		.size   = 0x040000,
+	},
+	{
+		.name   = "config",
+		.offset = 0x740000,
+		.size   = 0x0c0000,
+	},
+};
+#endif
+
+
+static __initdata struct of_device_id storcenter_of_bus[] = {
+	{ .name = "soc", },
+	{},
+};
+
+static int __init storcenter_device_probe(void)
+{
+	of_platform_bus_probe(NULL, storcenter_of_bus, NULL);
+	return 0;
+}
+machine_device_initcall(storcenter, storcenter_device_probe);
+
+
+static int __init storcenter_add_bridge(struct device_node *dev)
+{
+#ifdef CONFIG_PCI
+	int len;
+	struct pci_controller *hose;
+	const int *bus_range;
+
+	printk("Adding PCI host bridge %s\n", dev->full_name);
+
+	hose = pcibios_alloc_controller(dev);
+	if (hose == NULL)
+		return -ENOMEM;
+
+	bus_range = of_get_property(dev, "bus-range", &len);
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	setup_indirect_pci(hose, MPC10X_MAPB_CNFG_ADDR, MPC10X_MAPB_CNFG_DATA, 0);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, 1);
+#endif
+
+	return 0;
+}
+
+static void __init storcenter_setup_arch(void)
+{
+	struct device_node *np;
+
+#ifdef CONFIG_MTD_PHYSMAP
+	physmap_set_partitions(storcenter_physmap_partitions,
+			       ARRAY_SIZE(storcenter_physmap_partitions));
+#endif
+
+	/* Lookup PCI host bridges */
+	for_each_compatible_node(np, "pci", "mpc10x-pci")
+		storcenter_add_bridge(np);
+
+	printk(KERN_INFO "IOMEGA StorCenter\n");
+}
+
+/*
+ * Interrupt setup and service.  Interrrupts on the turbostation come
+ * from the four PCI slots plus onboard 8241 devices: I2C, DUART.
+ */
+static void __init storcenter_init_IRQ(void)
+{
+	struct mpic *mpic;
+	struct device_node *dnp;
+	const void *prop;
+	int size;
+	phys_addr_t paddr;
+
+	dnp = of_find_node_by_type(NULL, "open-pic");
+	if (dnp == NULL)
+		return;
+
+	prop = of_get_property(dnp, "reg", &size);
+	paddr = (phys_addr_t)of_translate_address(dnp, prop);
+	mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY | MPIC_WANTS_RESET,
+			4, 32, " EPIC     ");
+
+	of_node_put(dnp);
+
+	BUG_ON(mpic == NULL);
+
+	/* PCI IRQs */
+	/*
+	 * 2.6.12 patch:
+	 *         openpic_set_sources(0, 5, OpenPIC_Addr + 0x10200);
+	 *         openpic_set_sources(5, 2, OpenPIC_Addr + 0x11120);
+	 *         first_irq, num_irqs, __iomem first_ISR
+	 *         o_ss: i, src: 0, fdf50200
+	 *         o_ss: i, src: 1, fdf50220
+	 *         o_ss: i, src: 2, fdf50240
+	 *         o_ss: i, src: 3, fdf50260
+	 *         o_ss: i, src: 4, fdf50280
+	 *         o_ss: i, src: 5, fdf51120
+	 *         o_ss: i, src: 6, fdf51140
+	 */
+	mpic_assign_isu(mpic, 0, paddr + 0x10200);
+	mpic_assign_isu(mpic, 1, paddr + 0x10220);
+	mpic_assign_isu(mpic, 2, paddr + 0x10240);
+	mpic_assign_isu(mpic, 3, paddr + 0x10260);
+	mpic_assign_isu(mpic, 4, paddr + 0x10280);
+	mpic_assign_isu(mpic, 5, paddr + 0x11120);
+	mpic_assign_isu(mpic, 6, paddr + 0x11140);
+
+	mpic_init(mpic);
+}
+
+static void storcenter_restart(char *cmd)
+{
+	local_irq_disable();
+
+	/* Set exception prefix high - to the firmware */
+	_nmask_and_or_msr(0, MSR_IP);
+
+	/* Wait for reset to happen */
+	for (;;) ;
+}
+
+static int __init storcenter_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "storcenter");
+}
+
+define_machine(storcenter){
+	.name 			= "IOMEGA StorCenter",
+	.probe 			= storcenter_probe,
+	.setup_arch 		= storcenter_setup_arch,
+	.init_IRQ 		= storcenter_init_IRQ,
+	.get_irq 		= mpic_get_irq,
+	.restart 		= storcenter_restart,
+	.calibrate_decr 	= generic_calibrate_decr,
+};
-- 
1.5.4.rc0
