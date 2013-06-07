Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/5] powerpc/tm: Fix 32 bit non-rt signals
Date: Fri,  7 Jun 2013 20:36:26 +1000
Message-Id: <1370601390-29065-2-git-send-email-mikey@neuling.org>
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

Currently sys_sigreturn() is TM unaware.  Therefore, if we take a 32 bit signal
without SIGINFO (non RT) inside a transaction, on signal return we don't
restore the signal frame correctly.

This checks if the signal frame being restoring is an active transaction, and
if so, it copies the additional state to ptregs so it can be restored.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/signal_32.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 5bc819f..5b0fbe2 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1494,16 +1494,22 @@ badframe:
 long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 		       struct pt_regs *regs)
 {
+	struct sigframe __user *sf;
 	struct sigcontext __user *sc;
 	struct sigcontext sigctx;
 	struct mcontext __user *sr;
 	void __user *addr;
 	sigset_t set;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	struct mcontext __user *mcp, *tm_mcp;
+	unsigned long msr_hi;
+#endif
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current_thread_info()->restart_block.fn = do_no_restart_syscall;
 
-	sc = (struct sigcontext __user *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
+	sf = (struct sigframe __user *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
+	sc = &sf->sctx;
 	addr = sc;
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
 		goto badframe;
@@ -1520,11 +1526,23 @@ long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 #endif
 	set_current_blocked(&set);
 
-	sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
-	addr = sr;
-	if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
-	    || restore_user_regs(regs, sr, 1))
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	mcp = (struct mcontext __user *)&sf->mctx;
+	tm_mcp = (struct mcontext __user *)&sf->mctx_transact;
+	if (__get_user(msr_hi, &tm_mcp->mc_gregs[PT_MSR]))
 		goto badframe;
+	if MSR_TM_ACTIVE(msr_hi<<32) {
+		if (restore_tm_user_regs(regs, mcp, tm_mcp))
+			goto badframe;
+	} else
+#endif
+	{
+		sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
+		addr = sr;
+		if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
+		    || restore_user_regs(regs, sr, 1))
+			goto badframe;
+	}
 
 	set_thread_flag(TIF_RESTOREALL);
 	return 0;
-- 
1.7.10.4
