Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v83l2yWWzF1d7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 19:42:27 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id i26-v6so6473739pfo.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 02:42:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 5/5] powerpc/64s/hash: Add a SLB preload cache
Date: Mon, 20 Aug 2018 19:42:00 +1000
Message-Id: <20180820094200.13003-6-npiggin@gmail.com>
In-Reply-To: <20180820094200.13003-1-npiggin@gmail.com>
References: <20180820094200.13003-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When switching processes, currently all user SLBEs are cleared, and
a few (exec_base, pc, and stack) are preloaded. In trivial testing
with small apps, this tends to miss the heap and low 256MB segments,
and it will also miss commonly accessed segments on large memory
workloads.

Add a simple round-robin preload cache that just inserts the last
SLB miss into the head of the cache and preloads those at context
switch time.

Much more could go into this, including into the SLB entry reclaim
side to track some LRU information etc, which would require a study
of large memory workloads. But this is a simple thing we can do now
that is an obvious win for common workloads.

This plus the previous patch reduces SLB misses of a bare bones boot
to busybox from 945 to 180 when using 256MB segments, and 900 to 100 when
using 1T segments. These could almost all be eliminated by preloading
a bit more carefully with ELF binary loading.
---
 arch/powerpc/include/asm/thread_info.h |   4 +
 arch/powerpc/kernel/process.c          |   6 ++
 arch/powerpc/mm/mmu_context_book3s64.c |  10 ++-
 arch/powerpc/mm/slb.c                  | 107 ++++++++++++++++++++-----
 4 files changed, 102 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 3c0002044bc9..ee5e49ec12c7 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -29,6 +29,7 @@
 #include <asm/page.h>
 #include <asm/accounting.h>
 
+#define SLB_PRELOAD_NR	8U
 /*
  * low level task data.
  */
@@ -44,6 +45,9 @@ struct thread_info {
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE) && defined(CONFIG_PPC32)
 	struct cpu_accounting_data accounting;
 #endif
+	unsigned int slb_preload_nr;
+	unsigned long slb_preload_ea[SLB_PRELOAD_NR];
+
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 913c5725cdb2..678a2c668270 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1710,6 +1710,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	return 0;
 }
 
+void preload_new_slb_context(unsigned long start, unsigned long sp);
+
 /*
  * Set up a thread for executing a new program
  */
@@ -1717,6 +1719,10 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 {
 #ifdef CONFIG_PPC64
 	unsigned long load_addr = regs->gpr[2];	/* saved by ELF_PLAT_INIT */
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	preload_new_slb_context(start, sp);
+#endif
 #endif
 
 	/*
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 4a892d894a0f..3671a32141e2 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -85,7 +85,9 @@ int hash__alloc_context_id(void)
 }
 EXPORT_SYMBOL_GPL(hash__alloc_context_id);
 
-static int hash__init_new_context(struct mm_struct *mm)
+void init_new_slb_context(struct task_struct *tsk, struct mm_struct *mm);
+
+static int hash__init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	int index;
 
@@ -107,8 +109,10 @@ static int hash__init_new_context(struct mm_struct *mm)
 	 * We should not be calling init_new_context() on init_mm. Hence a
 	 * check against 0 is OK.
 	 */
-	if (mm->context.id == 0)
+	if (mm->context.id == 0) {
 		slice_init_new_context_exec(mm);
+		init_new_slb_context(tsk, mm);
+	}
 
 	subpage_prot_init_new_context(mm);
 
@@ -152,7 +156,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	if (radix_enabled())
 		index = radix__init_new_context(mm);
 	else
-		index = hash__init_new_context(mm);
+		index = hash__init_new_context(tsk, mm);
 
 	if (index < 0)
 		return index;
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 3de63598f7c4..e53846d4e474 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -216,14 +216,85 @@ static inline int esids_match(unsigned long addr1, unsigned long addr2)
 	return (GET_ESID_1T(addr1) == GET_ESID_1T(addr2));
 }
 
+static bool preload_hit(struct thread_info *ti, unsigned long ea)
+{
+	int i;
+
+	for (i = 0; i < min(SLB_PRELOAD_NR, ti->slb_preload_nr); i++)
+		if (esids_match(ti->slb_preload_ea[i], ea))
+			return true;
+	return false;
+}
+
+static bool preload_add(struct thread_info *ti, unsigned long ea)
+{
+	if (preload_hit(ti, ea))
+		return false;
+
+	ti->slb_preload_ea[ti->slb_preload_nr % SLB_PRELOAD_NR] = ea;
+	ti->slb_preload_nr++;
+
+	return true;
+}
+
+void preload_new_slb_context(unsigned long start, unsigned long sp)
+{
+	struct thread_info *ti = current_thread_info();
+	struct mm_struct *mm = current->mm;
+	unsigned long heap = mm->start_brk;
+
+	// printk("preload new slb context tsk:%s pc:%lx heap:%lx stack:%lx\n", current->comm, start, heap, sp);
+
+	if (!is_kernel_addr(start)) {
+		if (preload_add(ti, start))
+			slb_allocate_user(mm, start);
+	}
+
+	if (!is_kernel_addr(sp)) {
+		if (preload_add(ti, sp))
+			slb_allocate_user(mm, sp);
+	}
+
+	if (heap && !is_kernel_addr(heap)) {
+		if (preload_add(ti, heap))
+			slb_allocate_user(mm, heap);
+	}
+
+	// preload mm->mmap_base is too late at this point
+}
+
+void init_new_slb_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	// printk("init new slb context tsk:%s\n", tsk->comm);
+
+	/*
+	 * Clear out previous cache because new exec will put addresses
+	 * at different places. Preloading is still generally a win here
+	 * because we don't have all ELF information yet and take several
+	 * misses in kernel space on the user addresss when loading binary
+	 * and libraries. However we don't want to insert more slb entries
+	 * than we need for small processes. Probably should look at aging
+	 * out the preload cache slowly at context switch time.
+	 */
+	ti->slb_preload_nr = 0;
+
+	/*
+	 * preload some userspace segments into the SLB.
+	 * Almost all 32 and 64bit PowerPC executables are linked at
+	 * 0x10000000 so it makes sense to preload this segment.
+	 */
+	preload_add(ti, 0x10000000);
+}
+
 /* Flush all user entries from the segment table of the current processor. */
 void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
 	unsigned long offset;
 	unsigned long slbie_data = 0;
-	unsigned long pc = KSTK_EIP(tsk);
-	unsigned long stack = KSTK_ESP(tsk);
-	unsigned long exec_base;
+	struct thread_info *ti = task_thread_info(tsk);
+	int i;
 
 	/*
 	 * We need interrupts hard-disabled here, not just soft-disabled,
@@ -269,25 +340,12 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	}
 	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 
-	/*
-	 * preload some userspace segments into the SLB.
-	 * Almost all 32 and 64bit PowerPC executables are linked at
-	 * 0x10000000 so it makes sense to preload this segment.
+	/* XXX: should we gradually age out SLBs after a number of context
+	 * switches to reduce reload overhead of unused entries (like we do
+	 * with FP/VEC reload)?
 	 */
-	exec_base = 0x10000000;
-
-	if (is_kernel_addr(pc) || is_kernel_addr(stack) ||
-	    is_kernel_addr(exec_base))
-		return;
-
-	slb_allocate_user(mm, pc);
-
-	if (!esids_match(pc, stack))
-		slb_allocate_user(mm, stack);
-
-	if (!esids_match(pc, exec_base) &&
-	    !esids_match(stack, exec_base))
-		slb_allocate_user(mm, exec_base);
+	for (i = 0; i < min(SLB_PRELOAD_NR, ti->slb_preload_nr); i++)
+		slb_allocate_user(mm, ti->slb_preload_ea[i]);
 }
 
 void slb_set_size(u16 size)
@@ -536,11 +594,16 @@ long do_slb_fault(struct pt_regs *regs, unsigned long ea)
 		return slb_allocate_kernel(ea, id);
 	} else {
 		struct mm_struct *mm = current->mm;
+		long err;
 
 		if (unlikely(!mm))
 			return -EFAULT;
 
-		return slb_allocate_user(mm, ea);
+		err = slb_allocate_user(mm, ea);
+		if (!err)
+			preload_add(current_thread_info(), ea);
+
+		return err;
 	}
 }
 
-- 
2.17.0
