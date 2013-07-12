Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C33742C0341
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 15:37:52 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH v2 2/2] powerpc: introduce function emulate_math()
Date: Fri, 12 Jul 2013 13:36:42 +0800
Message-ID: <1373607402-21738-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1373607402-21738-1-git-send-email-haokexin@gmail.com>
References: <1373607402-21738-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are two invocations of do_mathemu() in traps.c. And the codes
in these two places are almost the same. Introduce a locale function
to eliminate the duplication. With this change we can also make sure
that in program_check_exception() the PPC_WARN_EMULATED is invoked for
the correctly emulated math instructions.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2:
  * Don't depend on the FPU for the PPC_WARN_EMULATED.
  * Invoke the PPC_WARN_EMULATED in the caller of do_mathemu().
  * Introduce a new function to eliminate the code duplication.

 arch/powerpc/kernel/traps.c | 79 +++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 58a8065..217724a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1052,11 +1052,41 @@ int is_valid_bugaddr(unsigned long addr)
 	return is_kernel_addr(addr);
 }
 
+#ifdef CONFIG_MATH_EMULATION
+static int emulate_math(struct pt_regs *regs)
+{
+	int ret;
+	extern int do_mathemu(struct pt_regs *regs);
+
+	ret = do_mathemu(regs);
+	if (ret >= 0)
+		PPC_WARN_EMULATED(math, regs);
+
+	switch (ret) {
+	case 0:
+		emulate_single_step(regs);
+		return 0;
+	case 1: {
+			int code = 0;
+			code = __parse_fpscr(current->thread.fpscr.val);
+			_exception(SIGFPE, regs, code, regs->nip);
+			return 0;
+		}
+	case -EFAULT:
+		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+		return 0;
+	}
+
+	return -1;
+}
+#else
+static inline int emulate_math(struct pt_regs *regs) { return -1; }
+#endif
+
 void __kprobes program_check_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
 	unsigned int reason = get_reason(regs);
-	extern int do_mathemu(struct pt_regs *regs);
 
 	/* We can now get here via a FP Unavailable exception if the core
 	 * has no FPU, in that case the reason flags will be 0 */
@@ -1122,7 +1152,6 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
 
-#ifdef CONFIG_MATH_EMULATION
 	/* (reason & REASON_ILLEGAL) would be the obvious thing here,
 	 * but there seems to be a hardware bug on the 405GP (RevD)
 	 * that means ESR is sometimes set incorrectly - either to
@@ -1131,22 +1160,8 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 	 * instruction or only on FP instructions, whether there is a
 	 * pattern to occurrences etc. -dgibson 31/Mar/2003
 	 */
-	switch (do_mathemu(regs)) {
-	case 0:
-		emulate_single_step(regs);
-		goto bail;
-	case 1: {
-			int code = 0;
-			code = __parse_fpscr(current->thread.fpscr.val);
-			_exception(SIGFPE, regs, code, regs->nip);
-			goto bail;
-		}
-	case -EFAULT:
-		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+	if (!emulate_math(regs))
 		goto bail;
-	}
-	/* fall through on any other errors */
-#endif /* CONFIG_MATH_EMULATION */
 
 	/* Try to emulate it if we should. */
 	if (reason & (REASON_ILLEGAL | REASON_PRIVILEGED)) {
@@ -1425,11 +1440,6 @@ void performance_monitor_exception(struct pt_regs *regs)
 #ifdef CONFIG_8xx
 void SoftwareEmulation(struct pt_regs *regs)
 {
-	extern int do_mathemu(struct pt_regs *);
-#if defined(CONFIG_MATH_EMULATION)
-	int errcode;
-#endif
-
 	CHECK_FULL_REGS(regs);
 
 	if (!user_mode(regs)) {
@@ -1437,31 +1447,10 @@ void SoftwareEmulation(struct pt_regs *regs)
 		die("Kernel Mode Software FPU Emulation", regs, SIGFPE);
 	}
 
-#ifdef CONFIG_MATH_EMULATION
-	errcode = do_mathemu(regs);
-	if (errcode >= 0)
-		PPC_WARN_EMULATED(math, regs);
-
-	switch (errcode) {
-	case 0:
-		emulate_single_step(regs);
-		return;
-	case 1: {
-			int code = 0;
-			code = __parse_fpscr(current->thread.fpscr.val);
-			_exception(SIGFPE, regs, code, regs->nip);
-			return;
-		}
-	case -EFAULT:
-		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+	if (!emulate_math(regs))
 		return;
-	default:
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-		return;
-	}
-#else
+
 	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-#endif
 }
 #endif /* CONFIG_8xx */
 
-- 
1.8.1.4
