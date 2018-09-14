Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bfd72lm2zF3Wx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 01:31:39 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id h79-v6so4471473pfk.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 08:31:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 12/12] powerpc/64s/hash: Add a SLB preload cache
Date: Sat, 15 Sep 2018 01:30:56 +1000
Message-Id: <20180914153056.3644-13-npiggin@gmail.com>
In-Reply-To: <20180914153056.3644-1-npiggin@gmail.com>
References: <20180914153056.3644-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When switching processes, currently all user SLBEs are cleared, and a
few (exec_base, pc, and stack) are preloaded. In trivial testing with
small apps, this tends to miss the heap and low 256MB segments, and it
will also miss commonly accessed segments on large memory workloads.

Add a simple round-robin preload cache that just inserts the last SLB
miss into the head of the cache and preloads those at context switch
time. Every 256 context switches, the oldest entry is removed from the
cache to shrink the cache and require fewer slbmte if they are unused.

Much more could go into this, including into the SLB entry reclaim
side to track some LRU information etc, which would require a study of
large memory workloads. But this is a simple thing we can do now that
is an obvious win for common workloads.

With the full series, process switching speed on the context_switch
benchmark on POWER9/hash (with kernel speculation security masures
disabled) increases from 140K/s to 178K/s (27%).

POWER8 does not change much (within 1%), it's unclear why it does not
see a big gain like POWER9.

Booting to busybox init with 256MB segments has SLB misses go down
from 945 to 69, and with 1T segments 900 to 21. These could almost all
be eliminated by preloading a bit more carefully with ELF binary
loading.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/processor.h   |   1 +
 arch/powerpc/include/asm/thread_info.h |   5 +
 arch/powerpc/kernel/process.c          |   7 ++
 arch/powerpc/mm/mmu_context_book3s64.c |   4 +
 arch/powerpc/mm/slb.c                  | 166 +++++++++++++++++++------
 5 files changed, 143 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 12b76ecdc57d..936795acba48 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -273,6 +273,7 @@ struct thread_struct {
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 	struct arch_hw_breakpoint hw_brk; /* info on the hardware breakpoint */
 	unsigned long	trap_nr;	/* last trap # on this thread */
+	u8 load_slb;			/* Ages out SLB preload cache entries */
 	u8 load_fp;
 #ifdef CONFIG_ALTIVEC
 	u8 load_vec;
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index f9a442bb5a72..9e78b7d26b64 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -29,6 +29,7 @@
 #include <asm/page.h>
 #include <asm/accounting.h>
 
+#define SLB_PRELOAD_NR	16U
 /*
  * low level task data.
  */
@@ -44,6 +45,10 @@ struct thread_info {
 #if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE) && defined(CONFIG_PPC32)
 	struct cpu_accounting_data accounting;
 #endif
+	unsigned char slb_preload_nr;
+	unsigned char slb_preload_tail;
+	u32 slb_preload_esid[SLB_PRELOAD_NR];
+
 	/* low level flags - has atomic operations done on it */
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e4feb45ae4c6..03c2e1f134bc 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1719,6 +1719,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	return 0;
 }
 
+void preload_new_slb_context(unsigned long start, unsigned long sp);
+
 /*
  * Set up a thread for executing a new program
  */
@@ -1726,6 +1728,10 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 {
 #ifdef CONFIG_PPC64
 	unsigned long load_addr = regs->gpr[2];	/* saved by ELF_PLAT_INIT */
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	preload_new_slb_context(start, sp);
+#endif
 #endif
 
 	/*
@@ -1816,6 +1822,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 #ifdef CONFIG_VSX
 	current->thread.used_vsr = 0;
 #endif
+	current->thread.load_slb = 0;
 	current->thread.load_fp = 0;
 	memset(&current->thread.fp_state, 0, sizeof(current->thread.fp_state));
 	current->thread.fp_save_area = NULL;
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index f7352c66b6b8..510f103d7813 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -53,6 +53,8 @@ int hash__alloc_context_id(void)
 }
 EXPORT_SYMBOL_GPL(hash__alloc_context_id);
 
+void slb_setup_new_exec(void);
+
 static int hash__init_new_context(struct mm_struct *mm)
 {
 	int index;
@@ -87,6 +89,8 @@ static int hash__init_new_context(struct mm_struct *mm)
 void hash__setup_new_exec(void)
 {
 	slice_setup_new_exec();
+
+	slb_setup_new_exec();
 }
 
 static int radix__init_new_context(struct mm_struct *mm)
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 98521fec3536..d200728fe41b 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -187,41 +187,119 @@ void slb_vmalloc_update(void)
 	slb_flush_and_rebolt();
 }
 
-/* Helper function to compare esids.  There are four cases to handle.
- * 1. The system is not 1T segment size capable.  Use the GET_ESID compare.
- * 2. The system is 1T capable, both addresses are < 1T, use the GET_ESID compare.
- * 3. The system is 1T capable, only one of the two addresses is > 1T.  This is not a match.
- * 4. The system is 1T capable, both addresses are > 1T, use the GET_ESID_1T macro to compare.
- */
-static inline int esids_match(unsigned long addr1, unsigned long addr2)
+static bool preload_hit(struct thread_info *ti, unsigned long esid)
 {
-	int esid_1t_count;
+	unsigned char i;
 
-	/* System is not 1T segment size capable. */
-	if (!mmu_has_feature(MMU_FTR_1T_SEGMENT))
-		return (GET_ESID(addr1) == GET_ESID(addr2));
+	for (i = 0; i < ti->slb_preload_nr; i++) {
+		unsigned char idx;
+
+		idx = (ti->slb_preload_tail + i) % SLB_PRELOAD_NR;
+		if (esid == ti->slb_preload_esid[idx])
+			return true;
+	}
+	return false;
+}
+
+static bool preload_add(struct thread_info *ti, unsigned long ea)
+{
+	unsigned char idx;
+	unsigned long esid;
+
+	if (mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
+		/* EAs are stored >> 28 so 256MB segments don't need clearing */
+		if (ea & ESID_MASK_1T)
+			ea &= ESID_MASK_1T;
+	}
 
-	esid_1t_count = (((addr1 >> SID_SHIFT_1T) != 0) +
-				((addr2 >> SID_SHIFT_1T) != 0));
+	esid = ea >> SID_SHIFT;
 
-	/* both addresses are < 1T */
-	if (esid_1t_count == 0)
-		return (GET_ESID(addr1) == GET_ESID(addr2));
+	if (preload_hit(ti, esid))
+		return false;
 
-	/* One address < 1T, the other > 1T.  Not a match */
-	if (esid_1t_count == 1)
-		return 0;
+	idx = (ti->slb_preload_tail + ti->slb_preload_nr) % SLB_PRELOAD_NR;
+	ti->slb_preload_esid[idx] = esid;
+	if (ti->slb_preload_nr == SLB_PRELOAD_NR)
+		ti->slb_preload_tail = (ti->slb_preload_tail + 1) % SLB_PRELOAD_NR;
+	else
+		ti->slb_preload_nr++;
 
-	/* Both addresses are > 1T. */
-	return (GET_ESID_1T(addr1) == GET_ESID_1T(addr2));
+	return true;
 }
 
+static void preload_age(struct thread_info *ti)
+{
+	if (!ti->slb_preload_nr)
+		return;
+	ti->slb_preload_nr--;
+	ti->slb_preload_tail = (ti->slb_preload_tail + 1) % SLB_PRELOAD_NR;
+}
+
+void slb_setup_new_exec(void)
+{
+	struct thread_info *ti = current_thread_info();
+	struct mm_struct *mm = current->mm;
+	unsigned long exec = 0x10000000;
+
+	/*
+	 * We have no good place to clear the slb preload cache on exec,
+	 * flush_thread is about the earliest arch hook but that happens
+	 * after we switch to the mm and have aleady preloaded the SLBEs.
+	 *
+	 * For the most part that's probably okay to use entries from the
+	 * previous exec, they will age out if unused. It may turn out to
+	 * be an advantage to clear the cache before switching to it,
+	 * however.
+	 */
+
+	/*
+	 * preload some userspace segments into the SLB.
+	 * Almost all 32 and 64bit PowerPC executables are linked at
+	 * 0x10000000 so it makes sense to preload this segment.
+	 */
+	if (!is_kernel_addr(exec)) {
+		if (preload_add(ti, exec))
+			slb_allocate_user(mm, exec);
+	}
+
+	/* Libraries and mmaps. */
+	if (!is_kernel_addr(mm->mmap_base)) {
+		if (preload_add(ti, mm->mmap_base))
+			slb_allocate_user(mm, mm->mmap_base);
+	}
+}
+
+void preload_new_slb_context(unsigned long start, unsigned long sp)
+{
+	struct thread_info *ti = current_thread_info();
+	struct mm_struct *mm = current->mm;
+	unsigned long heap = mm->start_brk;
+
+	/* Userspace entry address. */
+	if (!is_kernel_addr(start)) {
+		if (preload_add(ti, start))
+			slb_allocate_user(mm, start);
+	}
+
+	/* Top of stack, grows down. */
+	if (!is_kernel_addr(sp)) {
+		if (preload_add(ti, sp))
+			slb_allocate_user(mm, sp);
+	}
+
+	/* Bottom of heap, grows up. */
+	if (heap && !is_kernel_addr(heap)) {
+		if (preload_add(ti, heap))
+			slb_allocate_user(mm, heap);
+	}
+}
+
+
 /* Flush all user entries from the segment table of the current processor. */
 void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 {
-	unsigned long pc = KSTK_EIP(tsk);
-	unsigned long stack = KSTK_ESP(tsk);
-	unsigned long exec_base;
+	struct thread_info *ti = task_thread_info(tsk);
+	unsigned char i;
 
 	/*
 	 * We need interrupts hard-disabled here, not just soft-disabled,
@@ -244,8 +322,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 
 		if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
 		    offset <= SLB_CACHE_ENTRIES) {
-			unsigned long slbie_data;
-			int i;
+			unsigned long slbie_data = 0;
 
 			asm volatile("isync" : : : "memory");
 			for (i = 0; i < offset; i++) {
@@ -285,24 +362,28 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 
 	/*
-	 * preload some userspace segments into the SLB.
-	 * Almost all 32 and 64bit PowerPC executables are linked at
-	 * 0x10000000 so it makes sense to preload this segment.
+	 * We gradually age out SLBs after a number of context switches to
+	 * reduce reload overhead of unused entries (like we do with FP/VEC
+	 * reload). Each time we wrap 256 switches, take an entry out of the
+	 * SLB preload cache.
 	 */
-	exec_base = 0x10000000;
+	tsk->thread.load_slb++;
+	if (!tsk->thread.load_slb) {
+		unsigned long pc = KSTK_EIP(tsk);
 
-	if (is_kernel_addr(pc) || is_kernel_addr(stack) ||
-	    is_kernel_addr(exec_base))
-		return;
+		preload_age(ti);
+		preload_add(ti, pc);
+	}
 
-	slb_allocate_user(mm, pc);
+	for (i = 0; i < ti->slb_preload_nr; i++) {
+		unsigned char idx;
+		unsigned long ea;
 
-	if (!esids_match(pc, stack))
-		slb_allocate_user(mm, stack);
+		idx = (ti->slb_preload_tail + i) % SLB_PRELOAD_NR;
+		ea = (unsigned long)ti->slb_preload_esid[idx] << SID_SHIFT;
 
-	if (!esids_match(pc, exec_base) &&
-	    !esids_match(stack, exec_base))
-		slb_allocate_user(mm, exec_base);
+		slb_allocate_user(mm, ea);
+	}
 }
 
 void slb_set_size(u16 size)
@@ -575,11 +656,16 @@ long do_slb_fault(struct pt_regs *regs, unsigned long ea)
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
2.18.0
