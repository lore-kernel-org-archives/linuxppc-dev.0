Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 16 Nov 2007 18:21:06 +1100
Subject: [PATCH] powerpc: Fix 44x Machine Check handling
Message-Id: <20071116072149.350ADDDDF4@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This removes the old CONFIG_440A which was a pain for multiplatform
kernel and wasn't set properly by default and replaces it with a
CPU feature. This makes Machine Check reporting work correctly on
my Ebony (440GP) board.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: I'm only setting it for 440GX and EPx as the old code did,
I haven't checked whether other new 440 chips such as SPe also
need that bit set.

 arch/powerpc/kernel/cputable.c     |   10 +++++-----
 arch/powerpc/kernel/head_44x.S     |   11 ++++++-----
 arch/powerpc/kernel/traps.c        |   19 ++++++++-----------
 arch/powerpc/platforms/44x/Kconfig |    5 -----
 include/asm-powerpc/cputable.h     |    3 ++-
 include/asm-powerpc/reg_booke.h    |    2 +-
 6 files changed, 22 insertions(+), 28 deletions(-)

Index: linux-work/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2007-11-16 16:15:29.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cputable.c	2007-11-16 16:17:42.000000000 +1100
@@ -1158,7 +1158,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pvr_mask		= 0xf0000ffb,
 		.pvr_value		= 0x200008D8,
 		.cpu_name		= "440EPX",
-		.cpu_features		= CPU_FTRS_44X,
+		.cpu_features		= CPU_FTRS_44X | CPU_FTR_440A,
 		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -1189,7 +1189,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x50000850,
 		.cpu_name		= "440GX Rev. A",
-		.cpu_features		= CPU_FTRS_44X,
+		.cpu_features		= CPU_FTRS_44X | CPU_FTR_440A,
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -1199,7 +1199,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x50000851,
 		.cpu_name		= "440GX Rev. B",
-		.cpu_features		= CPU_FTRS_44X,
+		.cpu_features		= CPU_FTRS_44X | CPU_FTR_440A,
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -1209,7 +1209,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x50000892,
 		.cpu_name		= "440GX Rev. C",
-		.cpu_features		= CPU_FTRS_44X,
+		.cpu_features		= CPU_FTRS_44X | CPU_FTR_440A,
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -1219,7 +1219,7 @@ static struct cpu_spec __initdata cpu_sp
 		.pvr_mask		= 0xf0000fff,
 		.pvr_value		= 0x50000894,
 		.cpu_name		= "440GX Rev. F",
-		.cpu_features		= CPU_FTRS_44X,
+		.cpu_features		= CPU_FTRS_44X | CPU_FTR_440A,
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
Index: linux-work/arch/powerpc/kernel/head_44x.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_44x.S	2007-11-16 16:21:49.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_44x.S	2007-11-16 16:27:12.000000000 +1100
@@ -197,7 +197,7 @@ skpinv:	addi	r4,r4,1				/* Increment */
 
 	/* Establish the interrupt vector offsets */
 	SET_IVOR(0,  CriticalInput);
-	SET_IVOR(1,  MachineCheck);
+	SET_IVOR(1,  MachineCheck); /* patched later on 440A */
 	SET_IVOR(2,  DataStorage);
 	SET_IVOR(3,  InstructionStorage);
 	SET_IVOR(4,  ExternalInput);
@@ -237,6 +237,10 @@ skpinv:	addi	r4,r4,1				/* Increment */
 
 	bl	early_init
 
+BEGIN_FTR_SECTION
+	SET_IVOR(1,  MachineCheckA);
+END_FTR_SECTION_IFSET(CPU_FTR_440A)
+
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
@@ -289,11 +293,8 @@ interrupt_base:
 	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
 
 	/* Machine Check Interrupt */
-#ifdef CONFIG_440A
-	MCHECK_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
-#else
 	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
-#endif
+	MCHECK_EXCEPTION(0x0200, MachineCheckA, machine_check_exception)
 
 	/* Data Storage Interrupt */
 	START_EXCEPTION(DataStorage)
Index: linux-work/arch/powerpc/kernel/traps.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/traps.c	2007-11-16 16:19:52.000000000 +1100
+++ linux-work/arch/powerpc/kernel/traps.c	2007-11-16 16:28:58.000000000 +1100
@@ -338,20 +338,16 @@ static int generic_machine_check_excepti
 {
 	unsigned long reason = get_mc_reason(regs);
 
-#if defined(CONFIG_4xx) && !defined(CONFIG_440A)
-	if (reason & ESR_IMCP) {
-		printk("Instruction");
-		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
-	} else
-		printk("Data");
-	printk(" machine check in kernel mode.\n");
-#elif defined(CONFIG_440A)
+#if defined(CONFIG_4xx)
 	printk("Machine check in kernel mode.\n");
 	if (reason & ESR_IMCP){
-		printk("Instruction Synchronous Machine Check exception\n");
+		if (cpu_has_feature(CPU_FTR_440A))
+			printk("Instruction Synchronous Machine Check exception\n");
+		else
+			printk("Instruction Machine Check exception\n");
 		mtspr(SPRN_ESR, reason & ~ESR_IMCP);
 	}
-	else {
+	else if (cpu_has_feature(CPU_FTR_440A)) {
 		u32 mcsr = mfspr(SPRN_MCSR);
 		if (mcsr & MCSR_IB)
 			printk("Instruction Read PLB Error\n");
@@ -374,7 +370,8 @@ static int generic_machine_check_excepti
 
 		/* Clear MCSR */
 		mtspr(SPRN_MCSR, mcsr);
-	}
+	} else
+		printk("Data Machine Check exception\n");
 #elif defined (CONFIG_E500)
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from MCSR=%lx): ", reason);
Index: linux-work/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/Kconfig	2007-11-16 16:13:49.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/Kconfig	2007-11-16 16:29:28.000000000 +1100
@@ -62,11 +62,6 @@ config 440GX
 config 440SP
 	bool
 
-config 440A
-	bool
-	depends on 440GX || 440EPX
-	default y
-
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
Index: linux-work/include/asm-powerpc/cputable.h
===================================================================
--- linux-work.orig/include/asm-powerpc/cputable.h	2007-11-16 16:14:29.000000000 +1100
+++ linux-work/include/asm-powerpc/cputable.h	2007-11-16 16:19:35.000000000 +1100
@@ -138,6 +138,7 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x0000000000800000)
 #define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x0000000001000000)
 #define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
+#define CPU_FTR_440A			ASM_CONST(0x0000000004000000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
@@ -400,7 +401,7 @@ enum {
 	    CPU_FTRS_40X |
 #endif
 #ifdef CONFIG_44x
-	    CPU_FTRS_44X |
+	    CPU_FTRS_44X | CPU_FTR_440A |
 #endif
 #ifdef CONFIG_E200
 	    CPU_FTRS_E200 |
Index: linux-work/include/asm-powerpc/reg_booke.h
===================================================================
--- linux-work.orig/include/asm-powerpc/reg_booke.h	2007-11-16 16:28:40.000000000 +1100
+++ linux-work/include/asm-powerpc/reg_booke.h	2007-11-16 16:28:43.000000000 +1100
@@ -207,7 +207,7 @@
 #define	CCR1_TCS	0x00000080 /* Timer Clock Select */
 
 /* Bit definitions for the MCSR. */
-#ifdef CONFIG_440A
+#ifdef CONFIG_4xx
 #define MCSR_MCS	0x80000000 /* Machine Check Summary */
 #define MCSR_IB		0x40000000 /* Instruction PLB Error */
 #define MCSR_DRB	0x20000000 /* Data Read PLB Error */
