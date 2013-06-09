Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 5/5] powerpc/tm: Fix return of active 64bit signals
Date: Sun,  9 Jun 2013 21:23:19 +1000
Message-Id: <1370776999-14108-5-git-send-email-mikey@neuling.org>
In-Reply-To: <1370776999-14108-1-git-send-email-mikey@neuling.org>
References: <1370776999-14108-1-git-send-email-mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we only restore signals which are transactionally suspended but it's
possible that the transaction can be restored even when it's active.  Most
likely this will result in a transactional rollback by the hardware as the
transaction will have been doomed by an earlier treclaim.

The current code is a legacy of earlier kernel implementations which did
software rollback of active transactions in the kernel.  That code has now gone
but we didn't correctly fix up this part of the signals code which still makes
assumptions based on having software rollback.

This changes the signal return code to always restore both contexts on 64 bit
signal return.  It also ensures that the MSR TM bits are properly restored from
the signal context which they are not currently.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@vger.kernel.org (v3.9 only)
---
 arch/powerpc/kernel/signal_64.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 3459473..887e99d 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -410,6 +410,10 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 
 	/* get MSR separately, transfer the LE bit if doing signal return */
 	err |= __get_user(msr, &sc->gp_regs[PT_MSR]);
+	/* pull in MSR TM from user context */
+	regs->msr = (regs->msr & ~MSR_TS_MASK) | (msr & MSR_TS_MASK);
+
+	/* pull in MSR LE from user context */
 	regs->msr = (regs->msr & ~MSR_LE) | (msr & MSR_LE);
 
 	/* The following non-GPR non-FPR non-VR state is also checkpointed: */
@@ -505,8 +509,6 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 	tm_enable();
 	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&current->thread, msr);
-	/* The task has moved into TM state S, so ensure MSR reflects this: */
-	regs->msr = (regs->msr & ~MSR_TS_MASK) | __MASK(33);
 
 	/* This loads the speculative FP/VEC state, if used */
 	if (msr & MSR_FP) {
@@ -654,7 +656,7 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (__get_user(msr, &uc->uc_mcontext.gp_regs[PT_MSR]))
 		goto badframe;
-	if (MSR_TM_SUSPENDED(msr)) {
+	if (MSR_TM_ACTIVE(msr)) {
 		/* We recheckpoint on return. */
 		struct ucontext __user *uc_transact;
 		if (__get_user(uc_transact, &uc->uc_link))
-- 
1.7.10.4
