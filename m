Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b29dff6fba70d3c98ffb6d4f8a9a6712421fad3b.1204097262.git.michael@ellerman.id.au>
In-Reply-To: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
References: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 8/8] Convert the cell IOMMU fixed mapping to 16M IOMMU pages
Date: Wed, 27 Feb 2008 18:28:20 +1100 (EST)
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
 arch/powerpc/platforms/cell/iommu.c |   36 +++++++++++++++++++++-------------
 1 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 12db681..0e82255 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -875,37 +875,45 @@ static void cell_dma_dev_setup_fixed(struct device *dev)
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
 
-	ptab = cell_iommu_alloc_ptab(iommu, fbase, fsize, IOMMU_PAGE_SHIFT);
+	ptab = cell_iommu_alloc_ptab(iommu, fbase, fsize, 24);
 
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
