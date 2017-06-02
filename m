Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfGN80jHRzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 17:40:40 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id l145so8915026ita.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 00:40:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH 13/14] powerpc/64: context switch can avoid reservation clear
Date: Fri,  2 Jun 2017 17:39:45 +1000
Message-Id: <20170602073946.8983-14-npiggin@gmail.com>
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

There is no need to break reservation in _switch, because we are
guranteed that context switch path will include a larx/stcx.

Comment the guarantee and remove the reservation clear from _switch.
This is worth 1-2% in context switch performance.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S | 11 +++--------
 kernel/sched/core.c            |  6 ++++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 019a6322b982..012142fe39a4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -521,15 +521,10 @@ _GLOBAL(_switch)
 #endif /* CONFIG_SMP */
 
 	/*
-	 * If we optimise away the clear of the reservation in system
-	 * calls because we know the CPU tracks the address of the
-	 * reservation, then we need to clear it here to cover the
-	 * case that the kernel context switch path has no larx
-	 * instructions.
+	 * The kernel context switch path must contain a spin_lock,
+	 * which contains larx/stcx, which will clear any reservation
+	 * of the task being switched.
 	 */
-BEGIN_FTR_SECTION
-	ldarx	r6,0,r1
-END_FTR_SECTION_IFSET(CPU_FTR_STCX_CHECKS_ADDRESS)
 
 BEGIN_FTR_SECTION
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 803c3bc274c4..1f0688ad09d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2875,6 +2875,12 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	rq_unpin_lock(rq, rf);
 	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
 
+	/*
+	 * Some architectures require that a spin lock is taken before
+	 * _switch. The rq_lock satisfies this condition. See powerpc
+	 * _switch for details.
+	 */
+
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
 	barrier();
-- 
2.11.0
