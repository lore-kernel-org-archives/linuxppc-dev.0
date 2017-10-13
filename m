Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDCRV07NjzDrCl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 03:12:37 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9DG5Dqs095582
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 12:12:35 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dk08thcjf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 12:12:34 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 13 Oct 2017 12:12:34 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, mathieu.desnoyers@efficios.com, peterz@infradead.org,
 boqun.feng@gmail.com, ahh@google.com, maged.michael@gmail.com,
 gromer@google.com, avi@scylladb.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, davejwatson@fb.com,
 stern@rowland.harvard.edu, will.deacon@arm.com, luto@kernel.org,
 viro@zeniv.linux.org.uk, piggin@gmail.com, linux-arch@vger.kernel.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH tip/sched/membarrier 5/5] Fix: membarrier: Handle CLONE_VM +
 !CLONE_THREAD correctly on powerpc
Date: Fri, 13 Oct 2017 09:12:25 -0700
In-Reply-To: <20171012170051.GA27468@linux.vnet.ibm.com>
References: <20171012170051.GA27468@linux.vnet.ibm.com>
Message-Id: <1507911145-4134-5-git-send-email-paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Threads targeting the same VM but which belong to different thread
groups is a tricky case. It has a few consequences:

It turns out that we cannot rely on get_nr_threads(p) to count the
number of threads using a VM. We can use
(atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)
instead to skip the synchronize_sched() for cases where the VM only has
a single user, and that user only has a single thread.

It also turns out that we cannot use for_each_thread() to set
thread flags in all threads using a VM, as it only iterates on the
thread group.

Therefore, test the membarrier state variable directly rather than
relying on thread flags. This means
membarrier_register_private_expedited() needs to set the
MEMBARRIER_STATE_SWITCH_MM flag, issue synchronize_sched(), and only
then set MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY which allows private
expedited membarrier commands to succeed. membarrier_arch_switch_mm()
now tests for the MEMBARRIER_STATE_SWITCH_MM flag.

Changes since v1:
- Remove membarrier thread flag on powerpc (now unused).

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
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
CC: Nicholas Piggin <npiggin@gmail.com>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-arch@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/membarrier.h  | 21 ++-------------------
 arch/powerpc/include/asm/thread_info.h |  3 ---
 arch/powerpc/kernel/membarrier.c       | 17 ++++-------------
 include/linux/mm_types.h               |  2 +-
 include/linux/sched/mm.h               | 28 ++++++----------------------
 kernel/fork.c                          |  2 --
 kernel/sched/membarrier.c              | 16 +++++++++++++---
 7 files changed, 26 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/membarrier.h b/arch/powerpc/include/asm/membarrier.h
index 61152a7a3cf9..0951646253d9 100644
--- a/arch/powerpc/include/asm/membarrier.h
+++ b/arch/powerpc/include/asm/membarrier.h
@@ -11,8 +11,8 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 	 * when switching from userspace to kernel is not needed after
 	 * store to rq->curr.
 	 */
-	if (likely(!test_ti_thread_flag(task_thread_info(tsk),
-			TIF_MEMBARRIER_PRIVATE_EXPEDITED) || !prev))
+	if (likely(!(atomic_read(&next->membarrier_state)
+			& MEMBARRIER_STATE_SWITCH_MM) || !prev))
 		return;
 
 	/*
@@ -21,23 +21,6 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 	 */
 	smp_mb();
 }
-static inline void membarrier_arch_fork(struct task_struct *t,
-		unsigned long clone_flags)
-{
-	/*
-	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
-	 * fork is protected by siglock. membarrier_arch_fork is called
-	 * with siglock held.
-	 */
-	if (test_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED))
-		set_ti_thread_flag(task_thread_info(t),
-				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
-}
-static inline void membarrier_arch_execve(struct task_struct *t)
-{
-	clear_ti_thread_flag(task_thread_info(t),
-			TIF_MEMBARRIER_PRIVATE_EXPEDITED);
-}
 void membarrier_arch_register_private_expedited(struct task_struct *t);
 
 #endif /* _ASM_POWERPC_MEMBARRIER_H */
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 2a208487724b..a941cc6fc3e9 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -100,7 +100,6 @@ static inline struct thread_info *current_thread_info(void)
 #if defined(CONFIG_PPC64)
 #define TIF_ELF2ABI		18	/* function descriptors must die! */
 #endif
-#define TIF_MEMBARRIER_PRIVATE_EXPEDITED	19	/* membarrier */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -120,8 +119,6 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 #define _TIF_NOHZ		(1<<TIF_NOHZ)
-#define _TIF_MEMBARRIER_PRIVATE_EXPEDITED \
-				(1<<TIF_MEMBARRIER_PRIVATE_EXPEDITED)
 #define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
 				 _TIF_NOHZ)
diff --git a/arch/powerpc/kernel/membarrier.c b/arch/powerpc/kernel/membarrier.c
index b0d79a5f5981..4795ad59b833 100644
--- a/arch/powerpc/kernel/membarrier.c
+++ b/arch/powerpc/kernel/membarrier.c
@@ -19,24 +19,15 @@
 #include <linux/thread_info.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/atomic.h>
 
 void membarrier_arch_register_private_expedited(struct task_struct *p)
 {
-	struct task_struct *t;
+	struct mm_struct *mm = p->mm;
 
-	if (get_nr_threads(p) == 1) {
-		set_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED);
+	atomic_or(MEMBARRIER_STATE_SWITCH_MM, &mm->membarrier_state);
+	if (atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)
 		return;
-	}
-	/*
-	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
-	 * fork is protected by siglock.
-	 */
-	spin_lock(&p->sighand->siglock);
-	for_each_thread(p, t)
-		set_ti_thread_flag(task_thread_info(t),
-				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
-	spin_unlock(&p->sighand->siglock);
 	/*
 	 * Ensure all future scheduler executions will observe the new
 	 * thread flag state for this process.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5e0fe8ce053b..1861ea8dba77 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -446,7 +446,7 @@ struct mm_struct {
 
 	struct core_state *core_state; /* coredumping support */
 #ifdef CONFIG_MEMBARRIER
-	int membarrier_private_expedited;
+	atomic_t membarrier_state;
 #endif
 #ifdef CONFIG_AIO
 	spinlock_t			ioctx_lock;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 40379edac388..e88c57917ce2 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -218,35 +218,23 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 
 #ifdef CONFIG_MEMBARRIER
 
+enum {
+	MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY	= (1U << 0),
+	MEMBARRIER_STATE_SWITCH_MM			= (1U << 1),
+};
+
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
 #include <asm/membarrier.h>
 #else
-static inline void membarrier_arch_fork(struct task_struct *t,
-		unsigned long clone_flags)
-{
-}
-static inline void membarrier_arch_execve(struct task_struct *t)
-{
-}
 static inline void membarrier_arch_register_private_expedited(
 		struct task_struct *p)
 {
 }
 #endif
 
-static inline void membarrier_fork(struct task_struct *t,
-		unsigned long clone_flags)
-{
-	/*
-	 * Prior copy_mm() copies the membarrier_private_expedited field
-	 * from current->mm to t->mm.
-	 */
-	membarrier_arch_fork(t, clone_flags);
-}
 static inline void membarrier_execve(struct task_struct *t)
 {
-	t->mm->membarrier_private_expedited = 0;
-	membarrier_arch_execve(t);
+	atomic_set(&t->mm->membarrier_state, 0);
 }
 #else
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
@@ -255,10 +243,6 @@ static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 {
 }
 #endif
-static inline void membarrier_fork(struct task_struct *t,
-		unsigned long clone_flags)
-{
-}
 static inline void membarrier_execve(struct task_struct *t)
 {
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 0171db20176e..e702cb9ffbd8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1858,8 +1858,6 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	copy_seccomp(p);
 
-	membarrier_fork(p, clone_flags);
-
 	/*
 	 * Process group and session signals need to be delivered to just the
 	 * parent before the fork or both the parent and the child after the
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index f06949a279ca..23bd256f8458 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -18,6 +18,7 @@
 #include <linux/membarrier.h>
 #include <linux/tick.h>
 #include <linux/cpumask.h>
+#include <linux/atomic.h>
 
 #include "sched.h"	/* for cpu_rq(). */
 
@@ -40,7 +41,8 @@ static int membarrier_private_expedited(void)
 	bool fallback = false;
 	cpumask_var_t tmpmask;
 
-	if (!READ_ONCE(current->mm->membarrier_private_expedited))
+	if (!(atomic_read(&current->mm->membarrier_state)
+			& MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY))
 		return -EPERM;
 
 	if (num_online_cpus() == 1)
@@ -104,11 +106,19 @@ static int membarrier_private_expedited(void)
 static void membarrier_register_private_expedited(void)
 {
 	struct task_struct *p = current;
+	struct mm_struct *mm = p->mm;
 
-	if (READ_ONCE(p->mm->membarrier_private_expedited))
+	/*
+	 * We need to consider threads belonging to different thread
+	 * groups, which use the same mm. (CLONE_VM but not
+	 * CLONE_THREAD).
+	 */
+	if (atomic_read(&mm->membarrier_state)
+			& MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY)
 		return;
 	membarrier_arch_register_private_expedited(p);
-	WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
+	atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
+			&mm->membarrier_state);
 }
 
 /**
-- 
2.5.2
