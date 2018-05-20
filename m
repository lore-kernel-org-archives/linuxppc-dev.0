Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40pNT01XFyzDrKQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 10:44:04 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id bi12-v6so6669838plb.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 17:44:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 2/7] powerpc/64s/radix: reset mm_cpumask for single thread
 process when possible
Date: Sun, 20 May 2018 10:43:42 +1000
Message-Id: <20180520004347.19508-3-npiggin@gmail.com>
In-Reply-To: <20180520004347.19508-1-npiggin@gmail.com>
References: <20180520004347.19508-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a single-threaded process has a non-local mm_cpumask and requires
a full PID tlbie invalidation, use that as an opportunity to reset the
cpumask back to the current CPU we're running on.

No other thread can concurrently switch to this mm, because it must
have been given a reference to mm_users by the current thread before it
can use_mm. mm_users can be asynchronously incremented (by
mmget_not_zero), but those users must not do a use_mm, because existing
convention already disallows it (sparc64 has reset mm_cpumask using this
condition since the start of history, see arch/sparc/kernel/smp_64.c).

This reduces tlbies for a kernel compile workload from 0.90M to 0.40M,
tlbiels are increased from 20M to 22.5M because local pid flushes take
128 tlbiels vs 1 for global pid flush.

This slows down context switch benchmark ping-ponging on different
CPUs by 7.5%, because switching to the idle thread and back now
requires a PID switch. There are ways this could be avoided, but for
now it's simpler not to allow lazy PID switching.

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Fix switch_mm to be irq-safe (thanks Balbir)

 arch/powerpc/include/asm/mmu_context.h | 19 +++++++++
 arch/powerpc/include/asm/tlb.h         |  8 ++++
 arch/powerpc/mm/tlb-radix.c            | 57 +++++++++++++++++++-------
 3 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 1835ca1505d6..f26704371fdc 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/spinlock.h>
 #include <asm/mmu.h>	
 #include <asm/cputable.h>
@@ -201,6 +202,24 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 				  struct task_struct *tsk)
 {
+#ifdef CONFIG_PPC_BOOK3S_64
+	/*
+	 * Under radix, we do not want to keep lazy PIDs around because
+	 * even if the CPU does not access userspace, it can still bring
+	 * in translations through speculation and prefetching.
+	 *
+	 * Switching away here allows us to trim back the mm_cpumask in
+	 * cases where we know the process is not running on some CPUs
+	 * (see mm/tlb-radix.c).
+	 */
+	if (radix_enabled() && mm != &init_mm) {
+		mmgrab(&init_mm);
+		tsk->active_mm = &init_mm;
+		switch_mm(mm, tsk->active_mm, tsk);
+		mmdrop(mm);
+	}
+#endif
+
 	/* 64-bit Book3E keeps track of current PGD in the PACA */
 #ifdef CONFIG_PPC_BOOK3E_64
 	get_paca()->pgd = NULL;
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index a7eabff27a0f..006fce98c403 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -76,6 +76,14 @@ static inline int mm_is_thread_local(struct mm_struct *mm)
 		return false;
 	return cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm));
 }
+static inline void mm_reset_thread_local(struct mm_struct *mm)
+{
+	WARN_ON(atomic_read(&mm->context.copros) > 0);
+	WARN_ON(!(atomic_read(&mm->mm_users) == 1 && current->mm == mm));
+	atomic_set(&mm->context.active_cpus, 1);
+	cpumask_clear(mm_cpumask(mm));
+	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+}
 #else /* CONFIG_PPC_BOOK3S_64 */
 static inline int mm_is_thread_local(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 5ac3206c51cc..d5593a78702a 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -504,6 +504,15 @@ void radix__local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmadd
 }
 EXPORT_SYMBOL(radix__local_flush_tlb_page);
 
+static bool mm_is_singlethreaded(struct mm_struct *mm)
+{
+	if (atomic_read(&mm->context.copros) > 0)
+		return false;
+	if (atomic_read(&mm->mm_users) == 1 && current->mm == mm)
+		return true;
+	return false;
+}
+
 static bool mm_needs_flush_escalation(struct mm_struct *mm)
 {
 	/*
@@ -511,7 +520,9 @@ static bool mm_needs_flush_escalation(struct mm_struct *mm)
 	 * caching PTEs and not flushing them properly when
 	 * RIC = 0 for a PID/LPID invalidate
 	 */
-	return atomic_read(&mm->context.copros) != 0;
+	if (atomic_read(&mm->context.copros) > 0)
+		return true;
+	return false;
 }
 
 #ifdef CONFIG_SMP
@@ -525,12 +536,17 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 
 	preempt_disable();
 	if (!mm_is_thread_local(mm)) {
-		if (mm_needs_flush_escalation(mm))
+		if (mm_is_singlethreaded(mm)) {
 			_tlbie_pid(pid, RIC_FLUSH_ALL);
-		else
+			mm_reset_thread_local(mm);
+		} else if (mm_needs_flush_escalation(mm)) {
+			_tlbie_pid(pid, RIC_FLUSH_ALL);
+		} else {
 			_tlbie_pid(pid, RIC_FLUSH_TLB);
-	} else
+		}
+	} else {
 		_tlbiel_pid(pid, RIC_FLUSH_TLB);
+	}
 	preempt_enable();
 }
 EXPORT_SYMBOL(radix__flush_tlb_mm);
@@ -544,10 +560,13 @@ void radix__flush_all_mm(struct mm_struct *mm)
 		return;
 
 	preempt_disable();
-	if (!mm_is_thread_local(mm))
+	if (!mm_is_thread_local(mm)) {
 		_tlbie_pid(pid, RIC_FLUSH_ALL);
-	else
+		if (mm_is_singlethreaded(mm))
+			mm_reset_thread_local(mm);
+	} else {
 		_tlbiel_pid(pid, RIC_FLUSH_ALL);
+	}
 	preempt_enable();
 }
 EXPORT_SYMBOL(radix__flush_all_mm);
@@ -644,10 +663,14 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		if (local) {
 			_tlbiel_pid(pid, RIC_FLUSH_TLB);
 		} else {
-			if (mm_needs_flush_escalation(mm))
+			if (mm_is_singlethreaded(mm)) {
+				_tlbie_pid(pid, RIC_FLUSH_ALL);
+				mm_reset_thread_local(mm);
+			} else if (mm_needs_flush_escalation(mm)) {
 				_tlbie_pid(pid, RIC_FLUSH_ALL);
-			else
+			} else {
 				_tlbie_pid(pid, RIC_FLUSH_TLB);
+			}
 		}
 	} else {
 		bool hflush = false;
@@ -802,13 +825,19 @@ static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
 	}
 
 	if (full) {
-		if (!local && mm_needs_flush_escalation(mm))
-			also_pwc = true;
-
-		if (local)
+		if (local) {
 			_tlbiel_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
-		else
-			_tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL: RIC_FLUSH_TLB);
+		} else {
+			if (mm_is_singlethreaded(mm)) {
+				_tlbie_pid(pid, RIC_FLUSH_ALL);
+				mm_reset_thread_local(mm);
+			} else {
+				if (mm_needs_flush_escalation(mm))
+					also_pwc = true;
+
+				_tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
+			}
+		}
 	} else {
 		if (local)
 			_tlbiel_va_range(start, end, pid, page_size, psize, also_pwc);
-- 
2.17.0
