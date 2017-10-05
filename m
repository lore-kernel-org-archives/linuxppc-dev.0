Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y70nr4rdvzDr39
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:55:28 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org,
 cyrilbur@gmail.com
Subject: [PATCH] powerpc/tm: P9 disabled suspend mode workaround
Date: Thu,  5 Oct 2017 15:55:16 +1100
Message-Id: <20171005045516.26145-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Each POWER9 core is made of two super slices. Each super slice can
only have one thread at a time in TM suspend mode. The super slice
restricts ever entering a state where both threads are in suspend by
aborting transactions on tsuspend or exceptions into the kernel.

Unfortunately for context switch we need trechkpt which forces suspend
mode. If a thread is already in suspend and a second thread needs to
be restored that was suspended, the trechkpt must be executed.
Currently the trechkpt will hang in this case until the other thread
exits suspend. This causes problems for Linux resulting in hang and
RCU stall detectors going off.

To workaround this, we disable suspend in the core. This is done via a
firmware change which stops the hardware ever getting into suspend.
The hardware will always rollback a transaction on any tsuspend or
entry into the kernel.

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
---
 arch/powerpc/include/asm/cputable.h | 1 +
 arch/powerpc/kernel/cputable.c      | 7 +++++++
 arch/powerpc/kernel/process.c       | 2 ++
 arch/powerpc/kernel/signal_32.c     | 4 ++++
 arch/powerpc/kernel/signal_64.c     | 5 +++++
 5 files changed, 19 insertions(+)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a9bf921f4e..477e00b6a7 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -123,6 +123,7 @@ extern struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr);
 extern void identify_cpu_name(unsigned int pvr);
 extern void do_feature_fixups(unsigned long value, void *fixup_start,
 			      void *fixup_end);
+extern bool tm_suspend_supported(void);
 
 extern const char *powerpc_base_platform;
 
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 7608729160..70252843ff 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2301,6 +2301,13 @@ void __init identify_cpu_name(unsigned int pvr)
 	}
 }
 
+bool tm_suspend_supported(void)
+{
+	if (pvr_version_is(PVR_POWER9))
+		return false;
+	return true;
+}
+
 
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
 struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS] = {
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a0c74bbf34..5b81673c50 100644
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
index 92fb1c8dbb..9eac0131c0 100644
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
index c83c115858..6d28caf849 100644
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
2.11.0
