Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tFfT91WJwzDvnV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 23:33:01 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: [PATCH kernel v5 2/6] powerpc/iommu: Stop using @current in
 mm_iommu_xxx
Date: Fri, 11 Nov 2016 23:32:13 +1100
Message-Id: <1478867537-27893-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This changes mm_iommu_xxx helpers to take mm_struct as a parameter
instead of getting it from @current which in some situations may
not have a valid reference to mm.

This changes helpers to receive @mm and moves all references to @current
to the caller, including checks for !current and !current->mm;
checks in mm_iommu_preregistered() are removed as there is no caller
yet.

This moves the mm_iommu_adjust_locked_vm() call to the caller as
it receives mm_iommu_table_group_mem_t but it needs mm.

This should cause no behavioral change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/mmu_context.h | 16 ++++++------
 arch/powerpc/mm/mmu_context_iommu.c    | 46 +++++++++++++---------------------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 14 ++++++++---
 3 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 424844b..b9e3f0a 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -19,16 +19,18 @@ extern void destroy_context(struct mm_struct *mm);
 struct mm_iommu_table_group_mem_t;
 
 extern int isolate_lru_page(struct page *page);	/* from internal.h */
-extern bool mm_iommu_preregistered(void);
-extern long mm_iommu_get(unsigned long ua, unsigned long entries,
+extern bool mm_iommu_preregistered(struct mm_struct *mm);
+extern long mm_iommu_get(struct mm_struct *mm,
+		unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem);
-extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
+extern long mm_iommu_put(struct mm_struct *mm,
+		struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_init(struct mm_struct *mm);
 extern void mm_iommu_cleanup(struct mm_struct *mm);
-extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
-		unsigned long size);
-extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
-		unsigned long entries);
+extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
+		unsigned long ua, unsigned long size);
+extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
+		unsigned long ua, unsigned long entries);
 extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
 		unsigned long ua, unsigned long *hpa);
 extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index ad2e575..4c6db09 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -56,7 +56,7 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
 	}
 
 	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
-			current->pid,
+			current ? current->pid : 0,
 			incr ? '+' : '-',
 			npages << PAGE_SHIFT,
 			mm->locked_vm << PAGE_SHIFT,
@@ -66,12 +66,9 @@ static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
 	return ret;
 }
 
-bool mm_iommu_preregistered(void)
+bool mm_iommu_preregistered(struct mm_struct *mm)
 {
-	if (!current || !current->mm)
-		return false;
-
-	return !list_empty(&current->mm->context.iommu_group_mem_list);
+	return !list_empty(&mm->context.iommu_group_mem_list);
 }
 EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
 
@@ -124,19 +121,16 @@ static int mm_iommu_move_page_from_cma(struct page *page)
 	return 0;
 }
 
-long mm_iommu_get(unsigned long ua, unsigned long entries,
+long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
 		struct mm_iommu_table_group_mem_t **pmem)
 {
 	struct mm_iommu_table_group_mem_t *mem;
 	long i, j, ret = 0, locked_entries = 0;
 	struct page *page = NULL;
 
-	if (!current || !current->mm)
-		return -ESRCH; /* process exited */
-
 	mutex_lock(&mem_list_mutex);
 
-	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
+	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
 			next) {
 		if ((mem->ua == ua) && (mem->entries == entries)) {
 			++mem->used;
@@ -154,7 +148,7 @@ long mm_iommu_get(unsigned long ua, unsigned long entries,
 
 	}
 
-	ret = mm_iommu_adjust_locked_vm(current->mm, entries, true);
+	ret = mm_iommu_adjust_locked_vm(mm, entries, true);
 	if (ret)
 		goto unlock_exit;
 
@@ -215,11 +209,11 @@ long mm_iommu_get(unsigned long ua, unsigned long entries,
 	mem->entries = entries;
 	*pmem = mem;
 
-	list_add_rcu(&mem->next, &current->mm->context.iommu_group_mem_list);
+	list_add_rcu(&mem->next, &mm->context.iommu_group_mem_list);
 
 unlock_exit:
 	if (locked_entries && ret)
-		mm_iommu_adjust_locked_vm(current->mm, locked_entries, false);
+		mm_iommu_adjust_locked_vm(mm, locked_entries, false);
 
 	mutex_unlock(&mem_list_mutex);
 
@@ -264,17 +258,13 @@ static void mm_iommu_free(struct rcu_head *head)
 static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
 {
 	list_del_rcu(&mem->next);
-	mm_iommu_adjust_locked_vm(current->mm, mem->entries, false);
 	call_rcu(&mem->rcu, mm_iommu_free);
 }
 
-long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
+long mm_iommu_put(struct mm_struct *mm, struct mm_iommu_table_group_mem_t *mem)
 {
 	long ret = 0;
 
-	if (!current || !current->mm)
-		return -ESRCH; /* process exited */
-
 	mutex_lock(&mem_list_mutex);
 
 	if (mem->used == 0) {
@@ -297,6 +287,8 @@ long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
 	/* @mapped became 0 so now mappings are disabled, release the region */
 	mm_iommu_release(mem);
 
+	mm_iommu_adjust_locked_vm(mm, mem->entries, false);
+
 unlock_exit:
 	mutex_unlock(&mem_list_mutex);
 
@@ -304,14 +296,12 @@ long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
 }
 EXPORT_SYMBOL_GPL(mm_iommu_put);
 
-struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
-		unsigned long size)
+struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
+		unsigned long ua, unsigned long size)
 {
 	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
 
-	list_for_each_entry_rcu(mem,
-			&current->mm->context.iommu_group_mem_list,
-			next) {
+	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
 		if ((mem->ua <= ua) &&
 				(ua + size <= mem->ua +
 				 (mem->entries << PAGE_SHIFT))) {
@@ -324,14 +314,12 @@ struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
 }
 EXPORT_SYMBOL_GPL(mm_iommu_lookup);
 
-struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
-		unsigned long entries)
+struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
+		unsigned long ua, unsigned long entries)
 {
 	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
 
-	list_for_each_entry_rcu(mem,
-			&current->mm->context.iommu_group_mem_list,
-			next) {
+	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list, next) {
 		if ((mem->ua == ua) && (mem->entries == entries)) {
 			ret = mem;
 			break;
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 80378dd..d0c38b2 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -107,14 +107,17 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 {
 	struct mm_iommu_table_group_mem_t *mem;
 
+	if (!current || !current->mm)
+		return -ESRCH; /* process exited */
+
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
 		return -EINVAL;
 
-	mem = mm_iommu_find(vaddr, size >> PAGE_SHIFT);
+	mem = mm_iommu_find(current->mm, vaddr, size >> PAGE_SHIFT);
 	if (!mem)
 		return -ENOENT;
 
-	return mm_iommu_put(mem);
+	return mm_iommu_put(current->mm, mem);
 }
 
 static long tce_iommu_register_pages(struct tce_container *container,
@@ -124,11 +127,14 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	struct mm_iommu_table_group_mem_t *mem = NULL;
 	unsigned long entries = size >> PAGE_SHIFT;
 
+	if (!current || !current->mm)
+		return -ESRCH; /* process exited */
+
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
 			((vaddr + size) < vaddr))
 		return -EINVAL;
 
-	ret = mm_iommu_get(vaddr, entries, &mem);
+	ret = mm_iommu_get(current->mm, vaddr, entries, &mem);
 	if (ret)
 		return ret;
 
@@ -375,7 +381,7 @@ static int tce_iommu_prereg_ua_to_hpa(unsigned long tce, unsigned long size,
 	long ret = 0;
 	struct mm_iommu_table_group_mem_t *mem;
 
-	mem = mm_iommu_lookup(tce, size);
+	mem = mm_iommu_lookup(current->mm, tce, size);
 	if (!mem)
 		return -EINVAL;
 
-- 
2.5.0.rc3
