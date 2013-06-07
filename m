Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/5] powerpc/tm: Fix writing top half of MSR on 32 bit signals
Date: Fri,  7 Jun 2013 20:36:25 +1000
Message-Id: <1370601390-29065-1-git-send-email-mikey@neuling.org>
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

The MSR TM controls are in the top 32 bits of the MSR hence on 32 bit signals,
we stick the top half of the MSR in the checkpointed signal context so that the
user can access it.

Unfortunately, we don't currently write anything to the checkpointed signal
context when coming in a from a non transactional process and hence the top MSR
bits can contain junk.

This updates the 32 bit signal handling code to always write something to the
top MSR bits so that users know if the process is transactional or not and the
kernel can use it on signal return.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/signal_32.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 201385c..5bc819f 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -407,7 +407,8 @@ inline unsigned long copy_transact_fpr_from_user(struct task_struct *task,
  * altivec/spe instructions at some point.
  */
 static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
-		int sigret, int ctx_has_vsx_region)
+			  struct mcontext __user *tm_frame, int sigret,
+			  int ctx_has_vsx_region)
 {
 	unsigned long msr = regs->msr;
 
@@ -475,6 +476,12 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 
 	if (__put_user(msr, &frame->mc_gregs[PT_MSR]))
 		return 1;
+	/* We need to write 0 the MSR top 32 bits in the tm frame so that we
+	 * can check it on the restore to see if TM is active
+	 */
+	if (tm_frame && __put_user(0, &tm_frame->mc_gregs[PT_MSR]))
+		return 1;
+
 	if (sigret) {
 		/* Set up the sigreturn trampoline: li r0,sigret; sc */
 		if (__put_user(0x38000000UL + sigret, &frame->tramp[0])
@@ -952,6 +959,7 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 {
 	struct rt_sigframe __user *rt_sf;
 	struct mcontext __user *frame;
+	struct mcontext __user *tm_frame = NULL;
 	void __user *addr;
 	unsigned long newsp = 0;
 	int sigret;
@@ -985,23 +993,24 @@ int handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
 	}
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	tm_frame = &rt_sf->uc_transact.uc_mcontext;
 	if (MSR_TM_ACTIVE(regs->msr)) {
-		if (save_tm_user_regs(regs, &rt_sf->uc.uc_mcontext,
-				      &rt_sf->uc_transact.uc_mcontext, sigret))
+		if (save_tm_user_regs(regs, frame, tm_frame, sigret))
 			goto badframe;
 	}
 	else
 #endif
-		if (save_user_regs(regs, frame, sigret, 1))
+	{
+		if (save_user_regs(regs, frame, tm_frame, sigret, 1))
 			goto badframe;
+	}
 	regs->link = tramp;
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (MSR_TM_ACTIVE(regs->msr)) {
 		if (__put_user((unsigned long)&rt_sf->uc_transact,
 			       &rt_sf->uc.uc_link)
-		    || __put_user(to_user_ptr(&rt_sf->uc_transact.uc_mcontext),
-				  &rt_sf->uc_transact.uc_regs))
+		    || __put_user((unsigned long)tm_frame, &rt_sf->uc_transact.uc_regs))
 			goto badframe;
 	}
 	else
@@ -1170,7 +1179,7 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 		mctx = (struct mcontext __user *)
 			((unsigned long) &old_ctx->uc_mcontext & ~0xfUL);
 		if (!access_ok(VERIFY_WRITE, old_ctx, ctx_size)
-		    || save_user_regs(regs, mctx, 0, ctx_has_vsx_region)
+		    || save_user_regs(regs, mctx, NULL, 0, ctx_has_vsx_region)
 		    || put_sigset_t(&old_ctx->uc_sigmask, &current->blocked)
 		    || __put_user(to_user_ptr(mctx), &old_ctx->uc_regs))
 			return -EFAULT;
@@ -1392,6 +1401,7 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 {
 	struct sigcontext __user *sc;
 	struct sigframe __user *frame;
+	struct mcontext __user *tm_mctx = NULL;
 	unsigned long newsp = 0;
 	int sigret;
 	unsigned long tramp;
@@ -1425,6 +1435,7 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 	}
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	tm_mctx = &frame->mctx_transact;
 	if (MSR_TM_ACTIVE(regs->msr)) {
 		if (save_tm_user_regs(regs, &frame->mctx, &frame->mctx_transact,
 				      sigret))
@@ -1432,8 +1443,10 @@ int handle_signal32(unsigned long sig, struct k_sigaction *ka,
 	}
 	else
 #endif
-		if (save_user_regs(regs, &frame->mctx, sigret, 1))
+	{
+		if (save_user_regs(regs, &frame->mctx, tm_mctx, sigret, 1))
 			goto badframe;
+	}
 
 	regs->link = tramp;
 
-- 
1.7.10.4
