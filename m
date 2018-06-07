Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 411fH450KkzF31q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 18:44:32 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ram Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
Subject: [RFC PATCH kernel 2/5] powerpc/iommu_context: Change referencing in
 API
Date: Thu,  7 Jun 2018 18:44:17 +1000
Message-Id: <20180607084420.29513-3-aik@ozlabs.ru>
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

At the moment a single function - mm_iommu_get() - allocates a new region
or just references it if it is already registered with the current MM
context.

We are going to allow API to be used for memory devices and different
variant of mm_iommu_get() will be needed so let's move referencing
part to where it belongs - mm_iommu_find().

This turns mm_iommu_get() into a wrapper as the actual function will
be extended later and renames it to mm_iommu_new() to illustrate
the change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/mmu_context.h |  2 +-
 arch/powerpc/mm/mmu_context_iommu.c    | 19 +++++++++++++++----
 drivers/vfio/vfio_iommu_spapr_tce.c    | 21 +++++++++++----------
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 1835ca1..b598ec4 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -21,7 +21,7 @@ struct mm_iommu_table_group_mem_t;
 
 extern int isolate_lru_page(struct page *page);	/* from internal.h */
 extern bool mm_iommu_preregistered(struct mm_struct *mm);
-extern long mm_iommu_get(struct mm_struct *mm,
+extern long mm_iommu_new(struct mm_struct *mm,
 		unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem);
 extern long mm_iommu_put(struct mm_struct *mm,
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 4c615fc..6b471d2 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -120,7 +120,8 @@ static int mm_iommu_move_page_from_cma(struct page *page)
 	return 0;
 }
 
-long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
+static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
+		unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
@@ -132,8 +133,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
 			next) {
 		if ((mem->ua == ua) && (mem->entries == entries)) {
-			++mem->used;
-			*pmem = mem;
+			ret = -EBUSY;
 			goto unlock_exit;
 		}
 
@@ -218,7 +218,13 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mm_iommu_get);
+
+long mm_iommu_new(struct mm_struct *mm, unsigned long ua, unsigned long entries,
+		struct mm_iommu_table_group_mem_t **pmem)
+{
+	return mm_iommu_do_alloc(mm, ua, entries, pmem);
+}
+EXPORT_SYMBOL_GPL(mm_iommu_new);
 
 static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
 {
@@ -337,13 +343,18 @@ struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
 {
 	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
 
+	mutex_lock(&mem_list_mutex);
+
 	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
 		if ((mem->ua == ua) && (mem->entries == entries)) {
 			ret = mem;
+			++mem->used;
 			break;
 		}
 	}
 
+	mutex_unlock(&mem_list_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mm_iommu_find);
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 2c4a048..7f1effd 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -149,9 +149,9 @@ static long tce_iommu_prereg_free(struct tce_container *container,
 static long tce_iommu_unregister_pages(struct tce_container *container,
 		__u64 vaddr, __u64 size)
 {
+	long ret = -ENOENT;
 	struct mm_iommu_table_group_mem_t *mem;
 	struct tce_iommu_prereg *tcemem;
-	bool found = false;
 
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
 		return -EINVAL;
@@ -162,15 +162,14 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 
 	list_for_each_entry(tcemem, &container->prereg_list, next) {
 		if (tcemem->mem == mem) {
-			found = true;
+			ret = tce_iommu_prereg_free(container, tcemem);
 			break;
 		}
 	}
 
-	if (!found)
-		return -ENOENT;
+	mm_iommu_put(container->mm, mem);
 
-	return tce_iommu_prereg_free(container, tcemem);
+	return ret;
 }
 
 static long tce_iommu_register_pages(struct tce_container *container,
@@ -188,15 +187,17 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	mem = mm_iommu_find(container->mm, vaddr, entries);
 	if (mem) {
 		list_for_each_entry(tcemem, &container->prereg_list, next) {
-			if (tcemem->mem == mem)
+			if (tcemem->mem == mem) {
+				mm_iommu_put(container->mm, mem);
 				return -EBUSY;
+			}
 		}
+	} else {
+		ret = mm_iommu_new(container->mm, vaddr, entries, &mem);
+		if (ret)
+			return ret;
 	}
 
-	ret = mm_iommu_get(container->mm, vaddr, entries, &mem);
-	if (ret)
-		return ret;
-
 	tcemem = kzalloc(sizeof(*tcemem), GFP_KERNEL);
 	if (!tcemem) {
 		mm_iommu_put(container->mm, mem);
-- 
2.11.0
