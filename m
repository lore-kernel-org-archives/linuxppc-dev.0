Return-Path: <rdreier@cisco.com>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Define pci_unmap_addr() et al. when
	CONFIG_NOT_COHERENT_CACHE=y
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 06 Dec 2006 15:15:38 -0800
Message-ID: <adaslfsaa5h.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current PowerPC code makes pci_unmap_addr(), pci_unmap_addr_set(),
and friends trivial for all 32-bit kernels.  This is reasonable, since
for those kernels it is true that pci_unmap_single() does not need the
DMA address from the original DMA mapping -- in fact, it is a NOP.

However, I recently tried the tg3 driver on a PowerPC 440SPe machine,
which runs a 32-bit kernel and has non-cache-coherent PCI DMA.  I
found that the tg3 driver crashed in pci_dma_sync_single_for_cpu(),
since for non-coherent systems, that function must invalidate the
cache for the DMA address range requested, and therefore it does use
the address passed in.  tg3 uses a DMA address it stashes away with
pci_unmap_addr_set() and retrieves with pci_unmap_addr().  Of course,
since pci_unmap_addr() is defined to (0) right now, this doesn't work.

It seems to me that the tg3 driver is using pci_unmap_addr() in a
legitimate way -- I wouldn't want to have to teach all drivers that
they should use pci_unmap_addr() if they only need the address for
unmapping functions, but if they want the pci_dma_sync functions, then
they have to store the DMA address without the helper macros.
The right fix therefore seems to be in the definition of the macros in
<asm/pci.h> -- we should use the trivial versions only for 32-bit
kernels for coherent systems, and the real versions for both 64-bit
kernels and non-coherent systems.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
---
 include/asm-powerpc/pci.h |   33 ++++++++++++++++++++++-----------
 include/asm-ppc/pci.h     |   23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/include/asm-powerpc/pci.h b/include/asm-powerpc/pci.h
index 16f1331..ac656ee 100644
--- a/include/asm-powerpc/pci.h
+++ b/include/asm-powerpc/pci.h
@@ -143,8 +143,13 @@ int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
 /* Tell drivers/pci/proc.c that we have pci_mmap_page_range() */
 #define HAVE_PCI_MMAP	1
 
-#ifdef CONFIG_PPC64
-/* pci_unmap_{single,page} is not a nop, thus... */
+#if defined(CONFIG_PPC64) || defined(CONFIG_NOT_COHERENT_CACHE)
+/*
+ * For 64-bit kernels, pci_unmap_{single,page} is not a nop.
+ * For 32-bit non-coherent kernels, pci_dma_sync_single_for_cpu() and
+ * so on are not nops.
+ * and thus...
+ */
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)	\
 	dma_addr_t ADDR_NAME;
 #define DECLARE_PCI_UNMAP_LEN(LEN_NAME)		\
@@ -158,6 +163,20 @@ int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)		\
 	(((PTR)->LEN_NAME) = (VAL))
 
+#else /* 32-bit && coherent */
+
+/* pci_unmap_{page,single} is a nop so... */
+#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
+#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
+#define pci_unmap_addr(PTR, ADDR_NAME)		(0)
+#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
+#define pci_unmap_len(PTR, LEN_NAME)		(0)
+#define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
+
+#endif /* CONFIG_PPC64 || CONFIG_NOT_COHERENT_CACHE */
+
+#ifdef CONFIG_PPC64
+
 /* The PCI address space does not equal the physical memory address
  * space (we have an IOMMU).  The IDE and SCSI device layers use
  * this boolean for bounce buffer decisions.
@@ -172,16 +191,8 @@ int pci_mmap_page_range(struct pci_dev *pdev, struct vm_area_struct *vma,
  */
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
-/* pci_unmap_{page,single} is a nop so... */
-#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
-#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
-#define pci_unmap_addr(PTR, ADDR_NAME)		(0)
-#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
-#define pci_unmap_len(PTR, LEN_NAME)		(0)
-#define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
-
 #endif /* CONFIG_PPC64 */
-	
+
 extern void pcibios_resource_to_bus(struct pci_dev *dev,
 			struct pci_bus_region *region,
 			struct resource *res);
diff --git a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
index 11ffaaa..9d16202 100644
--- a/include/asm-ppc/pci.h
+++ b/include/asm-ppc/pci.h
@@ -61,6 +61,27 @@ extern unsigned long pci_bus_to_phys(unsigned int ba, int busnr);
  */
 #define PCI_DMA_BUS_IS_PHYS     (1)
 
+#ifdef CONFIG_NOT_COHERENT_CACHE
+/*
+ * pci_unmap_{page,single} are NOPs but pci_dma_sync_single_for_cpu()
+ * and so on are not, so...
+ */
+
+#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)	\
+	dma_addr_t ADDR_NAME;
+#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)		\
+	__u32 LEN_NAME;
+#define pci_unmap_addr(PTR, ADDR_NAME)			\
+	((PTR)->ADDR_NAME)
+#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)		\
+	(((PTR)->ADDR_NAME) = (VAL))
+#define pci_unmap_len(PTR, LEN_NAME)			\
+	((PTR)->LEN_NAME)
+#define pci_unmap_len_set(PTR, LEN_NAME, VAL)		\
+	(((PTR)->LEN_NAME) = (VAL))
+
+#else /* coherent */
+
 /* pci_unmap_{page,single} is a nop so... */
 #define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
 #define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
@@ -69,6 +90,8 @@ extern unsigned long pci_bus_to_phys(unsigned int ba, int busnr);
 #define pci_unmap_len(PTR, LEN_NAME)		(0)
 #define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
 
+#endif /* CONFIG_NOT_COHERENT_CACHE */
+
 #ifdef CONFIG_PCI
 static inline void pci_dma_burst_advice(struct pci_dev *pdev,
 					enum pci_dma_burst_strategy *strat,
-- 
1.4.4.1
