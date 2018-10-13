Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6E2C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:30:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9D720895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9D720895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XQZ22P1nzF3Cd
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 00:30:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XQJx5PRfzF3D5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 00:19:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XQJx4jRdz9sCt; Sun, 14 Oct 2018 00:19:13 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42XQJx4MRHz9sCm; Sun, 14 Oct 2018 00:19:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/6] powerpc/64s/hash: Add a SLB preload cache
Date: Sun, 14 Oct 2018 00:18:34 +1100
Message-Id: <20181013131836.26764-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013131836.26764-1-mpe@ellerman.id.au>
References: <20181013131836.26764-1-mpe@ellerman.id.au>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nicholas Piggin <npiggin@gmail.com>

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
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/processor.h   |   1 +
 arch/powerpc/include/asm/thread_info.h |   5 +
 arch/powerpc/kernel/process.c          |   7 +
 arch/powerpc/mm/mmu_context_book3s64.c |   4 +
 arch/powerpc/mm/slb.c                  | 208 +++++++++++++++++++------
 5 files changed, 181 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 3fefb8a65b17..7d04d60a39c9 100644
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
index 916a3d67b592..544cac0474cb 100644
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
index 96cd9cd1a119..7ad304a3cc7d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1727,6 +1727,8 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	return 0;
 }
 
+void preload_new_slb_context(unsigned long start, unsigned long sp);
+
 /*
  * Set up a thread for executing a new program
  */
@@ -1734,6 +1736,10 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 {
 #ifdef CONFIG_PPC64
 	unsigned long load_addr = regs->gpr[2];	/* saved by ELF_PLAT_INIT */
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	preload_new_slb_context(start, sp);
+#endif
 #endif
 
 	/*
@@ -1824,6 +1830,7 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
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
index ed61639fe4f4..3b7d8af09724 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -257,41 +257,148 @@ void slb_vmalloc_update(void)
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
+	WARN_ON(irqs_disabled());
+
+	/*
+	 * preload cache can only be used to determine whether a SLB
+	 * entry exists if it does not start to overflow.
+	 */
+	if (ti->slb_preload_nr + 2 > SLB_PRELOAD_NR)
+		return;
+
+	hard_irq_disable();
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
+
+	/* see switch_slb */
+	asm volatile("isync" : : : "memory");
+
+	local_irq_enable();
+}
+
+void preload_new_slb_context(unsigned long start, unsigned long sp)
+{
+	struct thread_info *ti = current_thread_info();
+	struct mm_struct *mm = current->mm;
+	unsigned long heap = mm->start_brk;
+
+	WARN_ON(irqs_disabled());
+
+	/* see above */
+	if (ti->slb_preload_nr + 3 > SLB_PRELOAD_NR)
+		return;
+
+	hard_irq_disable();
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
+
+	/* see switch_slb */
+	asm volatile("isync" : : : "memory");
+
+	local_irq_enable();
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
@@ -300,6 +407,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	 * which would update the slb_cache/slb_cache_ptr fields in the PACA.
 	 */
 	hard_irq_disable();
+	asm volatile("isync" : : : "memory");
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		/*
 		 * SLBIA IH=3 invalidates all Class=1 SLBEs and their
@@ -307,16 +415,14 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		 * switch_slb wants. So ARCH_300 does not use the slb
 		 * cache.
 		 */
-		asm volatile("isync ; " PPC_SLBIA(3)" ; isync");
+		asm volatile(PPC_SLBIA(3));
 	} else {
 		unsigned long offset = get_paca()->slb_cache_ptr;
 
 		if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
 		    offset <= SLB_CACHE_ENTRIES) {
 			unsigned long slbie_data = 0;
-			int i;
 
-			asm volatile("isync" : : : "memory");
 			for (i = 0; i < offset; i++) {
 				/* EA */
 				slbie_data = (unsigned long)
@@ -331,7 +437,6 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 			if (!cpu_has_feature(CPU_FTR_ARCH_207S) && offset == 1)
 				asm volatile("slbie %0" : : "r" (slbie_data));
 
-			asm volatile("isync" : : : "memory");
 		} else {
 			struct slb_shadow *p = get_slb_shadow();
 			unsigned long ksp_esid_data =
@@ -339,8 +444,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 			unsigned long ksp_vsid_data =
 				be64_to_cpu(p->save_area[KSTACK_INDEX].vsid);
 
-			asm volatile("isync\n"
-				     PPC_SLBIA(1) "\n"
+			asm volatile(PPC_SLBIA(1) "\n"
 				     "slbmte	%0,%1\n"
 				     "isync"
 				     :: "r"(ksp_vsid_data),
@@ -356,24 +460,35 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	copy_mm_to_paca(mm);
 
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
+
+	for (i = 0; i < ti->slb_preload_nr; i++) {
+		unsigned char idx;
+		unsigned long ea;
 
-	slb_allocate_user(mm, pc);
+		idx = (ti->slb_preload_tail + i) % SLB_PRELOAD_NR;
+		ea = (unsigned long)ti->slb_preload_esid[idx] << SID_SHIFT;
 
-	if (!esids_match(pc, stack))
-		slb_allocate_user(mm, stack);
+		slb_allocate_user(mm, ea);
+	}
 
-	if (!esids_match(pc, exec_base) &&
-	    !esids_match(stack, exec_base))
-		slb_allocate_user(mm, exec_base);
+	/*
+	 * Synchronize slbmte preloads with possible subsequent user memory
+	 * address accesses by the kernel (user mode won't happen until
+	 * rfid, which is safe).
+	 */
+	asm volatile("isync" : : : "memory");
 }
 
 void slb_set_size(u16 size)
@@ -642,11 +757,16 @@ long do_slb_fault(struct pt_regs *regs, unsigned long ea)
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
2.17.1

