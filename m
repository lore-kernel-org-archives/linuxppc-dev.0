Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org, paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Fix VSX signals for older user space binaries
Date: Thu, 23 Oct 2008 21:42:36 +1100
Message-ID: <6350.1224758556@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When saving an older signal context (smaller context without the extra
VSX state) for a task that has used VSX, currently we'll EINVAL.
Unfortunately if we have an older program which doesn't know about the
newer expanded signal context but happens to execute some VSX
instructions (via some new library that does understand VSX), it will
start getting EINVAL when it wasn't before.

This patch changes this behaviour so that we don't send an EINVAL in
this case.  It will now return the smaller context but the VSX MSR bit
will always be cleared, even if the task executed VSX instructions.

Both 32 and 64 bit cases are updated.

Thanks to benh for noticing this problem.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/signal_32.c |   28 +++++++++++-----------------
 arch/powerpc/kernel/signal_64.c |   25 +++++++++++--------------
 2 files changed, 22 insertions(+), 31 deletions(-)

benh: this is for 2.6.28, but we should probably back port it to
      2.6.27 as it changes the user visible API.  

Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
@@ -410,7 +410,7 @@ inline unsigned long copy_fpr_from_user(
  * altivec/spe instructions at some point.
  */
 static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
-		int sigret)
+		int sigret, int ctx_has_vsx_region)
 {
 	unsigned long msr = regs->msr;
 
@@ -451,7 +451,7 @@ static int save_user_regs(struct pt_regs
 	 * the saved MSR value to indicate that frame->mc_vregs
 	 * contains valid data
 	 */
-	if (current->thread.used_vsr) {
+	if (current->thread.used_vsr && ctx_has_vsx_region) {
 		__giveup_vsx(current);
 		if (copy_vsx_to_user(&frame->mc_vsregs, current))
 			return 1;
@@ -858,11 +858,11 @@ int handle_rt_signal32(unsigned long sig
 	frame = &rt_sf->uc.uc_mcontext;
 	addr = frame;
 	if (vdso32_rt_sigtramp && current->mm->context.vdso_base) {
-		if (save_user_regs(regs, frame, 0))
+		if (save_user_regs(regs, frame, 0, 1))
 			goto badframe;
 		regs->link = current->mm->context.vdso_base + vdso32_rt_sigtramp;
 	} else {
-		if (save_user_regs(regs, frame, __NR_rt_sigreturn))
+		if (save_user_regs(regs, frame, __NR_rt_sigreturn, 1))
 			goto badframe;
 		regs->link = (unsigned long) frame->tramp;
 	}
@@ -936,6 +936,7 @@ long sys_swapcontext(struct ucontext __u
 		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
 {
 	unsigned char tmp;
+	int ctx_has_vsx_region = 0;
 
 #ifdef CONFIG_PPC64
 	unsigned long new_msr = 0;
@@ -956,16 +957,9 @@ long sys_swapcontext(struct ucontext __u
 	if ((ctx_size < sizeof(struct ucontext)) &&
 	    (new_msr & MSR_VSX))
 		return -EINVAL;
-#ifdef CONFIG_VSX
-	/*
-	 * If userspace doesn't provide enough room for VSX data,
-	 * but current thread has used VSX, we don't have anywhere
-	 * to store the full context back into.
-	 */
-	if ((ctx_size < sizeof(struct ucontext)) &&
-	    (current->thread.used_vsr && old_ctx))
-		return -EINVAL;
-#endif
+	/* Does the context have enough room to store VSX data? */
+	if (ctx_size >= sizeof(struct ucontext))
+		ctx_has_vsx_region = 1;
 #else
 	/* Context size is for future use. Right now, we only make sure
 	 * we are passed something we understand
@@ -986,7 +980,7 @@ long sys_swapcontext(struct ucontext __u
 		mctx = (struct mcontext __user *)
 			((unsigned long) &old_ctx->uc_mcontext & ~0xfUL);
 		if (!access_ok(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
-		    || save_user_regs(regs, mctx, 0)
+		    || save_user_regs(regs, mctx, 0, ctx_has_vsx_region)
 		    || put_sigset_t(&old_ctx->uc_sigmask, &current->blocked)
 		    || __put_user(to_user_ptr(mctx), &old_ctx->uc_regs))
 			return -EFAULT;
@@ -1196,11 +1190,11 @@ int handle_signal32(unsigned long sig, s
 		goto badframe;
 
 	if (vdso32_sigtramp && current->mm->context.vdso_base) {
-		if (save_user_regs(regs, &frame->mctx, 0))
+		if (save_user_regs(regs, &frame->mctx, 0, 1))
 			goto badframe;
 		regs->link = current->mm->context.vdso_base + vdso32_sigtramp;
 	} else {
-		if (save_user_regs(regs, &frame->mctx, __NR_sigreturn))
+		if (save_user_regs(regs, &frame->mctx, __NR_sigreturn, 1))
 			goto badframe;
 		regs->link = (unsigned long) frame->mctx.tramp;
 	}
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
@@ -74,7 +74,8 @@ static const char fmt64[] = KERN_INFO \
  */
 
 static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
-		 int signr, sigset_t *set, unsigned long handler)
+		 int signr, sigset_t *set, unsigned long handler,
+		 int ctx_has_vsx_region)
 {
 	/* When CONFIG_ALTIVEC is set, we _always_ setup v_regs even if the
 	 * process never used altivec yet (MSR_VEC is zero in pt_regs of
@@ -121,7 +122,7 @@ static long setup_sigcontext(struct sigc
 	 * then out to userspace.  Update v_regs to point after the
 	 * VMX data.
 	 */
-	if (current->thread.used_vsr) {
+	if (current->thread.used_vsr && ctx_has_vsx_region) {
 		__giveup_vsx(current);
 		v_regs += ELF_NVRREG;
 		err |= copy_vsx_to_user(v_regs, current);
@@ -282,6 +283,7 @@ int sys_swapcontext(struct ucontext __us
 	unsigned char tmp;
 	sigset_t set;
 	unsigned long new_msr = 0;
+	int ctx_has_vsx_region = 0;
 
 	if (new_ctx &&
 	    __get_user(new_msr, &new_ctx->uc_mcontext.gp_regs[PT_MSR]))
@@ -299,19 +301,14 @@ int sys_swapcontext(struct ucontext __us
 	if ((ctx_size < sizeof(struct ucontext)) &&
 	    (new_msr & MSR_VSX))
 		return -EINVAL;
-#ifdef CONFIG_VSX
-	/*
-	 * If userspace doesn't provide enough room for VSX data,
-	 * but current thread has used VSX, we don't have anywhere
-	 * to store the full context back into.
-	 */
-	if ((ctx_size < sizeof(struct ucontext)) &&
-	    (current->thread.used_vsr && old_ctx))
-		return -EINVAL;
-#endif
+	/* Does the context have enough room to store VSX data? */
+	if (ctx_size >= sizeof(struct ucontext))
+		ctx_has_vsx_region = 1;
+
 	if (old_ctx != NULL) {
 		if (!access_ok(VERIFY_WRITE, old_ctx, sizeof(*old_ctx))
-		    || setup_sigcontext(&old_ctx->uc_mcontext, regs, 0, NULL, 0)
+		    || setup_sigcontext(&old_ctx->uc_mcontext, regs, 0, NULL, 0,
+					ctx_has_vsx_region)
 		    || __copy_to_user(&old_ctx->uc_sigmask,
 				      &current->blocked, sizeof(sigset_t)))
 			return -EFAULT;
@@ -423,7 +420,7 @@ int handle_rt_signal64(int signr, struct
 			  &frame->uc.uc_stack.ss_flags);
 	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, signr, NULL,
-				(unsigned long)ka->sa.sa_handler);
+				(unsigned long)ka->sa.sa_handler, 1);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
 		goto badframe;
