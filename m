Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 06 Nov 2006 18:05:53 +1100
Subject: [PATCH 20/27] powerpc: Generic OF platform driver for PCI host
	bridges.
In-Reply-To: <1162796738.274582.277491064706.qpush@grosgo>
Message-Id: <20061106070709.4A9F467E0E@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When enabled in Kconfig, it will pick up any of_platform_device
matching it's match list (currently type "pci", "pcix", "pcie",
or "ht" and setup a PHB for it.

Platform must provide a ppc_md.pci_setup_phb() for it to work
(for doing the necessary initialisations specific to a given PHB
like setting up the config space ops).

It's currently only available on 64 bits as the 32 bits PCI code
can't quite cope with it in it's current form. I will fix that
later.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/Kconfig                       |    6 +
 arch/powerpc/kernel/of_platform.c          |  103 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_64.c               |    9 ++
 arch/powerpc/kernel/rtas_pci.c             |    7 +
 arch/powerpc/platforms/cell/setup.c        |    1 
 arch/powerpc/platforms/pseries/pci_dlpar.c |    2 
 include/asm-powerpc/machdep.h              |    4 +
 include/asm-powerpc/ppc-pci.h              |   12 +--
 8 files changed, 134 insertions(+), 10 deletions(-)

Index: linux-cell/arch/powerpc/kernel/of_platform.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/of_platform.c	2006-11-06 15:19:56.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/of_platform.c	2006-11-06 15:26:43.000000000 +1100
@@ -1,6 +1,7 @@
 /*
  *    Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
  *			 <benh@kernel.crashing.org>
+ *    and		 Arnd Bergmann, IBM Corp.
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -17,12 +18,15 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 
 #include <asm/errno.h>
 #include <asm/dcr.h>
 #include <asm/of_device.h>
 #include <asm/of_platform.h>
 #include <asm/topology.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
 
 /*
  * The list of OF IDs below is used for matching bus types in the
@@ -378,3 +382,102 @@ struct of_device *of_find_device_by_phan
 	return NULL;
 }
 EXPORT_SYMBOL(of_find_device_by_phandle);
+
+
+#ifdef CONFIG_PPC_OF_PLATFORM_PCI
+
+/* The probing of PCI controllers from of_platform is currently
+ * 64 bits only, mostly due to gratuitous differences between
+ * the 32 and 64 bits PCI code on PowerPC and the 32 bits one
+ * lacking some bits needed here.
+ */
+
+static int __devinit of_pci_phb_probe(struct of_device *dev,
+				      const struct of_device_id *match)
+{
+	struct pci_controller *phb;
+
+	/* Check if we can do that ... */
+	if (ppc_md.pci_setup_phb == NULL)
+		return -ENODEV;
+
+	printk(KERN_INFO "Setting up PCI bus %s\n", dev->node->full_name);
+
+	/* Alloc and setup PHB data structure */
+	phb = pcibios_alloc_controller(dev->node);
+	if (!phb)
+		return -ENODEV;
+
+	/* Setup parent in sysfs */
+	phb->parent = &dev->dev;
+
+	/* Setup the PHB using arch provided callback */
+	if (ppc_md.pci_setup_phb(phb)) {
+		pcibios_free_controller(phb);
+		return -ENODEV;
+	}
+
+	/* Process "ranges" property */
+	pci_process_bridge_OF_ranges(phb, dev->node, 0);
+
+	/* Setup IO space.
+	 * This will not work properly for ISA IOs, something needs to be done
+	 * about it if we ever generalize that way of probing PCI brigdes
+	 */
+	pci_setup_phb_io_dynamic(phb, 0);
+
+	/* Init pci_dn data structures */
+	pci_devs_phb_init_dynamic(phb);
+
+	/* Register devices with EEH */
+#ifdef CONFIG_EEH
+	if (dev->node->child)
+		eeh_add_device_tree_early(dev->node);
+#endif /* CONFIG_EEH */
+
+	/* Scan the bus */
+	scan_phb(phb);
+
+	/* Claim resources. This might need some rework as well depending
+	 * wether we are doing probe-only or not, like assigning unassigned
+	 * resources etc...
+	 */
+	pcibios_claim_one_bus(phb->bus);
+
+	/* Finish EEH setup */
+#ifdef CONFIG_EEH
+	eeh_add_device_tree_late(phb->bus);
+#endif
+
+	/* Add probed PCI devices to the device model */
+	pci_bus_add_devices(phb->bus);
+
+	return 0;
+}
+
+static struct of_device_id of_pci_phb_ids[] = {
+	{ .type = "pci", },
+	{ .type = "pcix", },
+	{ .type = "pcie", },
+	{ .type = "pciex", },
+	{ .type = "ht", },
+	{}
+};
+
+static struct of_platform_driver of_pci_phb_driver = {
+       .name = "of-pci",
+       .match_table = of_pci_phb_ids,
+       .probe = of_pci_phb_probe,
+       .driver = {
+	       .multithread_probe = 1,
+       },
+};
+
+static __init int of_pci_phb_init(void)
+{
+	return of_register_platform_driver(&of_pci_phb_driver);
+}
+
+device_initcall(of_pci_phb_init);
+
+#endif /* CONFIG_PPC_OF_PLATFORM_PCI */
Index: linux-cell/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_64.c	2006-11-06 15:19:56.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/pci_64.c	2006-11-06 15:20:00.000000000 +1100
@@ -214,6 +214,10 @@ struct pci_controller * pcibios_alloc_co
 
 void pcibios_free_controller(struct pci_controller *phb)
 {
+	spin_lock(&hose_spinlock);
+	list_del(&phb->list_node);
+	spin_unlock(&hose_spinlock);
+
 	if (phb->is_dynamic)
 		kfree(phb);
 }
@@ -1284,6 +1288,11 @@ static void __devinit do_bus_setup(struc
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev = bus->self;
+	struct device_node *np;
+
+	np = pci_bus_to_OF_node(bus);
+
+	DBG("pcibios_fixup_bus(%s)\n", np ? np->full_name : "<???>");
 
 	if (dev && pci_probe_only &&
 	    (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
Index: linux-cell/include/asm-powerpc/machdep.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/machdep.h	2006-11-06 15:19:56.000000000 +1100
+++ linux-cell/include/asm-powerpc/machdep.h	2006-11-06 15:20:00.000000000 +1100
@@ -26,6 +26,7 @@ struct device_node;
 struct iommu_table;
 struct rtc_time;
 struct file;
+struct pci_controller;
 #ifdef CONFIG_KEXEC
 struct kimage;
 #endif
@@ -107,6 +108,9 @@ struct machdep_calls {
 	int		(*pci_probe_mode)(struct pci_bus *);
 	void		(*pci_irq_fixup)(struct pci_dev *dev);
 
+	/* To setup PHBs when using automatic OF platform driver for PCI */
+	int		(*pci_setup_phb)(struct pci_controller *host);
+
 	void		(*restart)(char *cmd);
 	void		(*power_off)(void);
 	void		(*halt)(void);
Index: linux-cell/arch/powerpc/kernel/rtas_pci.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/rtas_pci.c	2006-11-06 15:19:56.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/rtas_pci.c	2006-11-06 15:20:00.000000000 +1100
@@ -257,8 +257,10 @@ static int phb_set_bus_ranges(struct dev
 	return 0;
 }
 
-int __devinit setup_phb(struct device_node *dev, struct pci_controller *phb)
+int __devinit rtas_setup_phb(struct pci_controller *phb)
 {
+	struct device_node *dev = phb->arch_data;
+
 	if (is_python(dev))
 		python_countermeasures(dev);
 
@@ -290,7 +292,7 @@ unsigned long __init find_and_init_phbs(
 		phb = pcibios_alloc_controller(node);
 		if (!phb)
 			continue;
-		setup_phb(node, phb);
+		rtas_setup_phb(phb);
 		pci_process_bridge_OF_ranges(phb, node, 0);
 		pci_setup_phb_io(phb, index == 0);
 		index++;
@@ -362,7 +364,6 @@ int pcibios_remove_root_bus(struct pci_c
 		}
 	}
 
-	list_del(&phb->list_node);
 	pcibios_free_controller(phb);
 
 	return 0;
Index: linux-cell/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2006-11-06 15:19:56.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/pseries/pci_dlpar.c	2006-11-06 15:20:00.000000000 +1100
@@ -195,7 +195,7 @@ struct pci_controller * __devinit init_p
 	phb = pcibios_alloc_controller(dn);
 	if (!phb)
 		return NULL;
-	setup_phb(dn, phb);
+	rtas_setup_phb(phb);
 	pci_process_bridge_OF_ranges(phb, dn, 0);
 
 	pci_setup_phb_io_dynamic(phb, primary);
Index: linux-cell/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/ppc-pci.h	2006-11-06 15:19:56.000000000 +1100
+++ linux-cell/include/asm-powerpc/ppc-pci.h	2006-11-06 15:20:00.000000000 +1100
@@ -36,14 +36,14 @@ typedef void *(*traverse_func)(struct de
 void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 		void *data);
 
-void pci_devs_phb_init(void);
-void pci_devs_phb_init_dynamic(struct pci_controller *phb);
-int setup_phb(struct device_node *dev, struct pci_controller *phb);
-void __devinit scan_phb(struct pci_controller *hose);
+extern void pci_devs_phb_init(void);
+extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
+extern void scan_phb(struct pci_controller *hose);
 
 /* From rtas_pci.h */
-void init_pci_config_tokens (void);
-unsigned long get_phb_buid (struct device_node *);
+extern void init_pci_config_tokens (void);
+extern unsigned long get_phb_buid (struct device_node *);
+extern int rtas_setup_phb(struct pci_controller *phb);
 
 /* From pSeries_pci.h */
 extern void pSeries_final_fixup(void);
Index: linux-cell/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/setup.c	2006-11-06 15:19:56.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/setup.c	2006-11-06 15:20:00.000000000 +1100
@@ -264,6 +264,7 @@ define_machine(cell) {
 	.check_legacy_ioport	= cell_check_legacy_ioport,
 	.progress		= cell_progress,
 	.init_IRQ       	= cell_init_irq,
+	.pci_setup_phb		= rtas_setup_phb,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
Index: linux-cell/arch/powerpc/Kconfig
===================================================================
--- linux-cell.orig/arch/powerpc/Kconfig	2006-11-06 15:18:36.000000000 +1100
+++ linux-cell/arch/powerpc/Kconfig	2006-11-06 15:43:20.000000000 +1100
@@ -223,6 +223,11 @@ config PPC_DCR
 	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
 	default y
 
+config PPC_OF_PLATFORM_PCI
+	bool
+	depends on PPC64 # not supported on 32 bits yet
+	default n
+
 config BOOKE
 	bool
 	depends on E200 || E500
@@ -461,6 +466,7 @@ config PPC_CELL_NATIVE
 	bool
 	select PPC_CELL
 	select PPC_DCR_MMIO
+	select PPC_OF_PLATFORM_PCI
 	select MPIC
 	default n
 
