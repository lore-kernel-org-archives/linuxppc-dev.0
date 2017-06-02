Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfGNC1lH3zDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 17:40:43 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id i206so8918131ita.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 00:40:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH 14/14] powerpc/64: context switch additional hwsync can be
 avoided
Date: Fri,  2 Jun 2017 17:39:46 +1000
Message-Id: <20170602073946.8983-15-npiggin@gmail.com>
In-Reply-To: <20170602073946.8983-1-npiggin@gmail.com>
References: <20170602073946.8983-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hwsync in the context switch code to prevent MMIO access being
reordered from the point of view of a single process if it gets
migrated to a different CPU is not required because there is an hwsync
performed earlier in the context switch path.

Comment this so it's clear enough if anything changes on the scheduler
or the powerpc sides. Remove the hwsync from _switch. This is worth 2-3%
context switch performance.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/barrier.h |  4 ++++
 arch/powerpc/kernel/entry_64.S     | 21 +++++++++++++++------
 kernel/sched/core.c                |  3 +++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index c0deafc212b8..8bbadbd3b3c7 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -74,6 +74,10 @@ do {									\
 	___p1;								\
 })
 
+/*
+ * This must resolve to hwsync on SMP for the context switch path. See
+ * _switch.
+ */
 #define smp_mb__before_spinlock()   smp_mb()
 
 #include <asm-generic/barrier.h>
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 012142fe39a4..2b1e57b33757 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -512,13 +512,22 @@ _GLOBAL(_switch)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
-#ifdef CONFIG_SMP
-	/* We need a sync somewhere here to make sure that if the
-	 * previous task gets rescheduled on another CPU, it sees all
-	 * stores it has performed on this one.
+	/*
+	 * On SMP kernels, care must be taken because a task may be
+	 * scheduled off CPUx and on to CPUy. Memory ordering must be
+	 * considered.
+	 *
+	 * Cacheable stores on CPUx will be visible when the task is
+	 * scheduled on CPUy by virtue of smp_store_release(t->on_cpu, 0)
+	 * pairing with smp_cond_load_acquire(!t->on_cpu) on the other
+	 * CPU.
+	 *
+	 * Uncacheable stores in the case of involuntary preemption must
+	 * be taken care of. The smp_mb__before_spin_lock() in __schedule()
+	 * is a hwsync, which orders mmio too. That does not have to be
+	 * in any particular place within the context switch path, because
+	 * the context switch path itself does not do any mmio.
 	 */
-	sync
-#endif /* CONFIG_SMP */
 
 	/*
 	 * The kernel context switch path must contain a spin_lock,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1f0688ad09d7..ff375012d2c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3394,6 +3394,9 @@ static void __sched notrace __schedule(bool preempt)
 	 * Make sure that signal_pending_state()->signal_pending() below
 	 * can't be reordered with __set_current_state(TASK_INTERRUPTIBLE)
 	 * done by the caller to avoid the race with signal_wake_up().
+	 *
+	 * smp_mb__before_spinlock() must be present for powerpc
+	 * (see powerpc smp_mb__before_spinlock()).
 	 */
 	smp_mb__before_spinlock();
 	rq_lock(rq, &rf);
-- 
2.11.0
