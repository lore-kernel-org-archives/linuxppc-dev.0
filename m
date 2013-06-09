Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8261B2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 17:01:37 +1000 (EST)
Message-ID: <1370761284.14883.2.camel@pasglop>
Subject: [PATCH 2/3] powerpc/math-emu: Allow math-emu to be used for HW FPU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sun, 09 Jun 2013 17:01:24 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(Including 64-bit ones)

This allow SW emulation by the kernel of optional instructions
such as fsqrt which aren't implemented on some processors, and
thus fixes some Fedora 19 issues such as Anaconda since the
compiler is set to generate those by default on 64-bit.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig        |    6 +++++-
 arch/powerpc/kernel/traps.c |   12 +++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c33e3ad..e3009ab 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -298,7 +298,7 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 
 config MATH_EMULATION
 	bool "Math emulation"
-	depends on 4xx || 8xx || E200 || PPC_MPC832x || E500
+	depends on 4xx || 8xx || PPC_MPC832x || BOOKE
 	---help---
 	  Some PowerPC chips designed for embedded applications do not have
 	  a floating-point unit and therefore do not implement the
@@ -307,6 +307,10 @@ config MATH_EMULATION
 	  unit, which will allow programs that use floating-point
 	  instructions to run.
 
+	  This is also useful to emulate missing (optional) instructions
+	  such as fsqrt on cores that do have an FPU but do not implement
+	  them (such as Freescale BookE).
+
 config PPC_TRANSACTIONAL_MEM
        bool "Transactional Memory support for POWERPC"
        depends on PPC_BOOK3S_64
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6dfbb38..ff315a7 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1130,7 +1130,17 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 	 * ESR_DST (!?) or 0.  In the process of chasing this with the
 	 * hardware people - not sure if it can happen on any illegal
 	 * instruction or only on FP instructions, whether there is a
-	 * pattern to occurrences etc. -dgibson 31/Mar/2003 */
+	 * pattern to occurrences etc. -dgibson 31/Mar/2003
+	 */
+
+	/*
+	 * If we support a HW FPU, we need to ensure the FP state
+	 * if flushed into the thread_struct before attempting
+	 * emulation
+	 */
+#ifdef CONFIG_PPC_FPU
+	flush_fp_to_thread(current);
+#endif
 	switch (do_mathemu(regs)) {
 	case 0:
 		emulate_single_step(regs);
