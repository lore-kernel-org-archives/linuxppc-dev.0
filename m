Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10F561A0C3D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:47 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6DDB13578057
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGaYV14483844
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCGA6g030215
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:11 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 28/32] powerpc/mmu: Add userspace-to-physical
 addresses translation cache
Date: Sat, 25 Apr 2015 22:14:52 +1000
Message-Id: <1429964096-11524-29-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
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
request. This is going to help with multiple pinning of the same memory
and in-kernel acceleration of DMA requests.

This adds a list of memory regions to mm_context_t. Each region consists
of a header and a list of physical addresses. This adds API to:
1. register/unregister memory regions;
2. do final cleanup (which puts all pre-registered pages);
3. do userspace to physical address translation;
4. manage a mapped pages counter; when it is zero, it is safe to
unregister the region.

Multiple registration of the same region is allowed, kref is used to
track the number of registrations.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v8:
* s/mm_iommu_table_group_mem_t/struct mm_iommu_table_group_mem_t/
* fixed error fallback look (s/[i]/[j]/)
---
 arch/powerpc/include/asm/mmu-hash64.h      |   3 +
 arch/powerpc/include/asm/mmu_context.h     |  17 +++
 arch/powerpc/mm/Makefile                   |   1 +
 arch/powerpc/mm/mmu_context_hash64.c       |   6 +
 arch/powerpc/mm/mmu_context_hash64_iommu.c | 215 +++++++++++++++++++++++++++++
 5 files changed, 242 insertions(+)
 create mode 100644 arch/powerpc/mm/mmu_context_hash64_iommu.c

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
index 73382eb..d6116ca 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -16,6 +16,23 @@
  */
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 extern void destroy_context(struct mm_struct *mm);
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+struct mm_iommu_table_group_mem_t;
+
+extern bool mm_iommu_preregistered(void);
+extern long mm_iommu_alloc(unsigned long ua, unsigned long entries,
+		struct mm_iommu_table_group_mem_t **pmem);
+extern struct mm_iommu_table_group_mem_t *mm_iommu_get(unsigned long ua,
+		unsigned long entries);
+extern long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem);
+extern void mm_iommu_cleanup(mm_context_t *ctx);
+extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup(unsigned long ua,
+		unsigned long size);
+extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
+		unsigned long ua, unsigned long *hpa);
+extern long mm_iommu_mapped_update(struct mm_iommu_table_group_mem_t *mem,
+		bool inc);
+#endif
 
 extern void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next);
 extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 9c8770b..e216704 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
 obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
 obj-$(CONFIG_HIGHMEM)		+= highmem.o
 obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
+obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_hash64_iommu.o
diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
index 178876ae..eb3080c 100644
--- a/arch/powerpc/mm/mmu_context_hash64.c
+++ b/arch/powerpc/mm/mmu_context_hash64.c
@@ -89,6 +89,9 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 #ifdef CONFIG_PPC_64K_PAGES
 	mm->context.pte_frag = NULL;
 #endif
+#ifdef CONFIG_SPAPR_TCE_IOMMU
+	INIT_LIST_HEAD_RCU(&mm->context.iommu_group_mem_list);
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
diff --git a/arch/powerpc/mm/mmu_context_hash64_iommu.c b/arch/powerpc/mm/mmu_context_hash64_iommu.c
new file mode 100644
index 0000000..af7668c
--- /dev/null
+++ b/arch/powerpc/mm/mmu_context_hash64_iommu.c
@@ -0,0 +1,215 @@
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
+#include <linux/kref.h>
+#include <asm/mmu_context.h>
+
+struct mm_iommu_table_group_mem_t {
+	struct list_head next;
+	struct rcu_head rcu;
+	struct kref kref;	/* one reference per VFIO container */
+	atomic_t mapped;	/* number of currently mapped pages */
+	u64 ua;			/* userspace address */
+	u64 entries;		/* number of entries in hpas[] */
+	u64 *hpas;		/* vmalloc'ed */
+};
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
+long mm_iommu_alloc(unsigned long ua, unsigned long entries,
+		struct mm_iommu_table_group_mem_t **pmem)
+{
+	struct mm_iommu_table_group_mem_t *mem;
+	long i, j;
+	struct page *page = NULL;
+
+	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
+			next) {
+		if ((mem->ua == ua) && (mem->entries == entries))
+			return -EBUSY;
+
+		/* Overlap? */
+		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
+				(ua < (mem->ua + (mem->entries << PAGE_SHIFT))))
+			return -EINVAL;
+	}
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	mem->hpas = vzalloc(entries * sizeof(mem->hpas[0]));
+	if (!mem->hpas) {
+		kfree(mem);
+		return -ENOMEM;
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
+			return -EFAULT;
+		}
+
+		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
+	}
+
+	kref_init(&mem->kref);
+	atomic_set(&mem->mapped, 0);
+	mem->ua = ua;
+	mem->entries = entries;
+	*pmem = mem;
+
+	list_add_rcu(&mem->next, &current->mm->context.iommu_group_mem_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_alloc);
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
+static void mm_iommu_free(struct rcu_head *head)
+{
+	struct mm_iommu_table_group_mem_t *mem = container_of(head,
+			struct mm_iommu_table_group_mem_t, rcu);
+
+	mm_iommu_unpin(mem);
+	vfree(mem->hpas);
+	kfree(mem);
+}
+
+static void mm_iommu_release(struct kref *kref)
+{
+	struct mm_iommu_table_group_mem_t *mem = container_of(kref,
+			struct mm_iommu_table_group_mem_t, kref);
+
+	list_del_rcu(&mem->next);
+	call_rcu(&mem->rcu, mm_iommu_free);
+}
+
+struct mm_iommu_table_group_mem_t *mm_iommu_get(unsigned long ua,
+		unsigned long entries)
+{
+	struct mm_iommu_table_group_mem_t *mem;
+
+	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
+			next) {
+		if ((mem->ua == ua) && (mem->entries == entries)) {
+			kref_get(&mem->kref);
+			return mem;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_get);
+
+long mm_iommu_put(struct mm_iommu_table_group_mem_t *mem)
+{
+	if (atomic_read(&mem->mapped))
+		return -EBUSY;
+
+	kref_put(&mem->kref, mm_iommu_release);
+
+	return 0;
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
+long mm_iommu_mapped_update(struct mm_iommu_table_group_mem_t *mem, bool inc)
+{
+	long ret = 0;
+
+	if (inc)
+		atomic_inc(&mem->mapped);
+	else
+		ret = atomic_dec_if_positive(&mem->mapped);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mm_iommu_mapped_update);
+
+void mm_iommu_cleanup(mm_context_t *ctx)
+{
+	while (!list_empty(&ctx->iommu_group_mem_list)) {
+		struct mm_iommu_table_group_mem_t *mem;
+
+		mem = list_first_entry(&ctx->iommu_group_mem_list,
+				struct mm_iommu_table_group_mem_t, next);
+		mm_iommu_release(&mem->kref);
+	}
+}
-- 
2.0.0
