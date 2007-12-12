Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Dec 2007 16:22:59 +1100
Subject: [PATCH 7/13] [POWERPC] Merge pcibios_resource_to_bus/bus_to_resource
In-Reply-To: <1197436973.110379.888292904645.qpush@grosgo>
Message-Id: <20071212052303.ADAF2DDF67@ozlabs.org>
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

 arch/powerpc/kernel/pci-common.c |   36 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c     |   32 -----------------------------
 arch/powerpc/kernel/pci_64.c     |   43 ---------------------------------------
 3 files changed, 36 insertions(+), 75 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b2a5395..b666954 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
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
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 9a79a3d..f05ef5b 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -145,38 +145,6 @@ pcibios_fixup_resources(struct pci_dev *dev)
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
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 1b7c810..26c7df2 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -77,48 +77,6 @@ static void fixup_broken_pcnet32(struct pci_dev* dev)
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
-- 
1.5.3.7
