Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E3AF62C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 17:05:05 +1000 (EST)
Message-ID: <1370761498.14883.5.camel@pasglop>
Subject: [PATCH 3/3] powerpc/8xx: Remove 8xx specific "minimal FPU emulation"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sun, 09 Jun 2013 17:04:58 +1000
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

This is duplicated code from math-emu and implements such a small
subset of the FPU (load/stores/fmr) that it's essentially pointless
nowdays.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note that arch/powerpc/math-emu/math.c seems to have code in there
to do exactly the same thing (subset emulation) if CONFIG_MATH_EMULATION
isn't set. However that code isn't used since we simply don't call
do_mathemu() not build any of the relevant files when this is not
set.

I'm not removing this just yet. If somebody thinks there is value
in supporting that "minimal set emulation", then send me a patch
that provides a Kconfig/Makefile way of enabling that code, which
makes it work on all soft-fpu powerpc's and not just 8xx.

If nobody reacts, I'll probably just rip the code out by the next
kernel version.

 arch/powerpc/Kconfig        |   11 -----------
 arch/powerpc/kernel/traps.c |   22 +---------------------
 2 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e3009ab..5374776 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -319,17 +319,6 @@ config PPC_TRANSACTIONAL_MEM
        ---help---
          Support user-mode Transactional Memory on POWERPC.
 
-config 8XX_MINIMAL_FPEMU
-	bool "Minimal math emulation for 8xx"
-	depends on 8xx && !MATH_EMULATION
-	help
-	  Older arch/ppc kernels still emulated a few floating point
-	  instructions such as load and store, even when full math
-	  emulation is disabled.  Say "Y" here if you want to preserve
-	  this behavior.
-
-	  It is recommended that you build a soft-float userspace instead.
-
 config IOMMU_HELPER
 	def_bool PPC64
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ff315a7..8093156 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1401,8 +1401,7 @@ void performance_monitor_exception(struct pt_regs *regs)
 void SoftwareEmulation(struct pt_regs *regs)
 {
 	extern int do_mathemu(struct pt_regs *);
-	extern int Soft_emulate_8xx(struct pt_regs *);
-#if defined(CONFIG_MATH_EMULATION) || defined(CONFIG_8XX_MINIMAL_FPEMU)
+#if defined(CONFIG_MATH_EMULATION)
 	int errcode;
 #endif
 
@@ -1435,23 +1434,6 @@ void SoftwareEmulation(struct pt_regs *regs)
 		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 		return;
 	}
-
-#elif defined(CONFIG_8XX_MINIMAL_FPEMU)
-	errcode = Soft_emulate_8xx(regs);
-	if (errcode >= 0)
-		PPC_WARN_EMULATED(8xx, regs);
-
-	switch (errcode) {
-	case 0:
-		emulate_single_step(regs);
-		return;
-	case 1:
-		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-		return;
-	case -EFAULT:
-		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
-		return;
-	}
 #else
 	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 #endif
@@ -1801,8 +1783,6 @@ struct ppc_emulated ppc_emulated = {
 	WARN_EMULATED_SETUP(unaligned),
 #ifdef CONFIG_MATH_EMULATION
 	WARN_EMULATED_SETUP(math),
-#elif defined(CONFIG_8XX_MINIMAL_FPEMU)
-	WARN_EMULATED_SETUP(8xx),
 #endif
 #ifdef CONFIG_VSX
 	WARN_EMULATED_SETUP(vsx),
