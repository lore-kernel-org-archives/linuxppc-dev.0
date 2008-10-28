Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:33 +1100
Subject: [PATCH 4/10] powerpc/pci: Remove pcibios_do_bus_setup()
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054934.59A4ADDF83@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The function pcibios_do_bus_setup() was used by pcibios_fixup_bus()
to perform setup that is different between the 32-bit and 64-bit
code. This difference no longer exist, thus the function is removed
and the setup now done directly from pci-common.c

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pci.h   |    1 -
 arch/powerpc/kernel/pci-common.c |   16 +++++++++++-----
 arch/powerpc/kernel/pci_32.c     |   11 -----------
 arch/powerpc/kernel/pci_64.c     |   11 -----------
 4 files changed, 11 insertions(+), 28 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pci.h	2008-10-28 11:56:18.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pci.h	2008-10-28 11:56:46.000000000 +1100
@@ -235,7 +235,6 @@ extern void pci_resource_to_user(const s
 				 const struct resource *rsrc,
 				 resource_size_t *start, resource_size_t *end);
 
-extern void pcibios_do_bus_setup(struct pci_bus *bus);
 extern void pcibios_fixup_of_probed_bus(struct pci_bus *bus);
 
 
Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-28 11:56:45.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-28 11:56:46.000000000 +1100
@@ -1078,18 +1078,24 @@ static void __devinit pcibios_fixup_brid
 
 static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
 {
-	struct pci_dev *dev = bus->self;
+	struct pci_dev *dev;
 
-	pr_debug("PCI: Fixup bus %d (%s)\n", bus->number, dev ? pci_name(dev) : "PHB");
+	pr_debug("PCI: Fixup bus %d (%s)\n",
+		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
 
 	/* Fixup PCI<->PCI bridges. Host bridges are handled separately, for
 	 * now differently between 32 and 64 bits.
 	 */
-	if (dev != NULL)
+	if (bus->self != NULL)
 		pcibios_fixup_bridge(bus);
 
-	/* Additional setup that is different between 32 and 64 bits for now */
-	pcibios_do_bus_setup(bus);
+	/* Setup bus DMA mappings */
+	if (ppc_md.pci_dma_bus_setup)
+		ppc_md.pci_dma_bus_setup(bus);
+
+	/* Setup DMA for all PCI devices on that bus */
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		pcibios_setup_new_device(dev);
 
 	/* Platform specific bus fixups */
 	if (ppc_md.pcibios_fixup_bus)
Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2008-10-28 11:56:45.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2008-10-28 11:56:46.000000000 +1100
@@ -446,17 +446,6 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-void __devinit pcibios_do_bus_setup(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	if (ppc_md.pci_dma_bus_setup)
-		ppc_md.pci_dma_bus_setup(bus);
-
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		pcibios_setup_new_device(dev);
-}
-
 /* the next one is stolen from the alpha port... */
 void __init
 pcibios_update_irq(struct pci_dev *dev, int irq)
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2008-10-28 11:56:45.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_64.c	2008-10-28 11:56:46.000000000 +1100
@@ -502,17 +502,6 @@ int __devinit pcibios_map_io_space(struc
 }
 EXPORT_SYMBOL_GPL(pcibios_map_io_space);
 
-void __devinit pcibios_do_bus_setup(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	if (ppc_md.pci_dma_bus_setup)
-		ppc_md.pci_dma_bus_setup(bus);
-
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		pcibios_setup_new_device(dev);
-}
-
 unsigned long pci_address_to_pio(phys_addr_t address)
 {
 	struct pci_controller *hose, *tmp;
