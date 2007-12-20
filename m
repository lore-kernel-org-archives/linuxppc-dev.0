Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:54:55 +1100
Subject: [PATCH 10/19] [POWERPC] fix iSeries PCI resource management
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035457.99840DDE39@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The way iSeries manages PCI IO and Memory resources is a bit strange
and is based on overriding the content of those resources with home
cooked ones afterward.

This changes it a bit to better integrate with the new resource handling
so that the "virtual" tokens that iSeries replaces resources with are
done from the proper per-device fixup hook, and bridge resources are
set to enclose that token space. This fixes various things such as
the output of /proc/iomem & ioports, among others. The patch also fixup
various boot messages as well.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 
 arch/powerpc/kernel/pci-common.c       |   16 ++++
 arch/powerpc/kernel/pci_64.c           |   19 ++++-
 arch/powerpc/platforms/iseries/pci.c   |  123 +++++++++++++++++----------------
 arch/powerpc/platforms/iseries/pci.h   |    4 +
 arch/powerpc/platforms/iseries/setup.c |   37 +++++----
 5 files changed, 121 insertions(+), 78 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:32.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:33.000000000 +1100
@@ -190,6 +190,20 @@ int pci_read_irq_line(struct pci_dev *pc
 	struct of_irq oirq;
 	unsigned int virq;
 
+	/* The current device-tree that iSeries generates from the HV
+	 * PCI informations doesn't contain proper interrupt routing,
+	 * and all the fallback would do is print out crap, so we
+	 * don't attempt to resolve the interrupts here at all, some
+	 * iSeries specific fixup does it.
+	 *
+	 * In the long run, we will hopefully fix the generated device-tree
+	 * instead.
+	 */
+#ifdef CONFIG_PPC_ISERIES
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
+		return -1;
+#endif
+
 	DBG("Try to map irq for %s...\n", pci_name(pci_dev));
 
 #ifdef DEBUG
@@ -946,7 +960,7 @@ static void __init pcibios_allocate_bus_
 			    || res->start > res->end)
 				continue;
 			if (bus->parent == NULL)
-				pr = (res->flags & IORESOURCE_IO)?
+				pr = (res->flags & IORESOURCE_IO) ?
 					&ioport_resource : &iomem_resource;
 			else {
 				/* Don't bother with non-root busses when
Index: linux-merge/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:32.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:33.000000000 +1100
@@ -343,7 +343,7 @@ void __devinit scan_phb(struct pci_contr
 	int i, mode;
 	struct resource *res;
 
-	DBG("Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
+	DBG("PCI: Scanning PHB %s\n", node ? node->full_name : "<NO NAME>");
 
 	/* Create an empty bus for the toplevel */
 	bus = pci_create_bus(hose->parent, hose->first_busno, hose->ops, node);
@@ -359,9 +359,22 @@ void __devinit scan_phb(struct pci_contr
 	pcibios_map_io_space(bus);
 
 	/* Wire up PHB bus resources */
-	bus->resource[0] = res = &hose->io_resource;
-	for (i = 0; i < 3; ++i)
+	if (hose->io_resource.flags) {
+		DBG("PCI: PHB IO resource    = %016lx-%016lx [%lx]\n",
+		    hose->io_resource.start, hose->io_resource.end,
+		    hose->io_resource.flags);
+		bus->resource[0] = res = &hose->io_resource;
+	}
+	for (i = 0; i < 3; ++i) {
+		DBG("PCI: PHB MEM resource %d = %016lx-%016lx [%lx]\n", i,
+		    hose->mem_resources[i].start,
+		    hose->mem_resources[i].end,
+		    hose->mem_resources[i].flags);
 		bus->resource[i+1] = &hose->mem_resources[i];
+	}
+	DBG("PCI: PHB MEM offset     = %016lx\n", hose->pci_mem_offset);
+	DBG("PCI: PHB IO  offset     = %08lx\n",
+	    (unsigned long)hose->io_base_virt - _IO_BASE);
 
 	/* Get probe mode and perform scan */
 	mode = PCI_PROBE_NORMAL;
Index: linux-merge/arch/powerpc/platforms/iseries/pci.c
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/iseries/pci.c	2007-12-14 15:48:59.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/iseries/pci.c	2007-12-14 15:49:33.000000000 +1100
@@ -20,6 +20,9 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
+
+#undef DEBUG
+
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/string.h>
@@ -58,6 +61,7 @@ static int limit_pci_retries = 1;	/* Set
 #define IOMM_TABLE_MAX_ENTRIES	1024
 #define IOMM_TABLE_ENTRY_SIZE	0x0000000000400000UL
 #define BASE_IO_MEMORY		0xE000000000000000UL
+#define END_IO_MEMORY		0xEFFFFFFFFFFFFFFFUL
 
 static unsigned long max_io_memory = BASE_IO_MEMORY;
 static long current_iomm_table_entry;
@@ -68,7 +72,6 @@ static long current_iomm_table_entry;
 static struct device_node *iomm_table[IOMM_TABLE_MAX_ENTRIES];
 static u8 iobar_table[IOMM_TABLE_MAX_ENTRIES];
 
-static const char pci_io_text[] = "iSeries PCI I/O";
 static DEFINE_SPINLOCK(iomm_table_lock);
 
 /*
@@ -279,8 +282,8 @@ out_free:
  * PCI: Bus  0, Device 26, Vendor 0x12AE  Frame  1, Card  C10  Ethernet
  * controller
  */
-static void __init iseries_device_information(struct pci_dev *pdev, int count,
-		u16 bus, HvSubBusNumber subbus)
+static void __init iseries_device_information(struct pci_dev *pdev,
+					      u16 bus, HvSubBusNumber subbus)
 {
 	u8 frame = 0;
 	char card[4];
@@ -290,10 +293,9 @@ static void __init iseries_device_inform
 			ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus));
 
 	if (iseries_get_location_code(bus, agent, &frame, card)) {
-		printk("%d. PCI: Bus%3d, Device%3d, Vendor %04X Frame%3d, "
-			"Card %4s  0x%04X\n", count, bus,
-			PCI_SLOT(pdev->devfn), pdev->vendor, frame,
-			card, (int)(pdev->class >> 8));
+		printk(KERN_INFO "PCI: %s, Vendor %04X Frame%3d, "
+		       "Card %4s  0x%04X\n", pci_name(pdev), pdev->vendor,
+		       frame, card, (int)(pdev->class >> 8));
 	}
 }
 
@@ -323,7 +325,6 @@ static void __init iomm_table_allocate_e
 	 * Set Resource values.
 	 */
 	spin_lock(&iomm_table_lock);
-	bar_res->name = pci_io_text;
 	bar_res->start = BASE_IO_MEMORY +
 		IOMM_TABLE_ENTRY_SIZE * current_iomm_table_entry;
 	bar_res->end = bar_res->start + bar_size - 1;
@@ -393,61 +394,63 @@ static struct device_node *find_device_n
 }
 
 /*
- * iSeries_pci_final_fixup(void)
+ * iSeries_pcibios_fixup_resources
+ *
+ * Fixes up all resources for devices
  */
-void __init iSeries_pci_final_fixup(void)
+void __init iSeries_pcibios_fixup_resources(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = NULL;
+	const u32 *agent;
+	const u32 *sub_bus;
+	unsigned char bus = pdev->bus->number;
 	struct device_node *node;
-	int num_dev = 0;
-
-	/* Fix up at the device node and pci_dev relationship */
-	mf_display_src(0xC9000100);
+	int i;
 
-	printk("pcibios_final_fixup\n");
-	for_each_pci_dev(pdev) {
-		const u32 *agent;
-		const u32 *sub_bus;
-		unsigned char bus = pdev->bus->number;
-
-		node = find_device_node(bus, pdev->devfn);
-		printk("pci dev %p (%x.%x), node %p\n", pdev, bus,
-			pdev->devfn, node);
-		if (!node) {
-			printk("PCI: Device Tree not found for 0x%016lX\n",
-					(unsigned long)pdev);
-			continue;
-		}
-
-		agent = of_get_property(node, "linux,agent-id", NULL);
-		sub_bus = of_get_property(node, "linux,subbus", NULL);
-		if (agent && sub_bus) {
-			u8 irq = iSeries_allocate_IRQ(bus, 0, *sub_bus);
-			int err;
-
-			err = HvCallXm_connectBusUnit(bus, *sub_bus,
-					*agent, irq);
-			if (err)
-				pci_log_error("Connect Bus Unit",
-					bus, *sub_bus, *agent, err);
-			else {
-				err = HvCallPci_configStore8(bus, *sub_bus,
+	node = find_device_node(bus, pdev->devfn);
+	pr_debug("PCI: iSeries %s, pdev %p, node %p\n",
+		 pci_name(pdev), pdev, node);
+	if (!node) {
+		printk("PCI: %s disabled, device tree entry not found !\n",
+		       pci_name(pdev));
+		for (i = 0; i <= PCI_ROM_RESOURCE; i++)
+			pdev->resource[i].flags = 0;
+		return;
+	}
+	sub_bus = of_get_property(node, "linux,subbus", NULL);
+	agent = of_get_property(node, "linux,agent-id", NULL);
+	if (agent && sub_bus) {
+		u8 irq = iSeries_allocate_IRQ(bus, 0, *sub_bus);
+		int err;
+
+		err = HvCallXm_connectBusUnit(bus, *sub_bus, *agent, irq);
+		if (err)
+			pci_log_error("Connect Bus Unit",
+				      bus, *sub_bus, *agent, err);
+		else {
+			err = HvCallPci_configStore8(bus, *sub_bus,
 					*agent, PCI_INTERRUPT_LINE, irq);
-				if (err)
-					pci_log_error("PciCfgStore Irq Failed!",
+			if (err)
+				pci_log_error("PciCfgStore Irq Failed!",
 						bus, *sub_bus, *agent, err);
-				else
-					pdev->irq = irq;
-			}
+			else
+				pdev->irq = irq;
 		}
-
-		num_dev++;
-		pdev->sysdata = node;
-		PCI_DN(node)->pcidev = pdev;
-		allocate_device_bars(pdev);
-		iseries_device_information(pdev, num_dev, bus, *sub_bus);
-		iommu_devnode_init_iSeries(pdev, node);
 	}
+
+	pdev->sysdata = node;
+	PCI_DN(node)->pcidev = pdev;
+	allocate_device_bars(pdev);
+	iseries_device_information(pdev, bus, *sub_bus);
+	iommu_devnode_init_iSeries(pdev, node);
+}
+
+/*
+ * iSeries_pci_final_fixup(void)
+ */
+void __init iSeries_pci_final_fixup(void)
+{
+	/* Fix up at the device node and pci_dev relationship */
+	mf_display_src(0xC9000100);
 	iSeries_activate_IRQs();
 	mf_display_src(0xC9000200);
 }
@@ -894,10 +897,18 @@ void __init iSeries_pcibios_init(void)
 		/* All legacy iSeries PHBs are in domain zero */
 		phb->global_number = 0;
 
-		phb->pci_mem_offset = bus;
 		phb->first_busno = bus;
 		phb->last_busno = bus;
 		phb->ops = &iSeries_pci_ops;
+		phb->io_base_virt = (void __iomem *)_IO_BASE;
+		phb->io_resource.flags = IORESOURCE_IO;
+		phb->io_resource.start = BASE_IO_MEMORY;
+		phb->io_resource.end = END_IO_MEMORY;
+		phb->io_resource.name = "iSeries PCI IO";
+		phb->mem_resources[0].flags = IORESOURCE_MEM;
+		phb->mem_resources[0].start = BASE_IO_MEMORY;
+		phb->mem_resources[0].end = END_IO_MEMORY;
+		phb->mem_resources[0].name = "Series PCI MEM";
 	}
 
 	of_node_put(root);
Index: linux-merge/arch/powerpc/platforms/iseries/pci.h
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/iseries/pci.h	2007-12-14 15:48:59.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/iseries/pci.h	2007-12-14 15:49:33.000000000 +1100
@@ -43,12 +43,16 @@
 #define ISERIES_GET_DEVICE_FROM_SUBBUS(subbus)		((subbus >> 5) & 0x7)
 #define ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus)	((subbus >> 2) & 0x7)
 
+struct pci_dev;
+
 #ifdef CONFIG_PCI
 extern void	iSeries_pcibios_init(void);
 extern void	iSeries_pci_final_fixup(void);
+extern void 	iSeries_pcibios_fixup_resources(struct pci_dev *dev);
 #else
 static inline void	iSeries_pcibios_init(void) { }
 static inline void	iSeries_pci_final_fixup(void) { }
+static inline void 	iSeries_pcibios_fixup_resources(struct pci_dev *dev) {}
 #endif
 
 #endif /* _PLATFORMS_ISERIES_PCI_H */
Index: linux-merge/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/iseries/setup.c	2007-12-14 15:48:59.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/iseries/setup.c	2007-12-14 15:49:33.000000000 +1100
@@ -639,24 +639,25 @@ static int __init iseries_probe(void)
 }
 
 define_machine(iseries) {
-	.name		= "iSeries",
-	.setup_arch	= iSeries_setup_arch,
-	.show_cpuinfo	= iSeries_show_cpuinfo,
-	.init_IRQ	= iSeries_init_IRQ,
-	.get_irq	= iSeries_get_irq,
-	.init_early	= iSeries_init_early,
-	.pcibios_fixup	= iSeries_pci_final_fixup,
-	.restart	= mf_reboot,
-	.power_off	= mf_power_off,
-	.halt		= mf_power_off,
-	.get_boot_time	= iSeries_get_boot_time,
-	.set_rtc_time	= iSeries_set_rtc_time,
-	.get_rtc_time	= iSeries_get_rtc_time,
-	.calibrate_decr	= generic_calibrate_decr,
-	.progress	= iSeries_progress,
-	.probe		= iseries_probe,
-	.ioremap	= iseries_ioremap,
-	.iounmap	= iseries_iounmap,
+	.name			= "iSeries",
+	.setup_arch		= iSeries_setup_arch,
+	.show_cpuinfo		= iSeries_show_cpuinfo,
+	.init_IRQ		= iSeries_init_IRQ,
+	.get_irq		= iSeries_get_irq,
+	.init_early		= iSeries_init_early,
+	.pcibios_fixup		= iSeries_pci_final_fixup,
+	.pcibios_fixup_resources= iSeries_pcibios_fixup_resources,
+	.restart		= mf_reboot,
+	.power_off		= mf_power_off,
+	.halt			= mf_power_off,
+	.get_boot_time		= iSeries_get_boot_time,
+	.set_rtc_time		= iSeries_set_rtc_time,
+	.get_rtc_time		= iSeries_get_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= iSeries_progress,
+	.probe			= iseries_probe,
+	.ioremap		= iseries_ioremap,
+	.iounmap		= iseries_iounmap,
 	/* XXX Implement enable_pmcs for iSeries */
 };
 
