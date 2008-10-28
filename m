Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:37 +1100
Subject: [PATCH 5/10] powerpc/pci: Split pcibios_fixup_bus() into bus setup
	and devices setup
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054938.52224DDFBA@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, or PCI code uses the pcibios_fixup_bus() callback, which is
called by the generic code when probing PCI busses, for two different
thnings.

One is to setup things related to the bus itself, such as
reading bridge resources for P2P bridges, fixing them up, or setting
up the iommu's associated with bridges on some platfornms.

The other does some setup for each individual device under that
bridge, mostly setting up DMA mappings and interrupts.

The problem is that this approach doesn't work well with PCI hotplug
when an existing bus is re-probed for new children. This patch allows
this to be fixed by splitting it into two routines:

	pcibios_setup_bus_self() is now called to setup the bus itself

	pcibios_setup_bus_devices() is now called to setup devices

pcibios_fixup_bus() is then modified to call these two after reading the
bridge bases, and the OF based PCI probe is modified to avoid calling
into the first one when rescanning an existing bridge.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---


 arch/powerpc/include/asm/pci.h   |    5 +--
 arch/powerpc/kernel/pci-common.c |   59 +++++++++++++++++++--------------------
 arch/powerpc/kernel/pci_64.c     |   27 ++++++++++++++---
 3 files changed, 55 insertions(+), 36 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-28 12:06:00.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-28 14:58:41.000000000 +1100
@@ -37,6 +37,7 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
+#include <asm/eeh.h>
 
 static DEFINE_SPINLOCK(hose_spinlock);
 
@@ -1076,31 +1077,17 @@ static void __devinit pcibios_fixup_brid
 	}
 }
 
-static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
+void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
 	pr_debug("PCI: Fixup bus %d (%s)\n",
 		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
 
-	/* Fixup PCI<->PCI bridges. Host bridges are handled separately, for
-	 * now differently between 32 and 64 bits.
-	 */
-	if (bus->self != NULL)
-		pcibios_fixup_bridge(bus);
-
-	/* Setup bus DMA mappings */
-	if (ppc_md.pci_dma_bus_setup)
-		ppc_md.pci_dma_bus_setup(bus);
-
 	/* Setup DMA for all PCI devices on that bus */
 	list_for_each_entry(dev, &bus->devices, bus_list)
 		pcibios_setup_new_device(dev);
 
-	/* Platform specific bus fixups */
-	if (ppc_md.pcibios_fixup_bus)
-		ppc_md.pcibios_fixup_bus(bus);
-
 	/* Read default IRQs and fixup if necessary */
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pci_read_irq_line(dev);
@@ -1109,25 +1096,39 @@ static void __devinit __pcibios_fixup_bu
 	}
 }
 
+void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
+{
+	/* Fix up the bus resources */
+	if (bus->self != NULL)
+		pcibios_fixup_bridge(bus);
+
+	/* Platform specific bus fixups. This is currently only used
+	 * by fsl_pci and I'm hoping getting rid of it at some point
+	 */
+	if (ppc_md.pcibios_fixup_bus)
+		ppc_md.pcibios_fixup_bus(bus);
+
+	/* Setup bus DMA mappings */
+	if (ppc_md.pci_dma_bus_setup)
+		ppc_md.pci_dma_bus_setup(bus);
+}
+
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* When called from the generic PCI probe, read PCI<->PCI bridge
-	 * bases before proceeding
+	 * bases. This isn't called when generating the PCI tree from
+	 * the OF device-tree.
 	 */
 	if (bus->self != NULL)
 		pci_read_bridge_bases(bus);
-	__pcibios_fixup_bus(bus);
-}
-EXPORT_SYMBOL(pcibios_fixup_bus);
 
-/* When building a bus from the OF tree rather than probing, we need a
- * slightly different version of the fixup which doesn't read the
- * bridge bases using config space accesses
- */
-void __devinit pcibios_fixup_of_probed_bus(struct pci_bus *bus)
-{
-	__pcibios_fixup_bus(bus);
+	/* Now fixup the bus bus */
+	pcibios_setup_bus_self(bus);
+
+	/* Now fixup devices on that bus */
+	pcibios_setup_bus_devices(bus);
 }
+EXPORT_SYMBOL(pcibios_fixup_bus);
 
 static int skip_isa_ioresource_align(struct pci_dev *dev)
 {
@@ -1238,7 +1239,7 @@ static int __init reparent_resources(str
  *	    as well.
  */
 
-void pcibios_allocate_bus_resources(struct pci_bus *bus)
+static void pcibios_allocate_bus_resources(struct pci_bus *bus)
 {
 	struct pci_bus *b;
 	int i;
@@ -1394,11 +1395,12 @@ void __init pcibios_resource_survey(void
 }
 
 #ifdef CONFIG_HOTPLUG
+
 /* This is used by the pSeries hotplug driver to allocate resource
  * of newly plugged busses. We can try to consolidate with the
  * rest of the code later, for now, keep it as-is
  */
-void __devinit pcibios_claim_one_bus(struct pci_bus *bus)
+static void __devinit pcibios_claim_one_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 	struct pci_bus *child_bus;
@@ -1418,7 +1420,6 @@ void __devinit pcibios_claim_one_bus(str
 	list_for_each_entry(child_bus, &bus->children, node)
 		pcibios_claim_one_bus(child_bus);
 }
-EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
 #endif /* CONFIG_HOTPLUG */
 
 int pcibios_enable_device(struct pci_dev *dev, int mask)
Index: linux-work/arch/powerpc/include/asm/pci.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pci.h	2008-10-28 13:03:13.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pci.h	2008-10-28 14:56:52.000000000 +1100
@@ -221,6 +221,7 @@ extern void of_scan_pci_bridge(struct de
 				struct pci_dev *dev);
 
 extern void of_scan_bus(struct device_node *node, struct pci_bus *bus);
+extern void of_rescan_bus(struct device_node *node, struct pci_bus *bus);
 
 extern int pci_read_irq_line(struct pci_dev *dev);
 
@@ -235,8 +236,8 @@ extern void pci_resource_to_user(const s
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
 
-extern void pcibios_fixup_of_probed_bus(struct pci_bus *bus);
-
+extern void pcibios_setup_bus_devices(struct pci_bus *bus);
+extern void pcibios_setup_bus_self(struct pci_bus *bus);
 
 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2008-10-28 13:03:54.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2008-10-28 14:24:25.000000000 +1100
@@ -189,8 +189,8 @@ struct pci_dev *of_create_pci_dev(struct
 }
 EXPORT_SYMBOL(of_create_pci_dev);
 
-void __devinit of_scan_bus(struct device_node *node,
-			   struct pci_bus *bus)
+static void __devinit __of_scan_bus(struct device_node *node,
+				    struct pci_bus *bus, int rescan_existing)
 {
 	struct device_node *child;
 	const u32 *reg;
@@ -215,8 +215,12 @@ void __devinit of_scan_bus(struct device
 		pr_debug("    dev header type: %x\n", dev->hdr_type);
 	}
 
-	/* Ally all fixups */
-	pcibios_fixup_of_probed_bus(bus);
+	/* Apply all fixups necessary. We don't fixup the bus "self"
+	 * for an existing bridge that is being rescanned
+	 */
+	if (!rescan_existing)
+		pcibios_setup_bus_self(bus);
+	pcibios_setup_bus_devices(bus);
 
 	/* Now scan child busses */
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -228,7 +232,20 @@ void __devinit of_scan_bus(struct device
 		}
 	}
 }
-EXPORT_SYMBOL(of_scan_bus);
+
+void __devinit of_scan_bus(struct device_node *node,
+			   struct pci_bus *bus)
+{
+	__of_scan_bus(node, bus, 0);
+}
+EXPORT_SYMBOL_GPL(of_scan_bus);
+
+void __devinit of_rescan_bus(struct device_node *node,
+			     struct pci_bus *bus)
+{
+	__of_scan_bus(node, bus, 1);
+}
+EXPORT_SYMBOL_GPL(of_rescan_bus);
 
 void __devinit of_scan_pci_bridge(struct device_node *node,
 				  struct pci_dev *dev)
