Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmL81xl6zDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:16:16 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:16:14 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 231A219D8042
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:04:03 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u396GAn844105834
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 23:16:11 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396G9Wq031727
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 00:16:10 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 39/68] powerpc/mm/radix: Add tlbflush routines
Date: Sat,  9 Apr 2016 11:43:35 +0530
Message-Id: <1460182444-2468-40-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Core kernel don't track the page size of the va range that we are
invalidating. Hence we end up flushing tlb for the entire mm here.
Later patches will improve this.

We also don't flush page walk cache separetly instead use RIC=2 when
flushing tlb, because we do a mmu gather flush after freeing page table.

MMU_NO_CONTEXT is updated for hash.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |   1 +
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  13 +-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  33 +++
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  20 ++
 arch/powerpc/include/asm/tlbflush.h                |   1 +
 arch/powerpc/mm/Makefile                           |   2 +-
 arch/powerpc/mm/tlb-radix.c                        | 243 +++++++++++++++++++++
 7 files changed, 308 insertions(+), 5 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
 create mode 100644 arch/powerpc/mm/tlb-radix.c

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 7da61b85406b..290157e8d5b2 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -119,6 +119,7 @@
 #define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
 #define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
 #define POWER9_TLB_SETS_HASH	256	/* # sets in POWER9 TLB Hash mode */
+#define POWER9_TLB_SETS_RADIX	128	/* # sets in POWER9 TLB Radix mode */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
index ddce8477fe0c..e90310d1a519 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-hash.h
@@ -1,8 +1,6 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_TLBFLUSH_HASH_H
 #define _ASM_POWERPC_BOOK3S_64_TLBFLUSH_HASH_H
 
-#define MMU_NO_CONTEXT		0
-
 /*
  * TLB flushing for 64-bit hash-MMU CPUs
  */
@@ -29,14 +27,21 @@ extern void __flush_tlb_pending(struct ppc64_tlb_batch *batch);
 
 static inline void arch_enter_lazy_mmu_mode(void)
 {
-	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
+	struct ppc64_tlb_batch *batch;
 
+	if (radix_enabled())
+		return;
+	batch = this_cpu_ptr(&ppc64_tlb_batch);
 	batch->active = 1;
 }
 
 static inline void arch_leave_lazy_mmu_mode(void)
 {
-	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
+	struct ppc64_tlb_batch *batch;
+
+	if (radix_enabled())
+		return;
+	batch = this_cpu_ptr(&ppc64_tlb_batch);
 
 	if (batch->index)
 		__flush_tlb_pending(batch);
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
new file mode 100644
index 000000000000..584ffa0a331f
--- /dev/null
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h
@@ -0,0 +1,33 @@
+#ifndef _ASM_POWERPC_TLBFLUSH_RADIX_H
+#define _ASM_POWERPC_TLBFLUSH_RADIX_H
+
+struct vm_area_struct;
+struct mm_struct;
+struct mmu_gather;
+
+static inline int mmu_get_ap(int psize)
+{
+	return mmu_psize_defs[psize].ap;
+}
+
+extern void flush_rtlb_range(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end);
+extern void flush_rtlb_kernel_range(unsigned long start, unsigned long end);
+
+extern void local_flush_rtlb_mm(struct mm_struct *mm);
+extern void local_flush_rtlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+extern void __local_flush_rtlb_page(struct mm_struct *mm, unsigned long vmaddr,
+				    unsigned long ap, int nid);
+extern void rtlb_flush(struct mmu_gather *tlb);
+#ifdef CONFIG_SMP
+extern void flush_rtlb_mm(struct mm_struct *mm);
+extern void flush_rtlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+extern void __flush_rtlb_page(struct mm_struct *mm, unsigned long vmaddr,
+			      unsigned long ap, int nid);
+#else
+#define flush_rtlb_mm(mm)		local_flush_rtlb_mm(mm)
+#define flush_rtlb_page(vma,addr)	local_flush_rtlb_page(vma,addr)
+#define __flush_rtlb_page(mm,addr,p,i)	__local_flush_rtlb_page(mm,addr,p,i)
+#endif
+
+#endif
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 37d7f289ad42..66b7bc371491 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -1,51 +1,71 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_TLBFLUSH_H
 #define _ASM_POWERPC_BOOK3S_64_TLBFLUSH_H
 
+#define MMU_NO_CONTEXT	~0UL
+
+
 #include <asm/book3s/64/tlbflush-hash.h>
+#include <asm/book3s/64/tlbflush-radix.h>
 
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end)
 {
+	if (radix_enabled())
+		return flush_rtlb_range(vma, start, end);
 	return flush_hltlb_range(vma, start, end);
 }
 
 static inline void flush_tlb_kernel_range(unsigned long start,
 					  unsigned long end)
 {
+	if (radix_enabled())
+		return flush_rtlb_kernel_range(start, end);
 	return flush_hltlb_kernel_range(start, end);
 }
 
 static inline void local_flush_tlb_mm(struct mm_struct *mm)
 {
+	if (radix_enabled())
+		return local_flush_rtlb_mm(mm);
 	return local_flush_hltlb_mm(mm);
 }
 
 static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 					unsigned long vmaddr)
 {
+	if (radix_enabled())
+		return local_flush_rtlb_page(vma, vmaddr);
 	return local_flush_hltlb_page(vma, vmaddr);
 }
 
 static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
 					 unsigned long vmaddr)
 {
+	if (radix_enabled())
+		return flush_rtlb_page(vma, vmaddr);
 	return flush_hltlb_page_nohash(vma, vmaddr);
 }
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
+	if (radix_enabled())
+		return rtlb_flush(tlb);
 	return hltlb_flush(tlb);
 }
 
 #ifdef CONFIG_SMP
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
+	if (radix_enabled())
+		return flush_rtlb_mm(mm);
 	return flush_hltlb_mm(mm);
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long vmaddr)
 {
+	if (radix_enabled())
+		return flush_rtlb_page(vma, vmaddr);
 	return flush_hltlb_page(vma, vmaddr);
 }
 #else
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 2fc4331c5bc5..1b38eea28e5a 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -58,6 +58,7 @@ extern void __flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 
 #elif defined(CONFIG_PPC_STD_MMU_32)
 
+#define MMU_NO_CONTEXT      (0)
 /*
  * TLB flushing for "classic" hash-MMU 32-bit CPUs, 6xx, 7xx, 7xxx
  */
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 9589236028f4..48aa11ae6a6b 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(CONFIG_WORD_SIZE)e.o
 hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
 obj-$(CONFIG_PPC_STD_MMU_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y) mmu_context_book3s64.o
-obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o
+obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(CONFIG_WORD_SIZE).o
 ifeq ($(CONFIG_PPC_STD_MMU_64),y)
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
new file mode 100644
index 000000000000..9129c0d6322c
--- /dev/null
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -0,0 +1,243 @@
+/*
+ *  TLB flush routines for radix kernels.
+ *
+ *  Copyright (C) 2015 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+#include <linux/memblock.h>
+
+#include <asm/tlb.h>
+#include <asm/tlbflush.h>
+
+static DEFINE_RAW_SPINLOCK(native_tlbie_lock);
+
+static inline void __tlbiel_pid(unsigned long pid, int set)
+{
+	unsigned long rb,rs,ric,prs,r;
+
+	rb = PPC_BIT(53); /* IS = 1 */
+	rb |= set << PPC_BITLSHIFT(51);
+	rs = ((unsigned long)pid) << PPC_BITLSHIFT(31);
+	prs = 1; /* process scoped */
+	r = 1;   /* raidx format */
+	ric = 2;  /* invalidate all the caches */
+
+	asm volatile("ptesync": : :"memory");
+	asm volatile(".long 0x7c000224 | (%0 << 11) | (%1 << 16) |"
+		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	asm volatile("ptesync": : :"memory");
+}
+
+/*
+ * We use 128 set in radix mode and 256 set in hpt mode.
+ */
+static inline void _tlbiel_pid(unsigned long pid)
+{
+	int set;
+
+	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
+		__tlbiel_pid(pid, set);
+	}
+	return;
+}
+
+static inline void _tlbie_pid(unsigned long pid)
+{
+	unsigned long rb,rs,ric,prs,r;
+
+	rb = PPC_BIT(53); /* IS = 1 */
+	rs = pid << PPC_BITLSHIFT(31);
+	prs = 1; /* process scoped */
+	r = 1;   /* raidx format */
+	ric = 2;  /* invalidate all the caches */
+
+	asm volatile("ptesync": : :"memory");
+	asm volatile(".long 0x7c000264 | (%0 << 11) | (%1 << 16) |"
+		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+}
+
+static inline void _tlbiel_va(unsigned long va, unsigned long pid,
+			      unsigned long ap)
+{
+	unsigned long rb,rs,ric,prs,r;
+
+	rb = va & ~(PPC_BITMASK(52, 63));
+	rb |= ap << PPC_BITLSHIFT(58);
+	rs = pid << PPC_BITLSHIFT(31);
+	prs = 1; /* process scoped */
+	r = 1;   /* raidx format */
+	ric = 0;  /* no cluster flush yet */
+
+	asm volatile("ptesync": : :"memory");
+	asm volatile(".long 0x7c000224 | (%0 << 11) | (%1 << 16) |"
+		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	asm volatile("ptesync": : :"memory");
+}
+
+static inline void _tlbie_va(unsigned long va, unsigned long pid,
+			     unsigned long ap)
+{
+	unsigned long rb,rs,ric,prs,r;
+
+	rb = va & ~(PPC_BITMASK(52, 63));
+	rb |= ap << PPC_BITLSHIFT(58);
+	rs = pid << PPC_BITLSHIFT(31);
+	prs = 1; /* process scoped */
+	r = 1;   /* raidx format */
+	ric = 0;  /* no cluster flush yet */
+
+	asm volatile("ptesync": : :"memory");
+	asm volatile(".long 0x7c000264 | (%0 << 11) | (%1 << 16) |"
+		     "(%2 << 17) | (%3 << 18) | (%4 << 21)"
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	asm volatile("eieio; tlbsync; ptesync": : :"memory");
+}
+
+/*
+ * Base TLB flushing operations:
+ *
+ *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
+ *  - flush_tlb_page(vma, vmaddr) flushes one page
+ *  - flush_tlb_range(vma, start, end) flushes a range of pages
+ *  - flush_tlb_kernel_range(start, end) flushes kernel pages
+ *
+ *  - local_* variants of page and mm only apply to the current
+ *    processor
+ */
+void local_flush_rtlb_mm(struct mm_struct *mm)
+{
+	unsigned int pid;
+
+	preempt_disable();
+	pid = mm->context.id;
+	if (pid != MMU_NO_CONTEXT)
+		_tlbiel_pid(pid);
+	preempt_enable();
+}
+EXPORT_SYMBOL(local_flush_rtlb_mm);
+
+void __local_flush_rtlb_page(struct mm_struct *mm, unsigned long vmaddr,
+			    unsigned long ap, int nid)
+{
+	unsigned int pid;
+
+	preempt_disable();
+	pid = mm ? mm->context.id : 0;
+	if (pid != MMU_NO_CONTEXT)
+		_tlbiel_va(vmaddr, pid, ap);
+	preempt_enable();
+}
+
+void local_flush_rtlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	__local_flush_rtlb_page(vma ? vma->vm_mm : NULL, vmaddr,
+			       mmu_get_ap(mmu_virtual_psize), 0);
+}
+EXPORT_SYMBOL(local_flush_rtlb_page);
+
+#ifdef CONFIG_SMP
+static int mm_is_core_local(struct mm_struct *mm)
+{
+	return cpumask_subset(mm_cpumask(mm),
+			      topology_sibling_cpumask(smp_processor_id()));
+}
+
+void flush_rtlb_mm(struct mm_struct *mm)
+{
+	unsigned int pid;
+
+	preempt_disable();
+	pid = mm->context.id;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		goto no_context;
+
+	if (!mm_is_core_local(mm)) {
+		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+
+		if (lock_tlbie)
+			raw_spin_lock(&native_tlbie_lock);
+		_tlbie_pid(pid);
+		if (lock_tlbie)
+			raw_spin_unlock(&native_tlbie_lock);
+	} else
+		_tlbiel_pid(pid);
+no_context:
+	preempt_enable();
+}
+EXPORT_SYMBOL(flush_rtlb_mm);
+
+void __flush_rtlb_page(struct mm_struct *mm, unsigned long vmaddr,
+		       unsigned long ap, int nid)
+{
+	unsigned int pid;
+
+	preempt_disable();
+	pid = mm ? mm->context.id : 0;
+	if (unlikely(pid == MMU_NO_CONTEXT))
+		goto bail;
+	if (!mm_is_core_local(mm)) {
+		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+
+		if (lock_tlbie)
+			raw_spin_lock(&native_tlbie_lock);
+		_tlbie_va(vmaddr, pid, ap);
+		if (lock_tlbie)
+			raw_spin_unlock(&native_tlbie_lock);
+	} else
+		_tlbiel_va(vmaddr, pid, ap);
+bail:
+	preempt_enable();
+}
+
+void flush_rtlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	__flush_rtlb_page(vma ? vma->vm_mm : NULL, vmaddr,
+			 mmu_get_ap(mmu_virtual_psize), 0);
+}
+EXPORT_SYMBOL(flush_rtlb_page);
+
+#endif /* CONFIG_SMP */
+
+void flush_rtlb_kernel_range(unsigned long start, unsigned long end)
+{
+	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+
+	if (lock_tlbie)
+		raw_spin_lock(&native_tlbie_lock);
+	_tlbie_pid(0);
+	if (lock_tlbie)
+		raw_spin_unlock(&native_tlbie_lock);
+}
+EXPORT_SYMBOL(flush_rtlb_kernel_range);
+
+/*
+ * Currently, for range flushing, we just do a full mm flush. Because
+ * we use this in code path where we don' track the page size.
+ */
+void flush_rtlb_range(struct vm_area_struct *vma, unsigned long start,
+		     unsigned long end)
+
+{
+	struct mm_struct *mm = vma->vm_mm;
+	flush_rtlb_mm(mm);
+}
+EXPORT_SYMBOL(flush_rtlb_range);
+
+
+void rtlb_flush(struct mmu_gather *tlb)
+{
+	struct mm_struct *mm = tlb->mm;
+	flush_rtlb_mm(mm);
+}
-- 
2.5.0
