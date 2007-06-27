Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98539DDF7E
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 04:19:23 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] [POWERPC] Removed dead code related to PCI on ppc32
Date: Wed, 27 Jun 2007 13:19:13 -0500
Message-Id: <11829683631074-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11829683612573-git-send-email-galak@kernel.crashing.org>
References: <11829683583721-git-send-email-galak@kernel.crashing.org>
	<11829683604166-git-send-email-galak@kernel.crashing.org>
	<11829683612573-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are no in kernel users of any off these functions and some of
them were not even EXPORT_SYMBOL:

- pci_bus_io_base()
- pci_bus_io_base_phys()
- pci_bus_mem_base_phys()
- pci_resource_to_bus()
- phys_to_bus()
- pci_phys_to_bus()
- pci_bus_to_phys()
- pci_init_resource()
- resource_fixup()

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_32.c     |  112 --------------------------------------
 arch/powerpc/kernel/ppc_ksyms.c  |    3 -
 include/asm-powerpc/pci-bridge.h |   12 ----
 3 files changed, 0 insertions(+), 127 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 7738a28..2d4a1c4 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -1319,12 +1319,6 @@ pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-unsigned long resource_fixup(struct pci_dev * dev, struct resource * res,
-			     unsigned long start, unsigned long size)
-{
-	return start;
-}
-
 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
@@ -1508,53 +1502,6 @@ pci_bus_to_hose(int bus)
 	return NULL;
 }
 
-void __iomem *
-pci_bus_io_base(unsigned int bus)
-{
-	struct pci_controller *hose;
-
-	hose = pci_bus_to_hose(bus);
-	if (!hose)
-		return NULL;
-	return hose->io_base_virt;
-}
-
-unsigned long
-pci_bus_io_base_phys(unsigned int bus)
-{
-	struct pci_controller *hose;
-
-	hose = pci_bus_to_hose(bus);
-	if (!hose)
-		return 0;
-	return hose->io_base_phys;
-}
-
-unsigned long
-pci_bus_mem_base_phys(unsigned int bus)
-{
-	struct pci_controller *hose;
-
-	hose = pci_bus_to_hose(bus);
-	if (!hose)
-		return 0;
-	return hose->pci_mem_offset;
-}
-
-unsigned long
-pci_resource_to_bus(struct pci_dev *pdev, struct resource *res)
-{
-	/* Hack alert again ! See comments in chrp_pci.c
-	 */
-	struct pci_controller* hose =
-		(struct pci_controller *)pdev->sysdata;
-	if (hose && res->flags & IORESOURCE_MEM)
-		return res->start - hose->pci_mem_offset;
-	/* We may want to do something with IOs here... */
-	return res->start;
-}
-
-
 static struct resource *__pci_mmap_make_offset(struct pci_dev *dev,
 					       resource_size_t *offset,
 					       enum pci_mmap_state mmap_state)
@@ -1725,53 +1672,6 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 	return ret;
 }
 
-/* Obsolete functions. Should be removed once the symbios driver
- * is fixed
- */
-unsigned long
-phys_to_bus(unsigned long pa)
-{
-	struct pci_controller *hose;
-	int i;
-
-	for (hose = hose_head; hose; hose = hose->next) {
-		for (i = 0; i < 3; ++i) {
-			if (pa >= hose->mem_resources[i].start
-			    && pa <= hose->mem_resources[i].end) {
-				/*
-				 * XXX the hose->pci_mem_offset really
-				 * only applies to mem_resources[0].
-				 * We need a way to store an offset for
-				 * the others.  -- paulus
-				 */
-				if (i == 0)
-					pa -= hose->pci_mem_offset;
-				return pa;
-			}
-		}
-	}
-	/* hmmm, didn't find it */
-	return 0;
-}
-
-unsigned long
-pci_phys_to_bus(unsigned long pa, int busnr)
-{
-	struct pci_controller* hose = pci_bus_to_hose(busnr);
-	if (!hose)
-		return pa;
-	return pa - hose->pci_mem_offset;
-}
-
-unsigned long
-pci_bus_to_phys(unsigned int ba, int busnr)
-{
-	struct pci_controller* hose = pci_bus_to_hose(busnr);
-	if (!hose)
-		return ba;
-	return ba + hose->pci_mem_offset;
-}
-
 /* Provide information on locations of various I/O regions in physical
  * memory.  Do this on a per-card basis so that we choose the right
  * root bridge.
@@ -1853,18 +1753,6 @@ void pci_resource_to_user(const struct pci_dev *dev, int bar,
 	*end = rsrc->end - offset;
 }
 
-void __init pci_init_resource(struct resource *res, resource_size_t start,
-			      resource_size_t end, int flags, char *name)
-{
-	res->start = start;
-	res->end = end;
-	res->flags = flags;
-	res->name = name;
-	res->parent = NULL;
-	res->sibling = NULL;
-	res->child = NULL;
-}
-
 unsigned long pci_address_to_pio(phys_addr_t address)
 {
 	struct pci_controller* hose = hose_head;
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index c96fa9b..c58f2de 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -106,9 +106,6 @@ EXPORT_SYMBOL(isa_mem_base);
 EXPORT_SYMBOL(pci_dram_offset);
 EXPORT_SYMBOL(pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
-EXPORT_SYMBOL(pci_bus_io_base);
-EXPORT_SYMBOL(pci_bus_io_base_phys);
-EXPORT_SYMBOL(pci_bus_mem_base_phys);
 EXPORT_SYMBOL(pci_bus_to_hose);
 #endif /* CONFIG_PCI */
 
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 229ead9..e2b2b6b 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -9,21 +9,9 @@
 struct device_node;
 struct pci_controller;
 
-/*
- * pci_io_base returns the memory address at which you can access
- * the I/O space for PCI bus number `bus' (or NULL on error).
- */
-extern void __iomem *pci_bus_io_base(unsigned int bus);
-extern unsigned long pci_bus_io_base_phys(unsigned int bus);
-extern unsigned long pci_bus_mem_base_phys(unsigned int bus);
-
 /* Allocate a new PCI host bridge structure */
 extern struct pci_controller* pcibios_alloc_controller(void);
 
-/* Helper function for setting up resources */
-extern void pci_init_resource(struct resource *res, resource_size_t start,
-			      resource_size_t end, int flags, char *name);
-
 /* Get the PCI host controller for a bus */
 extern struct pci_controller* pci_bus_to_hose(int bus);
 
-- 
1.5.2.1
