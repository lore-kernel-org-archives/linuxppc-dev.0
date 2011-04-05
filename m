Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E442FB6FFB
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:21 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id p356ELoU008253
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356ELOd2105372
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EKZx027130
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/15] powerpc: Base support for exceptions using HSRR0/1
Date: Tue,  5 Apr 2011 16:14:02 +1000
Message-Id: <1301984051-18413-7-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pass the register type to the prolog, also provides alternate "HV"
version of hardware interrupt (0x500) and adjust LPES accordingly

We tag those interrupts by setting bit 0x2 in the trap number

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h   |   65 ++++++++++++++--------------
 arch/powerpc/include/asm/kvm_asm.h         |    1 +
 arch/powerpc/include/asm/kvm_book3s_asm.h  |    1 +
 arch/powerpc/kernel/cpu_setup_power7.S     |    3 +-
 arch/powerpc/kernel/exceptions-64s.S       |   48 ++++++++++++++++-----
 arch/powerpc/kvm/book3s_rmhandlers.S       |    1 +
 arch/powerpc/kvm/book3s_segment.S          |   10 +++-
 arch/powerpc/platforms/iseries/exception.S |    2 +-
 arch/powerpc/platforms/iseries/exception.h |    4 +-
 9 files changed, 86 insertions(+), 49 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 337b6fa..1d98e05 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -56,30 +56,37 @@
 #define LOAD_HANDLER(reg, label)					\
 	addi	reg,reg,(label)-_stext;	/* virt addr of handler ... */
 
-#define EXCEPTION_PROLOG_1(area)					\
+/* Exception register prefixes */
+#define EXC_HV	H
+#define EXC_STD
+
+#define __EXCEPTION_PROLOG_1(area, h)					\
 	GET_PACA(r13);							\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
 	std	r10,area+EX_R10(r13);					\
 	std	r11,area+EX_R11(r13);					\
 	std	r12,area+EX_R12(r13);					\
-	mfspr	r9,SPRN_SPRG_SCRATCH0;					\
+	mfspr	r9,SPRN_SPRG_##h##SCRATCH0;				\
 	std	r9,area+EX_R13(r13);					\
 	mfcr	r9
+#define EXCEPTION_PROLOG_1(area, h) __EXCEPTION_PROLOG_1(area, h)
 
-#define EXCEPTION_PROLOG_PSERIES_1(label)				\
+#define __EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
-	mfspr	r11,SPRN_SRR0;		/* save SRR0 */			\
+	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	LOAD_HANDLER(r12,label)						\
-	mtspr	SPRN_SRR0,r12;						\
-	mfspr	r12,SPRN_SRR1;		/* and SRR1 */			\
-	mtspr	SPRN_SRR1,r10;						\
-	rfid;								\
+	mtspr	SPRN_##h##SRR0,r12;					\
+	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
+	mtspr	SPRN_##h##SRR1,r10;					\
+	h##rfid;							\
 	b	.	/* prevent speculative execution */
+#define EXCEPTION_PROLOG_PSERIES_1(label, h) \
+	__EXCEPTION_PROLOG_PSERIES_1(label, h)
 
-#define EXCEPTION_PROLOG_PSERIES(area, label)				\
-	EXCEPTION_PROLOG_1(area);					\
-	EXCEPTION_PROLOG_PSERIES_1(label);
+#define EXCEPTION_PROLOG_PSERIES(area, label, h)			\
+	EXCEPTION_PROLOG_1(area, h);					\
+	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
 /*
  * The common exception prolog is used for all except a few exceptions
@@ -150,50 +157,44 @@ label##_pSeries:					\
 	HMT_MEDIUM;					\
 	DO_KVM	n;					\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;		/* save r13 */	\
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common, EXC_STD)
 
 #define HSTD_EXCEPTION_PSERIES(n, label)		\
 	. = n;						\
 	.globl label##_pSeries;				\
 label##_pSeries:					\
 	HMT_MEDIUM;					\
-	mtspr	SPRN_SPRG_SCRATCH0,r20;	/* save r20 */	\
-	mfspr	r20,SPRN_HSRR0;		/* copy HSRR0 to SRR0 */ \
-	mtspr	SPRN_SRR0,r20;				\
-	mfspr	r20,SPRN_HSRR1;		/* copy HSRR0 to SRR0 */ \
-	mtspr	SPRN_SRR1,r20;				\
-	mfspr	r20,SPRN_SPRG_SCRATCH0;	/* restore r20 */ \
-	mtspr	SPRN_SPRG_SCRATCH0,r13;		/* save r13 */	\
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common)
+	DO_KVM	n;					\
+	mtspr	SPRN_SPRG_HSCRATCH0,r13;/* save r13 */	\
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common, EXC_HV)
 
 
-#define MASKABLE_EXCEPTION_PSERIES(n, label)				\
-	. = n;								\
-	.globl label##_pSeries;						\
-label##_pSeries:							\
+#define __MASKABLE_EXCEPTION_PSERIES(n, label, h)			\
 	HMT_MEDIUM;							\
 	DO_KVM	n;							\
-	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
+	mtspr	SPRN_SPRG_##h##SCRATCH0,r13;    /* save r13 */		\
 	GET_PACA(r13);							\
 	std	r9,PACA_EXGEN+EX_R9(r13);	/* save r9, r10 */	\
 	std	r10,PACA_EXGEN+EX_R10(r13);				\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	mfcr	r9;							\
 	cmpwi	r10,0;							\
-	beq	masked_interrupt;					\
-	mfspr	r10,SPRN_SPRG_SCRATCH0;					\
+	beq	masked_##h##interrupt;					\
+	mfspr	r10,SPRN_SPRG_##h##SCRATCH0;				\
 	std	r10,PACA_EXGEN+EX_R13(r13);				\
 	std	r11,PACA_EXGEN+EX_R11(r13);				\
 	std	r12,PACA_EXGEN+EX_R12(r13);				\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
-	mfspr	r11,SPRN_SRR0;		/* save SRR0 */			\
+	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	LOAD_HANDLER(r12,label##_common)				\
-	mtspr	SPRN_SRR0,r12;						\
-	mfspr	r12,SPRN_SRR1;		/* and SRR1 */			\
-	mtspr	SPRN_SRR1,r10;						\
-	rfid;								\
+	mtspr	SPRN_##h##SRR0,r12;					\
+	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
+	mtspr	SPRN_##h##SRR1,r10;					\
+	h##rfid;							\
 	b	.	/* prevent speculative execution */
+#define MASKABLE_EXCEPTION_PSERIES(n, label, h)				\
+	__MASKABLE_EXCEPTION_PSERIES(n, label, h)
 
 #ifdef CONFIG_PPC_ISERIES
 #define DISABLE_INTS				\
diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 5b75046..0951b17 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -59,6 +59,7 @@
 #define BOOK3S_INTERRUPT_INST_SEGMENT	0x480
 #define BOOK3S_INTERRUPT_EXTERNAL	0x500
 #define BOOK3S_INTERRUPT_EXTERNAL_LEVEL	0x501
+#define BOOK3S_INTERRUPT_EXTERNAL_HV	0x502
 #define BOOK3S_INTERRUPT_ALIGNMENT	0x600
 #define BOOK3S_INTERRUPT_PROGRAM	0x700
 #define BOOK3S_INTERRUPT_FP_UNAVAIL	0x800
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 36fdb3a..d5a8a38 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -34,6 +34,7 @@
 	    (\intno == BOOK3S_INTERRUPT_DATA_SEGMENT) || \
 	    (\intno == BOOK3S_INTERRUPT_INST_SEGMENT) || \
 	    (\intno == BOOK3S_INTERRUPT_EXTERNAL) || \
+	    (\intno == BOOK3S_INTERRUPT_EXTERNAL_HV) || \
 	    (\intno == BOOK3S_INTERRUPT_ALIGNMENT) || \
 	    (\intno == BOOK3S_INTERRUPT_PROGRAM) || \
 	    (\intno == BOOK3S_INTERRUPT_FP_UNAVAIL) || \
diff --git a/arch/powerpc/kernel/cpu_setup_power7.S b/arch/powerpc/kernel/cpu_setup_power7.S
index f2b3178..e801ef1 100644
--- a/arch/powerpc/kernel/cpu_setup_power7.S
+++ b/arch/powerpc/kernel/cpu_setup_power7.S
@@ -52,13 +52,14 @@ __init_hvmode_206:
 __init_LPCR:
 	/* Setup a sane LPCR:
 	 *
-	 *   LPES = 0b11 (SRR0/1 used for 0x500)
+	 *   LPES = 0b01 (HSRR0/1 used for 0x500)
 	 *   PECE = 0b111
 	 *
 	 * Other bits untouched for now
 	 */
 	mfspr	r3,SPRN_LPCR
 	ori	r3,r3,(LPCR_LPES0|LPCR_LPES1)
+	xori	r3,r3, LPCR_LPES0
 	ori	r3,r3,(LPCR_PECE0|LPCR_PECE1|LPCR_PECE2)
 	mtspr	SPRN_LPCR,r3
 	isync
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4ea3cc6..fdd677b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -44,7 +44,7 @@ _machine_check_pSeries:
 	HMT_MEDIUM
 	DO_KVM	0x200
 	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common, EXC_STD)
 
 	. = 0x300
 	.globl data_access_pSeries
@@ -71,9 +71,9 @@ BEGIN_FTR_SECTION
 	std	r10,PACA_EXGEN+EX_R10(r13)
 	std	r11,PACA_EXGEN+EX_R9(r13)
 	std	r12,PACA_EXGEN+EX_R13(r13)
-	EXCEPTION_PROLOG_PSERIES_1(data_access_common)
+	EXCEPTION_PROLOG_PSERIES_1(data_access_common, EXC_STD)
 FTR_SECTION_ELSE
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common, EXC_STD)
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_SLB)
 
 	. = 0x380
@@ -147,11 +147,24 @@ instruction_access_slb_pSeries:
 	bctr
 #endif
 
-	MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt)
+	. = 0x500;
+	.globl hardware_interrupt_pSeries
+hardware_interrupt_pSeries:
+	BEGIN_FTR_SECTION
+	MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt, EXC_STD)
+	FTR_SECTION_ELSE
+	MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt, EXC_HV)
+	ALT_FTR_SECTION_END_IFCLR(CPU_FTR_HVMODE_206)
+
 	STD_EXCEPTION_PSERIES(0x600, alignment)
 	STD_EXCEPTION_PSERIES(0x700, program_check)
 	STD_EXCEPTION_PSERIES(0x800, fp_unavailable)
-	MASKABLE_EXCEPTION_PSERIES(0x900, decrementer)
+
+	. = 0x900;
+	.globl decrementer_pSeries
+decrementer_pSeries:
+	MASKABLE_EXCEPTION_PSERIES(0x900, decrementer, EXC_STD)
+
 	STD_EXCEPTION_PSERIES(0xa00, trap_0a)
 	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
 
@@ -207,15 +220,15 @@ vsx_unavailable_pSeries_1:
 	b	vsx_unavailable_pSeries
 
 #ifdef CONFIG_CBE_RAS
-	HSTD_EXCEPTION_PSERIES(0x1200, cbe_system_error)
+	HSTD_EXCEPTION_PSERIES(0x1202, cbe_system_error)
 #endif /* CONFIG_CBE_RAS */
 	STD_EXCEPTION_PSERIES(0x1300, instruction_breakpoint)
 #ifdef CONFIG_CBE_RAS
-	HSTD_EXCEPTION_PSERIES(0x1600, cbe_maintenance)
+	HSTD_EXCEPTION_PSERIES(0x1602, cbe_maintenance)
 #endif /* CONFIG_CBE_RAS */
 	STD_EXCEPTION_PSERIES(0x1700, altivec_assist)
 #ifdef CONFIG_CBE_RAS
-	HSTD_EXCEPTION_PSERIES(0x1800, cbe_thermal)
+	HSTD_EXCEPTION_PSERIES(0x1802, cbe_thermal)
 #endif /* CONFIG_CBE_RAS */
 
 	. = 0x3000
@@ -244,13 +257,26 @@ masked_interrupt:
 	rfid
 	b	.
 
+masked_Hinterrupt:
+	stb	r10,PACAHARDIRQEN(r13)
+	mtcrf	0x80,r9
+	ld	r9,PACA_EXGEN+EX_R9(r13)
+	mfspr	r10,SPRN_HSRR1
+	rldicl	r10,r10,48,1		/* clear MSR_EE */
+	rotldi	r10,r10,16
+	mtspr	SPRN_HSRR1,r10
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	mfspr	r13,SPRN_SPRG_HSCRATCH0
+	hrfid
+	b	.
+
 	.align	7
 do_stab_bolted_pSeries:
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
 	mfspr	r10,SPRN_SPRG_SCRATCH0
 	std	r10,PACA_EXSLB+EX_R13(r13)
-	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted)
+	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted, EXC_STD)
 
 #ifdef CONFIG_PPC_PSERIES
 /*
@@ -261,14 +287,14 @@ do_stab_bolted_pSeries:
 system_reset_fwnmi:
 	HMT_MEDIUM
 	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD)
 
 	.globl machine_check_fwnmi
       .align 7
 machine_check_fwnmi:
 	HMT_MEDIUM
 	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common, EXC_STD)
 
 #endif /* CONFIG_PPC_PSERIES */
 
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index b0ff5ff..046e1f3 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -112,6 +112,7 @@ INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_MACHINE_CHECK
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_DATA_STORAGE
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_INST_STORAGE
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_EXTERNAL
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_EXTERNAL_HV
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_ALIGNMENT
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_PROGRAM
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_FP_UNAVAIL
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 7c52ed0..d842795 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -155,9 +155,15 @@ kvmppc_handler_trampoline_exit:
 	PPC_LL	r2, (SHADOW_VCPU_OFF + SVCPU_HOST_R2)(r13)
 
 	/* Save guest PC and MSR */
-	mfsrr0	r3
+	andi.	r0,r12,0x2
+	beq	1f
+	mfspr	r3,SPRN_HSRR0
+	mfspr	r4,SPRN_HSRR1
+	andi.	r12,r12,0x3ffd
+	b	2f
+1:	mfsrr0	r3
 	mfsrr1	r4
-
+2:
 	PPC_STL	r3, (SHADOW_VCPU_OFF + SVCPU_PC)(r13)
 	PPC_STL	r4, (SHADOW_VCPU_OFF + SVCPU_SHADOW_SRR1)(r13)
 
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index 32a56c6..f7a4872 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -155,7 +155,7 @@ BEGIN_FTR_SECTION
 	std	r12,PACA_EXGEN+EX_R13(r13)
 	EXCEPTION_PROLOG_ISERIES_1
 FTR_SECTION_ELSE
-	EXCEPTION_PROLOG_1(PACA_EXGEN)
+	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_STD)
 	EXCEPTION_PROLOG_ISERIES_1
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_SLB)
 	b	data_access_common
diff --git a/arch/powerpc/platforms/iseries/exception.h b/arch/powerpc/platforms/iseries/exception.h
index bae3fba..57127d8 100644
--- a/arch/powerpc/platforms/iseries/exception.h
+++ b/arch/powerpc/platforms/iseries/exception.h
@@ -39,7 +39,7 @@
 label##_iSeries:							\
 	HMT_MEDIUM;							\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
-	EXCEPTION_PROLOG_1(area);					\
+	EXCEPTION_PROLOG_1(area, EXC_STD);				\
 	EXCEPTION_PROLOG_ISERIES_1;					\
 	b	label##_common
 
@@ -48,7 +48,7 @@ label##_iSeries:							\
 label##_iSeries:							\
 	HMT_MEDIUM;							\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN);					\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_STD);			\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	0,r10,0;						\
 	beq-	label##_iSeries_masked;					\
-- 
1.7.1
