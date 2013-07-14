Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 104402C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2013 18:41:24 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>
Subject: [PATCH v3 1/2] powerpc/math-emu: move the flush FPU state function
 into do_mathemu
Date: Sun, 14 Jul 2013 16:40:06 +0800
Message-ID: <1373791207-15017-2-git-send-email-haokexin@gmail.com>
In-Reply-To: <1373791207-15017-1-git-send-email-haokexin@gmail.com>
References: <1373791207-15017-1-git-send-email-haokexin@gmail.com>
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

By doing this we can make sure that the FPU state is only flushed to
the thread struct when it is really needed.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v3: Fix the typo in the comments.

 arch/powerpc/kernel/traps.c  | 9 ---------
 arch/powerpc/math-emu/math.c | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bf33c22..58a8065 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1131,15 +1131,6 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 	 * instruction or only on FP instructions, whether there is a
 	 * pattern to occurrences etc. -dgibson 31/Mar/2003
 	 */
-
-	/*
-	 * If we support a HW FPU, we need to ensure the FP state
-	 * if flushed into the thread_struct before attempting
-	 * emulation
-	 */
-#ifdef CONFIG_PPC_FPU
-	flush_fp_to_thread(current);
-#endif
 	switch (do_mathemu(regs)) {
 	case 0:
 		emulate_single_step(regs);
diff --git a/arch/powerpc/math-emu/math.c b/arch/powerpc/math-emu/math.c
index 3fe8e35..f9ef347 100644
--- a/arch/powerpc/math-emu/math.c
+++ b/arch/powerpc/math-emu/math.c
@@ -420,6 +420,15 @@ do_mathemu(struct pt_regs *regs)
 		goto illegal;
 	}
 
+	/*
+	 * If we support a HW FPU, we need to ensure the FP state
+	 * is flushed into the thread_struct before attempting
+	 * emulation
+	 */
+#ifdef CONFIG_PPC_FPU
+	flush_fp_to_thread(current);
+#endif
+
 	eflag = func(op0, op1, op2, op3);
 
 	if (insn & 1) {
-- 
1.8.1.4
