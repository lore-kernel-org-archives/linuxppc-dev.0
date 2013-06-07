Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/5] powerpc/tm: Fix restoration of MSR on 32bit signal return
Date: Fri,  7 Jun 2013 20:36:27 +1000
Message-Id: <1370601390-29065-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1370601390-29065-1-git-send-email-mikey@neuling.org>
References: <1370601390-29065-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
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

This removes the stripping of these MSR TM bits.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/signal_32.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 5b0fbe2..b8279b3 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -755,6 +755,7 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 {
 	long err;
 	unsigned long msr;
+	__u32 msr_hi;
 #ifdef CONFIG_VSX
 	int i;
 #endif
@@ -859,8 +860,10 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	tm_enable();
 	/* This loads the checkpointed FP/VEC state, if used */
 	tm_recheckpoint(&current->thread, msr);
-	/* The task has moved into TM state S, so ensure MSR reflects this */
-	regs->msr = (regs->msr & ~MSR_TS_MASK) | MSR_TS_S;
+	/* Retore the top half of the MSR */
+	if (__get_user(msr_hi, &tm_sr->mc_gregs[PT_MSR]))
+		return 1;
+	regs->msr = (regs->msr | (((unsigned long)msr_hi) << 32));
 
 	/* This loads the speculative FP/VEC state, if used */
 	if (msr & MSR_FP) {
-- 
1.7.10.4
