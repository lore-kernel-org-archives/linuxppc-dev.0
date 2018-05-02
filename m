Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bf6p4sBPzF2T4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:21:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] powerpc/syscalls: signal_{32,
 64} - switch to SYSCALL_DEFINE
Date: Wed,  2 May 2018 23:20:47 +1000
Message-Id: <20180502132051.28861-2-mpe@ellerman.id.au>
In-Reply-To: <20180502132051.28861-1-mpe@ellerman.id.au>
References: <20180502132051.28861-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[mpe: Fix sys_debug_setcontext() prototype to return long]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/asm-prototypes.h | 14 ++++-------
 arch/powerpc/kernel/signal.h              |  6 ++---
 arch/powerpc/kernel/signal_32.c           | 40 ++++++++++++++++++-------------
 arch/powerpc/kernel/signal_64.c           | 15 ++++--------
 4 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index d9713ad62e3c..e06eb219204e 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -81,18 +81,12 @@ void machine_check_exception(struct pt_regs *regs);
 void emulation_assist_interrupt(struct pt_regs *regs);
 
 /* signals, syscalls and interrupts */
-#ifdef CONFIG_PPC64
-int sys_swapcontext(struct ucontext __user *old_ctx,
-		    struct ucontext __user *new_ctx,
-		    long ctx_size, long r6, long r7, long r8, struct pt_regs *regs);
-#else
 long sys_swapcontext(struct ucontext __user *old_ctx,
 		    struct ucontext __user *new_ctx,
-		    int ctx_size, int r6, int r7, int r8, struct pt_regs *regs);
-int sys_debug_setcontext(struct ucontext __user *ctx,
-			 int ndbg, struct sig_dbg_op __user *dbg,
-			 int r6, int r7, int r8,
-			 struct pt_regs *regs);
+		    long ctx_size);
+#ifdef CONFIG_PPC32
+long sys_debug_setcontext(struct ucontext __user *ctx,
+			  int ndbg, struct sig_dbg_op __user *dbg);
 int
 ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp);
 unsigned long __init early_init(unsigned long dt_ptr);
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index a6467f843acf..800433685888 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -49,10 +49,8 @@ extern int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 
 #else /* CONFIG_PPC64 */
 
-extern long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
-		     struct pt_regs *regs);
-extern long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
-		       struct pt_regs *regs);
+extern long sys_rt_sigreturn(void);
+extern long sys_sigreturn(void);
 
 static inline int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 				     struct task_struct *tsk)
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 492f03451877..9cf8a03d3bc7 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -26,8 +26,8 @@
 #include <linux/elf.h>
 #include <linux/ptrace.h>
 #include <linux/ratelimit.h>
-#ifdef CONFIG_PPC64
 #include <linux/syscalls.h>
+#ifdef CONFIG_PPC64
 #include <linux/compat.h>
 #else
 #include <linux/wait.h>
@@ -57,10 +57,6 @@
 
 
 #ifdef CONFIG_PPC64
-#define sys_rt_sigreturn	compat_sys_rt_sigreturn
-#define sys_swapcontext	compat_sys_swapcontext
-#define sys_sigreturn	compat_sys_sigreturn
-
 #define old_sigaction	old_sigaction32
 #define sigcontext	sigcontext32
 #define mcontext	mcontext32
@@ -1041,10 +1037,15 @@ static int do_setcontext_tm(struct ucontext __user *ucp,
 }
 #endif
 
-long sys_swapcontext(struct ucontext __user *old_ctx,
-		     struct ucontext __user *new_ctx,
-		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
+#ifdef CONFIG_PPC64
+COMPAT_SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
+		       struct ucontext __user *, new_ctx, int, ctx_size)
+#else
+SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
+		       struct ucontext __user *, new_ctx, long, ctx_size)
+#endif
 {
+	struct pt_regs *regs = current_pt_regs();
 	unsigned char tmp __maybe_unused;
 	int ctx_has_vsx_region = 0;
 
@@ -1132,10 +1133,14 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 	return 0;
 }
 
-long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
-		     struct pt_regs *regs)
+#ifdef CONFIG_PPC64
+COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
+#else
+SYSCALL_DEFINE0(rt_sigreturn)
+#endif
 {
 	struct rt_sigframe __user *rt_sf;
+	struct pt_regs *regs = current_pt_regs();
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	struct ucontext __user *uc_transact;
 	unsigned long msr_hi;
@@ -1224,11 +1229,10 @@ long sys_rt_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 }
 
 #ifdef CONFIG_PPC32
-int sys_debug_setcontext(struct ucontext __user *ctx,
-			 int ndbg, struct sig_dbg_op __user *dbg,
-			 int r6, int r7, int r8,
-			 struct pt_regs *regs)
+SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
+			 int, ndbg, struct sig_dbg_op __user *, dbg)
 {
+	struct pt_regs *regs = current_pt_regs();
 	struct sig_dbg_op op;
 	int i;
 	unsigned char tmp __maybe_unused;
@@ -1419,9 +1423,13 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 /*
  * Do a signal return; undo the signal stack.
  */
-long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
-		       struct pt_regs *regs)
+#ifdef CONFIG_PPC64
+COMPAT_SYSCALL_DEFINE0(sigreturn)
+#else
+SYSCALL_DEFINE0(sigreturn)
+#endif
 {
+	struct pt_regs *regs = current_pt_regs();
 	struct sigframe __user *sf;
 	struct sigcontext __user *sc;
 	struct sigcontext sigctx;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 720117690822..83d51bf586c7 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #include <linux/ptrace.h>
 #include <linux/ratelimit.h>
+#include <linux/syscalls.h>
 
 #include <asm/sigcontext.h>
 #include <asm/ucontext.h>
@@ -624,17 +625,14 @@ static long setup_trampoline(unsigned int syscall, unsigned int __user *tramp)
 /*
  * Handle {get,set,swap}_context operations
  */
-int sys_swapcontext(struct ucontext __user *old_ctx,
-		    struct ucontext __user *new_ctx,
-		    long ctx_size, long r6, long r7, long r8, struct pt_regs *regs)
+SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
+		struct ucontext __user *, new_ctx, long, ctx_size)
 {
 	unsigned char tmp;
 	sigset_t set;
 	unsigned long new_msr = 0;
 	int ctx_has_vsx_region = 0;
 
-	BUG_ON(regs != current->thread.regs);
-
 	if (new_ctx &&
 	    get_user(new_msr, &new_ctx->uc_mcontext.gp_regs[PT_MSR]))
 		return -EFAULT;
@@ -698,18 +696,15 @@ int sys_swapcontext(struct ucontext __user *old_ctx,
  * Do a signal return; undo the signal stack.
  */
 
-int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
-		     unsigned long r6, unsigned long r7, unsigned long r8,
-		     struct pt_regs *regs)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
+	struct pt_regs *regs = current_pt_regs();
 	struct ucontext __user *uc = (struct ucontext __user *)regs->gpr[1];
 	sigset_t set;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	unsigned long msr;
 #endif
 
-	BUG_ON(current->thread.regs != regs);
-
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-- 
2.14.1
