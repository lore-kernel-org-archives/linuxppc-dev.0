Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 07/14] powerpc: Add relocation on exception vector handlers
Date: Fri,  9 Nov 2012 17:19:05 +1100
Message-Id: <1352441953-29096-8-git-send-email-mikey@neuling.org>
In-Reply-To: <1352441953-29096-1-git-send-email-mikey@neuling.org>
References: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER8/v2.07 allows exceptions to be taken with the MMU still on.

A new set of exception vectors is added at 0xc000_0000_0000_4xxx.  When the HW
takes us here, MSR IR/DR will be set already and we no longer need a costly
RFID to turn the MMU back on again.

The original 0x0 based exception vectors remain for when the HW can't leave the
MMU on.  Examples of this are when we can't trust the current the MMU mappings,
like when we are changing from guest to hypervisor (HV 0 -> 1) or when the MMU
was off already.  In these cases the HW will take us to the original 0x0 based
exception vectors with the MMU off as before.

This uses the new macros added previously too implement these new execption
vectors at 0xc000_0000_0000_4xxx.  We exit these exception vectors using
mflr/blr (rather than mtspr SSR0/RFID), since we don't need the costly MMU
switch anymore.

This moves the __end_interrupts marker down past these new 0x4000 vectors since
they will need to be copied down to 0x0 when the kernel is not at 0x0.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/exception-64s.h |    4 +-
 arch/powerpc/kernel/exceptions-64s.S     |  180 ++++++++++++++++++++++++++++--
 arch/powerpc/kernel/head_64.S            |    3 +-
 3 files changed, 177 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 10787d3..ad708dd 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -115,6 +115,7 @@
 	mfspr	r10,SPRN_CFAR;						\
 	std	r10,area+EX_CFAR(r13);					\
 	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		\
+	SAVE_LR(r10, area);						\
 	mfcr	r9;							\
 	extra(vec);							\
 	std	r11,area+EX_R11(r13);					\
@@ -215,6 +216,7 @@ do_kvm_##n:								\
 	sth	r1,PACA_TRAP_SAVE(r13);					   \
 	std	r3,area+EX_R3(r13);					   \
 	addi	r3,r13,area;		/* r3 -> where regs are saved*/	   \
+	RESTORE_LR(r1, area);						   \
 	b	bad_stack;						   \
 3:	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
 	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
@@ -240,8 +242,8 @@ do_kvm_##n:								\
 	ld	r10,area+EX_CFAR(r13);					   \
 	std	r10,ORIG_GPR3(r1);					   \
 	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		   \
+	GET_LR(r9,area);		/* Get LR, later save to stack	*/ \
 	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
-	mflr	r9;			/* save LR in stackframe	*/ \
 	std	r9,_LINK(r1);						   \
 	mfctr	r10;			/* save CTR in stackframe	*/ \
 	std	r10,_CTR(r1);						   \
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4dc1a04..fb95747 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -19,11 +19,13 @@
 /*
  * We layout physical memory as follows:
  * 0x0000 - 0x00ff : Secondary processor spin code
- * 0x0100 - 0x2fff : pSeries Interrupt prologs
- * 0x3000 - 0x5fff : interrupt support common interrupt prologs
- * 0x6000 - 0x6fff : Initial (CPU0) segment table
+ * 0x0100 - 0x17ff : pSeries Interrupt prologs
+ * 0x1800 - 0x4000 : interrupt support common interrupt prologs
+ * 0x4000 - 0x5fff : pSeries interrupts with IR=1,DR=1
+ * 0x6000 - 0x6fff : more interrupt support including for IR=1,DR=1
  * 0x7000 - 0x7fff : FWNMI data area
- * 0x8000 -        : Early init and support code
+ * 0x8000 - 0x8fff : Initial (CPU0) segment table
+ * 0x9000 -        : Early init and support code
  */
 	/* Syscall routine is used twice, in reloc-off and reloc-on paths */
 #define SYSCALL_PSERIES_1 					\
@@ -619,10 +621,6 @@ slb_miss_user_pseries:
 	b	.				/* prevent spec. execution */
 #endif /* __DISABLED__ */
 
-	.align	7
-	.globl	__end_interrupts
-__end_interrupts:
-
 /*
  * Code from here down to __end_handlers is invoked from the
  * exception prologs above.  Because the prologs assemble the
@@ -673,7 +671,158 @@ machine_check_common:
 	STD_EXCEPTION_COMMON(0x1800, cbe_thermal, .cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
+	/*
+	 * Relocation-on interrupts: A subset of the interrupts can be delivered
+	 * with IR=1/DR=1, if AIL==2 and MSR.HV won't be changed by delivering
+	 * it.  Addresses are the same as the original interrupt addresses, but
+	 * offset by 0xc000000000004000.
+	 * It's impossible to receive interrupts below 0x300 via this mechanism.
+	 * KVM: None of these traps are from the guest ; anything that escalated
+	 * to HV=1 from HV=0 is delivered via real mode handlers.
+	 */
+
+	/*
+	 * This uses the standard macro, since the original 0x300 vector
+	 * only has extra guff for STAB-based processors -- which never
+	 * come here.
+	 */
+	STD_RELON_EXCEPTION_PSERIES(0x4300, 0x300, data_access)
+	. = 0x4380
+	.globl data_access_slb_relon_pSeries
+data_access_slb_relon_pSeries:
+	HMT_MEDIUM
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r3,SPRN_DAR
+	mfspr	r12,SPRN_SRR1
+#ifndef CONFIG_RELOCATABLE
+	b	.slb_miss_realmode
+#else
+	/*
+	 * We can't just use a direct branch to .slb_miss_realmode
+	 * because the distance from here to there depends on where
+	 * the kernel ends up being put.
+	 */
+	mfctr	r11
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER(r10, .slb_miss_realmode)
+	mtctr	r10
+	bctr
+#endif
+
+	STD_RELON_EXCEPTION_PSERIES(0x4400, 0x400, instruction_access)
+	. = 0x4480
+	.globl instruction_access_slb_relon_pSeries
+instruction_access_slb_relon_pSeries:
+	HMT_MEDIUM
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
+	std	r3,PACA_EXSLB+EX_R3(r13)
+	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
+	mfspr	r12,SPRN_SRR1
+#ifndef CONFIG_RELOCATABLE
+	b	.slb_miss_realmode
+#else
+	mfctr	r11
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER(r10, .slb_miss_realmode)
+	mtctr	r10
+	bctr
+#endif
+
+	. = 0x4500
+	.globl hardware_interrupt_relon_pSeries;
+	.globl hardware_interrupt_relon_hv;
+hardware_interrupt_relon_pSeries:
+hardware_interrupt_relon_hv:
+	BEGIN_FTR_SECTION
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x502, hardware_interrupt, EXC_HV, SOFTEN_TEST_HV)
+	FTR_SECTION_ELSE
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt, EXC_STD, SOFTEN_TEST_PR)
+	ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_206)
+	STD_RELON_EXCEPTION_PSERIES(0x4600, 0x600, alignment)
+	STD_RELON_EXCEPTION_PSERIES(0x4700, 0x700, program_check)
+	STD_RELON_EXCEPTION_PSERIES(0x4800, 0x800, fp_unavailable)
+	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer)
+	STD_RELON_EXCEPTION_PSERIES(0x4980, 0x980, hdecrementer)
+	STD_RELON_EXCEPTION_PSERIES(0x4b00, 0xb00, trap_0b)
+
+	. = 0x4c00
+	.globl system_call_relon_pSeries
+system_call_relon_pSeries:
+	HMT_MEDIUM
+	SYSCALL_PSERIES_1
+	SYSCALL_PSERIES_2_DIRECT
+	SYSCALL_PSERIES_3
+
+	STD_RELON_EXCEPTION_PSERIES(0x4d00, 0xd00, single_step)
+
+	. = 0x4e00
+	b	h_data_storage_relon_hv
+
+	. = 0x4e20
+	b	h_instr_storage_relon_hv
+
+	. = 0x4e40
+	b	emulation_assist_relon_hv
+
+	. = 0x4e50
+	b	hmi_exception_relon_hv
+
+	. = 0x4e60
+	b	hmi_exception_relon_hv
+
+	/* For when we support the doorbell interrupt:
+	STD_RELON_EXCEPTION_HYPERVISOR(0x4e80, 0xe80, doorbell_hyper)
+	*/
+
+performance_monitor_relon_pSeries_1:
+	. = 0x4f00
+	b	performance_monitor_relon_pSeries
+
+altivec_unavailable_relon_pSeries_1:
+	. = 0x4f20
+	b	altivec_unavailable_relon_pSeries
+
+vsx_unavailable_relon_pSeries_1:
+	. = 0x4f40
+	b	vsx_unavailable_relon_pSeries
+
+#ifdef CONFIG_CBE_RAS
+	STD_RELON_EXCEPTION_HV(0x5200, 0x1202, cbe_system_error)
+#endif /* CONFIG_CBE_RAS */
+	STD_RELON_EXCEPTION_PSERIES(0x5300, 0x1300, instruction_breakpoint)
+#ifdef CONFIG_PPC_DENORMALISATION
+	. = 0x5500
+	b	denorm_exception_hv
+#endif
+#ifdef CONFIG_CBE_RAS
+	STD_RELON_EXCEPTION_HV(0x5600, 0x1602, cbe_maintenance)
+#else
+#ifdef CONFIG_HVC_SCOM
+	STD_RELON_EXCEPTION_HV(0x5600, 0x1600, maintence_interrupt)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1600)
+#endif /* CONFIG_HVC_SCOM */
+#endif /* CONFIG_CBE_RAS */
+	STD_RELON_EXCEPTION_PSERIES(0x5700, 0x1700, altivec_assist)
+#ifdef CONFIG_CBE_RAS
+	STD_RELON_EXCEPTION_HV(0x5800, 0x1802, cbe_thermal)
+#endif /* CONFIG_CBE_RAS */
+
+	/* Other future vectors */
+	.align	7
+	.globl	__end_interrupts
+__end_interrupts:
+
 	.align	7
+system_call_entry_direct:
+#if defined(CONFIG_RELOCATABLE)
+	/* The first level prologue may have used LR to get here, saving
+	 * orig in r10.  To save hacking/ifdeffing common code, restore here.
+	 */
+	mtlr	r10
+#endif
 system_call_entry:
 	b	system_call_common
 
@@ -1196,6 +1345,21 @@ _GLOBAL(do_stab_bolted)
 	rfid
 	b	.	/* prevent speculative execution */
 
+
+	/* Equivalents to the above handlers for relocation-on interrupt vectors */
+	STD_RELON_EXCEPTION_HV(., 0xe00, h_data_storage)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe00)
+	STD_RELON_EXCEPTION_HV(., 0xe20, h_instr_storage)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe20)
+	STD_RELON_EXCEPTION_HV(., 0xe40, emulation_assist)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe40)
+	STD_RELON_EXCEPTION_HV(., 0xe60, hmi_exception)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe60)
+
+	STD_RELON_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
+	STD_RELON_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
+	STD_RELON_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
+
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
  * Data area reserved for FWNMI option.
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 58bddee..d5a4efe 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -432,7 +432,8 @@ _STATIC(__after_prom_start)
 	cmplwi	cr0,r7,1
 	bne	3f
 
-	li	r5,__end_interrupts - _stext	/* just copy interrupts */
+	/* just copy interrupts */
+	LOAD_REG_IMMEDIATE(r5, __end_interrupts - _stext)
 	b	5f
 3:
 #endif
-- 
1.7.9.5
