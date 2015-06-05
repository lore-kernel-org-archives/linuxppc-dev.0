Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 083411A1DBD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:38:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 5 Jun 2015 16:38:39 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 64CCC3578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:38:37 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t556bEoT45809680
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:37:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556aoIW015748
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:36:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel v12 32/34] powerpc/mmu: Add userspace-to-physical
 addresses translation cache
Date: Fri,  5 Jun 2015 16:35:24 +1000
Message-Id: <1433486126-23551-33-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are adding support for DMA memory pre-registration to be used in
conjunction with VFIO. The idea is that the userspace which is going to
run a guest may want to pre-register a user space memory region so
it all gets pinned once and never goes away. Having this done,
a hypervisor will not have to pin/unpin pages on every DMA map/unmap
request. This is going to help with multiple pinning of the same memory.

Another use of it is in-kernel real mode (mmu off) acceleration of
DMA requests where real time translation of guest physical to host
physical addresses is non-trivial and may fail as linux ptes may be
temporarily invalid. Also, having cached host physical addresses
(compared to just pinning at the start and then walking the page table
again on every H_PUT_TCE), we can be sure that the addresses which we put
into TCE table are the ones we already pinned.

This adds a list of memory regions to mm_context_t. Each region consists
of a header and a list of physical addresses. This adds API to:
1. register/unregister memory regions;
2. do final cleanup (which puts all pre-registered pages);
3. do userspace to physical address translation;
4. manage usage counters; multiple registration of the same memory
is allowed (once per container).

This implements 2 counters per registered memory region:
- @mapped: incremented on every DMA mapping; decremented on unmapping;
initialized to 1 when a region is just registered; once it becomes zero,
no more mappings allowe;
- @used: incremented on every "register" ioctl; decremented on
"unregister"; unregistration is allowed for DMA mapped regions unless
it is the very last reference. For the very last reference this checks
that the region is still mapped and returns -EBUSY so the userspace
gets to know that memory is still pinned and unregistration needs to
be retried; @used remains 1.

Host physical addresses are stored in vmalloc'ed array. In order to
access these in the real mode (mmu off), there is a real_vmalloc_addr()
helper. In-kernel acceleration patchset will move it from KVM to MMU code.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v12:
* s/mmu_context_hash64_iommu.c/mmu_context_iommu.c/ as there is nothing
about hash64 in the new file
* added WARN_ON_ONCE() in mm_iommu_adjust_locked_vm()
* added mm_iommu_find() to find exact region (rather than overlapped),
as mm_iommu_get(), it takes @entries rather than @size
* mm_iommu_adjust_locked_vm() takes positive npages and a bool saying
whether to increment or decrement the limit

v11:
* added mutex to protect adding and removing
* added mm_iommu_init() helper
* kref is removed, now there are an atomic counter (@mapped) and a mutex
(for @used)
* merged mm_iommu_alloc into mm_iommu_get and do check-and-alloc under
one mutex lock; mm_iommu_get() returns old @used value so the caller can
know if it needs to elevate locked_vm counter
* do locked_vm counting in mmu_context_hash64_iommu.c

v10:
* split mm_iommu_mapped_update into mm_iommu_mapped_dec + mm_iommu_mapped_inc
* mapped counter now keep one reference for itself and mm_iommu_mapped_inc()
can tell if the region is being released
* updated commit log

v8:
* s/mm_iommu_table_group_mem_t/struct mm_iommu_table_group_mem_t/
* fixed error fallback look (s/[i]/[j]/)
---
 arch/powerpc/include/asm/mmu-hash64.h  |   3 +
 arch/powerpc/include/asm/mmu_context.h |  18 ++
 arch/powerpc/kernel/setup_64.c         |   3 +
 arch/powerpc/mm/Makefile               |   1 +
 arch/powerpc/mm/mmu_context_hash64.c   |   6 +
 arch/powerpc/mm/mmu_context_iommu.c    | 316 +++++++++++++++++++++++++++++++++
 6 files changed, 347 insertions(+)
 create mode 100644 arch/powerpc/mm/mmu_context_iommu.c

diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 1da6a81..a82f534 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -536,6 +536,9 @@ typedef struct {
 	/* for 4K PTE fragment support */
 	void *pte_frag;
 #endif
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	struct list_head iommu_group_mem_list;
+#endif
 } mm_context_t;
 
 
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 73382eb..3e51842 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -16,6 +16,24 @@
  */
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 extern void destroy_context(struct mm_struct *mm);
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+struct mm_iommu_table_group_mem_t;
+
+extern bool mm_iommu_preregistered(void);
+extern long mm_iommu_get(unsigned long ua, unsigned long entries,
+		struct mm_iommu_table_group_mem_t **pmem);
+extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
+extern void mm_iommu_init(mm_context_t *ctx);
+extern void mm_iommu_cleanup(mm_context_t *ctx);
+extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
+		unsigned long size);
+extern struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
+		unsigned long entries);
+extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
+		unsigned long ua, unsigned long *hpa);
+extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
+extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
+#endif
 
 extern void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
 extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index c69671c..5fc6ec2 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -686,6 +686,9 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_PPC_64K_PAGES
 	init_mm.context.pte_frag = NULL;
 #endif
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	mm_iommu_init(&init_mm.context);
+#endif
 	irqstack_early_init();
 	exc_lvl_early_init();
 	emergency_stack_init();
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 9c8770b..3eb73a3 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
+obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 178876ae..4e4efbc 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -89,6 +89,9 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 #ifdef CONFIG_PPC_64K_PAGES
 	mm->context.pte_frag = NULL;
 #endif
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	mm_iommu_init(&mm->context);
+#endif
 	return 0;
 }
 
@@ -132,6 +135,9 @@ static inline void destroy_pagetable_page(struct mm_struct *mm)
 
 void destroy_context(struct mm_struct *mm)
 {
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	mm_iommu_cleanup(&mm->context);
+#endif
 
 #ifdef CONFIG_PPC_ICSWX
 	drop_cop(mm->context.acop, mm);
diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
new file mode 100644
index 0000000..da6a216
--- /dev/null
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -0,0 +1,316 @@
+/*
+ *  IOMMU helpers in MMU context.
+ *
+ *  Copyright (C) 2015 IBM Corp. <aik@ozlabs.ru>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/rculist.h>
+#include <linux/vmalloc.h>
+#include <linux/mutex.h>
+#include <asm/mmu_context.h>
+
+static DEFINE_MUTEX(mem_list_mutex);
+
+struct mm_iommu_table_group_mem_t {
+	struct list_head next;
+	struct rcu_head rcu;
+	unsigned long used;
+	atomic64_t mapped;
+	u64 ua;			/* userspace address */
+	u64 entries;		/* number of entries in hpas[] */
+	u64 *hpas;		/* vmalloc'ed */
+};
+
+static long mm_iommu_adjust_locked_vm(struct mm_struct *mm,
+		unsigned long npages, bool incr)
+{
+	long ret = 0, locked, lock_limit;
+
+	if (!npages)
+		return 0;
+
+	down_write(&mm->mmap_sem);
+
+	if (incr) {
+		locked = mm->locked_vm + npages;
+		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+			ret = -ENOMEM;
+		else
+			mm->locked_vm += npages;
+	} else {
+		if (WARN_ON_ONCE(npages > mm->locked_vm))
+			npages = mm->locked_vm;
+		mm->locked_vm -= npages;
+	}
+
+	pr_debug("[%d] RLIMIT_MEMLOCK HASH64 %c%ld %ld/%ld\n",
+			current->pid,
+			incr ? '+' : '-',
+			npages << PAGE_SHIFT,
+			mm->locked_vm << PAGE_SHIFT,
+			rlimit(RLIMIT_MEMLOCK));
+	up_write(&mm->mmap_sem);
+
+	return ret;
+}
+
+bool mm_iommu_preregistered(void)
+{
+	if (!current || !current->mm)
+		return false;
+
+	return !list_empty(&current->mm->context.iommu_group_mem_list);
+}
+EXPORT_SYMBOL_GPL(mm_iommu_preregistered);
+
+long mm_iommu_get(unsigned long ua, unsigned long entries,
+		struct mm_iommu_table_group_mem_t **pmem)
+{
+	struct mm_iommu_table_group_mem_t *mem;
+	long i, j, ret = 0, locked_entries = 0;
+	struct page *page = NULL;
+
+	if (!current || !current->mm)
+		return -ESRCH; /* process exited */
+
+	mutex_lock(&mem_list_mutex);
+
+	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
+			next) {
+		if ((mem->ua == ua) && (mem->entries == entries)) {
+			++mem->used;
+			*pmem = mem;
+			goto unlock_exit;
+		}
+
+		/* Overlap? */
+		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
+				(ua < (mem->ua +
+				       (mem->entries << PAGE_SHIFT)))) {
+			ret = -EINVAL;
+			goto unlock_exit;
+		}
+
+	}
+
+	ret = mm_iommu_adjust_locked_vm(current->mm, entries, true);
+	if (ret)
+		goto unlock_exit;
+
+	locked_entries = entries;
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem) {
+		ret = -ENOMEM;
+		goto unlock_exit;
+	}
+
+	mem->hpas = vzalloc(entries * sizeof(mem->hpas[0]));
+	if (!mem->hpas) {
+		kfree(mem);
+		ret = -ENOMEM;
+		goto unlock_exit;
+	}
+
+	for (i = 0; i < entries; ++i) {
+		if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
+					1/* pages */, 1/* iswrite */, &page)) {
+			for (j = 0; j < i; ++j)
+				put_page(pfn_to_page(
+						mem->hpas[j] >> PAGE_SHIFT));
+			vfree(mem->hpas);
+			kfree(mem);
+			ret = -EFAULT;
+			goto unlock_exit;
+		}
+
+		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
+	}
+
+	atomic64_set(&mem->mapped, 1);
+	mem->used = 1;
+	mem->ua = ua;
+	mem->entries = entries;
+	*pmem = mem;
+
+	list_add_rcu(&mem->next, &current->mm->context.iommu_group_mem_list);
+
+unlock_exit:
+	if (locked_entries && ret)
+		mm_iommu_adjust_locked_vm(current->mm, locked_entries, false);
+
+	mutex_unlock(&mem_list_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_get);
+
+static void mm_iommu_unpin(struct mm_iommu_table_group_mem_t *mem)
+{
+	long i;
+	struct page *page = NULL;
+
+	for (i = 0; i < mem->entries; ++i) {
+		if (!mem->hpas[i])
+			continue;
+
+		page = pfn_to_page(mem->hpas[i] >> PAGE_SHIFT);
+		if (!page)
+			continue;
+
+		put_page(page);
+		mem->hpas[i] = 0;
+	}
+}
+
+static void mm_iommu_do_free(struct mm_iommu_table_group_mem_t *mem)
+{
+
+	mm_iommu_unpin(mem);
+	vfree(mem->hpas);
+	kfree(mem);
+}
+
+static void mm_iommu_free(struct rcu_head *head)
+{
+	struct mm_iommu_table_group_mem_t *mem = container_of(head,
+			struct mm_iommu_table_group_mem_t, rcu);
+
+	mm_iommu_do_free(mem);
+}
+
+static void mm_iommu_release(struct mm_iommu_table_group_mem_t *mem)
+{
+	list_del_rcu(&mem->next);
+	mm_iommu_adjust_locked_vm(current->mm, mem->entries, false);
+	call_rcu(&mem->rcu, mm_iommu_free);
+}
+
+long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
+{
+	long ret = 0;
+
+	if (!current || !current->mm)
+		return -ESRCH; /* process exited */
+
+	mutex_lock(&mem_list_mutex);
+
+	if (mem->used == 0) {
+		ret = -ENOENT;
+		goto unlock_exit;
+	}
+
+	--mem->used;
+	/* There are still users, exit */
+	if (mem->used)
+		goto unlock_exit;
+
+	/* Are there still mappings? */
+	if (atomic_cmpxchg(&mem->mapped, 1, 0) != 1) {
+		++mem->used;
+		ret = -EBUSY;
+		goto unlock_exit;
+	}
+
+	/* @mapped became 0 so now mappings are disabled, release the region */
+	mm_iommu_release(mem);
+
+unlock_exit:
+	mutex_unlock(&mem_list_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_put);
+
+struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
+		unsigned long size)
+{
+	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
+
+	list_for_each_entry_rcu(mem,
+			&current->mm->context.iommu_group_mem_list,
+			next) {
+		if ((mem->ua <= ua) &&
+				(ua + size <= mem->ua +
+				 (mem->entries << PAGE_SHIFT))) {
+			ret = mem;
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_lookup);
+
+struct mm_iommu_table_group_mem_t *mm_iommu_find(unsigned long ua,
+		unsigned long entries)
+{
+	struct mm_iommu_table_group_mem_t *mem, *ret = NULL;
+
+	list_for_each_entry_rcu(mem,
+			&current->mm->context.iommu_group_mem_list,
+			next) {
+		if ((mem->ua == ua) && (mem->entries == entries)) {
+			ret = mem;
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_find);
+
+long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
+		unsigned long ua, unsigned long *hpa)
+{
+	const long entry = (ua - mem->ua) >> PAGE_SHIFT;
+	u64 *va = &mem->hpas[entry];
+
+	if (entry >= mem->entries)
+		return -EFAULT;
+
+	*hpa = *va | (ua & ~PAGE_MASK);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_ua_to_hpa);
+
+long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem)
+{
+	if (atomic64_inc_not_zero(&mem->mapped))
+		return 0;
+
+	/* Last mm_iommu_put() has been called, no more mappings allowed() */
+	return -ENXIO;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_mapped_inc);
+
+void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem)
+{
+	atomic64_add_unless(&mem->mapped, -1, 1);
+}
+EXPORT_SYMBOL_GPL(mm_iommu_mapped_dec);
+
+void mm_iommu_init(mm_context_t *ctx)
+{
+	INIT_LIST_HEAD_RCU(&ctx->iommu_group_mem_list);
+}
+
+void mm_iommu_cleanup(mm_context_t *ctx)
+{
+	struct mm_iommu_table_group_mem_t *mem, *tmp;
+
+	list_for_each_entry_safe(mem, tmp, &ctx->iommu_group_mem_list, next) {
+		list_del_rcu(&mem->next);
+		mm_iommu_do_free(mem);
+	}
+}
-- 
2.4.0.rc3.8.gfb3e7d5
