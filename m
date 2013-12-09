Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:6])
 by ozlabs.org (Postfix) with ESMTP id 0D78B2C013E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 18:17:40 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 2/3] powerpc iommu: Add it_page_shift field to determine
 iommu page size
Date: Mon,  9 Dec 2013 18:17:02 +1100
Message-Id: <1386573423-7989-3-git-send-email-alistair@popple.id.au>
In-Reply-To: <1386573423-7989-1-git-send-email-alistair@popple.id.au>
References: <1386573423-7989-1-git-send-email-alistair@popple.id.au>
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
 arch/powerpc/platforms/cell/iommu.c    |    8 +++++---
 arch/powerpc/platforms/pasemi/iommu.c  |    5 ++++-
 arch/powerpc/platforms/powernv/pci.c   |    3 ++-
 arch/powerpc/platforms/pseries/iommu.c |   10 ++++++----
 arch/powerpc/platforms/wsp/wsp_pci.c   |    5 +++--
 7 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 0869c7e..7c92834 100644
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
index 2e89fa3..170ac24 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1177,9 +1177,10 @@ static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
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
index fc61b90..2b90ff8 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -197,7 +197,7 @@ static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
 
 	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
 
-	for (i = 0; i < npages; i++, uaddr += IOMMU_PAGE_SIZE_4K)
+	for (i = 0; i < npages; i++, uaddr += tbl->it_page_shift)
 		io_pte[i] = base_pte | (__pa(uaddr) & CBE_IOPTE_RPN_Mask);
 
 	mb();
@@ -487,8 +487,10 @@ cell_iommu_setup_window(struct cbe_iommu *iommu, struct device_node *np,
 	window->table.it_blocksize = 16;
 	window->table.it_base = (unsigned long)iommu->ptab;
 	window->table.it_index = iommu->nid;
-	window->table.it_offset = (offset >> IOMMU_PAGE_SHIFT_4K) + pte_offset;
-	window->table.it_size = size >> IOMMU_PAGE_SHIFT_4K;
+	window->table.it_page_shift = IOMMU_PAGE_SHIFT_4K;
+	window->table.it_offset =
+		(offset >> window->table.it_page_shift) + pte_offset;
+	window->table.it_size = size >> window->table.it_page_shift;
 
 	iommu_init_table(&window->table, iommu->nid);
 
diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 7d2d036..2e576f2 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -138,8 +138,11 @@ static void iommu_table_iobmap_setup(void)
 	pr_debug(" -> %s\n", __func__);
 	iommu_table_iobmap.it_busno = 0;
 	iommu_table_iobmap.it_offset = 0;
+	iommu_table_iobmap.it_page_shift = IOBMAP_PAGE_SHIFT;
+
 	/* it_size is in number of entries */
-	iommu_table_iobmap.it_size = 0x80000000 >> IOBMAP_PAGE_SHIFT;
+	iommu_table_iobmap.it_size =
+		0x80000000 >> iommu_table_iobmap.it_page_shift;
 
 	/* Initialize the common IOMMU code */
 	iommu_table_iobmap.it_base = (unsigned long)iob_l2_base;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 7f4d857..569b464 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -564,7 +564,8 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
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
index 1b7531c..e029918 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -486,9 +486,10 @@ static void iommu_table_setparms(struct pci_controller *phb,
 		memset((void *)tbl->it_base, 0, *sizep);
 
 	tbl->it_busno = phb->bus->number;
+	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
 
 	/* Units of tce entries */
-	tbl->it_offset = phb->dma_window_base_cur >> IOMMU_PAGE_SHIFT_4K;
+	tbl->it_offset = phb->dma_window_base_cur >> tbl->it_page_shift;
 
 	/* Test if we are going over 2GB of DMA space */
 	if (phb->dma_window_base_cur + phb->dma_window_size > 0x80000000ul) {
@@ -499,7 +500,7 @@ static void iommu_table_setparms(struct pci_controller *phb,
 	phb->dma_window_base_cur += phb->dma_window_size;
 
 	/* Set the tce table size - measured in entries */
-	tbl->it_size = phb->dma_window_size >> IOMMU_PAGE_SHIFT_4K;
+	tbl->it_size = phb->dma_window_size >> tbl->it_page_shift;
 
 	tbl->it_index = 0;
 	tbl->it_blocksize = 16;
@@ -537,11 +538,12 @@ static void iommu_table_setparms_lpar(struct pci_controller *phb,
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
diff --git a/arch/powerpc/platforms/wsp/wsp_pci.c b/arch/powerpc/platforms/wsp/wsp_pci.c
index 8a58961..9a15e5b 100644
--- a/arch/powerpc/platforms/wsp/wsp_pci.c
+++ b/arch/powerpc/platforms/wsp/wsp_pci.c
@@ -381,8 +381,9 @@ static struct wsp_dma_table *wsp_pci_create_dma32_table(struct wsp_phb *phb,
 
 	/* Init bits and pieces */
 	tbl->table.it_blocksize = 16;
-	tbl->table.it_offset = addr >> IOMMU_PAGE_SHIFT_4K;
-	tbl->table.it_size = size >> IOMMU_PAGE_SHIFT_4K;
+	tbl->table.it_page_shift = IOMMU_PAGE_SHIFT_4K;
+	tbl->table.it_offset = addr >> tbl->table.it_page_shift;
+	tbl->table.it_size = size >> tbl->table.it_page_shift;
 
 	/*
 	 * It's already blank but we clear it anyway.
-- 
1.7.10.4
