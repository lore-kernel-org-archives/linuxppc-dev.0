Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t2Rnm4vHpzDvfM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 17:53:32 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel v4 4/4] powerpc/mm/iommu,
 vfio/spapr: Put pages on VFIO container shutdown
Date: Mon, 24 Oct 2016 17:53:10 +1100
Message-Id: <1477291990-2872-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the userspace tool is expected to request pinning of
the entire guest RAM when VFIO IOMMU SPAPR v2 driver is present.
When the userspace process finishes, all the pinned pages need to
be put; this is done as a part of the userspace memory context (MM)
destruction which happens on the very last mmdrop().

This approach has a problem that a MM of the userspace process
may live longer than the userspace process itself as kernel threads
use userspace process MMs which was runnning on a CPU where
the kernel thread was scheduled to. If this happened, the MM remains
referenced until this exact kernel thread wakes up again
and releases the very last reference to the MM, on an idle system this
can take even hours.

This moves preregistered regions tracking from MM to VFIO; insteads of
using mm_iommu_table_group_mem_t::used, tce_container::prereg_list is
added so each container releases regions which it has pre-registered.

This changes the userspace interface to return EBUSY if a memory
region is already registered in a container. However it should not
have any practical effect as the only userspace tool available now
does register memory region once per container anyway.

As tce_iommu_register_pages/tce_iommu_unregister_pages are called
under container->lock, this does not need additional locking.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes:
v4:
* changed tce_iommu_register_pages() to call mm_iommu_find() first and
avoid calling mm_iommu_put() if memory is preregistered already

v3:
* moved tce_iommu_prereg_free() call out of list_for_each_entry()

v2:
* updated commit log
---
 arch/powerpc/mm/mmu_context_book3s64.c |  4 ---
 arch/powerpc/mm/mmu_context_iommu.c    | 11 -------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 58 +++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index ad82735..1a07969 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -159,10 +159,6 @@ static inline void destroy_pagetable_page(struct mm_struct *mm)
 
 void destroy_context(struct mm_struct *mm)
 {
-#ifdef CONFIG_SPAPR_TCE_IOMMU
-	mm_iommu_cleanup(mm);
-#endif
-
 #ifdef CONFIG_PPC_ICSWX
 	drop_cop(mm->context.acop, mm);
 	kfree(mm->context.cop_lockp);
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index 4c6db09..104bad0 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -365,14 +365,3 @@ void mm_iommu_init(struct mm_struct *mm)
 {
 	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
 }
-
-void mm_iommu_cleanup(struct mm_struct *mm)
-{
-	struct mm_iommu_table_group_mem_t *mem, *tmp;
-
-	list_for_each_entry_safe(mem, tmp, &mm->context.iommu_group_mem_list,
-			next) {
-		list_del_rcu(&mem->next);
-		mm_iommu_do_free(mem);
-	}
-}
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 81ab93f..001a488 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -86,6 +86,15 @@ struct tce_iommu_group {
 };
 
 /*
+ * A container needs to remember which preregistered region  it has
+ * referenced to do proper cleanup at the userspace process exit.
+ */
+struct tce_iommu_prereg {
+	struct list_head next;
+	struct mm_iommu_table_group_mem_t *mem;
+};
+
+/*
  * The container descriptor supports only a single group per container.
  * Required by the API as the container is not supplied with the IOMMU group
  * at the moment of initialization.
@@ -98,12 +107,27 @@ struct tce_container {
 	struct mm_struct *mm;
 	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
 	struct list_head group_list;
+	struct list_head prereg_list;
 };
 
+static long tce_iommu_prereg_free(struct tce_container *container,
+		struct tce_iommu_prereg *tcemem)
+{
+	long ret;
+
+	list_del(&tcemem->next);
+	ret = mm_iommu_put(container->mm, tcemem->mem);
+	kfree(tcemem);
+
+	return ret;
+}
+
 static long tce_iommu_unregister_pages(struct tce_container *container,
 		__u64 vaddr, __u64 size)
 {
 	struct mm_iommu_table_group_mem_t *mem;
+	struct tce_iommu_prereg *tcemem;
+	bool found = false;
 
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
 		return -EINVAL;
@@ -112,7 +136,17 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 	if (!mem)
 		return -ENOENT;
 
-	return mm_iommu_put(container->mm, mem);
+	list_for_each_entry(tcemem, &container->prereg_list, next) {
+		if (tcemem->mem == mem) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -ENOENT;
+
+	return tce_iommu_prereg_free(container, tcemem);
 }
 
 static long tce_iommu_register_pages(struct tce_container *container,
@@ -120,16 +154,29 @@ static long tce_iommu_register_pages(struct tce_container *container,
 {
 	long ret = 0;
 	struct mm_iommu_table_group_mem_t *mem = NULL;
+	struct tce_iommu_prereg *tcemem;
 	unsigned long entries = size >> PAGE_SHIFT;
 
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
 			((vaddr + size) < vaddr))
 		return -EINVAL;
 
+	mem = mm_iommu_find(container->mm, vaddr, entries);
+	if (mem) {
+		list_for_each_entry(tcemem, &container->prereg_list, next) {
+			if (tcemem->mem == mem)
+				return -EBUSY;
+		}
+	}
+
 	ret = mm_iommu_get(container->mm, vaddr, entries, &mem);
 	if (ret)
 		return ret;
 
+	tcemem = kzalloc(sizeof(*tcemem), GFP_KERNEL);
+	tcemem->mem = mem;
+	list_add(&tcemem->next, &container->prereg_list);
+
 	container->enabled = true;
 
 	return 0;
@@ -311,6 +358,7 @@ static void *tce_iommu_open(unsigned long arg)
 
 	mutex_init(&container->lock);
 	INIT_LIST_HEAD_RCU(&container->group_list);
+	INIT_LIST_HEAD_RCU(&container->prereg_list);
 
 	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
 
@@ -353,6 +401,14 @@ static void tce_iommu_release(void *iommu_data)
 		tce_iommu_free_table(container, tbl);
 	}
 
+	while (!list_empty(&container->prereg_list)) {
+		struct tce_iommu_prereg *tcemem;
+
+		tcemem = list_first_entry(&container->prereg_list,
+				struct tce_iommu_prereg, next);
+		tce_iommu_prereg_free(container, tcemem);
+	}
+
 	tce_iommu_disable(container);
 	mmdrop(container->mm);
 	mutex_destroy(&container->lock);
-- 
2.5.0.rc3
