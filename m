Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s463y4NBnzDqTV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:18 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 06/15] powerpc/mm/iommu: Put pages on process exit
Date: Wed,  3 Aug 2016 18:40:47 +1000
Message-Id: <1470213656-1042-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment VFIO IOMMU SPAPR v2 driver pins all guest RAM pages when
the userspace starts using VFIO. When the userspace process finishes,
all the pinned pages need to be put; this is done as a part of
the userspace memory context (MM) destruction which happens on
the very last mmdrop().

This approach has a problem that a MM of the userspace process
may live longer than the userspace process itself as kernel threads
use userspace process MMs which was runnning on a CPU where
the kernel thread was scheduled to. If this happened, the MM remains
referenced until this exact kernel thread wakes up again
and releases the very last reference to the MM, on an idle system this
can take even hours.

This references and caches MM once per container and adds tracking
how many times each preregistered area was registered in
a specific container. This way we do not depend on @current pointing to
a valid task descriptor.

This changes the userspace interface to return EBUSY if memory is
already registered (mm_iommu_get() used to increment the counter);
however it should not have any practical effect as the only
userspace tool available now does register memory area once per
container anyway.

As tce_iommu_register_pages/tce_iommu_unregister_pages are called
under container->lock, this does not need additional locking.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

# Conflicts:
#	arch/powerpc/include/asm/mmu_context.h
#	arch/powerpc/mm/mmu_context_book3s64.c
#	arch/powerpc/mm/mmu_context_iommu.c
---
 arch/powerpc/include/asm/mmu_context.h |  1 -
 arch/powerpc/mm/mmu_context_book3s64.c |  4 ---
 arch/powerpc/mm/mmu_context_iommu.c    | 11 -------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 52 +++++++++++++++++++++++++++++++++-
 4 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index b85cc7b..a4c4ed5 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -25,7 +25,6 @@ extern long mm_iommu_get(struct mm_struct *mm,
 extern long mm_iommu_put(struct mm_struct *mm,
 		struct mm_iommu_table_group_mem_t *mem);
 extern void mm_iommu_init(struct mm_struct *mm);
-extern void mm_iommu_cleanup(struct mm_struct *mm);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(struct mm_struct *mm,
 		unsigned long ua, unsigned long size);
 extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
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
index ee6685b..10f01fe 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -293,14 +293,3 @@ void mm_iommu_init(struct mm_struct *mm)
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
index 9752e77..40e71a0 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -89,6 +89,15 @@ struct tce_iommu_group {
 };
 
 /*
+ * A container needs to remember which preregistered areas and how many times
+ * it has referenced to do proper cleanup at the userspace process exit.
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
@@ -101,12 +110,26 @@ struct tce_container {
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
 
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK))
 		return -EINVAL;
@@ -115,7 +138,12 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
 	if (!mem)
 		return -ENOENT;
 
-	return mm_iommu_put(container->mm, mem);
+	list_for_each_entry(tcemem, &container->prereg_list, next) {
+		if (tcemem->mem == mem)
+			return tce_iommu_prereg_free(container, tcemem);
+	}
+
+	return -ENOENT;
 }
 
 static long tce_iommu_register_pages(struct tce_container *container,
@@ -123,6 +151,7 @@ static long tce_iommu_register_pages(struct tce_container *container,
 {
 	long ret = 0;
 	struct mm_iommu_table_group_mem_t *mem = NULL;
+	struct tce_iommu_prereg *tcemem;
 	unsigned long entries = size >> PAGE_SHIFT;
 
 	if ((vaddr & ~PAGE_MASK) || (size & ~PAGE_MASK) ||
@@ -140,6 +169,18 @@ static long tce_iommu_register_pages(struct tce_container *container,
 	ret = mm_iommu_get(container->mm, vaddr, entries, &mem);
 	if (ret)
 		return ret;
+
+	list_for_each_entry(tcemem, &container->prereg_list, next) {
+		if (tcemem->mem == mem) {
+			mm_iommu_put(container->mm, mem);
+			return -EBUSY;
+		}
+	}
+
+	tcemem = kzalloc(sizeof(*tcemem), GFP_KERNEL);
+	tcemem->mem = mem;
+	list_add(&tcemem->next, &container->prereg_list);
+
 	container->enabled = true;
 
 	return 0;
@@ -325,6 +366,7 @@ static void *tce_iommu_open(unsigned long arg)
 
 	mutex_init(&container->lock);
 	INIT_LIST_HEAD_RCU(&container->group_list);
+	INIT_LIST_HEAD_RCU(&container->prereg_list);
 
 	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
 
@@ -362,6 +404,14 @@ static void tce_iommu_release(void *iommu_data)
 		tce_iommu_free_table(tbl);
 	}
 
+	while (!list_empty(&container->prereg_list)) {
+		struct tce_iommu_prereg *tcemem;
+
+		tcemem = list_first_entry(&container->prereg_list,
+				struct tce_iommu_prereg, next);
+		tce_iommu_prereg_free(container, tcemem);
+	}
+
 	if (container->mm)
 		mmdrop(container->mm);
 	tce_iommu_disable(container);
-- 
2.5.0.rc3
