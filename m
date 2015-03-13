Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 822AB1A0A0B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:27 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 13 Mar 2015 18:09:27 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 909F92BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:24 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D89GUo43974694
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:09:24 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D88pxH021511
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 19:08:51 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v6 23/29] powerpc/powernv: Implement multilevel TCE
 tables
Date: Fri, 13 Mar 2015 19:07:31 +1100
Message-Id: <1426234057-16165-24-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
References: <1426234057-16165-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

TCE tables might get too big in case of 4K IOMMU pages and DDW enabled
on huge guests (hundreds of GB of RAM) so the kernel might be unable to
allocate contiguous chunk of physical memory to store the TCE table.

To address this, POWER8 CPU (actually, IODA2) supports multi-level TCE tables,
up to 5 levels which splits the table into a tree of smaller subtables.

This adds multi-level TCE tables support to pnv_pci_ioda2_create_table()
and pnv_pci_ioda2_free_table() callbacks.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h          |   2 +
 arch/powerpc/platforms/powernv/pci-ioda.c | 127 ++++++++++++++++++++++++------
 arch/powerpc/platforms/powernv/pci.c      |  19 +++++
 3 files changed, 122 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index fd118ea..4007432 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -88,6 +88,8 @@ struct iommu_pool {
 struct iommu_table {
 	unsigned long  it_busno;     /* Bus number this table belongs to */
 	unsigned long  it_size;      /* Size of iommu table in entries */
+	unsigned long  it_indirect_levels;
+	unsigned long  it_level_size;
 	unsigned long  it_offset;    /* Offset into global table */
 	unsigned long  it_base;      /* mapped address of tce table */
 	unsigned long  it_index;     /* which iommu table this is */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8bb5d6d..bdf511d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -47,6 +47,8 @@
 #include "powernv.h"
 #include "pci.h"
 
+#define POWERNV_IOMMU_DEFAULT_LEVELS	1
+
 static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...)
 {
@@ -1331,16 +1333,79 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
 }
 
+static void pnv_free_tce_table(unsigned long addr, unsigned size,
+		unsigned level)
+{
+	addr &= ~(TCE_PCI_READ | TCE_PCI_WRITE);
+
+	if (level) {
+		long i;
+		u64 *tmp = (u64 *) addr;
+
+		for (i = 0; i < size; ++i) {
+			unsigned long hpa = be64_to_cpu(tmp[i]);
+
+			if (!(hpa & (TCE_PCI_READ | TCE_PCI_WRITE)))
+				continue;
+
+			pnv_free_tce_table((unsigned long) __va(hpa),
+					size, level - 1);
+		}
+	}
+
+	free_pages(addr, get_order(size << 3));
+}
+
+static __be64 *pnv_alloc_tce_table(int nid,
+		unsigned shift, unsigned levels, unsigned long *left)
+{
+	struct page *tce_mem = NULL;
+	__be64 *addr, *tmp;
+	unsigned order = max_t(unsigned, shift, PAGE_SHIFT) - PAGE_SHIFT;
+	unsigned long chunk = 1UL << shift, i;
+
+	tce_mem = alloc_pages_node(nid, GFP_KERNEL, order);
+	if (!tce_mem) {
+		pr_err("Failed to allocate a TCE memory\n");
+		return NULL;
+	}
+
+	if (!*left)
+		return NULL;
+
+	addr = page_address(tce_mem);
+	memset(addr, 0, chunk);
+
+	--levels;
+	if (!levels) {
+		/* This is last level, actual TCEs */
+		*left -= min(*left, chunk);
+		return addr;
+	}
+
+	for (i = 0; i < (chunk >> 3); ++i) {
+		/* We allocated required TCEs, mark the rest "page fault" */
+		if (!*left) {
+			addr[i] = cpu_to_be64(0);
+			continue;
+		}
+
+		tmp = pnv_alloc_tce_table(nid, shift, levels, left);
+		addr[i] = cpu_to_be64(__pa(tmp) |
+				TCE_PCI_READ | TCE_PCI_WRITE);
+	}
+
+	return addr;
+}
+
 static long pnv_pci_ioda2_create_table(struct pnv_ioda_pe *pe,
-		__u32 page_shift, __u64 window_size,
+		__u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table *tbl)
 {
 	int nid = pe->phb->hose->node;
-	struct page *tce_mem = NULL;
 	void *addr;
-	unsigned long tce_table_size;
-	int64_t rc;
-	unsigned order;
+	unsigned long tce_table_size, left;
+	unsigned shift;
 
 	if (!(table_group->pgsizes & (1ULL << page_shift)))
 		return -EINVAL;
@@ -1348,20 +1413,27 @@ static long pnv_pci_ioda2_create_table(struct pnv_ioda_pe *pe,
 	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
 		return -EINVAL;
 
+	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
+		return -EINVAL;
+
 	tce_table_size = (window_size >> page_shift) * 8;
 	tce_table_size = max(0x1000UL, tce_table_size);
 
 	/* Allocate TCE table */
-	order = get_order(tce_table_size);
+#define ROUND_UP(x, n) (((x) + (n) - 1u) & ~((n) - 1u))
+	shift = ROUND_UP(ilog2(window_size) - page_shift, levels) / levels;
+	shift += 3;
+	shift = max_t(unsigned, shift, IOMMU_PAGE_SHIFT_4K);
+	pr_info("Creating TCE table %08llx, %d levels, TCE table size = %lx\n",
+			window_size, levels, 1UL << shift);
 
-	tce_mem = alloc_pages_node(nid, GFP_KERNEL, order);
-	if (!tce_mem) {
-		pr_err("Failed to allocate a TCE memory, order=%d\n", order);
-		rc = -ENOMEM;
-		goto fail;
-	}
-	addr = page_address(tce_mem);
-	memset(addr, 0, tce_table_size);
+	tbl->it_level_size = 1ULL << (shift - 3);
+	left = tce_table_size;
+	addr = pnv_alloc_tce_table(nid, shift, levels, &left);
+	if (!addr)
+		return -ENOMEM;
+
+	tbl->it_indirect_levels = levels - 1;
 
 	/* Setup linux iommu table */
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
@@ -1370,20 +1442,18 @@ static long pnv_pci_ioda2_create_table(struct pnv_ioda_pe *pe,
 	tbl->it_ops = &pnv_ioda2_iommu_ops;
 
 	return 0;
-fail:
-	if (tce_mem)
-		__free_pages(tce_mem, get_order(tce_table_size));
-
-	return rc;
 }
 
 static void pnv_pci_free_table(struct iommu_table *tbl)
 {
+	const unsigned size = tbl->it_indirect_levels ?
+			tbl->it_level_size : tbl->it_size;
+
 	if (!tbl->it_size)
 		return;
 
-	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
-	memset(tbl, 0, sizeof(struct iommu_table));
+	pnv_free_tce_table(tbl->it_base, size, tbl->it_indirect_levels);
+	iommu_reset_table(tbl, "ioda2");
 }
 
 static long pnv_pci_ioda2_set_window(struct pnv_ioda_pe *pe,
@@ -1392,12 +1462,15 @@ static long pnv_pci_ioda2_set_window(struct pnv_ioda_pe *pe,
 	struct pnv_phb *phb = pe->phb;
 	const __be64 *swinvp;
 	int64_t rc;
+	const unsigned size = tbl->it_indirect_levels ?
+			tbl->it_level_size : tbl->it_size;
 	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
 	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
 
-	pe_info(pe, "Setting up window at %llx..%llx pagesize=0x%x tablesize=0x%lx\n",
+	pe_info(pe, "Setting up window at %llx..%llx pagesize=0x%x tablesize=0x%lx levels=%d levelsize=%x\n",
 			start_addr, start_addr + win_size - 1,
-			1UL << tbl->it_page_shift, tbl->it_size << 3);
+			1UL << tbl->it_page_shift, tbl->it_size,
+			tbl->it_indirect_levels + 1, tbl->it_level_size);
 
 	pe->table_group.tables[0] = *tbl;
 	tbl = &pe->table_group.tables[0];
@@ -1408,8 +1481,9 @@ static long pnv_pci_ioda2_set_window(struct pnv_ioda_pe *pe,
 	 * shifted by 1 bit for 32-bits DMA space.
 	 */
 	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
-			pe->pe_number << 1, 1, __pa(tbl->it_base),
-			tbl->it_size << 3, 1ULL << tbl->it_page_shift);
+			pe->pe_number << 1, tbl->it_indirect_levels + 1,
+			__pa(tbl->it_base),
+			size << 3, 1ULL << tbl->it_page_shift);
 	if (rc) {
 		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
 		goto fail;
@@ -1523,7 +1597,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		end);
 
 	rc = pnv_pci_ioda2_create_table(pe, IOMMU_PAGE_SHIFT_4K,
-			phb->ioda.m32_pci_base, tbl);
+			phb->ioda.m32_pci_base,
+			POWERNV_IOMMU_DEFAULT_LEVELS, tbl);
 	if (rc) {
 		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
 		return;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index c5e1f05..9b4a0cf 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -592,6 +592,25 @@ struct pci_ops pnv_pci_ops = {
 static __be64 *pnv_tce(struct iommu_table *tbl, long index)
 {
 	__be64 *tmp = ((__be64 *)tbl->it_base);
+	int  level = tbl->it_indirect_levels;
+	const long shift = ilog2(tbl->it_level_size);
+	unsigned long mask = (tbl->it_level_size - 1) << (level * shift);
+
+	if (index >= tbl->it_size)
+		return NULL;
+
+	while (level) {
+		int n = (index & mask) >> (level * shift);
+		unsigned long tce = be64_to_cpu(tmp[n]);
+
+		if (!(tce & (TCE_PCI_READ | TCE_PCI_WRITE)))
+			return NULL;
+
+		tmp = __va(tce & ~(TCE_PCI_READ | TCE_PCI_WRITE));
+		index &= ~mask;
+		mask >>= shift;
+		--level;
+	}
 
 	return tmp + index;
 }
-- 
2.0.0
