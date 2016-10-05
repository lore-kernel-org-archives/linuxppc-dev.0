Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc276BSpzDrLw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 02/42] powerpc/64s: Consolidate exception handler alignment
Date: Wed,  5 Oct 2016 11:22:24 +1100
Message-Id: <1475626984-18770-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Move exception handler alignment directives into the head-64.h macros,
beause they will no longer work in-place after the next patch. This
slightly changes functions that have alignments applied and therefore
code generation, which is why it was not done initially (see earlier
patch).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/head-64.h   |  1 +
 arch/powerpc/kernel/exceptions-64s.S | 36 ------------------------------------
 2 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 358c25c80c62..613f743e91aa 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -18,6 +18,7 @@ exc_virt_##start##_##name:
 #define EXC_VIRT_END(name, start, end)
 
 #define EXC_COMMON_BEGIN(name)					\
+	.align	7;							\
 	.global name;							\
 name:
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 52d22891f6a4..d398e8716ef8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -366,7 +366,6 @@ EXC_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-	.align 7;
 TRAMP_REAL_BEGIN(machine_check_powernv_early)
 BEGIN_FTR_SECTION
 	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
@@ -535,7 +534,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	b	.
 #endif
 
-	.align	7
 	/* moved from 0xe00 */
 __TRAMP_REAL_REAL_OOL_HV(h_data_storage, 0xe00)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0xe00)
@@ -652,7 +650,6 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 /*
  * Vectors for the FWNMI option.  Share common code.
  */
-      .align 7
 TRAMP_REAL_BEGIN(system_reset_fwnmi)
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
@@ -695,46 +692,30 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 
 /*** Common interrupt handlers ***/
 
-	.align 7;
 EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
-	.align 7;
 EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
-	.align 7;
 EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
-	.align 7;
 EXC_COMMON(hdecrementer_common, 0x980, hdec_interrupt)
 
-	.align 7;
 #ifdef CONFIG_PPC_DOORBELL
 EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
 #else
 EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
 #endif
-	.align 7;
 EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
-	.align 7;
 EXC_COMMON(single_step_common, 0xd00, single_step_exception)
-	.align 7;
 EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
-	.align 7;
 EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
-	.align 7;
 EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
-	.align 7;
 #ifdef CONFIG_PPC_DOORBELL
 EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, doorbell_exception)
 #else
 EXC_COMMON_ASYNC(h_doorbell_common, 0xe80, unknown_exception)
 #endif
-	.align 7;
 EXC_COMMON_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
-	.align 7;
 EXC_COMMON_ASYNC(performance_monitor_common, 0xf00, performance_monitor_exception)
-	.align 7;
 EXC_COMMON(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
-	.align 7;
 EXC_COMMON_HV(denorm_common, 0x1500, unknown_exception)
-	.align 7;
 #ifdef CONFIG_ALTIVEC
 EXC_COMMON(altivec_assist_common, 0x1700, altivec_assist_exception)
 #else
@@ -889,7 +870,6 @@ TRAMP_REAL_BEGIN(ppc64_runlatch_on_trampoline)
  * SRR0 and SRR1 are saved in r11 and r12,
  * r9 - r13 are saved in paca->exgen.
  */
-	.align	7
 EXC_COMMON_BEGIN(data_access_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
@@ -909,7 +889,6 @@ MMU_FTR_SECTION_ELSE
 	b	handle_page_fault
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
-	.align  7
 EXC_COMMON_BEGIN(h_data_storage_common)
 	mfspr   r10,SPRN_HDAR
 	std     r10,PACA_EXGEN+EX_DAR(r13)
@@ -922,7 +901,6 @@ EXC_COMMON_BEGIN(h_data_storage_common)
 	bl      unknown_exception
 	b       ret_from_except
 
-	.align	7
 EXC_COMMON_BEGIN(instruction_access_common)
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
 	RECONCILE_IRQ_STATE(r10, r11)
@@ -938,14 +916,12 @@ MMU_FTR_SECTION_ELSE
 	b	handle_page_fault
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 
-	.align 7
 EXC_COMMON(h_instr_storage_common, 0xe20, unknown_exception)
 
 	/*
 	 * Machine check is different because we use a different
 	 * save area: PACA_EXMC instead of PACA_EXGEN.
 	 */
-	.align	7
 EXC_COMMON_BEGIN(machine_check_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXMC+EX_DAR(r13)
@@ -966,7 +942,6 @@ EXC_COMMON_BEGIN(machine_check_common)
 	bl	machine_check_exception
 	b	ret_from_except
 
-	.align	7
 EXC_COMMON_BEGIN(alignment_common)
 	mfspr	r10,SPRN_DAR
 	std	r10,PACA_EXGEN+EX_DAR(r13)
@@ -983,7 +958,6 @@ EXC_COMMON_BEGIN(alignment_common)
 	bl	alignment_exception
 	b	ret_from_except
 
-	.align	7
 EXC_COMMON_BEGIN(program_check_common)
 	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	save_nvgprs
@@ -992,7 +966,6 @@ EXC_COMMON_BEGIN(program_check_common)
 	bl	program_check_exception
 	b	ret_from_except
 
-	.align	7
 EXC_COMMON_BEGIN(fp_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0x800, PACA_EXGEN)
 	bne	1f			/* if from user, just load it up */
@@ -1022,7 +995,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 	b	ret_from_except
 #endif
 
-	.align	7
 EXC_COMMON_BEGIN(altivec_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf20, PACA_EXGEN)
 #ifdef CONFIG_ALTIVEC
@@ -1056,7 +1028,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	bl	altivec_unavailable_exception
 	b	ret_from_except
 
-	.align	7
 EXC_COMMON_BEGIN(vsx_unavailable_common)
 	EXCEPTION_PROLOG_COMMON(0xf40, PACA_EXGEN)
 #ifdef CONFIG_VSX
@@ -1125,22 +1096,16 @@ fwnmi_data_area:
 	. = 0x8000
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
-	.align 7;
 EXC_COMMON(facility_unavailable_common, 0xf60, facility_unavailable_exception)
-	.align 7;
 EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
 #ifdef CONFIG_CBE_RAS
-	.align 7;
 EXC_COMMON(cbe_system_error_common, 0x1200, cbe_system_error_exception)
-	.align 7;
 EXC_COMMON(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
-	.align 7;
 EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
 
-	.align 7;
 EXC_COMMON_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
 	mr	r10,r1			/* Save r1			*/
@@ -1226,7 +1191,6 @@ hmi_exception_after_realmode:
 	 * Handle machine check early in real mode. We come here with
 	 * ME=1, MMU (IR=0 and DR=0) off and using MC emergency stack.
 	 */
-	.align	7
 EXC_COMMON_BEGIN(machine_check_handle_early)
 	std	r0,GPR0(r1)	/* Save r0 */
 	EXCEPTION_PROLOG_COMMON_3(0x200)
-- 
2.7.4
