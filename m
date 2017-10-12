Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCRc9357BzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 21:17:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, benh@kernel.crashing.org, stewart@linux.vnet.ibm.com,
 cyrilbur@gmail.com
Subject: [PATCH 4/4] powerpc/tm: P9 disable transactionally suspended
 sigcontexts
Date: Thu, 12 Oct 2017 21:17:19 +1100
Message-Id: <1507803439-12862-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Neuling <mikey@neuling.org>

Unfortunately userspace can construct a sigcontext which enables
suspend. Thus userspace can force Linux into a path where trechkpt is
executed.

This patch blocks this from happening on POWER9 by sanity checking
sigcontexts passed in.

ptrace doesn't have this problem as only MSR SE and BE can be changed
via ptrace.

This patch also adds a number of WARN_ON() in case we ever enter
suspend when we shouldn't. This should catch systems that don't have
the firmware change and are running TM.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/process.c   | 2 ++
 arch/powerpc/kernel/signal_32.c | 4 ++++
 arch/powerpc/kernel/signal_64.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b02807ea54dc..c051dc2b42ad 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -910,6 +910,8 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 	if (!MSR_TM_ACTIVE(thr->regs->msr))
 		goto out_and_saveregs;
 
+	WARN_ON(tm_suspend_disabled);
+
 	TM_DEBUG("--- tm_reclaim on pid %d (NIP=%lx, "
 		 "ccr=%lx, msr=%lx, trap=%lx)\n",
 		 tsk->pid, thr->regs->nip,
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 92fb1c8dbbd8..1dd5fa0f65fd 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -519,6 +519,8 @@ static int save_tm_user_regs(struct pt_regs *regs,
 {
 	unsigned long msr = regs->msr;
 
+	WARN_ON(tm_suspend_disabled);
+
 	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
 	 * just indicates to userland that we were doing a transaction, but we
 	 * don't want to return in transactional state.  This also ensures
@@ -769,6 +771,8 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	int i;
 #endif
 
+	if (tm_suspend_disabled)
+		return 1;
 	/*
 	 * restore general registers but not including MSR or SOFTE. Also
 	 * take care of keeping r2 (TLS) intact if not a signal.
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index c83c115858c1..4dfdd8e56836 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -214,6 +214,8 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 
 	BUG_ON(!MSR_TM_ACTIVE(regs->msr));
 
+	WARN_ON(tm_suspend_disabled);
+
 	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
 	 * just indicates to userland that we were doing a transaction, but we
 	 * don't want to return in transactional state.  This also ensures
@@ -430,6 +432,9 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 
 	BUG_ON(tsk != current);
 
+	if (tm_suspend_disabled)
+		return -EINVAL;
+
 	/* copy the GPRs */
 	err |= __copy_from_user(regs->gpr, tm_sc->gp_regs, sizeof(regs->gpr));
 	err |= __copy_from_user(&tsk->thread.ckpt_regs, sc->gp_regs,
-- 
2.7.4
