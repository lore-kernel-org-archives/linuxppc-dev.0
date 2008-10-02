Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 02 Oct 2008 11:30:04 +1000
Subject: [PATCH] powerpc: Fix sysfs pci mmap on 32-bit machines with 64-bit PCI
Message-Id: <20081002013018.17A24DDE41@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When manipulating 64-bit PCI addresses, the code would lose the
top 32-bit in a couple of places when shifting a pfn due to missing
type casting from the 32-bit pfn to a 64-bit resource before the
shift.

This breaks using newer X servers for example on 440 machines
with the PCI bus above 32-bit.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-10-02 11:18:34.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-10-02 11:27:35.000000000 +1000
@@ -372,7 +372,7 @@ pgprot_t pci_phys_mem_access_prot(struct
 	struct pci_dev *pdev = NULL;
 	struct resource *found = NULL;
 	unsigned long prot = pgprot_val(protection);
-	unsigned long offset = pfn << PAGE_SHIFT;
+	resource_size_t offset = ((resource_size_t)pfn) << PAGE_SHIFT;
 	int i;
 
 	if (page_is_ram(pfn))
@@ -423,7 +423,8 @@ pgprot_t pci_phys_mem_access_prot(struct
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
-	resource_size_t offset = vma->vm_pgoff << PAGE_SHIFT;
+	resource_size_t offset =
+		((resource_size_t)vma->vm_pgoff) << PAGE_SHIFT;
 	struct resource *rp;
 	int ret;
 
