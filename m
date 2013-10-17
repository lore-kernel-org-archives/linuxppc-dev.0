Return-Path: <anton@samba.org>
Date: Thu, 17 Oct 2013 23:21:15 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, tony@bakeyournoodle.com,
 aik@ozlabs.ru
Subject: [PATCH] powerpc/pseries: Fix endian issues in pseries iommu code
Message-ID: <20131017232115.2f43c3c1@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    
Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0307901..f253361 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -52,7 +52,7 @@
 
 
 static void tce_invalidate_pSeries_sw(struct iommu_table *tbl,
-				      u64 *startp, u64 *endp)
+				      __be64 *startp, __be64 *endp)
 {
 	u64 __iomem *invalidate = (u64 __iomem *)tbl->it_index;
 	unsigned long start, end, inc;
@@ -86,7 +86,7 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 			      struct dma_attrs *attrs)
 {
 	u64 proto_tce;
-	u64 *tcep, *tces;
+	__be64 *tcep, *tces;
 	u64 rpn;
 
 	proto_tce = TCE_PCI_READ; // Read allowed
@@ -94,12 +94,12 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 	if (direction != DMA_TO_DEVICE)
 		proto_tce |= TCE_PCI_WRITE;
 
-	tces = tcep = ((u64 *)tbl->it_base) + index;
+	tces = tcep = ((__be64 *)tbl->it_base) + index;
 
 	while (npages--) {
 		/* can't move this out since we might cross MEMBLOCK boundary */
 		rpn = __pa(uaddr) >> TCE_SHIFT;
-		*tcep = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
+		*tcep = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
 
 		uaddr += TCE_PAGE_SIZE;
 		tcep++;
@@ -113,9 +113,9 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 
 static void tce_free_pSeries(struct iommu_table *tbl, long index, long npages)
 {
-	u64 *tcep, *tces;
+	__be64 *tcep, *tces;
 
-	tces = tcep = ((u64 *)tbl->it_base) + index;
+	tces = tcep = ((__be64 *)tbl->it_base) + index;
 
 	while (npages--)
 		*(tcep++) = 0;
@@ -126,11 +126,11 @@ static void tce_free_pSeries(struct iommu_table *tbl, long index, long npages)
 
 static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
 {
-	u64 *tcep;
+	__be64 *tcep;
 
-	tcep = ((u64 *)tbl->it_base) + index;
+	tcep = ((__be64 *)tbl->it_base) + index;
 
-	return *tcep;
+	return be64_to_cpu(*tcep);
 }
 
 static void tce_free_pSeriesLP(struct iommu_table*, long, long);
@@ -177,7 +177,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	return ret;
 }
 
-static DEFINE_PER_CPU(u64 *, tce_page);
+static DEFINE_PER_CPU(__be64 *, tce_page);
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -186,7 +186,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 {
 	u64 rc = 0;
 	u64 proto_tce;
-	u64 *tcep;
+	__be64 *tcep;
 	u64 rpn;
 	long l, limit;
 	long tcenum_start = tcenum, npages_start = npages;
@@ -206,7 +206,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	 * from iommu_alloc{,_sg}()
 	 */
 	if (!tcep) {
-		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
+		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
 			local_irq_restore(flags);
@@ -230,7 +230,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		limit = min_t(long, npages, 4096/TCE_ENTRY_SIZE);
 
 		for (l = 0; l < limit; l++) {
-			tcep[l] = proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT;
+			tcep[l] = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
 			rpn++;
 		}
 
@@ -329,16 +329,16 @@ struct direct_window {
 
 /* Dynamic DMA Window support */
 struct ddw_query_response {
-	u32 windows_available;
-	u32 largest_available_block;
-	u32 page_size;
-	u32 migration_capable;
+	__be32 windows_available;
+	__be32 largest_available_block;
+	__be32 page_size;
+	__be32 migration_capable;
 };
 
 struct ddw_create_response {
-	u32 liobn;
-	u32 addr_hi;
-	u32 addr_lo;
+	__be32 liobn;
+	__be32 addr_hi;
+	__be32 addr_lo;
 };
 
 static LIST_HEAD(direct_window_list);
@@ -392,7 +392,8 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 					unsigned long num_pfn, const void *arg)
 {
 	const struct dynamic_dma_window_prop *maprange = arg;
-	u64 *tcep, tce_size, num_tce, dma_offset, next, proto_tce, liobn;
+	u64 tce_size, num_tce, dma_offset, next, proto_tce, liobn;
+	__be64 *tcep;
 	u32 tce_shift;
 	u64 rc = 0;
 	long l, limit;
@@ -401,7 +402,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 	tcep = __get_cpu_var(tce_page);
 
 	if (!tcep) {
-		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
+		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		if (!tcep) {
 			local_irq_enable();
 			return -ENOMEM;
@@ -435,7 +436,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 		dma_offset = next + be64_to_cpu(maprange->dma_base);
 
 		for (l = 0; l < limit; l++) {
-			tcep[l] = proto_tce | next;
+			tcep[l] = cpu_to_be64(proto_tce | next);
 			next += tce_size;
 		}
 
@@ -780,7 +781,7 @@ static u64 find_existing_ddw(struct device_node *pdn)
 	list_for_each_entry(window, &direct_window_list, list) {
 		if (window->device == pdn) {
 			direct64 = window->prop;
-			dma_addr = direct64->dma_base;
+			dma_addr = be64_to_cpu(direct64->dma_base);
 			break;
 		}
 	}
@@ -1045,11 +1046,11 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		dev_dbg(&dev->dev, "no free dynamic windows");
 		goto out_restore_window;
 	}
-	if (query.page_size & 4) {
+	if (be32_to_cpu(query.page_size) & 4) {
 		page_shift = 24; /* 16MB */
-	} else if (query.page_size & 2) {
+	} else if (be32_to_cpu(query.page_size) & 2) {
 		page_shift = 16; /* 64kB */
-	} else if (query.page_size & 1) {
+	} else if (be32_to_cpu(query.page_size) & 1) {
 		page_shift = 12; /* 4kB */
 	} else {
 		dev_dbg(&dev->dev, "no supported direct page size in mask %x",
@@ -1059,7 +1060,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	/* verify the window * number of ptes will map the partition */
 	/* check largest block * page size > max memory hotplug addr */
 	max_addr = memory_hotplug_max();
-	if (query.largest_available_block < (max_addr >> page_shift)) {
+	if (be32_to_cpu(query.largest_available_block) < (max_addr >> page_shift)) {
 		dev_dbg(&dev->dev, "can't map partiton max 0x%llx with %u "
 			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
 			  1ULL << page_shift);
@@ -1085,7 +1086,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (ret != 0)
 		goto out_free_prop;
 
-	ddwprop->liobn = cpu_to_be32(create.liobn);
+	ddwprop->liobn = create.liobn;
 	ddwprop->dma_base = cpu_to_be64(of_read_number(&create.addr_hi, 2));
 	ddwprop->tce_shift = cpu_to_be32(page_shift);
 	ddwprop->window_shift = cpu_to_be32(len);
