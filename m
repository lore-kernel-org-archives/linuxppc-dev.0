Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<linux-pci@vger.kernel.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 03 Oct 2008 19:49:35 +1000
Subject: [RFC/PATCH 2/2] powerpc: Add legacy PCI access via sysfs
Message-Id: <20081003094953.A7F4EDE184@ozlabs.org>
Cc: tony.luck@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for legacy_io and legacy_mem files in
bus class directories in sysfs for powerpc

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Unfortunately, I didn't have a chance to properly test it yet. I was
hoping to use an old VGA card to muck around with but the card seems
fried. I'll do some more tests next wee, but at least it appears to
be mmap'ing the right physical address.

 arch/powerpc/include/asm/pci.h   |   11 +++
 arch/powerpc/kernel/pci-common.c |  140 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 149 insertions(+), 2 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pci.h	2008-10-02 16:11:43.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pci.h	2008-10-03 14:44:43.000000000 +1000
@@ -123,6 +123,16 @@ int pci_mmap_page_range(struct pci_dev *
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
 
+extern int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val,
+			   size_t count);
+extern int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val,
+			   size_t count);
+extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
+				      struct vm_area_struct *vma,
+				      enum pci_mmap_state mmap_state);
+
+#define HAVE_PCI_LEGACY	1
+
 #if defined(CONFIG_PPC64) || defined(CONFIG_NOT_COHERENT_CACHE)
 /*
  * For 64-bit kernels, pci_unmap_{single,page} is not a nop.
@@ -226,5 +236,6 @@ extern void pci_resource_to_user(const s
 extern void pcibios_do_bus_setup(struct pci_bus *bus);
 extern void pcibios_fixup_of_probed_bus(struct pci_bus *bus);
 
+
 #endif	/* __KERNEL__ */
 #endif /* __ASM_POWERPC_PCI_H */
Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-03 14:44:06.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-03 19:46:26.000000000 +1000
@@ -452,7 +452,8 @@ pgprot_t pci_phys_mem_access_prot(struct
 		pci_dev_put(pdev);
 	}
 
-	DBG("non-PCI map for %lx, prot: %lx\n", offset, prot);
+	DBG("non-PCI map for %llx, prot: %lx\n",
+	    (unsigned long long)offset, prot);
 
 	return __pgprot(prot);
 }
@@ -491,6 +492,141 @@ int pci_mmap_page_range(struct pci_dev *
 	return ret;
 }
 
+/* This provides legacy IO read access on a bus */
+int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val, size_t size)
+{
+	unsigned long offset;
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct resource *rp = &hose->io_resource;
+	void __iomem *addr;
+
+	/* Check if port can be supported by that bus. We only check
+	 * the ranges of the PHB though, not the bus itself as the rules
+	 * for forwarding legacy cycles down bridges are not our problem
+	 * here. So if the host bridge supports it, we do it.
+	 */
+	offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+	offset += port;
+
+	if (!(rp->flags & IORESOURCE_IO))
+		return -ENXIO;
+	if (offset < rp->start || (offset + size) > rp->end)
+		return -ENXIO;
+	addr = hose->io_base_virt + port;
+
+	switch(size) {
+	case 1:
+		*((u8 *)val) = in_8(addr);
+		return 1;
+	case 2:
+		if (port & 1)
+			return -EINVAL;
+		*((u16 *)val) = in_le16(addr);
+		return 2;
+	case 4:
+		if (port & 3)
+			return -EINVAL;
+		*((u32 *)val) = in_le32(addr);
+		return 4;
+	}
+	return -EINVAL;
+}
+
+/* This provides legacy IO write access on a bus */
+int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val, size_t size)
+{
+	unsigned long offset;
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct resource *rp = &hose->io_resource;
+	void __iomem *addr;
+
+	/* Check if port can be supported by that bus. We only check
+	 * the ranges of the PHB though, not the bus itself as the rules
+	 * for forwarding legacy cycles down bridges are not our problem
+	 * here. So if the host bridge supports it, we do it.
+	 */
+	offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+	offset += port;
+
+	if (!(rp->flags & IORESOURCE_IO))
+		return -ENXIO;
+	if (offset < rp->start || (offset + size) > rp->end)
+		return -ENXIO;
+	addr = hose->io_base_virt + port;
+
+	/* WARNING: The generic code is idiotic. It gets passed a pointer
+	 * to what can be a 1, 2 or 4 byte quantity and always reads that
+	 * as a u32, which means that we have to correct the location of
+	 * the data read within those 32 bits for size 1 and 2
+	 */
+	switch(size) {
+	case 1:
+		out_8(addr, val >> 24);
+		return 1;
+	case 2:
+		if (port & 1)
+			return -EINVAL;
+		out_le16(addr, val >> 16);
+		return 2;
+	case 4:
+		if (port & 3)
+			return -EINVAL;
+		out_le32(addr, val);
+		return 4;
+	}
+	return -EINVAL;
+}
+
+/* This provides legacy IO or memory mmap access on a bus */
+int pci_mmap_legacy_page_range(struct pci_bus *bus,
+			       struct vm_area_struct *vma,
+			       enum pci_mmap_state mmap_state)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	resource_size_t offset =
+		((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
+	resource_size_t size = vma->vm_end - vma->vm_start;
+	struct resource *rp;
+
+	pr_debug("pci_mmap_legacy_page_range(%04x:%02x, %s @%llx..%llx)\n",
+		 pci_domain_nr(bus), bus->number,
+		 mmap_state == pci_mmap_mem ? "MEM" : "IO",
+		 (unsigned long long)offset,
+		 (unsigned long long)(offset + size - 1));
+
+	if (mmap_state == pci_mmap_mem) {
+		int i;
+
+		offset += hose->pci_mem_offset;
+		for (i=0; i<3; i++) {
+			rp = &hose->mem_resources[i];
+			if (!(rp->flags & IORESOURCE_MEM))
+				continue;
+			if (offset < rp->start || (offset + size) > rp->end)
+				continue;
+			break;
+		}
+		if (i >= 3)
+			return -ENXIO;
+	} else {
+		unsigned long io_offset = (unsigned long)hose->io_base_virt - _IO_BASE;
+		unsigned long roffset = offset + io_offset;
+		rp = &hose->io_resource;
+		if (!(rp->flags & IORESOURCE_IO))
+			return -ENXIO;
+		if (roffset < rp->start || (roffset + size) > rp->end)
+			return -ENXIO;
+		offset += hose->io_base_phys;
+	}
+	pr_debug(" -> mapping phys %llx\n", (unsigned long long)offset);
+
+	vma->vm_pgoff = offset >> PAGE_SHIFT;
+	vma->vm_page_prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
+	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
+}
+
 void pci_resource_to_user(const struct pci_dev *dev, int bar,
 			  const struct resource *rsrc,
 			  resource_size_t *start, resource_size_t *end)
@@ -649,7 +785,7 @@ void __devinit pci_process_bridge_OF_ran
 			break;
 		case 2:		/* PCI Memory space */
 		case 3:		/* PCI 64 bits Memory space */
-			printk(KERN_INFO
+		printk(KERN_INFO
 			       " MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
 			       cpu_addr, cpu_addr + size - 1, pci_addr,
 			       (pci_space & 0x40000000) ? "Prefetch" : "");
 
