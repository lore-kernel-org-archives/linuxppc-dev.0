Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7hYQ5PGhzDql4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 18:47:06 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v967i25W118501
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 03:47:04 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2de4r9jyd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 03:47:04 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 6 Oct 2017 17:47:01 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v967kwc645482028
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 18:46:58 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v967l1dv017931
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 18:47:01 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 3/3] powerpc/tm: P9 disable transactionally suspended
 sigcontexts
Date: Fri,  6 Oct 2017 18:46:43 +1100
In-Reply-To: <20171006074643.25269-1-cyrilbur@gmail.com>
References: <20171006074643.25269-1-cyrilbur@gmail.com>
Message-Id: <20171006074643.25269-3-cyrilbur@gmail.com>
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

This patch blocks this from happening on POWER9 but sanity checking
sigcontexts passed in.

ptrace doesn't have this problem as only MSR SE and BE can be changed
via ptrace.

This patch also adds a number of WARN_ON() in case we every enter
suspend when we shouldn't. This should catch systems that don't have
the firmware change and are running TM.

A future firmware change will allow suspend mode on POWER9 but that is
going to require additional Linux changes to support. In the interim,
this allows TM to continue to (partially) work while stopping
userspace from crashing Linux.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c   | 2 ++
 arch/powerpc/kernel/signal_32.c | 4 ++++
 arch/powerpc/kernel/signal_64.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a0c74bbf3454..5b81673c5026 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -903,6 +903,8 @@ static inline void tm_reclaim_task(struct task_struct *tsk)
 	if (!MSR_TM_ACTIVE(thr->regs->msr))
 		goto out_and_saveregs;
 
+	WARN_ON(!tm_suspend_supported());
+
 	TM_DEBUG("--- tm_reclaim on pid %d (NIP=%lx, "
 		 "ccr=%lx, msr=%lx, trap=%lx)\n",
 		 tsk->pid, thr->regs->nip,
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 92fb1c8dbbd8..9eac0131c080 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -519,6 +519,8 @@ static int save_tm_user_regs(struct pt_regs *regs,
 {
 	unsigned long msr = regs->msr;
 
+	WARN_ON(!tm_suspend_supported());
+
 	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
 	 * just indicates to userland that we were doing a transaction, but we
 	 * don't want to return in transactional state.  This also ensures
@@ -769,6 +771,8 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	int i;
 #endif
 
+	if (!tm_suspend_supported())
+		return 1;
 	/*
 	 * restore general registers but not including MSR or SOFTE. Also
 	 * take care of keeping r2 (TLS) intact if not a signal.
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index c83c115858c1..6d28caf8496f 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -214,6 +214,8 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 
 	BUG_ON(!MSR_TM_ACTIVE(regs->msr));
 
+	WARN_ON(!tm_suspend_supported());
+
 	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
 	 * just indicates to userland that we were doing a transaction, but we
 	 * don't want to return in transactional state.  This also ensures
@@ -430,6 +432,9 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 
 	BUG_ON(tsk != current);
 
+	if (!tm_suspend_supported())
+		return -EINVAL;
+
 	/* copy the GPRs */
 	err |= __copy_from_user(regs->gpr, tm_sc->gp_regs, sizeof(regs->gpr));
 	err |= __copy_from_user(&tsk->thread.ckpt_regs, sc->gp_regs,
-- 
2.14.2
