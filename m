Return-Path: <mathieu.desnoyers@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3fCq66y6zDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Sep 2017 03:47:49 +1000 (AEST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>,
 gromer@google.com, Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org
Subject: [PATCH v5 for 4.14 1/3] membarrier: Provide register expedited
 private command
Date: Fri, 29 Sep 2017 13:47:18 -0400
Message-Id: <20170929174720.18330-1-mathieu.desnoyers@efficios.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide a new command allowing processes to register their intent to use
the private expedited command.

This allows PowerPC to skip the full memory barrier in switch_mm(), and
only issue the barrier when scheduling into a task belonging to a
process that has registered to use expedited private.

Processes are now required to register before using
MEMBARRIER_CMD_PRIVATE_EXPEDITED, otherwise that command returns EPERM.

Changes since v1:
- Use test_ti_thread_flag(next, ...) instead of test_thread_flag() in
  powerpc membarrier_arch_sched_in(), given that we want to specifically
  check the next thread state.
- Add missing ARCH_HAS_MEMBARRIER_HOOKS in Kconfig.
- Use task_thread_info() to pass thread_info from task to
  *_ti_thread_flag().

Changes since v2:
- Move membarrier_arch_sched_in() call to finish_task_switch().
- Check for NULL t->mm in membarrier_arch_fork().
- Use membarrier_sched_in() in generic code, which invokes the
  arch-specific membarrier_arch_sched_in(). This fixes allnoconfig
  build on PowerPC.
- Move asm/membarrier.h include under CONFIG_MEMBARRIER, fixing
  allnoconfig build on PowerPC.
- Build and runtime tested on PowerPC.

Changes since v3:
- Simply rely on copy_mm() to copy the membarrier_private_expedited mm
  field on fork.
- powerpc: test thread flag instead of reading
  membarrier_private_expedited in membarrier_arch_fork().
- powerpc: skip memory barrier in membarrier_arch_sched_in() if coming
  from kernel thread, since mmdrop() implies a full barrier.
- Set membarrier_private_expedited to 1 only after arch registration
  code, thus eliminating a race where concurrent commands could succeed
  when they should fail if issued concurrently with process
  registration.
- Use READ_ONCE() for membarrier_private_expedited field access in
  membarrier_private_expedited. Matches WRITE_ONCE() performed in
  process registration.

Changes since v4:
- Move powerpc hook from sched_in() to switch_mm(), based on feedback
  from Nicholas Piggin.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>
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
---
 MAINTAINERS                            |  2 ++
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/membarrier.h  | 43 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/thread_info.h |  3 ++
 arch/powerpc/kernel/Makefile           |  2 ++
 arch/powerpc/kernel/membarrier.c       | 45 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/mmu_context.c          |  7 +++++
 fs/exec.c                              |  1 +
 include/linux/mm_types.h               |  3 ++
 include/linux/sched/mm.h               | 50 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/membarrier.h        | 23 +++++++++++-----
 init/Kconfig                           |  3 ++
 kernel/fork.c                          |  2 ++
 kernel/sched/core.c                    | 10 -------
 kernel/sched/membarrier.c              | 25 ++++++++++++++---
 15 files changed, 199 insertions(+), 21 deletions(-)
 create mode 100644 arch/powerpc/include/asm/membarrier.h
 create mode 100644 arch/powerpc/kernel/membarrier.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6671f375f7fc..f11d8aece00d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8816,6 +8816,8 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	kernel/sched/membarrier.c
 F:	include/uapi/linux/membarrier.h
+F:	arch/powerpc/kernel/membarrier.c
+F:	arch/powerpc/include/asm/membarrier.h
 
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 809c468edab1..6f44c5f74f71 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -138,6 +138,7 @@ config PPC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_MEMBARRIER_HOOKS
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/powerpc/include/asm/membarrier.h b/arch/powerpc/include/asm/membarrier.h
new file mode 100644
index 000000000000..61152a7a3cf9
--- /dev/null
+++ b/arch/powerpc/include/asm/membarrier.h
@@ -0,0 +1,43 @@
+#ifndef _ASM_POWERPC_MEMBARRIER_H
+#define _ASM_POWERPC_MEMBARRIER_H
+
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+		struct mm_struct *next, struct task_struct *tsk)
+{
+	/*
+	 * Only need the full barrier when switching between processes.
+	 * Barrier when switching from kernel to userspace is not
+	 * required here, given that it is implied by mmdrop(). Barrier
+	 * when switching from userspace to kernel is not needed after
+	 * store to rq->curr.
+	 */
+	if (likely(!test_ti_thread_flag(task_thread_info(tsk),
+			TIF_MEMBARRIER_PRIVATE_EXPEDITED) || !prev))
+		return;
+
+	/*
+	 * The membarrier system call requires a full memory barrier
+	 * after storing to rq->curr, before going back to user-space.
+	 */
+	smp_mb();
+}
+static inline void membarrier_arch_fork(struct task_struct *t,
+		unsigned long clone_flags)
+{
+	/*
+	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
+	 * fork is protected by siglock. membarrier_arch_fork is called
+	 * with siglock held.
+	 */
+	if (test_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED))
+		set_ti_thread_flag(task_thread_info(t),
+				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
+}
+static inline void membarrier_arch_execve(struct task_struct *t)
+{
+	clear_ti_thread_flag(task_thread_info(t),
+			TIF_MEMBARRIER_PRIVATE_EXPEDITED);
+}
+void membarrier_arch_register_private_expedited(struct task_struct *t);
+
+#endif /* _ASM_POWERPC_MEMBARRIER_H */
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index a941cc6fc3e9..2a208487724b 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -100,6 +100,7 @@ static inline struct thread_info *current_thread_info(void)
 #if defined(CONFIG_PPC64)
 #define TIF_ELF2ABI		18	/* function descriptors must die! */
 #endif
+#define TIF_MEMBARRIER_PRIVATE_EXPEDITED	19	/* membarrier */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -119,6 +120,8 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 #define _TIF_NOHZ		(1<<TIF_NOHZ)
+#define _TIF_MEMBARRIER_PRIVATE_EXPEDITED \
+				(1<<TIF_MEMBARRIER_PRIVATE_EXPEDITED)
 #define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
 				 _TIF_NOHZ)
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 91960f83039c..2dd4b9e3313a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -135,6 +135,8 @@ endif
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
+obj-$(CONFIG_MEMBARRIER)	+= membarrier.o
+
 # Disable GCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
 UBSAN_SANITIZE_prom_init.o := n
diff --git a/arch/powerpc/kernel/membarrier.c b/arch/powerpc/kernel/membarrier.c
new file mode 100644
index 000000000000..b0d79a5f5981
--- /dev/null
+++ b/arch/powerpc/kernel/membarrier.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2010-2017 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * membarrier system call - PowerPC architecture code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/thread_info.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+
+void membarrier_arch_register_private_expedited(struct task_struct *p)
+{
+	struct task_struct *t;
+
+	if (get_nr_threads(p) == 1) {
+		set_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED);
+		return;
+	}
+	/*
+	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
+	 * fork is protected by siglock.
+	 */
+	spin_lock(&p->sighand->siglock);
+	for_each_thread(p, t)
+		set_ti_thread_flag(task_thread_info(t),
+				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
+	spin_unlock(&p->sighand->siglock);
+	/*
+	 * Ensure all future scheduler executions will observe the new
+	 * thread flag state for this process.
+	 */
+	synchronize_sched();
+}
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
diff --git a/fs/exec.c b/fs/exec.c
index ac34d9724684..b2448f2731b3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1802,6 +1802,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
+	membarrier_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current);
 	free_bprm(bprm);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 46f4ecf5479a..5e0fe8ce053b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -445,6 +445,9 @@ struct mm_struct {
 	unsigned long flags; /* Must use atomic bitops to access the bits */
 
 	struct core_state *core_state; /* coredumping support */
+#ifdef CONFIG_MEMBARRIER
+	int membarrier_private_expedited;
+#endif
 #ifdef CONFIG_AIO
 	spinlock_t			ioctx_lock;
 	struct kioctx_table __rcu	*ioctx_table;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 3a19c253bdb1..4af1b719c65f 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -205,4 +205,54 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
 }
 
+#ifdef CONFIG_MEMBARRIER
+
+#ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
+#include <asm/membarrier.h>
+#else
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+		struct mm_struct *next, struct task_struct *tsk)
+{
+}
+static inline void membarrier_arch_fork(struct task_struct *t,
+		unsigned long clone_flags)
+{
+}
+static inline void membarrier_arch_execve(struct task_struct *t)
+{
+}
+static inline void membarrier_arch_register_private_expedited(
+		struct task_struct *p)
+{
+}
+#endif
+
+static inline void membarrier_fork(struct task_struct *t,
+		unsigned long clone_flags)
+{
+	/*
+	 * Prior copy_mm() copies the membarrier_private_expedited field
+	 * from current->mm to t->mm.
+	 */
+	membarrier_arch_fork(t, clone_flags);
+}
+static inline void membarrier_execve(struct task_struct *t)
+{
+	t->mm->membarrier_private_expedited = 0;
+	membarrier_arch_execve(t);
+}
+#else
+static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
+		struct mm_struct *next, struct task_struct *tsk)
+{
+}
+static inline void membarrier_fork(struct task_struct *t,
+		unsigned long clone_flags)
+{
+}
+static inline void membarrier_execve(struct task_struct *t)
+{
+}
+#endif
+
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
index 6d47b3249d8a..4e01ad7ffe98 100644
--- a/include/uapi/linux/membarrier.h
+++ b/include/uapi/linux/membarrier.h
@@ -52,21 +52,30 @@
  *                          (non-running threads are de facto in such a
  *                          state). This only covers threads from the
  *                          same processes as the caller thread. This
- *                          command returns 0. The "expedited" commands
- *                          complete faster than the non-expedited ones,
- *                          they never block, but have the downside of
- *                          causing extra overhead.
+ *                          command returns 0 on success. The
+ *                          "expedited" commands complete faster than
+ *                          the non-expedited ones, they never block,
+ *                          but have the downside of causing extra
+ *                          overhead. A process needs to register its
+ *                          intent to use the private expedited command
+ *                          prior to using it, otherwise this command
+ *                          returns -EPERM.
+ * @MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
+ *                          Register the process intent to use
+ *                          MEMBARRIER_CMD_PRIVATE_EXPEDITED. Always
+ *                          returns 0.
  *
  * Command to be passed to the membarrier system call. The commands need to
  * be a single bit each, except for MEMBARRIER_CMD_QUERY which is assigned to
  * the value 0.
  */
 enum membarrier_cmd {
-	MEMBARRIER_CMD_QUERY			= 0,
-	MEMBARRIER_CMD_SHARED			= (1 << 0),
+	MEMBARRIER_CMD_QUERY				= 0,
+	MEMBARRIER_CMD_SHARED				= (1 << 0),
 	/* reserved for MEMBARRIER_CMD_SHARED_EXPEDITED (1 << 1) */
 	/* reserved for MEMBARRIER_CMD_PRIVATE (1 << 2) */
-	MEMBARRIER_CMD_PRIVATE_EXPEDITED	= (1 << 3),
+	MEMBARRIER_CMD_PRIVATE_EXPEDITED		= (1 << 3),
+	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED	= (1 << 4),
 };
 
 #endif /* _UAPI_LINUX_MEMBARRIER_H */
diff --git a/init/Kconfig b/init/Kconfig
index 78cb2461012e..a3dc6a66f0d1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1400,6 +1400,9 @@ config MEMBARRIER
 
 	  If unsure, say Y.
 
+config ARCH_HAS_MEMBARRIER_HOOKS
+	bool
+
 config EMBEDDED
 	bool "Embedded system"
 	option allnoconfig_y
diff --git a/kernel/fork.c b/kernel/fork.c
index 10646182440f..bd4a93915e08 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1840,6 +1840,8 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	copy_seccomp(p);
 
+	membarrier_fork(p, clone_flags);
+
 	/*
 	 * Process group and session signals need to be delivered to just the
 	 * parent before the fork or both the parent and the child after the
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 18a6966567da..afbdc260d4da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2644,16 +2644,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	prev_state = prev->state;
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
-	/*
-	 * The membarrier system call requires a full memory barrier
-	 * after storing to rq->curr, before going back to user-space.
-	 *
-	 * TODO: This smp_mb__after_unlock_lock can go away if PPC end
-	 * up adding a full barrier to switch_mm(), or we should figure
-	 * out if a smp_mb__after_unlock_lock is really the proper API
-	 * to use.
-	 */
-	smp_mb__after_unlock_lock();
 	finish_lock_switch(rq, prev);
 	finish_arch_post_lock_switch();
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index a92fddc22747..f06949a279ca 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -26,21 +26,25 @@
  * except MEMBARRIER_CMD_QUERY.
  */
 #define MEMBARRIER_CMD_BITMASK	\
-	(MEMBARRIER_CMD_SHARED | MEMBARRIER_CMD_PRIVATE_EXPEDITED)
+	(MEMBARRIER_CMD_SHARED | MEMBARRIER_CMD_PRIVATE_EXPEDITED	\
+	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED)
 
 static void ipi_mb(void *info)
 {
 	smp_mb();	/* IPIs should be serializing but paranoid. */
 }
 
-static void membarrier_private_expedited(void)
+static int membarrier_private_expedited(void)
 {
 	int cpu;
 	bool fallback = false;
 	cpumask_var_t tmpmask;
 
+	if (!READ_ONCE(current->mm->membarrier_private_expedited))
+		return -EPERM;
+
 	if (num_online_cpus() == 1)
-		return;
+		return 0;
 
 	/*
 	 * Matches memory barriers around rq->curr modification in
@@ -94,6 +98,17 @@ static void membarrier_private_expedited(void)
 	 * rq->curr modification in scheduler.
 	 */
 	smp_mb();	/* exit from system call is not a mb */
+	return 0;
+}
+
+static void membarrier_register_private_expedited(void)
+{
+	struct task_struct *p = current;
+
+	if (READ_ONCE(p->mm->membarrier_private_expedited))
+		return;
+	membarrier_arch_register_private_expedited(p);
+	WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
 }
 
 /**
@@ -144,7 +159,9 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 			synchronize_sched();
 		return 0;
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
-		membarrier_private_expedited();
+		return membarrier_private_expedited();
+	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
+		membarrier_register_private_expedited();
 		return 0;
 	default:
 		return -EINVAL;
-- 
2.11.0
