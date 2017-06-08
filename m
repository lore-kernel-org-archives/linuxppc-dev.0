Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk8fM1dkkzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:36:27 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id v18so4951224pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:36:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/4] powerpc/64: context switch an hwsync instruction can be
 avoided
Date: Fri,  9 Jun 2017 01:36:08 +1000
Message-Id: <20170608153609.19217-3-npiggin@gmail.com>
In-Reply-To: <20170608153609.19217-1-npiggin@gmail.com>
References: <20170608153609.19217-1-npiggin@gmail.com>
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
or the powerpc sides. Remove the hwsync from _switch.

This improves context switch performance by 2-3% on POWER8.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/barrier.h |  5 +++++
 arch/powerpc/kernel/entry_64.S     | 23 +++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index c0deafc212b8..25d42bd3f114 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -74,6 +74,11 @@ do {									\
 	___p1;								\
 })
 
+/*
+ * This must resolve to hwsync on SMP for the context switch path.
+ * See _switch, and core scheduler context switch memory ordering
+ * comments.
+ */
 #define smp_mb__before_spinlock()   smp_mb()
 
 #include <asm-generic/barrier.h>
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 273a35926534..fb143859cc68 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -512,13 +512,24 @@ _GLOBAL(_switch)
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
+	 * scheduled on CPUy by virtue of the core scheduler barriers
+	 * (see "Notes on Program-Order guarantees on SMP systems." in
+	 * kernel/sched/core.c).
+	 *
+	 * Uncacheable stores in the case of involuntary preemption must
+	 * be taken care of. The smp_mb__before_spin_lock() in __schedule()
+	 * is implemented as hwsync on powerpc, which orders MMIO too. So
+	 * long as there is an hwsync in the context switch path, it will
+	 * be executed on the source CPU after the task has performed
+	 * all MMIO ops on that CPU, and on the destination CPU before the
+	 * task performs any MMIO ops there.
 	 */
-	sync
-#endif /* CONFIG_SMP */
 
 	/*
 	 * The kernel context switch path must contain a spin_lock,
-- 
2.11.0
