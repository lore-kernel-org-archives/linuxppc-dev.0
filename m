Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 412BHY0SZbzF36K
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 15:46:49 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH kernel 4/6] powerpc/powernv: Add indirect levels to
 it_userspace
Date: Fri,  8 Jun 2018 15:46:31 +1000
Message-Id: <20180608054633.18659-5-aik@ozlabs.ru>
In-Reply-To: <20180608054633.18659-1-aik@ozlabs.ru>
References: <20180608054633.18659-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to support sparse memory and therefore huge chunks of DMA windows
do not need to be mapped. If a DMA window big enough to require 2 or more
indirect levels, and a DMA window is used to map all RAM (which is
a default case for 64bit window), we can actually save some memory by
not allocation TCE for regions which we are not going to map anyway.

The hardware tables alreary support indirect levels but we also keep
host-physical-to-userspace translation array which is allocated by
vmalloc() and is a flat array which might use quite some memory.

This converts it_userspace from vmalloc'ed array to a multi level table.

As the format becomes platform dependend, this replaces the direct access
to it_usespace with a iommu_table_ops::useraddrptr hook which returns
a pointer to the userspace copy of a TCE; future extension will return
NULL if the level was not allocated.

This should not change non-KVM handling of TCE tables and it_userspace
will not be allocated for non-KVM tables.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h              |  6 +--
 arch/powerpc/platforms/powernv/pci.h          |  3 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c           |  8 ----
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 65 +++++++++++++++++++++------
 arch/powerpc/platforms/powernv/pci-ioda.c     | 31 ++++++++++---
 drivers/vfio/vfio_iommu_spapr_tce.c           | 46 -------------------
 6 files changed, 81 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 803ac70..4bdcf22 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -69,6 +69,8 @@ struct iommu_table_ops {
 			long index,
 			unsigned long *hpa,
 			enum dma_data_direction *direction);
+
+	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index);
 #endif
 	void (*clear)(struct iommu_table *tbl,
 			long index, long npages);
@@ -123,9 +125,7 @@ struct iommu_table {
 };
 
 #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
-		((tbl)->it_userspace ? \
-			&((tbl)->it_userspace[(entry) - (tbl)->it_offset]) : \
-			NULL)
+		((tbl)->it_ops->useraddrptr((tbl), (entry)))
 
 /* Pure 2^n version of get_order */
 static inline __attribute_const__
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index f507baf..5e02408 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -268,11 +268,12 @@ extern int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 extern void pnv_tce_free(struct iommu_table *tbl, long index, long npages);
 extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
 		unsigned long *hpa, enum dma_data_direction *direction);
+extern __be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index);
 extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
 
 extern long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 		__u32 page_shift, __u64 window_size, __u32 levels,
-		struct iommu_table *tbl);
+		bool alloc_userspace_copy, struct iommu_table *tbl);
 extern void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
 
 extern long pnv_pci_link_table_and_group(int node, int num,
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 18109f3..db0490c 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -206,10 +206,6 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
 		/* it_userspace allocation might be delayed */
 		return H_TOO_HARD;
 
-	pua = (void *) vmalloc_to_phys(pua);
-	if (WARN_ON_ONCE_RM(!pua))
-		return H_HARDWARE;
-
 	mem = mm_iommu_lookup_rm(kvm->mm, be64_to_cpu(*pua), pgsize);
 	if (!mem)
 		return H_TOO_HARD;
@@ -282,10 +278,6 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
 	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
 		return H_HARDWARE;
 
-	pua = (void *) vmalloc_to_phys(pua);
-	if (WARN_ON_ONCE_RM(!pua))
-		return H_HARDWARE;
-
 	if (WARN_ON_ONCE_RM(mm_iommu_mapped_inc(mem)))
 		return H_CLOSED;
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index 700ceb1..f14b282 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -31,9 +31,9 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 	tbl->it_type = TCE_PCI;
 }
 
-static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
+static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx)
 {
-	__be64 *tmp = ((__be64 *)tbl->it_base);
+	__be64 *tmp = user ? tbl->it_userspace : (__be64 *) tbl->it_base;
 	int  level = tbl->it_indirect_levels;
 	const long shift = ilog2(tbl->it_level_size);
 	unsigned long mask = (tbl->it_level_size - 1) << (level * shift);
@@ -67,7 +67,7 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
 			((rpn + i) << tbl->it_page_shift);
 		unsigned long idx = index - tbl->it_offset + i;
 
-		*(pnv_tce(tbl, idx)) = cpu_to_be64(newtce);
+		*(pnv_tce(tbl, false, idx)) = cpu_to_be64(newtce);
 	}
 
 	return 0;
@@ -86,12 +86,21 @@ int pnv_tce_xchg(struct iommu_table *tbl, long index,
 	if (newtce & TCE_PCI_WRITE)
 		newtce |= TCE_PCI_READ;
 
-	oldtce = be64_to_cpu(xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce)));
+	oldtce = be64_to_cpu(xchg(pnv_tce(tbl, false, idx),
+				  cpu_to_be64(newtce)));
 	*hpa = oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
 	*direction = iommu_tce_direction(oldtce);
 
 	return 0;
 }
+
+__be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index)
+{
+	if (WARN_ON_ONCE(!tbl->it_userspace))
+		return NULL;
+
+	return pnv_tce(tbl, true, index - tbl->it_offset);
+}
 #endif
 
 void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
@@ -101,13 +110,15 @@ void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
 	for (i = 0; i < npages; i++) {
 		unsigned long idx = index - tbl->it_offset + i;
 
-		*(pnv_tce(tbl, idx)) = cpu_to_be64(0);
+		*(pnv_tce(tbl, false, idx)) = cpu_to_be64(0);
 	}
 }
 
 unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
 {
-	return be64_to_cpu(*(pnv_tce(tbl, index - tbl->it_offset)));
+	__be64 *ptce = pnv_tce(tbl, false, index - tbl->it_offset);
+
+	return be64_to_cpu(*ptce);
 }
 
 static void pnv_pci_ioda2_table_do_free_pages(__be64 *addr,
@@ -144,6 +155,10 @@ void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
 
 	pnv_pci_ioda2_table_do_free_pages((__be64 *)tbl->it_base, size,
 			tbl->it_indirect_levels);
+	if (tbl->it_userspace) {
+		pnv_pci_ioda2_table_do_free_pages(tbl->it_userspace, size,
+				tbl->it_indirect_levels);
+	}
 }
 
 static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned int shift,
@@ -191,10 +206,11 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned int shift,
 
 long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 		__u32 page_shift, __u64 window_size, __u32 levels,
-		struct iommu_table *tbl)
+		bool alloc_userspace_copy, struct iommu_table *tbl)
 {
-	void *addr;
+	void *addr, *uas = NULL;
 	unsigned long offset = 0, level_shift, total_allocated = 0;
+	unsigned long total_allocated_uas = 0;
 	const unsigned int window_shift = ilog2(window_size);
 	unsigned int entries_shift = window_shift - page_shift;
 	unsigned int table_shift = max_t(unsigned int, entries_shift + 3,
@@ -228,10 +244,20 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	 * we did not allocate as much as we wanted,
 	 * release partially allocated table.
 	 */
-	if (offset < tce_table_size) {
-		pnv_pci_ioda2_table_do_free_pages(addr,
-				1ULL << (level_shift - 3), levels - 1);
-		return -ENOMEM;
+	if (offset < tce_table_size)
+		goto free_tces_exit;
+
+	/* Allocate userspace view of the TCE table */
+	if (alloc_userspace_copy) {
+		offset = 0;
+		uas = pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
+				levels, tce_table_size, &offset,
+				&total_allocated_uas);
+		if (!uas)
+			goto free_tces_exit;
+		if (offset < tce_table_size ||
+				total_allocated_uas != total_allocated)
+			goto free_uas_exit;
 	}
 
 	/* Setup linux iommu table */
@@ -240,11 +266,22 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	tbl->it_level_size = 1ULL << (level_shift - 3);
 	tbl->it_indirect_levels = levels - 1;
 	tbl->it_allocated_size = total_allocated;
+	tbl->it_userspace = uas;
 
-	pr_devel("Created TCE table: ws=%08llx ts=%lx @%08llx\n",
-			window_size, tce_table_size, bus_offset);
+	pr_debug("Created TCE table: ws=%08llx ts=%lx @%08llx base=%lx uas=%p levels=%d\n",
+			window_size, tce_table_size, bus_offset, tbl->it_base,
+			tbl->it_userspace, levels);
 
 	return 0;
+
+free_uas_exit:
+	pnv_pci_ioda2_table_do_free_pages(uas,
+			1ULL << (level_shift - 3), levels - 1);
+free_tces_exit:
+	pnv_pci_ioda2_table_do_free_pages(addr,
+			1ULL << (level_shift - 3), levels - 1);
+
+	return -ENOMEM;
 }
 
 static void pnv_iommu_table_group_link_free(struct rcu_head *head)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9577059..c61c04d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2043,6 +2043,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 #ifdef CONFIG_IOMMU_API
 	.exchange = pnv_ioda1_tce_xchg,
 	.exchange_rm = pnv_ioda1_tce_xchg_rm,
+	.useraddrptr = pnv_tce_useraddrptr,
 #endif
 	.clear = pnv_ioda1_tce_free,
 	.get = pnv_tce_get,
@@ -2207,6 +2208,7 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
 #ifdef CONFIG_IOMMU_API
 	.exchange = pnv_ioda2_tce_xchg,
 	.exchange_rm = pnv_ioda2_tce_xchg_rm,
+	.useraddrptr = pnv_tce_useraddrptr,
 #endif
 	.clear = pnv_ioda2_tce_free,
 	.get = pnv_tce_get,
@@ -2460,9 +2462,9 @@ void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 		pe->tce_bypass_enabled = enable;
 }
 
-static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
+static long pnv_pci_ioda2_do_create_table(struct iommu_table_group *table_group,
 		int num, __u32 page_shift, __u64 window_size, __u32 levels,
-		struct iommu_table **ptbl)
+		bool alloc_userspace_copy, struct iommu_table **ptbl)
 {
 	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
 			table_group);
@@ -2479,7 +2481,7 @@ static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
 
 	ret = pnv_pci_ioda2_table_alloc_pages(nid,
 			bus_offset, page_shift, window_size,
-			levels, tbl);
+			levels, alloc_userspace_copy, tbl);
 	if (ret) {
 		iommu_tce_table_put(tbl);
 		return ret;
@@ -2599,7 +2601,24 @@ static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 				tce_table_size, direct_table_size);
 	}
 
-	return bytes;
+	return bytes + bytes; /* one for HW table, one for userspace copy */
+}
+
+static long pnv_pci_ioda2_create_table(struct iommu_table_group *table_group,
+		int num, __u32 page_shift, __u64 window_size, __u32 levels,
+		struct iommu_table **ptbl)
+{
+	return pnv_pci_ioda2_do_create_table(table_group,
+			num, page_shift, window_size, levels, false, ptbl);
+}
+
+static long pnv_pci_ioda2_create_table_userspace(
+		struct iommu_table_group *table_group,
+		int num, __u32 page_shift, __u64 window_size, __u32 levels,
+		struct iommu_table **ptbl)
+{
+	return pnv_pci_ioda2_do_create_table(table_group,
+			num, page_shift, window_size, levels, true, ptbl);
 }
 
 static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
@@ -2628,7 +2647,7 @@ static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
 
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 	.get_table_size = pnv_pci_ioda2_get_table_size,
-	.create_table = pnv_pci_ioda2_create_table,
+	.create_table = pnv_pci_ioda2_create_table_userspace,
 	.set_window = pnv_pci_ioda2_set_window,
 	.unset_window = pnv_pci_ioda2_unset_window,
 	.take_ownership = pnv_ioda2_take_ownership,
@@ -2733,7 +2752,7 @@ static void pnv_ioda2_npu_take_ownership(struct iommu_table_group *table_group)
 
 static struct iommu_table_group_ops pnv_pci_ioda2_npu_ops = {
 	.get_table_size = pnv_pci_ioda2_get_table_size,
-	.create_table = pnv_pci_ioda2_create_table,
+	.create_table = pnv_pci_ioda2_create_table_userspace,
 	.set_window = pnv_pci_ioda2_npu_set_window,
 	.unset_window = pnv_pci_ioda2_npu_unset_window,
 	.take_ownership = pnv_ioda2_npu_take_ownership,
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 81f48114..628a948 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -212,44 +212,6 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	return 0;
 }
 
-static long tce_iommu_userspace_view_alloc(struct iommu_table *tbl,
-		struct mm_struct *mm)
-{
-	unsigned long cb = _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
-			tbl->it_size, PAGE_SIZE);
-	unsigned long *uas;
-	long ret;
-
-	BUG_ON(tbl->it_userspace);
-
-	ret = try_increment_locked_vm(mm, cb >> PAGE_SHIFT);
-	if (ret)
-		return ret;
-
-	uas = vzalloc(cb);
-	if (!uas) {
-		decrement_locked_vm(mm, cb >> PAGE_SHIFT);
-		return -ENOMEM;
-	}
-	tbl->it_userspace = (__be64 *) uas;
-
-	return 0;
-}
-
-static void tce_iommu_userspace_view_free(struct iommu_table *tbl,
-		struct mm_struct *mm)
-{
-	unsigned long cb = _ALIGN_UP(sizeof(tbl->it_userspace[0]) *
-			tbl->it_size, PAGE_SIZE);
-
-	if (!tbl->it_userspace)
-		return;
-
-	vfree(tbl->it_userspace);
-	tbl->it_userspace = NULL;
-	decrement_locked_vm(mm, cb >> PAGE_SHIFT);
-}
-
 static bool tce_page_is_contained(unsigned long hpa, unsigned page_shift)
 {
 	struct page *page = __va(realmode_pfn_to_page(hpa >> PAGE_SHIFT));
@@ -608,12 +570,6 @@ static long tce_iommu_build_v2(struct tce_container *container,
 	unsigned long hpa;
 	enum dma_data_direction dirtmp;
 
-	if (!tbl->it_userspace) {
-		ret = tce_iommu_userspace_view_alloc(tbl, container->mm);
-		if (ret)
-			return ret;
-	}
-
 	for (i = 0; i < pages; ++i) {
 		struct mm_iommu_table_group_mem_t *mem = NULL;
 		__be64 *pua = IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry + i);
@@ -693,7 +649,6 @@ static void tce_iommu_free_table(struct tce_container *container,
 {
 	unsigned long pages = tbl->it_allocated_size >> PAGE_SHIFT;
 
-	tce_iommu_userspace_view_free(tbl, container->mm);
 	iommu_tce_table_put(tbl);
 	decrement_locked_vm(container->mm, pages);
 }
@@ -1208,7 +1163,6 @@ static void tce_iommu_release_ownership(struct tce_container *container,
 			continue;
 
 		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
-		tce_iommu_userspace_view_free(tbl, container->mm);
 		if (tbl->it_map)
 			iommu_release_ownership(tbl);
 
-- 
2.11.0
