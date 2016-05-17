Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r88by3TGLzDqCh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 17:49:18 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id gh9so1045543pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 00:49:18 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: sbauer@plzdonthack.me
Subject: [PATCH 2/2] powerpc/SROP mitigation: Add cookies to sigframes
Date: Tue, 17 May 2016 17:47:51 +1000
Message-Id: <1463471271-26788-3-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1463471271-26788-1-git-send-email-rashmicy@gmail.com>
References: <1463471271-26788-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds SROP mitigation logic to the powerpc signal delivery
and sigreturn code. The cookie is placed in the sigframe just after (at
a lower address) the ABI gap.

This is derived from the x86 SROP mitigation patch:
https://lkml.org/lkml/2016/3/29/791.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/kernel/signal_32.c | 33 +++++++++++++++++++++++++++++----
 arch/powerpc/kernel/signal_64.c | 21 +++++++++++++++++++--
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index b6aa378aff63..01e6d0c966ee 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -207,6 +207,7 @@ static inline int restore_general_regs(struct pt_regs *regs,
  * When we have signals to deliver, we set up on the
  * user stack, going down from the original stack pointer:
  *	an ABI gap of 56 words
+ *	a cookie
  *	an mcontext struct
  *	a sigcontext struct
  *	a gap of __SIGNAL_FRAMESIZE bytes
@@ -222,6 +223,7 @@ struct sigframe {
 	struct sigcontext sctx_transact;
 	struct mcontext	mctx_transact;
 #endif
+	unsigned long user_cookie;
 	/*
 	 * Programs using the rs6000/xcoff abi can save up to 19 gp
 	 * regs and 18 fp regs below sp before decrementing it.
@@ -235,7 +237,7 @@ struct sigframe {
 /*
  *  When we have rt signals to deliver, we set up on the
  *  user stack, going down from the original stack pointer:
- *	one rt_sigframe struct (siginfo + ucontext + ABI gap)
+ *	one rt_sigframe struct (siginfo + ucontext + cookie + ABI gap)
  *	a gap of __SIGNAL_FRAMESIZE+16 bytes
  *  (the +16 is to get the siginfo and ucontext in the same
  *  positions as in older kernels).
@@ -253,6 +255,7 @@ struct rt_sigframe {
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	struct ucontext	uc_transact;
 #endif
+	unsigned long user_cookie;
 	/*
 	 * Programs using the rs6000/xcoff abi can save up to 19 gp
 	 * regs and 18 fp regs below sp before decrementing it.
@@ -980,11 +983,12 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	unsigned long newsp = 0;
 	int sigret;
 	unsigned long tramp;
-
+	void __user *cookie_location;
 	/* Set up Signal Frame */
 	/* Put a Real Time Context onto stack */
 	rt_sf = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*rt_sf), 1);
 	addr = rt_sf;
+	cookie_location = &(rt_sf->user_cookie);
 	if (unlikely(rt_sf == NULL))
 		goto badframe;
 
@@ -1016,6 +1020,8 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 		    __put_user((unsigned long)tm_frame,
 			       &rt_sf->uc_transact.uc_regs))
 			goto badframe;
+		if (set_sigcookie(cookie_location))
+			goto badframe;
 		if (save_tm_user_regs(regs, frame, tm_frame, sigret))
 			goto badframe;
 	}
@@ -1024,6 +1030,8 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	{
 		if (__put_user(0, &rt_sf->uc.uc_link))
 			goto badframe;
+		if (set_sigcookie(cookie_location))
+			goto badframe;
 		if (save_user_regs(regs, frame, tm_frame, sigret, 1))
 			goto badframe;
 	}
@@ -1219,11 +1227,13 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 	unsigned long tmp;
 	int tm_restore = 0;
 #endif
+	void __user *user_cookie;
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
 	rt_sf = (struct rt_sigframe __user *)
 		(regs->gpr[1] + __SIGNAL_FRAMESIZE + 16);
+	user_cookie = &(rt_sf->user_cookie);
 	if (!access_ok(VERIFY_READ, rt_sf, sizeof(*rt_sf)))
 		goto bad;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
@@ -1264,6 +1274,9 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 	 * always done it up until now so it is probably better not to
 	 * change it.  -- paulus
 	 */
+
+	if (verify_clear_sigcookie(user_cookie))
+		goto bad;
 #ifdef CONFIG_PPC64
 	if (compat_restore_altstack(&rt_sf->uc.uc_stack))
 		goto bad;
@@ -1404,11 +1417,12 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs
 	unsigned long newsp = 0;
 	int sigret;
 	unsigned long tramp;
-
+	void __user *cookie_location;
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*frame), 1);
 	if (unlikely(frame == NULL))
 		goto badframe;
+	cookie_location = &(frame->user_cookie);
 	sc = (struct sigcontext __user *) &frame->sctx;
 
 #if _NSIG != 64
@@ -1436,6 +1450,8 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	tm_mctx = &frame->mctx_transact;
 	if (MSR_TM_ACTIVE(regs->msr)) {
+		if (set_sigcookie(cookie_location))
+			goto badframe;
 		if (save_tm_user_regs(regs, &frame->mctx, &frame->mctx_transact,
 				      sigret))
 			goto badframe;
@@ -1443,6 +1459,8 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs
 	else
 #endif
 	{
+		if (set_sigcookie(cookie_location))
+			goto badframe;
 		if (save_user_regs(regs, &frame->mctx, tm_mctx, sigret, 1))
 			goto badframe;
 	}
@@ -1491,11 +1509,12 @@ long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 	struct mcontext __user *mcp, *tm_mcp;
 	unsigned long msr_hi;
 #endif
-
+	void __user *user_cookie;
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
 	sf = (struct sigframe __user *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
+	user_cookie = &(sf->user_cookie);
 	sc = &sf->sctx;
 	addr = sc;
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
@@ -1521,13 +1540,19 @@ long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 	if (MSR_TM_ACTIVE(msr_hi<<32)) {
 		if (!cpu_has_feature(CPU_FTR_TM))
 			goto badframe;
+		if (verify_clear_sigcookie(user_cookie))
+			goto badframe;
 		if (restore_tm_user_regs(regs, mcp, tm_mcp))
 			goto badframe;
 	} else
 #endif
 	{
+
 		sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
 		addr = sr;
+		if (verify_clear_sigcookie(user_cookie))
+			goto badframe;
+
 		if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
 		    || restore_user_regs(regs, sr, 1))
 			goto badframe;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 25520794aa37..0b6e3f61a59d 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #include <linux/ptrace.h>
 #include <linux/ratelimit.h>
+#include <linux/signal.h>
 
 #include <asm/sigcontext.h>
 #include <asm/ucontext.h>
@@ -35,6 +36,7 @@
 #include <asm/vdso.h>
 #include <asm/switch_to.h>
 #include <asm/tm.h>
+#include <asm/compat.h>
 
 #include "signal.h"
 
@@ -48,7 +50,7 @@
 /*
  * When we have signals to deliver, we set up on the user stack,
  * going down from the original stack pointer:
- *	1) a rt_sigframe struct which contains the ucontext	
+ *	1) a rt_sigframe struct which contains the ucontext.
  *	2) a gap of __SIGNAL_FRAMESIZE bytes which acts as a dummy caller
  *	   frame for the signal handler.
  */
@@ -64,6 +66,7 @@ struct rt_sigframe {
 	struct siginfo __user *pinfo;
 	void __user *puc;
 	struct siginfo info;
+	unsigned long user_cookie;
 	/* New 64 bit little-endian ABI allows redzone of 512 bytes below sp */
 	char abigap[USER_REDZONE_SIZE];
 } __attribute__ ((aligned (16)));
@@ -661,6 +664,10 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	unsigned long msr;
 #endif
+	/* Only need the sigframe to get the cookie */
+	struct rt_sigframe __user *sf = (struct rt_sigframe __user
+			*)regs->gpr[1];
+	void __user *user_cookie = &(sf->user_cookie);
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -682,13 +689,16 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 		if (restore_tm_sigcontexts(regs, &uc->uc_mcontext,
 					   &uc_transact->uc_mcontext))
 			goto badframe;
+		if (verify_clear_sigcookie(user_cookie))
+			goto badframe;
 	}
 	else
 	/* Fall through, for non-TM restore */
 #endif
 	if (restore_sigcontext(regs, NULL, 1, &uc->uc_mcontext))
 		goto badframe;
-
+	if (verify_clear_sigcookie(user_cookie))
+		goto badframe;
 	if (restore_altstack(&uc->uc_stack))
 		goto badframe;
 
@@ -710,6 +720,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 	struct rt_sigframe __user *frame;
 	unsigned long newsp = 0;
 	long err = 0;
+	void __user *cookie_location;
 
 	frame = get_sigframe(ksig, get_tm_stackpointer(regs), sizeof(*frame), 0);
 	if (unlikely(frame == NULL))
@@ -724,12 +735,17 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
 	err |= __save_altstack(&frame->uc.uc_stack, regs->gpr[1]);
+
+	cookie_location = &(frame->user_cookie);
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	if (MSR_TM_ACTIVE(regs->msr)) {
 		/* The ucontext_t passed to userland points to the second
 		 * ucontext_t (for transactional state) with its uc_link ptr.
 		 */
 		err |= __put_user(&frame->uc_transact, &frame->uc.uc_link);
+
+		err |= set_sigcookie(cookie_location);
+
 		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
 					    &frame->uc_transact.uc_mcontext,
 					    regs, ksig->sig,
@@ -739,6 +755,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs
 #endif
 	{
 		err |= __put_user(0, &frame->uc.uc_link);
+		err |= set_sigcookie(cookie_location);
 		err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, ksig->sig,
 					NULL, (unsigned long)ksig->ka.sa.sa_handler,
 					1);
-- 
2.5.0
