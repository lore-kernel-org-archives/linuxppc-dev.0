Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw45v5B1YzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:45:07 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i6so4904078pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:45:07 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 08/14] powerpc/pseries: consolidate exception handler alignment
Date: Thu, 21 Jul 2016 16:44:07 +1000
Message-Id: <1469083453-9279-9-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move exception handler alignment directives into the head-64.h macros,
beause they will no longer work in-place after the next patch. This
slightly changes functions that have alignments applied and therefore
code generation, which is why it was not done initially (see earlier
patch).

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/head-64.h   |  5 +++++
 arch/powerpc/kernel/exceptions-64s.S | 38 +-----------------------------------
 2 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index bc06848..98cd36b 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -1,9 +1,11 @@
 #ifndef _ASM_POWERPC_HEAD_64_H
 #define _ASM_POWERPC_HEAD_64_H
 
+#include <asm/cache.h>
 
 #define VECTOR_HANDLER_REAL_BEGIN(name, start, end)			\
 	. = start ;							\
+	.align 7;							\
 	.global exc_##start##_##name ;					\
 exc_##start##_##name:
 
@@ -11,18 +13,21 @@ exc_##start##_##name:
 
 #define VECTOR_HANDLER_VIRT_BEGIN(name, start, end)			\
 	. = start ;							\
+	.align 7;	i						\
 	.global exc_##start##_##name ;					\
 exc_##start##_##name:
 
 #define VECTOR_HANDLER_VIRT_END(name, start, end)
 
 #define COMMON_HANDLER_BEGIN(name)					\
+	.align 7;							\
 	.global name;							\
 name:
 
 #define COMMON_HANDLER_END(name)
 
 #define TRAMP_HANDLER_BEGIN(name)					\
+	.align 7;							\
 	.global name ;							\
 name:
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 82fb261..db13569 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -407,7 +407,6 @@ VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-	.align 7;
 TRAMP_HANDLER_BEGIN(machine_check_powernv_early)
 BEGIN_FTR_SECTION
 	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
@@ -566,7 +565,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 COMMON_HANDLER_END(denorm_assist)
 
-	.align	7
 	/* moved from 0x900 */
 __TRAMP_HANDLER_REAL_OOL_MASKABLE(decrementer, 0x900)
 
@@ -680,7 +678,6 @@ COMMON_HANDLER_END(__replay_interrupt)
 /*
  * Vectors for the FWNMI option.  Share common code.
  */
-      .align 7
 TRAMP_HANDLER_BEGIN(system_reset_fwnmi)
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
@@ -727,55 +724,37 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 
 /*** Common interrupt handlers ***/
 
-	.align 7;
 COMMON_HANDLER(system_reset_common, 0x100, system_reset_exception)
-	.align 7;
 COMMON_HANDLER_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
-	.align 7;
 COMMON_HANDLER_ASYNC(decrementer_common, 0x900, timer_interrupt)
-	.align 7;
 COMMON_HANDLER(hdecrementer_common, 0x980, hdec_interrupt)
 
-	.align 7;
 #ifdef CONFIG_PPC_DOORBELL
 COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
 #else
 COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
 #endif
-	.align 7;
 COMMON_HANDLER(trap_0b_common, 0xb00, unknown_exception)
-	.align 7;
 COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
-	.align 7;
 COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
-	.align 7;
 COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
-	.align 7;
 COMMON_HANDLER_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
-	.align 7;
 #ifdef CONFIG_PPC_DOORBELL
 COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
 #else
 COMMON_HANDLER_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
 #endif
-	.align 7;
 COMMON_HANDLER_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
-	.align 7;
 COMMON_HANDLER(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
-	.align 7;
 COMMON_HANDLER_HV(denorm_common, 0x1500, unknown_exception)
-	.align 7;
 #ifdef CONFIG_ALTIVEC
 COMMON_HANDLER(altivec_assist_common, 0x1700, altivec_assist_exception)
 #else
 COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 #endif
 #ifdef CONFIG_CBE_RAS
-	.align 7;
 COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
-	.align 7;
 COMMON_HANDLER(cbe_maintenance, 0x1600, cbe_maintenance_exception)
-	.align 7;
 COMMON_HANDLER(cbe_thermal, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
@@ -918,7 +897,6 @@ VECTOR_HANDLER_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
 VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
 
 
-	.align	7
 TRAMP_HANDLER_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
@@ -928,7 +906,6 @@ TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
  * SRR0 and SRR1 are saved in r11 and r12,
  * r9 - r13 are saved in paca->exgen.
  */
-	.align	7
 COMMON_HANDLER_BEGIN(data_access_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
@@ -949,7 +926,6 @@ MMU_FTR_SECTION_ELSE
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
 COMMON_HANDLER_END(data_access_common)
 
-	.align  7
 COMMON_HANDLER_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
 	std     r10,PACA_EXGEN+EX_DAR(r13)
@@ -963,7 +939,6 @@ COMMON_HANDLER_BEGIN(h_data_storage_common)
 	b       ret_from_except
 COMMON_HANDLER_END(h_data_storage_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(instruction_access_common)
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
 	RECONCILE_IRQ_STATE(r10, r11)
@@ -980,14 +955,12 @@ MMU_FTR_SECTION_ELSE
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
 COMMON_HANDLER_END(instruction_access_common)
 
-	.align 7
 COMMON_HANDLER(h_instr_storage_common, 0xe20, unknown_exception)
 
 	/*
 	 * Machine check is different because we use a different
 	 * save area: PACA_EXMC instead of PACA_EXGEN.
 	 */
-	.align	7
 COMMON_HANDLER_BEGIN(machine_check_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
@@ -1006,7 +979,6 @@ COMMON_HANDLER_BEGIN(machine_check_common)
 	b	ret_from_except
 COMMON_HANDLER_END(machine_check_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(alignment_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
@@ -1024,7 +996,6 @@ COMMON_HANDLER_BEGIN(alignment_common)
 	b	ret_from_except
 COMMON_HANDLER_END(alignment_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(program_check_common)
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	save_nvgprs
@@ -1034,7 +1005,6 @@ COMMON_HANDLER_BEGIN(program_check_common)
 	b	ret_from_except
 COMMON_HANDLER_END(program_check_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(fp_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	1f			/* if from user, just load it up */
@@ -1065,7 +1035,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 COMMON_HANDLER_END(fp_unavailable_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
@@ -1100,7 +1069,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	b	ret_from_except
 COMMON_HANDLER_END(altivec_unavailable_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(vsx_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
 #ifdef CONFIG_VSX
@@ -1134,9 +1102,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	b	ret_from_except
 COMMON_HANDLER_END(vsx_unavailable_common)
 
-	.align 7;
 COMMON_HANDLER(facility_unavailable_common, 0xf60, facility_unavailable_exception)
-	.align 7;
 COMMON_HANDLER(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
@@ -1174,7 +1140,6 @@ fwnmi_data_area:
 	. = 0x8000
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
-	.align 7;
 COMMON_HANDLER_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0xe60)
 	mr	r10,r1			/* Save r1			*/
@@ -1261,7 +1226,6 @@ COMMON_HANDLER_END(hmi_exception_early)
 	 * Handle machine check early in real mode. We come here with
 	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
 	 */
-	.align	7
 COMMON_HANDLER_BEGIN(machine_check_handle_early)
 	std	r0,GPR0(r1)	/* Save r0 */
 	EXCEPTION_PROLOG_COMMON_3(0x200)
@@ -1458,7 +1422,7 @@ TRAMP_HANDLER_END(power4_fixup_nap)
 /*
  * Hash table stuff
  */
-	.align	7
+	.align 7
 do_hash_page:
 #ifdef CONFIG_PPC_STD_MMU_64
 	andis.	r0,r4,0xa410		/* weird error? */
-- 
2.8.1
