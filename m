Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 555EB67C94
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 07:20:25 +1100 (EST)
Date: Wed, 22 Nov 2006 14:20:20 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Add support for FP emulation for the e300c2 core
Message-Id: <20061122142020.3e700bac.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The e300c2 has no FPU.  Its MSR[FP] is grounded to zero.  If an attempt
is made to execute a floating point instruction (including floating-point
load, store, or move instructions), the e300c2 takes a floating-point
unavailable interrupt (IVOR7).

This patch adds support for FP emulation on the e300c2 by declaring a
new CPU_FTR_FP_TAKES_FPUNAVAIL, where FP unavail interrupts are
intercepted and redirected to the ProgramCheck exception path for
correct emulation handling.

It adds a single cycle latency to "FPUfull" 32-bit powerpc processors
load_up_fpu path.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/Kconfig           |    2 +-
 arch/powerpc/kernel/cputable.c |    3 ++-
 arch/powerpc/kernel/head_32.S  |    7 +++++++
 arch/powerpc/kernel/traps.c    |    2 ++
 include/asm-powerpc/cputable.h |    1 +
 5 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1d71aff..250e4be 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -669,7 +669,7 @@ config FORCE_MAX_ZONEORDER
 
 config MATH_EMULATION
 	bool "Math emulation"
-	depends on 4xx || 8xx || E200 || E500
+	depends on 4xx || 8xx || E200 || PPC_83xx || E500
 	---help---
 	  Some PowerPC chips designed for embedded applications do not have
 	  a floating-point unit and therefore do not implement the
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 911ac44..0310be9 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -833,7 +833,8 @@ #if CLASSIC_PPC
 		.pvr_mask		= 0x7fff0000,
 		.pvr_value		= 0x00840000,
 		.cpu_name		= "e300c2",
-		.cpu_features		= CPU_FTRS_E300,
+		.cpu_features		= CPU_FTRS_E300 |
+			CPU_FTR_FP_TAKES_FPUNAVAIL,
 		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index d88e182..5bd8098 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -437,6 +437,13 @@ Alignment:
 /* Floating-point unavailable */
 	. = 0x800
 FPUnavailable:
+BEGIN_FTR_SECTION
+/*
+ * certain freescale cores treat 'normal' floating point instructions
+ * as FP Unavail exception.  Redirect to normal illegal/emulation handling.
+ */
+	b 	ProgramCheck
+END_FTR_SECTION_IFSET(CPU_FTR_FP_TAKES_FPUNAVAIL)
 	EXCEPTION_PROLOG
 	bne	load_up_fpu		/* if from user, just load it up */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 0d4e203..0de17e1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -790,6 +790,8 @@ #ifdef CONFIG_MATH_EMULATION
 	 * hardware people - not sure if it can happen on any illegal
 	 * instruction or only on FP instructions, whether there is a
 	 * pattern to occurences etc. -dgibson 31/Mar/2003 */
+	/* certain freescale cores reach here from the FPUnavailable
+	 * exception path, also without setting ESR */
 	if (!(reason & REASON_TRAP) && do_mathemu(regs) == 0) {
 		emulate_single_step(regs);
 		return;
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index d06222a..5eae732 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -126,6 +126,7 @@ #define CPU_FTR_BIG_PHYS		ASM_CONST(0x00
 #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
 #define CPU_FTR_PPC_LE			ASM_CONST(0x0000000000200000)
 #define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
+#define CPU_FTR_FP_TAKES_FPUNAVAIL	ASM_CONST(0x0000000000800000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
-- 
1.4.2.3
