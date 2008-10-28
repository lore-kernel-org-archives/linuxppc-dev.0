Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:56 +1100
Subject: [PATCH 10/10] powerpc/pci: Cosmetic cleanups of pci-common.c
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054957.2735EDE015@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This does a few costmetic cleanups, moving a couple of things
around but without actually changing what the code does.

(There is a minor change in ordering of operations in
pcibios_setup_bus_devices but it should have no impact).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   77 ++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 41 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-28 16:39:53.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-28 16:39:54.000000000 +1100
@@ -202,25 +202,6 @@ char __devinit *pcibios_setup(char *str)
 	return str;
 }
 
-static void __devinit pcibios_setup_new_device(struct pci_dev *dev)
-{
-	struct dev_archdata *sd = &dev->dev.archdata;
-
-	sd->of_node = pci_device_to_OF_node(dev);
-
-	pr_debug("PCI: device %s OF node: %s\n", pci_name(dev),
-		 sd->of_node ? sd->of_node->full_name : "<none>");
-
-	sd->dma_ops = pci_dma_ops;
-#ifdef CONFIG_PPC32
-	sd->dma_data = (void *)PCI_DRAM_OFFSET;
-#endif
-	set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
-
-	if (ppc_md.pci_dma_dev_setup)
-		ppc_md.pci_dma_dev_setup(dev);
-}
-
 /*
  * Reads the interrupt pin to determine if interrupt is use by card.
  * If the interrupt is used, then gets the interrupt line from the
@@ -1076,33 +1057,14 @@ static void __devinit pcibios_fixup_brid
 	}
 }
 
-void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	pr_debug("PCI: Fixup bus %d (%s)\n",
-		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
-
-	/* Setup DMA for all PCI devices on that bus */
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		pcibios_setup_new_device(dev);
-
-	/* Read default IRQs and fixup if necessary */
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_read_irq_line(dev);
-		if (ppc_md.pci_irq_fixup)
-			ppc_md.pci_irq_fixup(dev);
-	}
-}
-
 void __devinit pcibios_setup_bus_self(struct pci_bus *bus)
 {
-	/* Fix up the bus resources */
+	/* Fix up the bus resources for P2P bridges */
 	if (bus->self != NULL)
 		pcibios_fixup_bridge(bus);
 
 	/* Platform specific bus fixups. This is currently only used
-	 * by fsl_pci and I'm hoping getting rid of it at some point
+	 * by fsl_pci and I'm hoping to get rid of it at some point
 	 */
 	if (ppc_md.pcibios_fixup_bus)
 		ppc_md.pcibios_fixup_bus(bus);
@@ -1112,10 +1074,43 @@ void __devinit pcibios_setup_bus_self(st
 		ppc_md.pci_dma_bus_setup(bus);
 }
 
+void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	pr_debug("PCI: Fixup bus devices %d (%s)\n",
+		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct dev_archdata *sd = &dev->dev.archdata;
+
+		/* Setup OF node pointer in archdata */
+		sd->of_node = pci_device_to_OF_node(dev);
+
+		/* Fixup NUMA node as it may not be setup yet by the generic
+		 * code and is needed by the DMA init
+		 */
+		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
+
+		/* Hook up default DMA ops */
+		sd->dma_ops = pci_dma_ops;
+		sd->dma_data = (void *)PCI_DRAM_OFFSET;
+
+		/* Additional platform DMA/iommu setup */
+		if (ppc_md.pci_dma_dev_setup)
+			ppc_md.pci_dma_dev_setup(dev);
+
+		/* Read default IRQs and fixup if necessary */
+		pci_read_irq_line(dev);
+		if (ppc_md.pci_irq_fixup)
+			ppc_md.pci_irq_fixup(dev);
+	}
+}
+
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* When called from the generic PCI probe, read PCI<->PCI bridge
-	 * bases. This isn't called when generating the PCI tree from
+	 * bases. This is -not- called when generating the PCI tree from
 	 * the OF device-tree.
 	 */
 	if (bus->self != NULL)
