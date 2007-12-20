Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:54:50 +1100
Subject: [PATCH 7/19] [POWERPC] Merge pcibios_resource_to_bus/bus_to_resource
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035453.4820ADDE1F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This merges the PowerPC 32 and 64 bits version of pcibios_resource_to_bus
and pcibios_bus_to_resource().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |   36 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c     |   32 -----------------------------
 arch/powerpc/kernel/pci_64.c     |   42 ---------------------------------------
 3 files changed, 36 insertions(+), 74 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:30.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:31.000000000 +1100
@@ -655,3 +655,39 @@ int pci_proc_domain(struct pci_bus *bus)
 #endif
 }
 
+void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
+			     struct resource *res)
+{
+	resource_size_t offset = 0, mask = (resource_size_t)-1;
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	if (!hose)
+		return;
+	if (res->flags & IORESOURCE_IO) {
+		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+		mask = 0xffffffffu;
+	} else if (res->flags & IORESOURCE_MEM)
+		offset = hose->pci_mem_offset;
+
+	region->start = (res->start - offset) & mask;
+	region->end = (res->end - offset) & mask;
+}
+EXPORT_SYMBOL(pcibios_resource_to_bus);
+
+void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
+			     struct pci_bus_region *region)
+{
+	resource_size_t offset = 0, mask = (resource_size_t)-1;
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	if (!hose)
+		return;
+	if (res->flags & IORESOURCE_IO) {
+		offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+		mask = 0xffffffffu;
+	} else if (res->flags & IORESOURCE_MEM)
+		offset = hose->pci_mem_offset;
+	res->start = (region->start + offset) & mask;
+	res->end = (region->end + offset) & mask;
+}
+EXPORT_SYMBOL(pcibios_bus_to_resource);
Index: linux-merge/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:29.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:31.000000000 +1100
@@ -145,38 +145,6 @@ pcibios_fixup_resources(struct pci_dev *
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID,		PCI_ANY_ID,			pcibios_fixup_resources);
 
-void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			struct resource *res)
-{
-	resource_size_t offset = 0, mask = (resource_size_t)-1;
-	struct pci_controller *hose = dev->sysdata;
-
-	if (hose && res->flags & IORESOURCE_IO) {
-		offset = (unsigned long)hose->io_base_virt - isa_io_base;
-		mask = 0xffffffffu;
-	} else if (hose && res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-	region->start = (res->start - offset) & mask;
-	region->end = (res->end - offset) & mask;
-}
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			     struct pci_bus_region *region)
-{
-	resource_size_t offset = 0, mask = (resource_size_t)-1;
-	struct pci_controller *hose = dev->sysdata;
-
-	if (hose && res->flags & IORESOURCE_IO) {
-		offset = (unsigned long)hose->io_base_virt - isa_io_base;
-		mask = 0xffffffffu;
-	} else if (hose && res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-	res->start = (region->start + offset) & mask;
-	res->end = (region->end + offset) & mask;
-}
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-
 static int skip_isa_ioresource_align(struct pci_dev *dev)
 {
 	if ((ppc_pci_flags & PPC_PCI_CAN_SKIP_ISA_ALIGN) &&
Index: linux-merge/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:30.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:31.000000000 +1100
@@ -77,48 +77,6 @@ static void fixup_broken_pcnet32(struct 
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TRIDENT, PCI_ANY_ID, fixup_broken_pcnet32);
 
-void  pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
-			      struct resource *res)
-{
-	unsigned long offset = 0;
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	if (!hose)
-		return;
-
-	if (res->flags & IORESOURCE_IO)
-	        offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-
-	if (res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-
-	region->start = res->start - offset;
-	region->end = res->end - offset;
-}
-
-void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
-			      struct pci_bus_region *region)
-{
-	unsigned long offset = 0;
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	if (!hose)
-		return;
-
-	if (res->flags & IORESOURCE_IO)
-	        offset = (unsigned long)hose->io_base_virt - _IO_BASE;
-
-	if (res->flags & IORESOURCE_MEM)
-		offset = hose->pci_mem_offset;
-
-	res->start = region->start + offset;
-	res->end = region->end + offset;
-}
-
-#ifdef CONFIG_HOTPLUG
-EXPORT_SYMBOL(pcibios_resource_to_bus);
-EXPORT_SYMBOL(pcibios_bus_to_resource);
-#endif
 
 /*
  * We need to avoid collisions with `mirrored' VGA ports
