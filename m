Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 411fH71zG0zF31q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 18:44:35 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ram Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
Subject: [RFC PATCH kernel 3/5] powerpc/iommu: Do not pin memory of a memory
 device
Date: Thu,  7 Jun 2018 18:44:18 +1000
Message-Id: <20180607084420.29513-4-aik@ozlabs.ru>
In-Reply-To: <20180607084420.29513-1-aik@ozlabs.ru>
References: <20180607084420.29513-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This new memory does not have page structs as it is not hotplugged to
the host so gup() will fail anyway.

This registers a new mapping in memory context so the user of this
API does not have to worry about the nature of this memory.

Also, since host addresses may not be backed with page structs, this
adds a workaround to iommu_tce_xchg() to avoid putting absent page structs.
realmode_pfn_to_page() is used there as, unline its virtmode counterpart,
it actually walks through the list of vmemmap_backing.

The same is used in tce_page_is_contained() to drop the check for now.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

# Conflicts:
#	arch/powerpc/mm/mmu_context_iommu.c
---
 arch/powerpc/include/asm/mmu_context.h |  3 ++
 arch/powerpc/kernel/iommu.c            |  8 +++--
 arch/powerpc/mm/mmu_context_iommu.c    | 55 +++++++++++++++++++++++++++-------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 12 +++++++-
 4 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b598ec4..0c14495 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -24,6 +24,9 @@ extern bool mm_iommu_preregistered(struct mm_struct *mm);
 extern long mm_iommu_new(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem);
+extern long mm_iommu_newdev(struct mm_struct *mm, unsigned long ua,
+		unsigned long entries, unsigned long dev_hpa,
+		struct mm_iommu_table_group_mem_t **pmem);
 extern long mm_iommu_put(struct mm_struct *mm,
 		struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_init(struct mm_struct *mm);
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index af7a20d..fc985a5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1001,8 +1001,12 @@ long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
 	ret = tbl->it_ops->exchange(tbl, entry, hpa, direction);
 
 	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
-			(*direction == DMA_BIDIRECTIONAL)))
-		SetPageDirty(pfn_to_page(*hpa >> PAGE_SHIFT));
+			(*direction == DMA_BIDIRECTIONAL))) {
+		struct page *pg = __va(realmode_pfn_to_page(*hpa >> PAGE_SHIFT));
+
+		if (pg)
+			SetPageDirty(pg);
+	}
 
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 6b471d2..b132924 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -30,6 +30,8 @@ struct mm_iommu_table_group_mem_t {
 	u64 ua;			/* userspace address */
 	u64 entries;		/* number of entries in hpas[] */
 	u64 *hpas;		/* vmalloc'ed */
+#define MM_IOMMU_TABLE_INVALID_HPA	((uint64_t)-1)
+	u64 dev_hpa;		/* Device memory base address */
 };
 
 static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
@@ -121,7 +123,7 @@ static int mm_iommu_move_page_from_cma(struct page *page)
 }
 
 static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
-		unsigned long entries,
+		unsigned long entries, unsigned long dev_hpa,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
@@ -147,11 +149,13 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 
 	}
 
-	ret = mm_iommu_adjust_locked_vm(mm, entries, true);
-	if (ret)
-		goto unlock_exit;
+	if (dev_hpa == MM_IOMMU_TABLE_INVALID_HPA) {
+		ret = mm_iommu_adjust_locked_vm(mm, entries, true);
+		if (ret)
+			goto unlock_exit;
 
-	locked_entries = entries;
+		locked_entries = entries;
+	}
 
 	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 	if (!mem) {
@@ -159,6 +163,11 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 		goto unlock_exit;
 	}
 
+	if (dev_hpa != MM_IOMMU_TABLE_INVALID_HPA) {
+		mem->dev_hpa = dev_hpa;
+		goto good_exit;
+	}
+
 	mem->hpas = vzalloc(entries * sizeof(mem->hpas[0]));
 	if (!mem->hpas) {
 		kfree(mem);
@@ -202,6 +211,7 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
 	}
 
+good_exit:
 	atomic64_set(&mem->mapped, 1);
 	mem->used = 1;
 	mem->ua = ua;
@@ -222,15 +232,27 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
-	return mm_iommu_do_alloc(mm, ua, entries, pmem);
+	return mm_iommu_do_alloc(mm, ua, entries, MM_IOMMU_TABLE_INVALID_HPA,
+			pmem);
 }
 EXPORT_SYMBOL_GPL(mm_iommu_new);
 
+long mm_iommu_newdev(struct mm_struct *mm, unsigned long ua,
+		unsigned long entries, unsigned long dev_hpa,
+		struct mm_iommu_table_group_mem_t **pmem)
+{
+	return mm_iommu_do_alloc(mm, ua, entries, dev_hpa, pmem);
+}
+EXPORT_SYMBOL_GPL(mm_iommu_newdev);
+
 static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
 {
 	long i;
 	struct page *page = NULL;
 
+	if (!mem->hpas)
+		return;
+
 	for (i = 0; i < mem->entries; ++i) {
 		if (!mem->hpas[i])
 			continue;
@@ -269,6 +291,7 @@ static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
 long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 {
 	long ret = 0;
+	unsigned long entries;
 
 	mutex_lock(&mem_list_mutex);
 
@@ -290,9 +313,11 @@ long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 	}
 
 	/* @mapped became 0 so now mappings are disabled, release the region */
+	entries = mem->entries;
 	mm_iommu_release(mem);
 
-	mm_iommu_adjust_locked_vm(mm, mem->entries, false);
+	if (mem->dev_hpa != MM_IOMMU_TABLE_INVALID_HPA)
+		mm_iommu_adjust_locked_vm(mm, entries, false);
 
 unlock_exit:
 	mutex_unlock(&mem_list_mutex);
@@ -363,11 +388,17 @@ long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned long *hpa)
 {
 	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
-	u64 *va = &mem->hpas[entry];
+	u64 *va;
 
 	if (entry >= mem->entries)
 		return -EFAULT;
 
+	if (!mem->hpas) {
+		*hpa = mem->dev_hpa + (ua - mem->ua);
+		return 0;
+	}
+
+	va = &mem->hpas[entry];
 	*hpa = *va | (ua & ~PAGE_MASK);
 
 	return 0;
@@ -378,13 +409,17 @@ long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned long *hpa)
 {
 	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
-	void *va = &mem->hpas[entry];
 	unsigned long *pa;
 
 	if (entry >= mem->entries)
 		return -EFAULT;
 
-	pa = (void *) vmalloc_to_phys(va);
+	if (!mem->hpas) {
+		*hpa = mem->dev_hpa + (ua - mem->ua);
+		return 0;
+	}
+
+	pa = (void *) vmalloc_to_phys(&mem->hpas[entry]);
 	if (!pa)
 		return -EFAULT;
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 7f1effd..47071f3 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -252,7 +252,17 @@ static void tce_iommu_userspace_view_free(struct iommu_table *tbl,
 
 static bool tce_page_is_contained(unsigned long hpa, unsigned page_shift)
 {
-	struct page *page = pfn_to_page(hpa >> PAGE_SHIFT);
+	struct page *page = __va(realmode_pfn_to_page(hpa >> PAGE_SHIFT));
+
+	/*
+	 * If there not page, we assume it is a device memory and therefore
+	 * it is contigous and always pinned.
+	 *
+	 * TODO: test device boundaries?
+	 */
+	if (!page)
+		return true;
+
 	/*
 	 * Check that the TCE table granularity is not bigger than the size of
 	 * a page we just found. Otherwise the hardware can get access to
-- 
2.11.0
