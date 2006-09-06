Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DF26567B94
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 05:46:19 +1000 (EST)
Date: Wed, 6 Sep 2006 14:42:08 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org, anton@samba.org
Subject: [patch 4/5] [v3] powerpc: PA Semi PWRficient platform support
Message-ID: <20060906144208.425e46b3@localhost.localdomain>
In-Reply-To: <20060906143305.05b54abb@localhost.localdomain>
References: <20060906143305.05b54abb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Base patch for PA6T and PA6T-1682M. This introduces the
arch/powerpc/platform/pasemi directory, together with basic
implementations for various setup.

Much of this was based on other platform code, i.e. Maple, etc.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: merge/arch/powerpc/Kconfig
===================================================================
--- merge.orig/arch/powerpc/Kconfig
+++ merge/arch/powerpc/Kconfig
@@ -413,6 +413,17 @@ config PPC_MAPLE
           This option enables support for the Maple 970FX Evaluation Board.
 	  For more informations, refer to <http://www.970eval.com>
 
+config PPC_PASEMI
+	depends on PPC_MULTIPLATFORM && PPC64
+	bool "PA Semi SoC-based platforms"
+	default n
+	select MPIC
+	select PPC_UDBG_16550
+	select GENERIC_TBSYNC
+	help
+	  This option enables support for PA Semi's PWRficient line
+	  of SoC processors, including PA6T-1682M
+
 config PPC_CELL
 	bool
 	default n
Index: merge/arch/powerpc/platforms/Makefile
===================================================================
--- merge.orig/arch/powerpc/platforms/Makefile
+++ merge/arch/powerpc/platforms/Makefile
@@ -13,5 +13,6 @@ obj-$(CONFIG_PPC_86xx)		+= 86xx/
 obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
+obj-$(CONFIG_PPC_PASEMI)		+= pasemi/
 obj-$(CONFIG_PPC_CELL)		+= cell/
 obj-$(CONFIG_EMBEDDED6xx)	+= embedded6xx/
Index: merge/arch/powerpc/platforms/pasemi/Makefile
===================================================================
--- /dev/null
+++ merge/arch/powerpc/platforms/pasemi/Makefile
@@ -0,0 +1 @@
+obj-y	+= setup.o pci.o time.o
Index: merge/arch/powerpc/platforms/pasemi/pci.c
===================================================================
--- /dev/null
+++ merge/arch/powerpc/platforms/pasemi/pci.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright (C) 2006 PA Semi, Inc
+ *
+ * Authors: Kip Walker, PA Semi
+ *	    Olof Johansson, PA Semi
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
+ *
+ * Based on arch/powerpc/platforms/maple/pci.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+
+#include <asm/ppc-pci.h>
+
+#define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) << 12) | (off))
+
+#define CONFIG_OFFSET_VALID(off) ((off) < 4096)
+
+static unsigned long pa_pxp_cfg_addr(struct pci_controller *hose,
+				       u8 bus, u8 devfn, int offset)
+{
+	return ((unsigned long)hose->cfg_data) + PA_PXP_CFA(bus, devfn, offset);
+}
+
+static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
+			      int offset, int len, u32 *val)
+{
+	struct pci_controller *hose;
+	unsigned long addr;
+
+	hose = pci_bus_to_host(bus);
+	if (!hose)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (!CONFIG_OFFSET_VALID(offset))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		*val = in_8((u8 *)addr);
+		break;
+	case 2:
+		*val = in_le16((u16 *)addr);
+		break;
+	default:
+		*val = in_le32((u32 *)addr);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int pa_pxp_write_config(struct pci_bus *bus, unsigned int devfn,
+			       int offset, int len, u32 val)
+{
+	struct pci_controller *hose;
+	unsigned long addr;
+
+	hose = pci_bus_to_host(bus);
+	if (!hose)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (!CONFIG_OFFSET_VALID(offset))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		out_8((u8 *)addr, val);
+		(void) in_8((u8 *)addr);
+		break;
+	case 2:
+		out_le16((u16 *)addr, val);
+		(void) in_le16((u16 *)addr);
+		break;
+	default:
+		out_le32((u32 *)addr, val);
+		(void) in_le32((u32 *)addr);
+		break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops pa_pxp_ops = {
+	pa_pxp_read_config,
+	pa_pxp_write_config,
+};
+
+static void __init setup_pa_pxp(struct pci_controller *hose)
+{
+	hose->ops = &pa_pxp_ops;
+	hose->cfg_data = ioremap(0xe0000000, 0x10000000);
+}
+
+static int __init add_bridge(struct device_node *dev)
+{
+	struct pci_controller *hose;
+
+	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
+
+	hose = pcibios_alloc_controller(dev);
+	if (!hose)
+		return -ENOMEM;
+
+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+
+	setup_pa_pxp(hose);
+
+	printk(KERN_INFO "Found PA-PXP PCI host bridge.\n");
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, 1);
+	pci_setup_phb_io(hose, 1);
+
+	return 0;
+}
+
+
+void __init pas_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	for_each_pci_dev(dev)
+		pci_read_irq_line(dev);
+}
+
+static void __init pas_fixup_phb_resources(void)
+{
+	struct pci_controller *hose, *tmp;
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		unsigned long offset = (unsigned long)hose->io_base_virt - pci_io_base;
+		hose->io_resource.start += offset;
+		hose->io_resource.end += offset;
+		printk(KERN_INFO "PCI Host %d, io start: %lx; io end: %lx\n",
+		       hose->global_number,
+		       hose->io_resource.start, hose->io_resource.end);
+	}
+}
+
+
+void __init pas_pci_init(void)
+{
+	struct device_node *np, *root;
+
+	root = of_find_node_by_path("/");
+	if (!root) {
+		printk(KERN_CRIT "pas_pci_init: can't find root "
+			"of device tree\n");
+		return;
+	}
+
+	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
+		if (np->name && !strcmp(np->name, "pxp") && !add_bridge(np))
+			of_node_get(np);
+
+	of_node_put(root);
+
+	pas_fixup_phb_resources();
+
+	/* Setup the linkage between OF nodes and PHBs */
+	pci_devs_phb_init();
+
+	/* Use the common resource allocation mechanism */
+	pci_probe_only = 1;
+}
Index: merge/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- /dev/null
+++ merge/arch/powerpc/platforms/pasemi/setup.c
@@ -0,0 +1,188 @@
+/*
+ * Copyright (C) 2006 PA Semi, Inc
+ *
+ * Authors: Kip Walker, PA Semi
+ *	    Olof Johansson, PA Semi
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
+ *
+ * Based on arch/powerpc/platforms/maple/setup.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/console.h>
+
+#include <asm/prom.h>
+#include <asm/system.h>
+#include <asm/iommu.h>
+#include <asm/machdep.h>
+#include <asm/mpic.h>
+#include <asm/smp.h>
+#include <asm/time.h>
+
+#include "pasemi.h"
+
+static void pas_restart(char *cmd)
+{
+	printk("restart unimplemented, looping...\n");
+	for (;;) ;
+}
+
+static void pas_power_off(void)
+{
+	printk("power off unimplemented, looping...\n");
+	for (;;) ;
+}
+
+static void pas_halt(void)
+{
+	pas_power_off();
+}
+
+#ifdef CONFIG_SMP
+struct smp_ops_t pas_smp_ops = {
+	.probe		= smp_mpic_probe,
+	.message_pass	= smp_mpic_message_pass,
+	.kick_cpu	= smp_generic_kick_cpu,
+	.setup_cpu	= smp_mpic_setup_cpu,
+	.give_timebase	= smp_generic_give_timebase,
+	.take_timebase	= smp_generic_take_timebase,
+};
+#endif /* CONFIG_SMP */
+
+void __init pas_setup_arch(void)
+{
+#ifdef CONFIG_SMP
+	/* Setup SMP callback */
+	smp_ops = &pas_smp_ops;
+#endif
+	/* Lookup PCI hosts */
+	pas_pci_init();
+
+#ifdef CONFIG_DUMMY_CONSOLE
+	conswitchp = &dummy_con;
+#endif
+
+	printk(KERN_DEBUG "Using default idle loop\n");
+}
+
+static void iommu_dev_setup_null(struct pci_dev *dev) { }
+static void iommu_bus_setup_null(struct pci_bus *bus) { }
+
+static void __init pas_init_early(void)
+{
+	/* No iommu code yet */
+	ppc_md.iommu_dev_setup = iommu_dev_setup_null;
+	ppc_md.iommu_bus_setup = iommu_bus_setup_null;
+	pci_direct_iommu_init();
+}
+
+/* No legacy IO on our parts */
+static int pas_check_legacy_ioport(unsigned int baseport)
+{
+	return -ENODEV;
+}
+
+static __init void pas_init_IRQ(void)
+{
+	struct device_node *np;
+	struct device_node *root, *mpic_node;
+	unsigned long openpic_addr;
+	const unsigned int *opprop;
+	int naddr, opplen;
+	struct mpic *mpic;
+
+	mpic_node = NULL;
+
+	for_each_node_by_type(np, "interrupt-controller")
+		if (device_is_compatible(np, "open-pic")) {
+			mpic_node = np;
+			break;
+		}
+	if (!mpic_node)
+		for_each_node_by_type(np, "open-pic") {
+			mpic_node = np;
+			break;
+		}
+	if (!mpic_node) {
+		printk(KERN_ERR
+			"Failed to locate the MPIC interrupt controller\n");
+		return;
+	}
+
+	/* Find address list in /platform-open-pic */
+	root = of_find_node_by_path("/");
+	naddr = prom_n_addr_cells(root);
+	opprop = get_property(root, "platform-open-pic", &opplen);
+	if (!opprop) {
+		printk(KERN_ERR "No platform-open-pic property.\n");
+		of_node_put(root);
+		return;
+	}
+	openpic_addr = of_read_number(opprop, naddr);
+	printk(KERN_DEBUG "OpenPIC addr: %lx\n", openpic_addr);
+	of_node_put(root);
+
+	mpic = mpic_alloc(mpic_node, openpic_addr, MPIC_PRIMARY, 0, 0,
+			  " PAS-OPIC  ");
+	BUG_ON(!mpic);
+
+	mpic_assign_isu(mpic, 0, openpic_addr + 0x10000);
+	mpic_init(mpic);
+	of_node_put(mpic_node);
+	of_node_put(root);
+}
+
+static void __init pas_progress(char *s, unsigned short hex)
+{
+	printk("[%04x] : %s\n", hex, s ? s : "");
+}
+
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init pas_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "PA6T-1682M"))
+		return 0;
+
+	hpte_init_native();
+
+	return 1;
+}
+
+define_machine(pas) {
+	.name			= "PA Semi PA6T-1682M",
+	.probe			= pas_probe,
+	.setup_arch		= pas_setup_arch,
+	.init_early		= pas_init_early,
+	.init_IRQ		= pas_init_IRQ,
+	.get_irq		= mpic_get_irq,
+	.pcibios_fixup		= pas_pcibios_fixup,
+	.restart		= pas_restart,
+	.power_off		= pas_power_off,
+	.halt			= pas_halt,
+	.get_boot_time		= pas_get_boot_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.check_legacy_ioport    = pas_check_legacy_ioport,
+	.progress		= pas_progress,
+};
Index: merge/arch/powerpc/platforms/pasemi/time.c
===================================================================
--- /dev/null
+++ merge/arch/powerpc/platforms/pasemi/time.c
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2006 PA Semi, Inc
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/config.h>
+#include <linux/time.h>
+
+#include <asm/time.h>
+
+unsigned long __init pas_get_boot_time(void)
+{
+	/* Let's just return a fake date right now */
+	return mktime(2006, 1, 1, 12, 0, 0);
+}
Index: merge/arch/powerpc/platforms/pasemi/pasemi.h
===================================================================
--- /dev/null
+++ merge/arch/powerpc/platforms/pasemi/pasemi.h
@@ -0,0 +1,8 @@
+#ifndef _PASEMI_PASEMI_H
+#define _PASEMI_PASEMI_H
+
+extern unsigned long pas_get_boot_time(void);
+extern void pas_pci_init(void);
+extern void pas_pcibios_fixup(void);
+
+#endif /* _PASEMI_PASEMI_H */
