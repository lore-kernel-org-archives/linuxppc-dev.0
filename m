Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR2lC6KwGzDqwZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 18:18:46 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id n89so13066550pfk.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 00:18:46 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 6/7] powerpc/64s/radix: reset mm_cpumask for single thread
 process when possible
Date: Tue, 31 Oct 2017 18:18:27 +1100
Message-Id: <20171031071828.28448-1-npiggin@gmail.com>
In-Reply-To: <20171031064432.25190-1-npiggin@gmail.com>
References: <20171031064432.25190-1-npiggin@gmail.com>
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

There is a lot of tuning we can do with this, and more sophisticated
management of PIDs and stale translations across CPUs, but this is
something simple that can be done to significantly help single threaded
processes without changing behaviour too much.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/mmu_context.h | 19 +++++++++++++
 arch/powerpc/mm/tlb-radix.c            | 52 +++++++++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 20eae6f76247..05516027fd82 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/spinlock.h>
 #include <asm/mmu.h>	
 #include <asm/cputable.h>
@@ -153,6 +154,24 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
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
+		switch_mm_irqs_off(mm, tsk->active_mm, tsk);
+		mmdrop(mm);
+	}
+#endif
+
 	/* 64-bit Book3E keeps track of current PGD in the PACA */
 #ifdef CONFIG_PPC_BOOK3E_64
 	get_paca()->pgd = NULL;
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 49cc581a31cd..db7e696e4faf 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -255,10 +255,18 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
 		return;
 
 	preempt_disable();
-	if (!mm_is_thread_local(mm))
-		_tlbie_pid(pid, RIC_FLUSH_TLB);
-	else
+	if (!mm_is_thread_local(mm)) {
+		if (atomic_read(&mm->mm_users) == 1 && current->mm == mm) {
+			_tlbie_pid(pid, RIC_FLUSH_ALL);
+			atomic_set(&mm->context.active_cpus, 1);
+			cpumask_clear(mm_cpumask(mm));
+			cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+		} else {
+			_tlbie_pid(pid, RIC_FLUSH_TLB);
+		}
+	} else {
 		_tlbiel_pid(pid, RIC_FLUSH_TLB);
+	}
 	preempt_enable();
 }
 EXPORT_SYMBOL(radix__flush_tlb_mm);
@@ -272,10 +280,16 @@ void radix__flush_all_mm(struct mm_struct *mm)
 		return;
 
 	preempt_disable();
-	if (!mm_is_thread_local(mm))
+	if (!mm_is_thread_local(mm)) {
 		_tlbie_pid(pid, RIC_FLUSH_ALL);
-	else
+		if (atomic_read(&mm->mm_users) == 1 && current->mm == mm) {
+			atomic_set(&mm->context.active_cpus, 1);
+			cpumask_clear(mm_cpumask(mm));
+			cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+		}
+	} else {
 		_tlbiel_pid(pid, RIC_FLUSH_ALL);
+	}
 	preempt_enable();
 }
 EXPORT_SYMBOL(radix__flush_all_mm);
@@ -368,10 +382,18 @@ void radix__flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	}
 
 	if (full) {
-		if (local)
+		if (local) {
 			_tlbiel_pid(pid, RIC_FLUSH_TLB);
-		else
-			_tlbie_pid(pid, RIC_FLUSH_TLB);
+		} else {
+			if (atomic_read(&mm->mm_users) == 1 && current->mm == mm) {
+				_tlbie_pid(pid, RIC_FLUSH_ALL);
+				atomic_set(&mm->context.active_cpus, 1);
+				cpumask_clear(mm_cpumask(mm));
+				cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+			} else {
+				_tlbie_pid(pid, RIC_FLUSH_TLB);
+			}
+		}
 	} else {
 		bool hflush = false;
 		unsigned long hstart, hend;
@@ -481,10 +503,18 @@ static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
 	}
 
 	if (full) {
-		if (local)
+		if (local) {
 			_tlbiel_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
-		else
-			_tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL: RIC_FLUSH_TLB);
+		} else {
+			if (atomic_read(&mm->mm_users) == 1 && current->mm == mm) {
+				_tlbie_pid(pid, RIC_FLUSH_ALL);
+				atomic_set(&mm->context.active_cpus, 1);
+				cpumask_clear(mm_cpumask(mm));
+				cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
+			} else {
+				_tlbie_pid(pid, also_pwc ? RIC_FLUSH_ALL : RIC_FLUSH_TLB);
+			}
+		}
 	} else {
 		if (local)
 			_tlbiel_va_range(start, end, pid, page_size, psize, also_pwc);
-- 
2.15.0.rc2
