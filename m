Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyJ0knQzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 42/70] powerpc/mm/radix: Add tlbflush routines
Date: Fri, 29 Apr 2016 23:26:05 +1000
Message-Id: <1461936393-10131-42-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Core kernel doesn't track the page size of the VA range that we are
invalidating. Hence we end up flushing TLB for the entire mm here. Later
patches will improve this.

We also don't flush page walk cache separetly instead use RIC=2 when
flushing TLB, because we do a MMU gather flush after freeing page table.

MMU_NO_CONTEXT is updated for hash.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |   1 +
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |  13 +-
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  33 +++
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |  20 ++
 arch/powerpc/include/asm/tlbflush.h                |   1 +
 arch/powerpc/kernel/mce_power.c                    |   3 +
 arch/powerpc/mm/Makefile                           |   2 +-
 arch/powerpc/mm/tlb-radix.c                        | 242 +++++++++++++++++++++
 8 files changed, 310 insertions(+), 5 deletions(-)
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
index cc092ea0387c..f12ddf5e8de5 100644
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
index 000000000000..13ef38828dfe
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
+extern void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end);
+extern void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end);
+
+extern void radix__local_flush_tlb_mm(struct mm_struct *mm);
+extern void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+extern void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
+				    unsigned long ap, int nid);
+extern void radix__tlb_flush(struct mmu_gather *tlb);
+#ifdef CONFIG_SMP
+extern void radix__flush_tlb_mm(struct mm_struct *mm);
+extern void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+extern void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
+			      unsigned long ap, int nid);
+#else
+#define radix__flush_tlb_mm(mm)		radix__local_flush_tlb_mm(mm)
+#define radix__flush_tlb_page(vma,addr)	radix__local_flush_tlb_page(vma,addr)
+#define radix___flush_tlb_page(mm,addr,p,i)	radix___local_flush_tlb_page(mm,addr,p,i)
+#endif
+
+#endif
diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 476ea24b0313..d98424ae356c 100644
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
+		return radix__flush_tlb_range(vma, start, end);
 	return hash__flush_tlb_range(vma, start, end);
 }
 
 static inline void flush_tlb_kernel_range(unsigned long start,
 					  unsigned long end)
 {
+	if (radix_enabled())
+		return radix__flush_tlb_kernel_range(start, end);
 	return hash__flush_tlb_kernel_range(start, end);
 }
 
 static inline void local_flush_tlb_mm(struct mm_struct *mm)
 {
+	if (radix_enabled())
+		return radix__local_flush_tlb_mm(mm);
 	return hash__local_flush_tlb_mm(mm);
 }
 
 static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 					unsigned long vmaddr)
 {
+	if (radix_enabled())
+		return radix__local_flush_tlb_page(vma, vmaddr);
 	return hash__local_flush_tlb_page(vma, vmaddr);
 }
 
 static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
 					 unsigned long vmaddr)
 {
+	if (radix_enabled())
+		return radix__flush_tlb_page(vma, vmaddr);
 	return hash__flush_tlb_page_nohash(vma, vmaddr);
 }
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
+	if (radix_enabled())
+		return radix__tlb_flush(tlb);
 	return hash__tlb_flush(tlb);
 }
 
 #ifdef CONFIG_SMP
 static inline void flush_tlb_mm(struct mm_struct *mm)
 {
+	if (radix_enabled())
+		return radix__flush_tlb_mm(mm);
 	return hash__flush_tlb_mm(mm);
 }
 
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 				  unsigned long vmaddr)
 {
+	if (radix_enabled())
+		return radix__flush_tlb_page(vma, vmaddr);
 	return hash__flush_tlb_page(vma, vmaddr);
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
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index ee62b197502d..f64660254951 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -72,6 +72,9 @@ void __flush_tlb_power8(unsigned int action)
 
 void __flush_tlb_power9(unsigned int action)
 {
+	if (radix_enabled())
+		flush_tlb_206(POWER9_TLB_SETS_RADIX, action);
+
 	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
 }
 
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
index 000000000000..ecfa00f81f1e
--- /dev/null
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -0,0 +1,242 @@
+/*
+ * TLB flush routines for radix kernels.
+ *
+ * Copyright 2015-2016, Aneesh Kumar K.V, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
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
+void radix__local_flush_tlb_mm(struct mm_struct *mm)
+{
+	unsigned int pid;
+
+	preempt_disable();
+	pid = mm->context.id;
+	if (pid != MMU_NO_CONTEXT)
+		_tlbiel_pid(pid);
+	preempt_enable();
+}
+EXPORT_SYMBOL(radix__local_flush_tlb_mm);
+
+void radix___local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
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
+void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	radix___local_flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
+			       mmu_get_ap(mmu_virtual_psize), 0);
+}
+EXPORT_SYMBOL(radix__local_flush_tlb_page);
+
+#ifdef CONFIG_SMP
+static int mm_is_core_local(struct mm_struct *mm)
+{
+	return cpumask_subset(mm_cpumask(mm),
+			      topology_sibling_cpumask(smp_processor_id()));
+}
+
+void radix__flush_tlb_mm(struct mm_struct *mm)
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
+EXPORT_SYMBOL(radix__flush_tlb_mm);
+
+void radix___flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
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
+void radix__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	radix___flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
+			 mmu_get_ap(mmu_virtual_psize), 0);
+}
+EXPORT_SYMBOL(radix__flush_tlb_page);
+
+#endif /* CONFIG_SMP */
+
+void radix__flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+
+	if (lock_tlbie)
+		raw_spin_lock(&native_tlbie_lock);
+	_tlbie_pid(0);
+	if (lock_tlbie)
+		raw_spin_unlock(&native_tlbie_lock);
+}
+EXPORT_SYMBOL(radix__flush_tlb_kernel_range);
+
+/*
+ * Currently, for range flushing, we just do a full mm flush. Because
+ * we use this in code path where we don' track the page size.
+ */
+void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+		     unsigned long end)
+
+{
+	struct mm_struct *mm = vma->vm_mm;
+	radix__flush_tlb_mm(mm);
+}
+EXPORT_SYMBOL(radix__flush_tlb_range);
+
+
+void radix__tlb_flush(struct mmu_gather *tlb)
+{
+	struct mm_struct *mm = tlb->mm;
+	radix__flush_tlb_mm(mm);
+}
-- 
2.5.0
