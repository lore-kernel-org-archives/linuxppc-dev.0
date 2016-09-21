Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBV01JFNzDsh3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:40 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id my20so1944622pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/41] powerpc/64s: consolidate exception handler alignment
Date: Wed, 21 Sep 2016 17:43:28 +1000
Message-Id: <20160921074407.4885-3-npiggin@gmail.com>
In-Reply-To: <20160921074407.4885-1-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/head-64.h   |  1 +
 arch/powerpc/kernel/exceptions-64s.S | 36 ------------------------------------
 2 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index cf44542..a76049d 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -18,6 +18,7 @@ exc_##start##_##name:
 #define VECTOR_HANDLER_VIRT_END(name, start, end)
 
 #define COMMON_HANDLER_BEGIN(name)					\
+	.align	7;							\
 	.global name;							\
 name:
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index facfb5f..418758d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -371,7 +371,6 @@ VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-	.align 7;
 TRAMP_HANDLER_BEGIN(machine_check_powernv_early)
 BEGIN_FTR_SECTION
 	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
@@ -546,7 +545,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 TRAMP_HANDLER_END(denorm_assist)
 
-	.align	7
 	/* moved from 0xe00 */
 __TRAMP_HANDLER_REAL_OOL_HV(h_data_storage, 0xe00)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
@@ -663,7 +661,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 /*
  * Vectors for the FWNMI option.  Share common code.
  */
-      .align 7
 TRAMP_HANDLER_BEGIN(system_reset_fwnmi)
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
@@ -709,46 +706,30 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 
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
 COMMON_HANDLER_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
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
@@ -904,7 +885,6 @@ TRAMP_HANDLER_END(ppc64_runlatch_on_trampoline)
  * SRR0 and SRR1 are saved in r11 and r12,
  * r9 - r13 are saved in paca->exgen.
  */
-	.align	7
 COMMON_HANDLER_BEGIN(data_access_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
@@ -925,7 +905,6 @@ MMU_FTR_SECTION_ELSE
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 COMMON_HANDLER_END(data_access_common)
 
-	.align  7
 COMMON_HANDLER_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
 	std     r10,PACA_EXGEN+EX_DAR(r13)
@@ -939,7 +918,6 @@ COMMON_HANDLER_BEGIN(h_data_storage_common)
 	b       ret_from_except
 COMMON_HANDLER_END(h_data_storage_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(instruction_access_common)
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
 	RECONCILE_IRQ_STATE(r10, r11)
@@ -956,14 +934,12 @@ MMU_FTR_SECTION_ELSE
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
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
 	std	r10,PACA_EXMC+EX_DAR(r13)
@@ -985,7 +961,6 @@ COMMON_HANDLER_BEGIN(machine_check_common)
 	b	ret_from_except
 COMMON_HANDLER_END(machine_check_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(alignment_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
@@ -1003,7 +978,6 @@ COMMON_HANDLER_BEGIN(alignment_common)
 	b	ret_from_except
 COMMON_HANDLER_END(alignment_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(program_check_common)
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	save_nvgprs
@@ -1013,7 +987,6 @@ COMMON_HANDLER_BEGIN(program_check_common)
 	b	ret_from_except
 COMMON_HANDLER_END(program_check_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(fp_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	1f			/* if from user, just load it up */
@@ -1044,7 +1017,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 COMMON_HANDLER_END(fp_unavailable_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
@@ -1079,7 +1051,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	b	ret_from_except
 COMMON_HANDLER_END(altivec_unavailable_common)
 
-	.align	7
 COMMON_HANDLER_BEGIN(vsx_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
 #ifdef CONFIG_VSX
@@ -1149,22 +1120,16 @@ fwnmi_data_area:
 	. = 0x8000
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
-	.align 7;
 COMMON_HANDLER(facility_unavailable_common, 0xf60, facility_unavailable_exception)
-	.align 7;
 COMMON_HANDLER(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
 #ifdef CONFIG_CBE_RAS
-	.align 7;
 COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
-	.align 7;
 COMMON_HANDLER(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
-	.align 7;
 COMMON_HANDLER(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
 
-	.align 7;
 COMMON_HANDLER_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
 	mr	r10,r1			/* Save r1			*/
@@ -1251,7 +1216,6 @@ COMMON_HANDLER_END(hmi_exception_early)
 	 * Handle machine check early in real mode. We come here with
 	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
 	 */
-	.align	7
 COMMON_HANDLER_BEGIN(machine_check_handle_early)
 	std	r0,GPR0(r1)	/* Save r0 */
 	EXCEPTION_PROLOG_COMMON_3(0x200)
-- 
2.9.3
