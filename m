Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C7CAB6F06
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2011 22:30:31 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] powerpc/fsl-booke64: Add support for Debug Level
	exception handler
Date: Wed,  6 Apr 2011 07:30:22 -0500
Message-Id: <1302093022-10875-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/cputable.h  |    4 ++-
 arch/powerpc/kernel/exceptions-64e.S |   65 ++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/setup_64.c       |    8 ++++
 3 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 9028a9e..bb9fc80 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -157,6 +157,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_476_DD2			ASM_CONST(0x0000000000010000)
 #define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
 #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
+#define CPU_FTR_DEBUG_LVL_EXC		ASM_CONST(0x0000000000080000)
 #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
 #define CPU_FTR_PPC_LE			ASM_CONST(0x0000000000200000)
 #define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
@@ -389,7 +390,8 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_E5500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
-	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD)
+	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
+	    CPU_FTR_DEBUG_LVL_EXC)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 5c43063..28f2223 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -252,9 +252,6 @@ exception_marker:
 	.balign	0x1000
 	.globl interrupt_base_book3e
 interrupt_base_book3e:					/* fake trap */
-	/* Note: If real debug exceptions are supported by the HW, the vector
-	 * below will have to be patched up to point to an appropriate handler
-	 */
 	EXCEPTION_STUB(0x000, machine_check)		/* 0x0200 */
 	EXCEPTION_STUB(0x020, critical_input)		/* 0x0580 */
 	EXCEPTION_STUB(0x040, debug_crit)		/* 0x0d00 */
@@ -454,6 +451,68 @@ interrupt_end_book3e:
 kernel_dbg_exc:
 	b	.	/* NYI */
 
+/* Debug exception as a debug interrupt*/
+	START_EXCEPTION(debug_debug);
+	DBG_EXCEPTION_PROLOG(0xd00, PROLOG_ADDITION_2REGS)
+
+	/*
+	 * If there is a single step or branch-taken exception in an
+	 * exception entry sequence, it was probably meant to apply to
+	 * the code where the exception occurred (since exception entry
+	 * doesn't turn off DE automatically).  We simulate the effect
+	 * of turning off DE on entry to an exception handler by turning
+	 * off DE in the DSRR1 value and clearing the debug status.
+	 */
+
+	mfspr	r14,SPRN_DBSR		/* check single-step/branch taken */
+	andis.	r15,r14,DBSR_IC@h
+	beq+	1f
+
+	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
+	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
+	cmpld	cr0,r10,r14
+	cmpld	cr1,r10,r15
+	blt+	cr0,1f
+	bge+	cr1,1f
+
+	/* here it looks like we got an inappropriate debug exception. */
+	lis	r14,DBSR_IC@h		/* clear the IC event */
+	rlwinm	r11,r11,0,~MSR_DE	/* clear DE in the DSRR1 value */
+	mtspr	SPRN_DBSR,r14
+	mtspr	SPRN_DSRR1,r11
+	lwz	r10,PACA_EXDBG+EX_CR(r13)	/* restore registers */
+	ld	r1,PACA_EXDBG+EX_R1(r13)
+	ld	r14,PACA_EXDBG+EX_R14(r13)
+	ld	r15,PACA_EXDBG+EX_R15(r13)
+	mtcr	r10
+	ld	r10,PACA_EXDBG+EX_R10(r13)	/* restore registers */
+	ld	r11,PACA_EXDBG+EX_R11(r13)
+	mfspr	r13,SPRN_SPRG_DBG_SCRATCH
+	rfdi
+
+	/* Normal debug exception */
+	/* XXX We only handle coming from userspace for now since we can't
+	 *     quite save properly an interrupted kernel state yet
+	 */
+1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
+	beq	kernel_dbg_exc;		/* if from kernel mode */
+
+	/* Now we mash up things to make it look like we are coming on a
+	 * normal exception
+	 */
+	mfspr	r15,SPRN_SPRG_DBG_SCRATCH
+	mtspr	SPRN_SPRG_GEN_SCRATCH,r15
+	mfspr	r14,SPRN_DBSR
+	EXCEPTION_COMMON(0xd00, PACA_EXDBG, INTS_DISABLE_ALL)
+	std	r14,_DSISR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	mr	r4,r14
+	ld	r14,PACA_EXDBG+EX_R14(r13)
+	ld	r15,PACA_EXDBG+EX_R15(r13)
+	bl	.save_nvgprs
+	bl	.DebugException
+	b	.ret_from_except
+
 /* Doorbell interrupt */
 	MASKABLE_EXCEPTION(0x2070, doorbell, .doorbell_exception, ACK_NONE)
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 5a0401f..2ff0032 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -62,6 +62,7 @@
 #include <asm/udbg.h>
 #include <asm/kexec.h>
 #include <asm/mmu_context.h>
+#include <asm/code-patching.h>
 
 #include "setup.h"
 
@@ -453,6 +454,9 @@ static void __init irqstack_early_init(void)
 #ifdef CONFIG_PPC_BOOK3E
 static void __init exc_lvl_early_init(void)
 {
+	extern unsigned int interrupt_base_book3e;
+	extern unsigned int exc_debug_debug_book3e;
+
 	unsigned int i;
 
 	for_each_possible_cpu(i) {
@@ -463,6 +467,10 @@ static void __init exc_lvl_early_init(void)
 		mcheckirq_ctx[i] = (struct thread_info *)
 			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
 	}
+
+	if (cpu_has_feature(CPU_FTR_DEBUG_LVL_EXC))
+		patch_branch(&interrupt_base_book3e + (0x040 / 4) + 1,
+			     (unsigned long)&exc_debug_debug_book3e, 0);
 }
 #else
 #define exc_lvl_early_init()
-- 
1.7.3.4
