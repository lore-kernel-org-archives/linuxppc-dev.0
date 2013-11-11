Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:7])
 by ozlabs.org (Postfix) with ESMTP id 145A12C0369
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 15:22:12 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc iommu: Add it_page_shift field to determine iommu
 page size
Date: Mon, 11 Nov 2013 15:22:08 +1100
Message-Id: <1384143729-14491-3-git-send-email-alistair@popple.id.au>
In-Reply-To: <1384143729-14491-1-git-send-email-alistair@popple.id.au>
References: <1384143729-14491-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a it_page_shift field to struct iommu_table and
initiliases it to 4K for all platforms.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/asm/iommu.h       |    1 +
 arch/powerpc/kernel/vio.c              |    5 +++--
 arch/powerpc/platforms/cell/iommu.c    |   14 ++++++++------
 arch/powerpc/platforms/powernv/pci.c   |    3 ++-
 arch/powerpc/platforms/pseries/iommu.c |   10 ++++++----
 5 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index e53de39..706073a 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -76,6 +76,7 @@ struct iommu_table {
 	struct iommu_pool large_pool;
 	struct iommu_pool pools[IOMMU_NR_POOLS];
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
+	unsigned long  it_page_shift;/* table iommu page size */
 #ifdef CONFIG_IOMMU_API
 	struct iommu_group *it_group;
 #endif
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index a93e501..30c1cf5 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1171,9 +1171,10 @@ static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 			    &tbl->it_index, &offset, &size);
 
 	/* TCE table size - measured in tce entries */
-	tbl->it_size = size >> IOMMU_PAGE_SHIFT_4K;
+	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
+	tbl->it_size = size >> tbl->it_page_shift;
 	/* offset for VIO should always be 0 */
-	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT_4K;
+	tbl->it_offset = offset >> tbl->it_page_shift;
 	tbl->it_busno = 0;
 	tbl->it_type = TCE_VB;
 	tbl->it_blocksize = 16;
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index b535606..2b90ff8 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -197,7 +197,7 @@ static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
 
 	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
 
-	for (i = 0; i < npages; i++, uaddr += IOMMU_PAGE_SIZE)
+	for (i = 0; i < npages; i++, uaddr += tbl->it_page_shift)
 		io_pte[i] = base_pte | (__pa(uaddr) & CBE_IOPTE_RPN_Mask);
 
 	mb();
@@ -430,7 +430,7 @@ static void cell_iommu_setup_hardware(struct cbe_iommu *iommu,
 {
 	cell_iommu_setup_stab(iommu, base, size, 0, 0);
 	iommu->ptab = cell_iommu_alloc_ptab(iommu, base, size, 0, 0,
-					    IOMMU_PAGE_SHIFT);
+					    IOMMU_PAGE_SHIFT_4K);
 	cell_iommu_enable_hardware(iommu);
 }
 
@@ -487,8 +487,10 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 	window->table.it_blocksize = 16;
 	window->table.it_base = (unsigned long)iommu->ptab;
 	window->table.it_index = iommu->nid;
-	window->table.it_offset = (offset >> IOMMU_PAGE_SHIFT) + pte_offset;
-	window->table.it_size = size >> IOMMU_PAGE_SHIFT;
+	window->table.it_page_shift = IOMMU_PAGE_SHIFT_4K;
+	window->table.it_offset =
+		(offset >> window->table.it_page_shift) + pte_offset;
+	window->table.it_size = size >> window->table.it_page_shift;
 
 	iommu_init_table(&window->table, iommu->nid);
 
@@ -773,7 +775,7 @@ static void __init cell_iommu_init_one(struct device_node *np,
 
 	/* Setup the iommu_table */
 	cell_iommu_setup_window(iommu, np, base, size,
-				offset >> IOMMU_PAGE_SHIFT);
+				offset >> IOMMU_PAGE_SHIFT_4K);
 }
 
 static void __init cell_disable_iommus(void)
@@ -1122,7 +1124,7 @@ static int __init cell_iommu_fixed_mapping_init(void)
 
 		cell_iommu_setup_stab(iommu, dbase, dsize, fbase, fsize);
 		iommu->ptab = cell_iommu_alloc_ptab(iommu, dbase, dsize, 0, 0,
-						    IOMMU_PAGE_SHIFT);
+						    IOMMU_PAGE_SHIFT_4K);
 		cell_iommu_setup_fixed_ptab(iommu, np, dbase, dsize,
 					     fbase, fsize);
 		cell_iommu_enable_hardware(iommu);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 78b231c..cfab147 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -452,7 +452,8 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 {
 	tbl->it_blocksize = 16;
 	tbl->it_base = (unsigned long)tce_mem;
-	tbl->it_offset = dma_offset >> IOMMU_PAGE_SHIFT_4K;
+	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
+	tbl->it_offset = dma_offset >> tbl->it_page_shift;
 	tbl->it_index = 0;
 	tbl->it_size = tce_size >> 3;
 	tbl->it_busno = 0;
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 007c21f..6a43f2d 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -485,9 +485,10 @@ static void iommu_table_setparms(struct pci_controller *phb,
 		memset((void *)tbl->it_base, 0, *sizep);
 
 	tbl->it_busno = phb->bus->number;
+	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
 
 	/* Units of tce entries */
-	tbl->it_offset = phb->dma_window_base_cur >> IOMMU_PAGE_SHIFT_4K;
+	tbl->it_offset = phb->dma_window_base_cur >> tbl->it_page_shift;
 
 	/* Test if we are going over 2GB of DMA space */
 	if (phb->dma_window_base_cur + phb->dma_window_size > 0x80000000ul) {
@@ -498,7 +499,7 @@ static void iommu_table_setparms(struct pci_controller *phb,
 	phb->dma_window_base_cur += phb->dma_window_size;
 
 	/* Set the tce table size - measured in entries */
-	tbl->it_size = phb->dma_window_size >> IOMMU_PAGE_SHIFT_4K;
+	tbl->it_size = phb->dma_window_size >> tbl->it_page_shift;
 
 	tbl->it_index = 0;
 	tbl->it_blocksize = 16;
@@ -536,11 +537,12 @@ static void iommu_table_setparms_lpar(struct pci_controller *phb,
 	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
 
 	tbl->it_busno = phb->bus->number;
+	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
 	tbl->it_base   = 0;
 	tbl->it_blocksize  = 16;
 	tbl->it_type = TCE_PCI;
-	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT_4K;
-	tbl->it_size = size >> IOMMU_PAGE_SHIFT_4K;
+	tbl->it_offset = offset >> tbl->it_page_shift;
+	tbl->it_size = size >> tbl->it_page_shift;
 }
 
 static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
-- 
1.7.10.4
