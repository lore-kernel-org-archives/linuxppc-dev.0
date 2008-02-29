Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <39518dc11175a7cdd01ecfbe9a67b932bb38b522.1204270367.git.michael@ellerman.id.au>
In-Reply-To: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
References: <fdd3edc0f2f3d2d6cade5cd695b8080d0da95a7f.1204270367.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 8/8] Convert the cell IOMMU fixed mapping to 16M IOMMU pages
Date: Fri, 29 Feb 2008 18:33:29 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The only tricky part is we need to adjust the PTE insertion loop to
cater for holes in the page table. The PTEs for each segment start on
a 4K boundary, so with 16M pages we have 16 PTEs per segment and then
a gap to the next 4K page boundary.

It might be possible to allocate the PTEs for each segment separately,
saving the memory currently filling the gaps. However we'd need to
check that's OK with the hardware, and that it actually saves memory.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   37 ++++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index b0e347e..20ea0e1 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -882,38 +882,45 @@ static void cell_dma_dev_setup_fixed(struct device *dev)
 	dev_dbg(dev, "iommu: fixed addr = %lx\n", addr);
 }
 
+static void insert_16M_pte(unsigned long addr, unsigned long *ptab,
+			   unsigned long base_pte)
+{
+	unsigned long segment, offset;
+
+	segment = addr >> IO_SEGMENT_SHIFT;
+	offset = (addr >> 24) - (segment << IO_PAGENO_BITS(24));
+	ptab = ptab + (segment * (1 << 12) / sizeof(unsigned long));
+
+	pr_debug("iommu: addr %lx ptab %p segment %lx offset %lx\n",
+		  addr, ptab, segment, offset);
+
+	ptab[offset] = base_pte | (__pa(addr) & IOPTE_RPN_Mask);
+}
+
 static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
 	struct device_node *np, unsigned long dbase, unsigned long dsize,
 	unsigned long fbase, unsigned long fsize)
 {
-	int i;
-	unsigned long base_pte, uaddr, *io_pte, *ptab;
+	unsigned long base_pte, uaddr, ioaddr, *ptab;
 
-	ptab = cell_iommu_alloc_ptab(iommu, fbase, fsize, dbase, dsize,
-				     IOMMU_PAGE_SHIFT);
+	ptab = cell_iommu_alloc_ptab(iommu, fbase, fsize, dbase, dsize, 24);
 
 	dma_iommu_fixed_base = fbase;
 
-	/* convert from bytes into page table indices */
-	dbase = dbase >> IOMMU_PAGE_SHIFT;
-	dsize = dsize >> IOMMU_PAGE_SHIFT;
-	fbase = fbase >> IOMMU_PAGE_SHIFT;
-	fsize = fsize >> IOMMU_PAGE_SHIFT;
-
 	pr_debug("iommu: mapping 0x%lx pages from 0x%lx\n", fsize, fbase);
 
-	io_pte = ptab;
 	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW
 		    | (cell_iommu_get_ioid(np) & IOPTE_IOID_Mask);
 
-	uaddr = 0;
-	for (i = fbase; i < fbase + fsize; i++, uaddr += IOMMU_PAGE_SIZE) {
+	for (uaddr = 0; uaddr < fsize; uaddr += (1 << 24)) {
 		/* Don't touch the dynamic region */
-		if (i >= dbase && i < (dbase + dsize)) {
+		ioaddr = uaddr + fbase;
+		if (ioaddr >= dbase && ioaddr < (dbase + dsize)) {
 			pr_debug("iommu: fixed/dynamic overlap, skipping\n");
 			continue;
 		}
-		io_pte[i - fbase] = base_pte | (__pa(uaddr) & IOPTE_RPN_Mask);
+
+		insert_16M_pte(uaddr, ptab, base_pte);
 	}
 
 	mb();
-- 
1.5.2.rc1.1884.g59b20
