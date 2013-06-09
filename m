Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 3/5] powerpc/tm: Fix restoration of MSR on 32bit signal
 return
Date: Sun,  9 Jun 2013 21:23:17 +1000
Message-Id: <1370776999-14108-3-git-send-email-mikey@neuling.org>
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

Currently we clear out the MSR TM bits on signal return assuming that the
signal should never return to an active transaction.

This is bogus as the user may do this.  It's most likely the transaction will
be doomed due to a treclaim but that's a problem for the HW not the kernel.

The current code is a legacy of earlier kernel implementations which did
software rollback of active transactions in the kernel.  That code has now gone
but we didn't correctly fix up this part of the signals code which still makes
the assumption that it must be returning to a suspended transaction.

This pulls out both MSR TM bits from the user supplied context rather than just
setting TM suspend.  We pull out only the bits needed to ensure the user can't
do anything dangerous to the MSR.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@vger.kernel.org (v3.9 only)
---
 arch/powerpc/kernel/signal_32.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index fa81462..364cb1e 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -754,7 +754,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 				 struct mcontext __user *tm_sr)
 {
 	long err;
-	unsigned long msr;
+	unsigned long msr, msr_hi;
 #ifdef CONFIG_VSX
 	int i;
 #endif
@@ -859,8 +859,11 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	tm_enable();
 	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&current->thread, msr);
-	/* The task has moved into TM state S, so ensure MSR reflects this */
-	regs->msr = (regs->msr & ~MSR_TS_MASK) | MSR_TS_S;
+	/* Get the top half of the MSR */
+	if (__get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR]))
+		return 1;
+	/* Pull in MSR TM from user context */
+	regs->msr = (regs->msr & ~MSR_TS_MASK) | ((msr_hi<<32) & MSR_TS_MASK);
 
 	/* This loads the speculative FP/VEC state, if used */
 	if (msr & MSR_FP) {
-- 
1.7.10.4
