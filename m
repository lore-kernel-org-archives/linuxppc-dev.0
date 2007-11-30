Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:10:42 +1100
Subject: [PATCH 3/24] powerpc: Fix powerpc 32 bits resource fixup for 64 bits
	resources
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
Message-Id: <20071130061145.0062DDDEDE@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The 32bits powerpc resource fixup code uses unsigned longs to do the
offseting of resources which overflows on platforms such as 4xx where
resources can be 64 bits.

This fixes it by using resource_size_t instead.

However, the IO stuff does rely on some 32 bits arithmetic, so we hack
by cropping the result of the fixups for IO resources with a 32 bits
mask.

This isn't the prettiest but should work for now until we change the
32 bits PCI code to do IO mappings like 64 bits does, within a reserved
are of the kernel address space.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This needs some regression testing.

 arch/powerpc/kernel/pci_32.c |   44 +++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2007-11-16 15:48:27.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2007-11-16 15:55:54.000000000 +1100
@@ -104,7 +104,7 @@ pcibios_fixup_resources(struct pci_dev *
 {
 	struct pci_controller* hose = (struct pci_controller *)dev->sysdata;
 	int i;
-	unsigned long offset;
+	resource_size_t offset, mask;
 
 	if (!hose) {
 		printk(KERN_ERR "No hose for PCI dev %s!\n", pci_name(dev));
@@ -123,15 +123,17 @@ pcibios_fixup_resources(struct pci_dev *
 			continue;
 		}
 		offset = 0;
+		mask = (resource_size_t)-1;
 		if (res->flags & IORESOURCE_MEM) {
 			offset = hose->pci_mem_offset;
 		} else if (res->flags & IORESOURCE_IO) {
 			offset = (unsigned long) hose->io_base_virt
 				- isa_io_base;
+			mask = 0xffffffffu;
 		}
 		if (offset != 0) {
-			res->start += offset;
-			res->end += offset;
+			res->start = (res->start + offset) & mask;
+			res->end = (res->end + offset) & mask;
 			DBG("Fixup res %d (%lx) of dev %s: %llx -> %llx\n",
 			    i, res->flags, pci_name(dev),
 			    (u64)res->start - offset, (u64)res->start);
@@ -147,30 +149,32 @@ DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID,		PC
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			struct resource *res)
 {
-	unsigned long offset = 0;
+	resource_size_t offset = 0, mask = (resource_size_t)-1;
 	struct pci_controller *hose = dev->sysdata;
 
-	if (hose && res->flags & IORESOURCE_IO)
+	if (hose && res->flags & IORESOURCE_IO) {
 		offset = (unsigned long)hose->io_base_virt - isa_io_base;
-	else if (hose && res->flags & IORESOURCE_MEM)
+		mask = 0xffffffffu;
+	} else if (hose && res->flags & IORESOURCE_MEM)
 		offset = hose->pci_mem_offset;
-	region->start = res->start - offset;
-	region->end = res->end - offset;
+	region->start = (res->start - offset) & mask;
+	region->end = (res->end - offset) & mask;
 }
 EXPORT_SYMBOL(pcibios_resource_to_bus);
 
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region)
 {
-	unsigned long offset = 0;
+	resource_size_t offset = 0, mask = (resource_size_t)-1;
 	struct pci_controller *hose = dev->sysdata;
 
-	if (hose && res->flags & IORESOURCE_IO)
+	if (hose && res->flags & IORESOURCE_IO) {
 		offset = (unsigned long)hose->io_base_virt - isa_io_base;
-	else if (hose && res->flags & IORESOURCE_MEM)
+		mask = 0xffffffffu;
+	} else if (hose && res->flags & IORESOURCE_MEM)
 		offset = hose->pci_mem_offset;
-	res->start = region->start + offset;
-	res->end = region->end + offset;
+	res->start = (region->start + offset) & mask;
+	res->end = (region->end + offset) & mask;
 }
 EXPORT_SYMBOL(pcibios_bus_to_resource);
 
@@ -334,9 +338,9 @@ static int __init
 pci_relocate_bridge_resource(struct pci_bus *bus, int i)
 {
 	struct resource *res, *pr, *conflict;
-	unsigned long try, size;
-	int j;
+	resource_size_t try, size;
 	struct pci_bus *parent = bus->parent;
+	int j;
 
 	if (parent == NULL) {
 		/* shouldn't ever happen */
@@ -438,7 +442,7 @@ update_bridge_resource(struct pci_dev *d
 	u8 io_base_lo, io_limit_lo;
 	u16 mem_base, mem_limit;
 	u16 cmd;
-	unsigned long start, end, off;
+	resource_size_t start, end, off;
 	struct pci_controller *hose = dev->sysdata;
 
 	if (!hose) {
@@ -1157,8 +1161,8 @@ void pcibios_fixup_bus(struct pci_bus *b
 			res->end = IO_SPACE_LIMIT;
 			res->flags = IORESOURCE_IO;
 		}
-		res->start += io_offset;
-		res->end += io_offset;
+		res->start = (res->start + io_offset) & 0xffffffffu;
+		res->end = (res->end + io_offset) & 0xffffffffu;
 
 		for (i = 0; i < 3; ++i) {
 			res = &hose->mem_resources[i];
@@ -1183,8 +1187,8 @@ void pcibios_fixup_bus(struct pci_bus *b
 			if (!res->flags || bus->self->transparent)
 				continue;
 			if (io_offset && (res->flags & IORESOURCE_IO)) {
-				res->start += io_offset;
-				res->end += io_offset;
+				res->start = (res->start + io_offset) & 0xffffffffu;
+				res->end = (res->end + io_offset) & 0xffffffffu;
 			} else if (hose->pci_mem_offset
 				   && (res->flags & IORESOURCE_MEM)) {
 				res->start += hose->pci_mem_offset;
