Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4D9F1A09FA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:55 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 28 Mar 2015 00:56:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BDB122BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:52 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2REuiGt47644774
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:52 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2REuJTu030933
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 01:56:19 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 24/31] powerpc/powernv/ioda: Define and implement
 DMA table/window management callbacks
Date: Sat, 28 Mar 2015 01:55:08 +1100
Message-Id: <1427468115-2224-25-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This extends iommu_table_group_ops by a set of callbacks to support
dynamic DMA windows management.

query() returns IOMMU capabilities such as default DMA window address and
supported number of DMA windows and TCE table levels.

create_table() creates a TCE table with specific parameters.
it receives iommu_table_group to know nodeid in order to allocate
TCE table memory closer to the PHB. The exact format of allocated
multi-level table might be also specific to the PHB model (not
the case now though).
This callback calculated the DMA window offset on a PCI bus from @num
and stores it in a just created table.

set_window() sets the window at specified TVT index + @num on PHB.

unset_window() unsets the window from specified TVT.

This adds a free() callback to iommu_table_ops to free the memory
(potentially a tree of tables) allocated for the TCE table.

create_table() and free() are supposed to be called once per
VFIO container and set_window()/unset_window() are supposed to be
called for every group in a container.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h            | 21 +++++++
 arch/powerpc/platforms/powernv/pci-ioda.c   | 87 ++++++++++++++++++++++++-----
 arch/powerpc/platforms/powernv/pci-p5ioc2.c | 11 +++-
 3 files changed, 102 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 1e0d907..2c08c91 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -64,6 +64,8 @@ struct iommu_table_ops {
 			long index, long npages);
 	unsigned long (*get)(struct iommu_table *tbl, long index);
 	void (*flush)(struct iommu_table *tbl);
+
+	void (*free)(struct iommu_table *tbl);
 };
 
 /* These are used by VIO */
@@ -150,12 +152,31 @@ struct iommu_table_group_ops {
 	 */
 	void (*set_ownership)(struct iommu_table_group *table_group,
 			bool enable);
+
+	long (*create_table)(struct iommu_table_group *table_group,
+			int num,
+			__u32 page_shift,
+			__u64 window_size,
+			__u32 levels,
+			struct iommu_table *tbl);
+	long (*set_window)(struct iommu_table_group *table_group,
+			int num,
+			struct iommu_table *tblnew);
+	long (*unset_window)(struct iommu_table_group *table_group,
+			int num);
 };
 
 struct iommu_table_group {
 #ifdef CONFIG_IOMMU_API
 	struct iommu_group *group;
 #endif
+	/* Some key properties of IOMMU */
+	__u32 tce32_start;
+	__u32 tce32_size;
+	__u64 pgsizes; /* Bitmap of supported page sizes */
+	__u32 max_dynamic_windows_supported;
+	__u32 max_levels;
+
 	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
 	struct iommu_table_group_ops *ops;
 };
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 80ea84d..6939402 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -25,6 +25,7 @@
 #include <linux/memblock.h>
 #include <linux/iommu.h>
 #include <linux/mmzone.h>
+#include <linux/sizes.h>
 
 #include <asm/mmzone.h>
 #include <asm/sections.h>
@@ -1236,6 +1237,8 @@ static void pnv_ioda2_tce_free_vm(struct iommu_table *tbl, long index,
 		pnv_pci_ioda2_tce_invalidate(tbl, index, npages, false);
 }
 
+static void pnv_pci_free_table(struct iommu_table *tbl);
+
 static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 	.set = pnv_ioda2_tce_build_vm,
 #ifdef CONFIG_IOMMU_API
@@ -1243,6 +1246,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 #endif
 	.clear = pnv_ioda2_tce_free_vm,
 	.get = pnv_tce_get,
+	.free = pnv_pci_free_table,
 };
 
 static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
@@ -1325,6 +1329,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				 TCE_PCI_SWINV_PAIR);
 	}
 	tbl->it_ops = &pnv_ioda1_iommu_ops;
+	pe->table_group.tce32_start = tbl->it_offset << tbl->it_page_shift;
+	pe->table_group.tce32_size = tbl->it_size << tbl->it_page_shift;
 	iommu_init_table(tbl, phb->hose->node);
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
@@ -1409,7 +1415,7 @@ static __be64 *pnv_alloc_tce_table(int nid,
 }
 
 static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
-		__u32 page_shift, __u64 window_size, __u32 levels,
+		int num, __u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table *tbl)
 {
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
@@ -1422,6 +1428,9 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
 		return -EINVAL;
 
+	if (!(table_group->pgsizes & (1ULL << page_shift)))
+		return -EINVAL;
+
 	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
 		return -EINVAL;
 
@@ -1432,8 +1441,8 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 	shift = ROUND_UP(ilog2(window_size) - page_shift, levels) / levels;
 	shift += 3;
 	shift = max_t(unsigned, shift, IOMMU_PAGE_SHIFT_4K);
-	pr_info("Creating TCE table %08llx, %d levels, TCE table size = %lx\n",
-			window_size, levels, 1UL << shift);
+	pr_info("Creating TCE table #%d %08llx, %d levels, TCE table size = %lx\n",
+			num, window_size, levels, 1UL << shift);
 
 	tbl->it_level_size = 1ULL << (shift - 3);
 	left = tce_table_size;
@@ -1444,8 +1453,8 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 	tbl->it_indirect_levels = levels - 1;
 
 	/* Setup linux iommu table */
-	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
-			page_shift);
+	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size,
+			num ? pe->tce_bypass_base : 0, page_shift);
 
 	tbl->it_ops = &pnv_ioda2_iommu_ops;
 
@@ -1464,8 +1473,21 @@ static void pnv_pci_free_table(struct iommu_table *tbl)
 	iommu_reset_table(tbl, "ioda2");
 }
 
+static inline void pnv_pci_ioda2_tvt_invalidate(unsigned int pe_number,
+		unsigned long it_index)
+{
+	__be64 __iomem *invalidate = (__be64 __iomem *)it_index;
+	/* 01xb - invalidate TCEs that match the specified PE# */
+	unsigned long addr = (0x4ull << 60) | (pe_number & 0xFF);
+
+	if (!it_index)
+		return;
+
+	__raw_writeq(cpu_to_be64(addr), invalidate);
+}
+
 static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
-		struct iommu_table *tbl)
+		int num, struct iommu_table *tbl)
 {
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
 			table_group);
@@ -1477,13 +1499,13 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
 	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
 
-	pe_info(pe, "Setting up window at %llx..%llx pagesize=0x%x tablesize=0x%lx levels=%d levelsize=%x\n",
-			start_addr, start_addr + win_size - 1,
+	pe_info(pe, "Setting up window #%d (%p) at %llx..%llx pagesize=0x%x tablesize=0x%lx levels=%d levelsize=%x\n",
+			num, tbl, start_addr, start_addr + win_size - 1,
 			1UL << tbl->it_page_shift, tbl->it_size,
 			tbl->it_indirect_levels + 1, tbl->it_level_size);
 
-	pe->table_group.tables[0] = *tbl;
-	tbl = &pe->table_group.tables[0];
+	pe->table_group.tables[num] = *tbl;
+	tbl = &pe->table_group.tables[num];
 	tbl->it_group = &pe->table_group;
 
 	/*
@@ -1491,7 +1513,8 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 	 * shifted by 1 bit for 32-bits DMA space.
 	 */
 	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
-			pe->pe_number << 1, tbl->it_indirect_levels + 1,
+			(pe->pe_number << 1) + num,
+			tbl->it_indirect_levels + 1,
 			__pa(tbl->it_base),
 			size << 3, 1ULL << tbl->it_page_shift);
 	if (rc) {
@@ -1513,6 +1536,8 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 	}
 
+	pnv_pci_ioda2_tvt_invalidate(pe->pe_number, tbl->it_index);
+
 	return 0;
 fail:
 	if (pe->tce32_seg >= 0)
@@ -1572,6 +1597,30 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
 }
 
 #ifdef CONFIG_IOMMU_API
+static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
+		int num)
+{
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
+	struct pnv_phb *phb = pe->phb;
+	struct iommu_table *tbl = &pe->table_group.tables[num];
+	long ret;
+
+	pe_info(pe, "Removing DMA window #%d\n", num);
+
+	ret = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+			(pe->pe_number << 1) + num,
+			0/* levels */, 0/* table address */,
+			0/* table size */, 0/* page size */);
+	if (ret)
+		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
+
+	pnv_pci_ioda2_tvt_invalidate(pe->pe_number, tbl->it_index);
+	memset(tbl, 0, sizeof(*tbl));
+
+	return ret;
+}
+
 static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
 				     bool enable)
 {
@@ -1587,6 +1636,9 @@ static void pnv_ioda2_set_ownership(struct iommu_table_group *table_group,
 
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 	.set_ownership = pnv_ioda2_set_ownership,
+	.create_table = pnv_pci_ioda2_create_table,
+	.set_window = pnv_pci_ioda2_set_window,
+	.unset_window = pnv_pci_ioda2_unset_window,
 };
 #endif
 
@@ -1607,8 +1659,15 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
 		end);
 
-	rc = pnv_pci_ioda2_create_table(&pe->table_group, IOMMU_PAGE_SHIFT_4K,
-			phb->ioda.m32_pci_base,
+	pe->table_group.tce32_start = 0;
+	pe->table_group.tce32_size = phb->ioda.m32_pci_base;
+	pe->table_group.max_dynamic_windows_supported =
+			IOMMU_TABLE_GROUP_MAX_TABLES;
+	pe->table_group.max_levels = POWERNV_IOMMU_MAX_LEVELS;
+	pe->table_group.pgsizes = SZ_4K | SZ_64K | SZ_16M;
+
+	rc = pnv_pci_ioda2_create_table(&pe->table_group, 0,
+			IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base,
 			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
 	if (rc) {
 		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
@@ -1622,7 +1681,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
 #endif
 
-	rc = pnv_pci_ioda2_set_window(&pe->table_group, tbl);
+	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table,"
 		       " err %ld\n", rc);
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index d2d9092..99cb858 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -116,6 +116,8 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	u64 phb_id;
 	int64_t rc;
 	static int primary = 1;
+	struct iommu_table_group *table_group;
+	struct iommu_table *tbl;
 
 	pr_info(" Initializing p5ioc2 PHB %s\n", np->full_name);
 
@@ -180,13 +182,16 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 	pnv_pci_init_p5ioc2_msis(phb);
 
 	/* Setup iommu */
-	phb->p5ioc2.table_group.tables[0].it_group = &phb->p5ioc2.table_group;
+	table_group = &phb->p5ioc2.table_group;
+	tbl = &phb->p5ioc2.table_group.tables[0];
+	tbl->it_group = table_group;
 
 	/* Setup TCEs */
 	phb->dma_dev_setup = pnv_pci_p5ioc2_dma_dev_setup;
-	pnv_pci_setup_iommu_table(&phb->p5ioc2.table_group.tables[0],
-				  tce_mem, tce_size, 0,
+	pnv_pci_setup_iommu_table(tbl, tce_mem, tce_size, 0,
 				  IOMMU_PAGE_SHIFT_4K);
+	table_group->tce32_start = tbl->it_offset << tbl->it_page_shift;
+	table_group->tce32_size = tbl->it_size << tbl->it_page_shift;
 }
 
 void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
-- 
2.0.0
