Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: powerpc/tm: Fix 32bit non-rt signal return
Date: Mon, 03 Jun 2013 20:56:13 +1000
Message-ID: <17963.1370256973@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently sys_sigreturn() is transactional memory unaware, hence if we take a
32 bit signal without SIGINFO (non RT) inside a transaction, we don't restore
the signal frame correctly on return.

This checks if the signal frame being restoring is an active transaction, and
if so, it copies the additional state to the ptregs so it can be restored.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: <stable@vger.kernel.org> # 3.9 only

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 201385c..0bc961b 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1481,16 +1481,22 @@ badframe:
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
@@ -1507,12 +1513,23 @@ long sys_sigreturn(int r3, int r4, int r5, int r6, int r7, int r8,
 #endif
 	set_current_blocked(&set);
 
-	sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
-	addr = sr;
-	if (!access_ok(VERIFY_READ, sr, sizeof(*sr))
-	    || restore_user_regs(regs, sr, 1))
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	mcp = (struct mcontext __user *)&sf->mctx;
+	tm_mcp = (struct mcontext __user *)&sf->mctx_transact;
+	if (__get_user(msr_hi, &mcp->mc_gregs[PT_MSR]))
 		goto badframe;
-
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
 
