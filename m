Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0689AB6FFC
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:22 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id p356ARFQ023698
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:10:27 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356EKe32494588
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:21 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EK6M011081
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/15] powerpc: Always use SPRN_SPRG_HSCRATCH0 when running in
	HV mode
Date: Tue,  5 Apr 2011 16:14:04 +1000
Message-Id: <1301984051-18413-9-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

This uses feature sections to arrange that we always use HSPRG1
as the scratch register in the interrupt entry code rather than
SPRG2 when we're running in hypervisor mode on POWER7.  This will
ensure that we don't trash the guest's SPRG2 when we are running
KVM guests.  To simplify the code, we define GET_SCRATCH0() and
SET_SCRATCH0() macros like the GET_PACA/SET_PACA macros.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h   |   15 +++++++--------
 arch/powerpc/include/asm/reg.h             |   14 ++++++++++++++
 arch/powerpc/kernel/exceptions-64s.S       |   26 +++++++++++++-------------
 arch/powerpc/kvm/book3s_rmhandlers.S       |    6 +++---
 arch/powerpc/kvm/book3s_segment.S          |    2 +-
 arch/powerpc/platforms/iseries/exception.S |    2 +-
 arch/powerpc/platforms/iseries/exception.h |    4 ++--
 7 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index fb5b0af..d6b4849 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -60,16 +60,15 @@
 #define EXC_HV	H
 #define EXC_STD
 
-#define __EXCEPTION_PROLOG_1(area, h)					\
+#define EXCEPTION_PROLOG_1(area)					\
 	GET_PACA(r13);							\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
 	std	r10,area+EX_R10(r13);					\
 	std	r11,area+EX_R11(r13);					\
 	std	r12,area+EX_R12(r13);					\
-	mfspr	r9,SPRN_SPRG_##h##SCRATCH0;				\
+	GET_SCRATCH0(r9);						\
 	std	r9,area+EX_R13(r13);					\
 	mfcr	r9
-#define EXCEPTION_PROLOG_1(area, h) __EXCEPTION_PROLOG_1(area, h)
 
 #define __EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
@@ -85,7 +84,7 @@
 	__EXCEPTION_PROLOG_PSERIES_1(label, h)
 
 #define EXCEPTION_PROLOG_PSERIES(area, label, h)			\
-	EXCEPTION_PROLOG_1(area, h);					\
+	EXCEPTION_PROLOG_1(area);					\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
 /*
@@ -156,7 +155,7 @@
 label##_pSeries:					\
 	HMT_MEDIUM;					\
 	DO_KVM	vec;					\
-	mtspr	SPRN_SPRG_SCRATCH0,r13;		/* save r13 */	\
+	SET_SCRATCH0(r13);		/* save r13 */		\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common, EXC_STD)
 
 #define STD_EXCEPTION_HV(loc, vec, label)		\
@@ -165,13 +164,13 @@ label##_pSeries:					\
 label##_hv:						\
 	HMT_MEDIUM;					\
 	DO_KVM	vec;					\
-	mtspr	SPRN_SPRG_HSCRATCH0,r13;/* save r13 */	\
+	SET_SCRATCH0(r13);	/* save r13 */		\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common, EXC_HV)
 
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h)			\
 	HMT_MEDIUM;							\
 	DO_KVM	vec;							\
-	mtspr	SPRN_SPRG_##h##SCRATCH0,r13;    /* save r13 */		\
+	SET_SCRATCH0(r13);    /* save r13 */				\
 	GET_PACA(r13);							\
 	std	r9,PACA_EXGEN+EX_R9(r13);	/* save r9, r10 */	\
 	std	r10,PACA_EXGEN+EX_R10(r13);				\
@@ -179,7 +178,7 @@ label##_hv:						\
 	mfcr	r9;							\
 	cmpwi	r10,0;							\
 	beq	masked_##h##interrupt;					\
-	mfspr	r10,SPRN_SPRG_##h##SCRATCH0;				\
+	GET_SCRATCH0(r10);						\
 	std	r10,PACA_EXGEN+EX_R13(r13);				\
 	std	r11,PACA_EXGEN+EX_R11(r13);				\
 	std	r12,PACA_EXGEN+EX_R12(r13);				\
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 13429a0..76d7d5f 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -802,6 +802,20 @@
 	FTR_SECTION_ELSE_NESTED(66);			\
 	mtspr	SPRN_SPRG_HPACA,rX;			\
 	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
+
+#define GET_SCRATCH0(rX)				\
+	BEGIN_FTR_SECTION_NESTED(66);			\
+	mfspr	rX,SPRN_SPRG_SCRATCH0;			\
+	FTR_SECTION_ELSE_NESTED(66);			\
+	mfspr	rX,SPRN_SPRG_HSCRATCH0;			\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
+
+#define SET_SCRATCH0(rX)				\
+	BEGIN_FTR_SECTION_NESTED(66);			\
+	mtspr	SPRN_SPRG_SCRATCH0,rX;			\
+	FTR_SECTION_ELSE_NESTED(66);			\
+	mtspr	SPRN_SPRG_HSCRATCH0,rX;			\
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
 #endif
 
 #ifdef CONFIG_PPC_BOOK3E_64
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 54429ee..0c50a52 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -43,7 +43,7 @@ __start_interrupts:
 _machine_check_pSeries:
 	HMT_MEDIUM
 	DO_KVM	0x200
-	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
+	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common, EXC_STD)
 
 	. = 0x300
@@ -51,7 +51,7 @@ _machine_check_pSeries:
 data_access_pSeries:
 	HMT_MEDIUM
 	DO_KVM	0x300
-	mtspr	SPRN_SPRG_SCRATCH0,r13
+	SET_SCRATCH0(r13)
 BEGIN_FTR_SECTION
 	GET_PACA(r13)
 	std	r9,PACA_EXSLB+EX_R9(r13)
@@ -67,7 +67,7 @@ BEGIN_FTR_SECTION
 	std	r11,PACA_EXGEN+EX_R11(r13)
 	ld	r11,PACA_EXSLB+EX_R9(r13)
 	std	r12,PACA_EXGEN+EX_R12(r13)
-	mfspr	r12,SPRN_SPRG_SCRATCH0
+	GET_SCRATCH0(r12)
 	std	r10,PACA_EXGEN+EX_R10(r13)
 	std	r11,PACA_EXGEN+EX_R9(r13)
 	std	r12,PACA_EXGEN+EX_R13(r13)
@@ -81,7 +81,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_SLB)
 data_access_slb_pSeries:
 	HMT_MEDIUM
 	DO_KVM	0x380
-	mtspr	SPRN_SPRG_SCRATCH0,r13
+	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
@@ -95,7 +95,7 @@ data_access_slb_pSeries:
 	std	r10,PACA_EXSLB+EX_R10(r13)
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
-	mfspr	r10,SPRN_SPRG_SCRATCH0
+	GET_SCRATCH0(r10)
 	std	r10,PACA_EXSLB+EX_R13(r13)
 	mfspr	r12,SPRN_SRR1		/* and SRR1 */
 #ifndef CONFIG_RELOCATABLE
@@ -120,7 +120,7 @@ data_access_slb_pSeries:
 instruction_access_slb_pSeries:
 	HMT_MEDIUM
 	DO_KVM	0x480
-	mtspr	SPRN_SPRG_SCRATCH0,r13
+	SET_SCRATCH0(r13)
 	GET_PACA(r13)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
@@ -134,7 +134,7 @@ instruction_access_slb_pSeries:
 	std	r10,PACA_EXSLB+EX_R10(r13)
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
-	mfspr	r10,SPRN_SPRG_SCRATCH0
+	GET_SCRATCH0(r10)
 	std	r10,PACA_EXSLB+EX_R13(r13)
 	mfspr	r12,SPRN_SRR1		/* and SRR1 */
 #ifndef CONFIG_RELOCATABLE
@@ -272,7 +272,7 @@ masked_interrupt:
 	rotldi	r10,r10,16
 	mtspr	SPRN_SRR1,r10
 	ld	r10,PACA_EXGEN+EX_R10(r13)
-	mfspr	r13,SPRN_SPRG_SCRATCH0
+	GET_SCRATCH0(r13)
 	rfid
 	b	.
 
@@ -285,7 +285,7 @@ masked_Hinterrupt:
 	rotldi	r10,r10,16
 	mtspr	SPRN_HSRR1,r10
 	ld	r10,PACA_EXGEN+EX_R10(r13)
-	mfspr	r13,SPRN_SPRG_HSCRATCH0
+	GET_SCRATCH0(r13)
 	hrfid
 	b	.
 
@@ -293,7 +293,7 @@ masked_Hinterrupt:
 do_stab_bolted_pSeries:
 	std	r11,PACA_EXSLB+EX_R11(r13)
 	std	r12,PACA_EXSLB+EX_R12(r13)
-	mfspr	r10,SPRN_SPRG_SCRATCH0
+	GET_SCRATCH0(r10)
 	std	r10,PACA_EXSLB+EX_R13(r13)
 	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted, EXC_STD)
 
@@ -305,14 +305,14 @@ do_stab_bolted_pSeries:
       .align 7
 system_reset_fwnmi:
 	HMT_MEDIUM
-	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
+	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD)
 
 	.globl machine_check_fwnmi
       .align 7
 machine_check_fwnmi:
 	HMT_MEDIUM
-	mtspr	SPRN_SPRG_SCRATCH0,r13		/* save r13 */
+	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common, EXC_STD)
 
 #endif /* CONFIG_PPC_PSERIES */
@@ -327,7 +327,7 @@ slb_miss_user_pseries:
 	std	r10,PACA_EXGEN+EX_R10(r13)
 	std	r11,PACA_EXGEN+EX_R11(r13)
 	std	r12,PACA_EXGEN+EX_R12(r13)
-	mfspr	r10,SPRG_SCRATCH0
+	GET_SCRATCH0(r10)
 	ld	r11,PACA_EXSLB+EX_R9(r13)
 	ld	r12,PACA_EXSLB+EX_R3(r13)
 	std	r10,PACA_EXGEN+EX_R13(r13)
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 046e1f3..ae99af6 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -70,7 +70,7 @@
 .global kvmppc_trampoline_\intno
 kvmppc_trampoline_\intno:
 
-	mtspr	SPRN_SPRG_SCRATCH0, r13		/* Save r13 */
+	SET_SCRATCH0(r13)		/* Save r13 */
 
 	/*
 	 * First thing to do is to find out if we're coming
@@ -89,7 +89,7 @@ kvmppc_trampoline_\intno:
 	lwz	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH1)(r13)
 	mtcr	r12
 	PPC_LL	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH0)(r13)
-	mfspr	r13, SPRN_SPRG_SCRATCH0		/* r13 = original r13 */
+	GET_SCRATCH0(r13)			/* r13 = original r13 */
 	b	kvmppc_resume_\intno		/* Get back original handler */
 
 	/* Now we know we're handling a KVM guest */
@@ -157,7 +157,7 @@ kvmppc_handler_skip_ins:
 	lwz	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH1)(r13)
 	mtcr	r12
 	PPC_LL	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH0)(r13)
-	mfspr	r13, SPRN_SPRG_SCRATCH0
+	GET_SCRATCH0(r13)
 
 	/* And get back into the code */
 	RFI
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index d842795..4512642 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -168,7 +168,7 @@ kvmppc_handler_trampoline_exit:
 	PPC_STL	r4, (SHADOW_VCPU_OFF + SVCPU_SHADOW_SRR1)(r13)
 
 	/* Get scratch'ed off registers */
-	mfspr	r9, SPRN_SPRG_SCRATCH0
+	GET_SCRATCH0(r9)
 	PPC_LL	r8, (SHADOW_VCPU_OFF + SVCPU_SCRATCH0)(r13)
 	lwz	r7, (SHADOW_VCPU_OFF + SVCPU_SCRATCH1)(r13)
 
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index f7a4872..32a56c6 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -155,7 +155,7 @@ BEGIN_FTR_SECTION
 	std	r12,PACA_EXGEN+EX_R13(r13)
 	EXCEPTION_PROLOG_ISERIES_1
 FTR_SECTION_ELSE
-	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_STD)
+	EXCEPTION_PROLOG_1(PACA_EXGEN)
 	EXCEPTION_PROLOG_ISERIES_1
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_SLB)
 	b	data_access_common
diff --git a/arch/powerpc/platforms/iseries/exception.h b/arch/powerpc/platforms/iseries/exception.h
index 57127d8..bae3fba 100644
--- a/arch/powerpc/platforms/iseries/exception.h
+++ b/arch/powerpc/platforms/iseries/exception.h
@@ -39,7 +39,7 @@
 label##_iSeries:							\
 	HMT_MEDIUM;							\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
-	EXCEPTION_PROLOG_1(area, EXC_STD);				\
+	EXCEPTION_PROLOG_1(area);					\
 	EXCEPTION_PROLOG_ISERIES_1;					\
 	b	label##_common
 
@@ -48,7 +48,7 @@ label##_iSeries:							\
 label##_iSeries:							\
 	HMT_MEDIUM;							\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_STD);			\
+	EXCEPTION_PROLOG_1(PACA_EXGEN);					\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	0,r10,0;						\
 	beq-	label##_iSeries_masked;					\
-- 
1.7.1
