Return-Path: <mathieu.desnoyers@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y35tt1TKNzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 06:31:17 +1000 (AEST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 Maged Michael <maged.michael@gmail.com>, gromer@google.com,
 Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH for 4.14] membarrier powerpc: Move hook to switch_mm()
Date: Thu, 28 Sep 2017 16:21:27 -0400
Message-Id: <20170928202127.18472-1-mathieu.desnoyers@efficios.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nick has a valid point that the sched_in() hook is a fast-path compared
to switch_mm(). Adding an extra TIF test in a fast-path to save a
barrier in a comparatively slow-path is therefore not such a good idea
overall.

Therefore, move the architecture hook to switch_mm() instead.

[ This patch is aimed at Paul's tree. It applies on top of
  "membarrier: Provide register expedited private command (v4)" and
  "membarrier: Document scheduler barrier requirements (v4)". ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Andrew Hunter <ahh@google.com>
CC: Maged Michael <maged.michael@gmail.com>
CC: gromer@google.com
CC: Avi Kivity <avi@scylladb.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Dave Watson <davejwatson@fb.com>
CC: Alan Stern <stern@rowland.harvard.edu>
CC: Will Deacon <will.deacon@arm.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-arch@vger.kernel.org
---
 arch/powerpc/include/asm/membarrier.h |  9 ++++-----
 arch/powerpc/mm/mmu_context.c         |  7 +++++++
 include/linux/sched/mm.h              | 13 ++++---------
 kernel/sched/core.c                   |  6 ++----
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/membarrier.h b/arch/powerpc/include/asm/membarrier.h
index 588154c1cf57..61152a7a3cf9 100644
--- a/arch/powerpc/include/asm/membarrier.h
+++ b/arch/powerpc/include/asm/membarrier.h
@@ -1,8 +1,8 @@
 #ifndef _ASM_POWERPC_MEMBARRIER_H
 #define _ASM_POWERPC_MEMBARRIER_H
 
-static inline void membarrier_arch_sched_in(struct task_struct *prev,
-		struct task_struct *next)
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+		struct mm_struct *next, struct task_struct *tsk)
 {
 	/*
 	 * Only need the full barrier when switching between processes.
@@ -11,9 +11,8 @@ static inline void membarrier_arch_sched_in(struct task_struct *prev,
 	 * when switching from userspace to kernel is not needed after
 	 * store to rq->curr.
 	 */
-	if (likely(!test_ti_thread_flag(task_thread_info(next),
-			TIF_MEMBARRIER_PRIVATE_EXPEDITED)
-			|| !prev->mm || prev->mm == next->mm))
+	if (likely(!test_ti_thread_flag(task_thread_info(tsk),
+			TIF_MEMBARRIER_PRIVATE_EXPEDITED) || !prev))
 		return;
 
 	/*
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index 0f613bc63c50..22f5c91cdc38 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -12,6 +12,7 @@
 
 #include <linux/mm.h>
 #include <linux/cpu.h>
+#include <linux/sched/mm.h>
 
 #include <asm/mmu_context.h>
 
@@ -67,6 +68,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 *
 		 * On the read side the barrier is in pte_xchg(), which orders
 		 * the store to the PTE vs the load of mm_cpumask.
+		 *
+		 * This full barrier is needed by membarrier when switching
+		 * between processes after store to rq->curr, before user-space
+		 * memory accesses.
 		 */
 		smp_mb();
 
@@ -89,6 +94,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 	if (new_on_cpu)
 		radix_kvm_prefetch_workaround(next);
+	else
+		membarrier_arch_switch_mm(prev, next, tsk);
 
 	/*
 	 * The actual HW switching method differs between the various
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 1bd10c2c0893..d5a9ab8f3836 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -215,8 +215,8 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
 #include <asm/membarrier.h>
 #else
-static inline void membarrier_arch_sched_in(struct task_struct *prev,
-		struct task_struct *next)
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+		struct mm_struct *next, struct task_struct *tsk)
 {
 }
 static inline void membarrier_arch_fork(struct task_struct *t,
@@ -232,11 +232,6 @@ static inline void membarrier_arch_register_private_expedited(
 }
 #endif
 
-static inline void membarrier_sched_in(struct task_struct *prev,
-		struct task_struct *next)
-{
-	membarrier_arch_sched_in(prev, next);
-}
 static inline void membarrier_fork(struct task_struct *t,
 		unsigned long clone_flags)
 {
@@ -252,8 +247,8 @@ static inline void membarrier_execve(struct task_struct *t)
 	membarrier_arch_execve(t);
 }
 #else
-static inline void membarrier_sched_in(struct task_struct *prev,
-		struct task_struct *next)
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+		struct mm_struct *next, struct task_struct *tsk)
 {
 }
 static inline void membarrier_fork(struct task_struct *t,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6254f87645de..8585abebe32b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2643,7 +2643,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 */
 	prev_state = prev->state;
 	vtime_task_switch(prev);
-	membarrier_sched_in(prev, current);
 	perf_event_task_sched_in(prev, current);
 	finish_lock_switch(rq, prev);
 	finish_arch_post_lock_switch();
@@ -3357,13 +3356,12 @@ static void __sched notrace __schedule(bool preempt)
 		 *
 		 * Here are the schemes providing that barrier on the
 		 * various architectures:
-		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc,
+		 * - mm ? switch_mm() : mmdrop() for x86, s390, sparc, PowerPC.
+		 *   switch_mm() rely on membarrier_arch_switch_mm() on PowerPC.
 		 * - finish_lock_switch() for weakly-ordered
 		 *   architectures where spin_unlock is a full barrier,
 		 * - switch_to() for arm64 (weakly-ordered, spin_unlock
 		 *   is a RELEASE barrier),
-		 * - membarrier_arch_sched_in() for PowerPC,
-		 *   (weakly-ordered, spin_unlock is a RELEASE barrier).
 		 */
 		++*switch_count;
 
-- 
2.11.0
