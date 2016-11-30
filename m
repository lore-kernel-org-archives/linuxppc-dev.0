Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTB2605lkzDvtR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 17:53:01 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: [PATCH kernel v7 7/7] powerpc/mm/iommu,
 vfio/spapr: Put pages on VFIO container shutdown
Date: Wed, 30 Nov 2016 17:52:05 +1100
Message-Id: <1480488725-12783-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1480488725-12783-1-git-send-email-aik@ozlabs.ru>
References: <1480488725-12783-1-git-send-email-aik@ozlabs.ru>
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
v7:
* left sanity check in destroy_context()
* tce_iommu_prereg_free() does not free tce_iommu_prereg struct if
mm_iommu_put() failed; VFIO SPAPR container release callback now warns
on an error

v4:
* changed tce_iommu_register_pages() to call mm_iommu_find() first and
avoid calling mm_iommu_put() if memory is preregistered already

v3:
* moved tce_iommu_prereg_free() call out of list_for_each_entry()

v2:
* updated commit log
---
 arch/powerpc/mm/mmu_context_book3s64.c |  4 +--
 arch/powerpc/mm/mmu_context_iommu.c    | 11 ------
 drivers/vfio/vfio_iommu_spapr_tce.c    | 61 +++++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index ad82735..73bf6e1 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -156,13 +156,11 @@ static inline void destroy_pagetable_page(struct mm_struct *mm)
 }
 #endif
 
-
 void destroy_context(struct mm_struct *mm)
 {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
-	mm_iommu_cleanup(mm);
+	WARN_ON_ONCE(!list_empty(&mm->context.iommu_group_mem_list));
 #endif
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
index 4c03c85..c882357 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -89,6 +89,15 @@ struct tce_iommu_group {
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
@@ -102,6 +111,7 @@ struct tce_container {
 	struct mm_struct *mm;
 	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
 	struct list_head group_list;
+	struct list_head prereg_list;
 };
 
 static long tce_iommu_mm_set(struct tce_container *container)
@@ -118,10 +128,27 @@ static long tce_iommu_mm_set(struct tce_container *container)
 	return 0;
 }
 
+static long tce_iommu_prereg_free(struct tce_container *container,
+		struct tce_iommu_prereg *tcemem)
+{
+	long ret;
+
+	ret = mm_iommu_put(container->mm, tcemem->mem);
+	if (ret)
+		return ret;
+
+	list_del(&tcemem->next);
+	kfree(tcemem);
+
+	return 0;
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
@@ -130,7 +157,17 @@ static long tce_iommu_unregister_pages(struct tce_container *container,
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
@@ -138,16 +175,29 @@ static long tce_iommu_register_pages(struct tce_container *container,
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
@@ -334,6 +384,7 @@ static void *tce_iommu_open(unsigned long arg)
 
 	mutex_init(&container->lock);
 	INIT_LIST_HEAD_RCU(&container->group_list);
+	INIT_LIST_HEAD_RCU(&container->prereg_list);
 
 	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
 
@@ -372,6 +423,14 @@ static void tce_iommu_release(void *iommu_data)
 		tce_iommu_free_table(container, tbl);
 	}
 
+	while (!list_empty(&container->prereg_list)) {
+		struct tce_iommu_prereg *tcemem;
+
+		tcemem = list_first_entry(&container->prereg_list,
+				struct tce_iommu_prereg, next);
+		WARN_ON_ONCE(tce_iommu_prereg_free(container, tcemem));
+	}
+
 	tce_iommu_disable(container);
 	if (container->mm)
 		mmdrop(container->mm);
-- 
2.5.0.rc3
