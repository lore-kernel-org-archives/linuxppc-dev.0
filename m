Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CAABBDDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 14:55:56 +1000 (EST)
Date: Tue, 21 Aug 2007 14:45:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 3/4] [POWERPC] Move the iSeries exception vectors
Message-Id: <20070821144538.4c6ce421.sfr@canb.auug.org.au>
In-Reply-To: <20070821144422.776257e3.sfr@canb.auug.org.au>
References: <20070821144222.e240bbf0.sfr@canb.auug.org.au>
	<20070821144422.776257e3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

out of head_64.S and into platforms/iseries/head.S

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/head_64.S         |  136 ---------------------------------
 arch/powerpc/platforms/iseries/head.S |  136 +++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 136 deletions(-)

Built for iseries_defconfig, pseries_defconfig, ppc64_defconfig,
allmodconfig and booted on iSeries 270 for iseries_defconfig and
ppc64_defconfig.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index fe6122b..33c4e8c 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -358,142 +358,6 @@ machine_check_fwnmi:
 	mtspr	SPRN_SPRG1,r13		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES_FORCE_64BIT(PACA_EXMC, machine_check_common)
 
-#ifdef CONFIG_PPC_ISERIES
-/***  ISeries-LPAR interrupt handlers ***/
-
-	STD_EXCEPTION_ISERIES(0x200, machine_check, PACA_EXMC)
-
-	.globl data_access_iSeries
-data_access_iSeries:
-	mtspr	SPRN_SPRG1,r13
-BEGIN_FTR_SECTION
-	mtspr	SPRN_SPRG2,r12
-	mfspr	r13,SPRN_DAR
-	mfspr	r12,SPRN_DSISR
-	srdi	r13,r13,60
-	rlwimi	r13,r12,16,0x20
-	mfcr	r12
-	cmpwi	r13,0x2c
-	beq	.do_stab_bolted_iSeries
-	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG2
-END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
-	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN)
-	EXCEPTION_PROLOG_ISERIES_2
-	b	data_access_common
-
-.do_stab_bolted_iSeries:
-	mtcrf	0x80,r12
-	mfspr	r12,SPRN_SPRG2
-	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
-	EXCEPTION_PROLOG_ISERIES_2
-	b	.do_stab_bolted
-
-	.globl	data_access_slb_iSeries
-data_access_slb_iSeries:
-	mtspr	SPRN_SPRG1,r13		/* save r13 */
-	mfspr	r13,SPRN_SPRG3		/* get paca address into r13 */
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	mfspr	r3,SPRN_DAR
-	std	r9,PACA_EXSLB+EX_R9(r13)
-	mfcr	r9
-#ifdef __DISABLED__
-	cmpdi	r3,0
-	bge	slb_miss_user_iseries
-#endif
-	std	r10,PACA_EXSLB+EX_R10(r13)
-	std	r11,PACA_EXSLB+EX_R11(r13)
-	std	r12,PACA_EXSLB+EX_R12(r13)
-	mfspr	r10,SPRN_SPRG1
-	std	r10,PACA_EXSLB+EX_R13(r13)
-	ld	r12,PACALPPACAPTR(r13)
-	ld	r12,LPPACASRR1(r12)
-	b	.slb_miss_realmode
-
-	STD_EXCEPTION_ISERIES(0x400, instruction_access, PACA_EXGEN)
-
-	.globl	instruction_access_slb_iSeries
-instruction_access_slb_iSeries:
-	mtspr	SPRN_SPRG1,r13		/* save r13 */
-	mfspr	r13,SPRN_SPRG3		/* get paca address into r13 */
-	std	r3,PACA_EXSLB+EX_R3(r13)
-	ld	r3,PACALPPACAPTR(r13)
-	ld	r3,LPPACASRR0(r3)	/* get SRR0 value */
-	std	r9,PACA_EXSLB+EX_R9(r13)
-	mfcr	r9
-#ifdef __DISABLED__
-	cmpdi	r3,0
-	bge	.slb_miss_user_iseries
-#endif
-	std	r10,PACA_EXSLB+EX_R10(r13)
-	std	r11,PACA_EXSLB+EX_R11(r13)
-	std	r12,PACA_EXSLB+EX_R12(r13)
-	mfspr	r10,SPRN_SPRG1
-	std	r10,PACA_EXSLB+EX_R13(r13)
-	ld	r12,PACALPPACAPTR(r13)
-	ld	r12,LPPACASRR1(r12)
-	b	.slb_miss_realmode
-
-#ifdef __DISABLED__
-slb_miss_user_iseries:
-	std	r10,PACA_EXGEN+EX_R10(r13)
-	std	r11,PACA_EXGEN+EX_R11(r13)
-	std	r12,PACA_EXGEN+EX_R12(r13)
-	mfspr	r10,SPRG1
-	ld	r11,PACA_EXSLB+EX_R9(r13)
-	ld	r12,PACA_EXSLB+EX_R3(r13)
-	std	r10,PACA_EXGEN+EX_R13(r13)
-	std	r11,PACA_EXGEN+EX_R9(r13)
-	std	r12,PACA_EXGEN+EX_R3(r13)
-	EXCEPTION_PROLOG_ISERIES_2
-	b	slb_miss_user_common
-#endif
-
-	MASKABLE_EXCEPTION_ISERIES(0x500, hardware_interrupt)
-	STD_EXCEPTION_ISERIES(0x600, alignment, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0x700, program_check, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0x800, fp_unavailable, PACA_EXGEN)
-	MASKABLE_EXCEPTION_ISERIES(0x900, decrementer)
-	STD_EXCEPTION_ISERIES(0xa00, trap_0a, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES(0xb00, trap_0b, PACA_EXGEN)
-
-	.globl	system_call_iSeries
-system_call_iSeries:
-	mr	r9,r13
-	mfspr	r13,SPRN_SPRG3
-	EXCEPTION_PROLOG_ISERIES_2
-	b	system_call_common
-
-	STD_EXCEPTION_ISERIES( 0xd00, single_step, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES( 0xe00, trap_0e, PACA_EXGEN)
-	STD_EXCEPTION_ISERIES( 0xf00, performance_monitor, PACA_EXGEN)
-
-decrementer_iSeries_masked:
-	/* We may not have a valid TOC pointer in here. */
-	li	r11,1
-	ld	r12,PACALPPACAPTR(r13)
-	stb	r11,LPPACADECRINT(r12)
-	LOAD_REG_IMMEDIATE(r12, tb_ticks_per_jiffy)
-	lwz	r12,0(r12)
-	mtspr	SPRN_DEC,r12
-	/* fall through */
-
-hardware_interrupt_iSeries_masked:
-	mtcrf	0x80,r9		/* Restore regs */
-	ld	r12,PACALPPACAPTR(r13)
-	ld	r11,LPPACASRR0(r12)
-	ld	r12,LPPACASRR1(r12)
-	mtspr	SPRN_SRR0,r11
-	mtspr	SPRN_SRR1,r12
-	ld	r9,PACA_EXGEN+EX_R9(r13)
-	ld	r10,PACA_EXGEN+EX_R10(r13)
-	ld	r11,PACA_EXGEN+EX_R11(r13)
-	ld	r12,PACA_EXGEN+EX_R12(r13)
-	ld	r13,PACA_EXGEN+EX_R13(r13)
-	rfid
-	b	.	/* prevent speculative execution */
-#endif /* CONFIG_PPC_ISERIES */
-
 /*** Common interrupt handlers ***/
 
 	STD_EXCEPTION_COMMON(0x100, system_reset, .system_reset_exception)
diff --git a/arch/powerpc/platforms/iseries/head.S b/arch/powerpc/platforms/iseries/head.S
index b6e2f8c..b5f6006 100644
--- a/arch/powerpc/platforms/iseries/head.S
+++ b/arch/powerpc/platforms/iseries/head.S
@@ -30,6 +30,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
+#include <asm/exception.h>
+#include <asm/cputable.h>
 
 	.text
 
@@ -83,6 +85,140 @@ iSeries_secondary_smp_loop:
 	b	1b			/* If SMP not configured, secondaries
 					 * loop forever */
 
+/***  ISeries-LPAR interrupt handlers ***/
+
+	STD_EXCEPTION_ISERIES(0x200, machine_check, PACA_EXMC)
+
+	.globl data_access_iSeries
+data_access_iSeries:
+	mtspr	SPRN_SPRG1,r13
+BEGIN_FTR_SECTION
+	mtspr	SPRN_SPRG2,r12
+	mfspr	r13,SPRN_DAR
+	mfspr	r12,SPRN_DSISR
+	srdi	r13,r13,60
+	rlwimi	r13,r12,16,0x20
+	mfcr	r12
+	cmpwi	r13,0x2c
+	beq	.do_stab_bolted_iSeries
+	mtcrf	0x80,r12
+	mfspr	r12,SPRN_SPRG2
+END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
+	EXCEPTION_PROLOG_ISERIES_1(PACA_EXGEN)
+	EXCEPTION_PROLOG_ISERIES_2
+	b	data_access_common
+
+.do_stab_bolted_iSeries:
+	mtcrf	0x80,r12
+	mfspr	r12,SPRN_SPRG2
+	EXCEPTION_PROLOG_ISERIES_1(PACA_EXSLB)
+	EXCEPTION_PROLOG_ISERIES_2
+	b	.do_stab_bolted
+
+	.globl	data_access_slb_iSeries
+data_access_slb_iSeries:
+	mtspr	SPRN_SPRG1,r13		/* save r13 */
+	mfspr	r13,SPRN_SPRG3		/* get paca address into r13 */
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r3,SPRN_DAR
+	std	r9,PACA_EXSLB+EX_R9(r13)
+	mfcr	r9
+#ifdef __DISABLED__
+	cmpdi	r3,0
+	bge	slb_miss_user_iseries
+#endif
+	std	r10,PACA_EXSLB+EX_R10(r13)
+	std	r11,PACA_EXSLB+EX_R11(r13)
+	std	r12,PACA_EXSLB+EX_R12(r13)
+	mfspr	r10,SPRN_SPRG1
+	std	r10,PACA_EXSLB+EX_R13(r13)
+	ld	r12,PACALPPACAPTR(r13)
+	ld	r12,LPPACASRR1(r12)
+	b	.slb_miss_realmode
+
+	STD_EXCEPTION_ISERIES(0x400, instruction_access, PACA_EXGEN)
+
+	.globl	instruction_access_slb_iSeries
+instruction_access_slb_iSeries:
+	mtspr	SPRN_SPRG1,r13		/* save r13 */
+	mfspr	r13,SPRN_SPRG3		/* get paca address into r13 */
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	ld	r3,PACALPPACAPTR(r13)
+	ld	r3,LPPACASRR0(r3)	/* get SRR0 value */
+	std	r9,PACA_EXSLB+EX_R9(r13)
+	mfcr	r9
+#ifdef __DISABLED__
+	cmpdi	r3,0
+	bge	slb_miss_user_iseries
+#endif
+	std	r10,PACA_EXSLB+EX_R10(r13)
+	std	r11,PACA_EXSLB+EX_R11(r13)
+	std	r12,PACA_EXSLB+EX_R12(r13)
+	mfspr	r10,SPRN_SPRG1
+	std	r10,PACA_EXSLB+EX_R13(r13)
+	ld	r12,PACALPPACAPTR(r13)
+	ld	r12,LPPACASRR1(r12)
+	b	.slb_miss_realmode
+
+#ifdef __DISABLED__
+slb_miss_user_iseries:
+	std	r10,PACA_EXGEN+EX_R10(r13)
+	std	r11,PACA_EXGEN+EX_R11(r13)
+	std	r12,PACA_EXGEN+EX_R12(r13)
+	mfspr	r10,SPRG1
+	ld	r11,PACA_EXSLB+EX_R9(r13)
+	ld	r12,PACA_EXSLB+EX_R3(r13)
+	std	r10,PACA_EXGEN+EX_R13(r13)
+	std	r11,PACA_EXGEN+EX_R9(r13)
+	std	r12,PACA_EXGEN+EX_R3(r13)
+	EXCEPTION_PROLOG_ISERIES_2
+	b	slb_miss_user_common
+#endif
+
+	MASKABLE_EXCEPTION_ISERIES(0x500, hardware_interrupt)
+	STD_EXCEPTION_ISERIES(0x600, alignment, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0x700, program_check, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0x800, fp_unavailable, PACA_EXGEN)
+	MASKABLE_EXCEPTION_ISERIES(0x900, decrementer)
+	STD_EXCEPTION_ISERIES(0xa00, trap_0a, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES(0xb00, trap_0b, PACA_EXGEN)
+
+	.globl	system_call_iSeries
+system_call_iSeries:
+	mr	r9,r13
+	mfspr	r13,SPRN_SPRG3
+	EXCEPTION_PROLOG_ISERIES_2
+	b	system_call_common
+
+	STD_EXCEPTION_ISERIES( 0xd00, single_step, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES( 0xe00, trap_0e, PACA_EXGEN)
+	STD_EXCEPTION_ISERIES( 0xf00, performance_monitor, PACA_EXGEN)
+
+decrementer_iSeries_masked:
+	/* We may not have a valid TOC pointer in here. */
+	li	r11,1
+	ld	r12,PACALPPACAPTR(r13)
+	stb	r11,LPPACADECRINT(r12)
+	LOAD_REG_IMMEDIATE(r12, tb_ticks_per_jiffy)
+	lwz	r12,0(r12)
+	mtspr	SPRN_DEC,r12
+	/* fall through */
+
+hardware_interrupt_iSeries_masked:
+	mtcrf	0x80,r9		/* Restore regs */
+	ld	r12,PACALPPACAPTR(r13)
+	ld	r11,LPPACASRR0(r12)
+	ld	r12,LPPACASRR1(r12)
+	mtspr	SPRN_SRR0,r11
+	mtspr	SPRN_SRR1,r12
+	ld	r9,PACA_EXGEN+EX_R9(r13)
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	ld	r11,PACA_EXGEN+EX_R11(r13)
+	ld	r12,PACA_EXGEN+EX_R12(r13)
+	ld	r13,PACA_EXGEN+EX_R13(r13)
+	rfid
+	b	.	/* prevent speculative execution */
+
 _INIT_STATIC(__start_initialization_iSeries)
 	/* Clear out the BSS */
 	LOAD_REG_IMMEDIATE(r11,__bss_stop)
-- 
1.5.2.4
