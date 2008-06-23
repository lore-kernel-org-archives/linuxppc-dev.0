Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Mon, 23 Jun 2008 17:38:07 +1000
Subject: [PATCH 1/9] powerpc: Fix msr setting in 32 bit signal code
In-Reply-To: <1214206687.690380.817887322840.qpush@coopers>
Message-Id: <20080623073807.E915670294@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we set the SPE MSR bit in save_user_regs we can blow away the VEC
bit.  This will never happen in reality (VMX and SPE will never be in
the same processor as their opcodes overlap), but it looks bad.  Also
when we add VSX here in a later patch, we can hit two of these at the
same time.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/signal_32.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
@@ -336,6 +336,8 @@ struct rt_sigframe {
 static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 		int sigret)
 {
+	unsigned long msr = regs->msr;
+
 	/* Make sure floating point registers are stored in regs */
 	flush_fp_to_thread(current);
 
@@ -354,8 +356,7 @@ static int save_user_regs(struct pt_regs
 			return 1;
 		/* set MSR_VEC in the saved MSR value to indicate that
 		   frame->mc_vregs contains valid data */
-		if (__put_user(regs->msr | MSR_VEC, &frame->mc_gregs[PT_MSR]))
-			return 1;
+		msr |= MSR_VEC;
 	}
 	/* else assert((regs->msr & MSR_VEC) == 0) */
 
@@ -377,8 +378,7 @@ static int save_user_regs(struct pt_regs
 			return 1;
 		/* set MSR_SPE in the saved MSR value to indicate that
 		   frame->mc_vregs contains valid data */
-		if (__put_user(regs->msr | MSR_SPE, &frame->mc_gregs[PT_MSR]))
-			return 1;
+		msr |= MSR_SPE;
 	}
 	/* else assert((regs->msr & MSR_SPE) == 0) */
 
@@ -387,6 +387,8 @@ static int save_user_regs(struct pt_regs
 		return 1;
 #endif /* CONFIG_SPE */
 
+	if (__put_user(msr, &frame->mc_gregs[PT_MSR]))
+		return 1;
 	if (sigret) {
 		/* Set up the sigreturn trampoline: li r0,sigret; sc */
 		if (__put_user(0x38000000UL + sigret, &frame->tramp[0])
