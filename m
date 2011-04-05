Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 337CDB6FD0
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:14:21 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3569DS8021510
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:09:13 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p356EKLL2330748
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p356EKCk011076
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Apr 2011 16:14:20 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/15] powerpc: More work to support HV exceptions
Date: Tue,  5 Apr 2011 16:14:03 +1000
Message-Id: <1301984051-18413-8-git-send-email-benh@kernel.crashing.org>
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

Rework exception macros a bit to split offset from vector and add
some basic support for HDEC, HDSI, HISI and a few more.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h  |   37 ++++++++----
 arch/powerpc/include/asm/feature-fixups.h |    2 +-
 arch/powerpc/kernel/exceptions-64s.S      |   92 ++++++++++++++++++++---------
 3 files changed, 89 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 1d98e05..fb5b0af 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -150,28 +150,27 @@
 /*
  * Exception vectors.
  */
-#define STD_EXCEPTION_PSERIES(n, label)			\
-	. = n;						\
+#define STD_EXCEPTION_PSERIES(loc, vec, label)		\
+	. = loc;					\
 	.globl label##_pSeries;				\
 label##_pSeries:					\
 	HMT_MEDIUM;					\
-	DO_KVM	n;					\
+	DO_KVM	vec;					\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;		/* save r13 */	\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common, EXC_STD)
 
-#define HSTD_EXCEPTION_PSERIES(n, label)		\
-	. = n;						\
-	.globl label##_pSeries;				\
-label##_pSeries:					\
+#define STD_EXCEPTION_HV(loc, vec, label)		\
+	. = loc;					\
+	.globl label##_hv;				\
+label##_hv:						\
 	HMT_MEDIUM;					\
-	DO_KVM	n;					\
+	DO_KVM	vec;					\
 	mtspr	SPRN_SPRG_HSCRATCH0,r13;/* save r13 */	\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common, EXC_HV)
 
-
-#define __MASKABLE_EXCEPTION_PSERIES(n, label, h)			\
+#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h)			\
 	HMT_MEDIUM;							\
-	DO_KVM	n;							\
+	DO_KVM	vec;							\
 	mtspr	SPRN_SPRG_##h##SCRATCH0,r13;    /* save r13 */		\
 	GET_PACA(r13);							\
 	std	r9,PACA_EXGEN+EX_R9(r13);	/* save r9, r10 */	\
@@ -193,8 +192,20 @@ label##_pSeries:					\
 	mtspr	SPRN_##h##SRR1,r10;					\
 	h##rfid;							\
 	b	.	/* prevent speculative execution */
-#define MASKABLE_EXCEPTION_PSERIES(n, label, h)				\
-	__MASKABLE_EXCEPTION_PSERIES(n, label, h)
+#define _MASKABLE_EXCEPTION_PSERIES(vec, label, h)			\
+	__MASKABLE_EXCEPTION_PSERIES(vec, label, h)
+
+#define MASKABLE_EXCEPTION_PSERIES(loc, vec, label)			\
+	. = loc;							\
+	.globl label##_pSeries;						\
+label##_pSeries:							\
+	_MASKABLE_EXCEPTION_PSERIES(vec, label, EXC_STD)
+
+#define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
+	. = loc;							\
+	.globl label##_hv;						\
+label##_hv:								\
+	_MASKABLE_EXCEPTION_PSERIES(vec, label, EXC_HV)
 
 #ifdef CONFIG_PPC_ISERIES
 #define DISABLE_INTS				\
diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 921a847..bdc0d68 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -49,7 +49,7 @@ label##5:							\
 	FTR_ENTRY_OFFSET label##2b-label##5b;			\
 	FTR_ENTRY_OFFSET label##3b-label##5b;			\
 	FTR_ENTRY_OFFSET label##4b-label##5b;			\
-	.ifgt (label##4b-label##3b)-(label##2b-label##1b);	\
+	.ifgt (label##4b- label##3b)-(label##2b- label##1b);	\
 	.error "Feature section else case larger than body";	\
 	.endif;							\
 	.popsection;
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index fdd677b..54429ee 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -37,7 +37,7 @@
 	.globl __start_interrupts
 __start_interrupts:
 
-	STD_EXCEPTION_PSERIES(0x100, system_reset)
+	STD_EXCEPTION_PSERIES(0x100, 0x100, system_reset)
 
 	. = 0x200
 _machine_check_pSeries:
@@ -113,7 +113,7 @@ data_access_slb_pSeries:
 	bctr
 #endif
 
-	STD_EXCEPTION_PSERIES(0x400, instruction_access)
+	STD_EXCEPTION_PSERIES(0x400, 0x400, instruction_access)
 
 	. = 0x480
 	.globl instruction_access_slb_pSeries
@@ -147,26 +147,29 @@ instruction_access_slb_pSeries:
 	bctr
 #endif
 
+	/* We open code these as we can't have a ". = x" (even with
+	 * x = "." within a feature section
+	 */
 	. = 0x500;
-	.globl hardware_interrupt_pSeries
+	.globl hardware_interrupt_pSeries;
+	.globl hardware_interrupt_hv;
 hardware_interrupt_pSeries:
+hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
-	MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt, EXC_STD)
+		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt, EXC_STD)
 	FTR_SECTION_ELSE
-	MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt, EXC_HV)
+		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt, EXC_HV)
 	ALT_FTR_SECTION_END_IFCLR(CPU_FTR_HVMODE_206)
 
-	STD_EXCEPTION_PSERIES(0x600, alignment)
-	STD_EXCEPTION_PSERIES(0x700, program_check)
-	STD_EXCEPTION_PSERIES(0x800, fp_unavailable)
+	STD_EXCEPTION_PSERIES(0x600, 0x600, alignment)
+	STD_EXCEPTION_PSERIES(0x700, 0x700, program_check)
+	STD_EXCEPTION_PSERIES(0x800, 0x800, fp_unavailable)
 
-	. = 0x900;
-	.globl decrementer_pSeries
-decrementer_pSeries:
-	MASKABLE_EXCEPTION_PSERIES(0x900, decrementer, EXC_STD)
+	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
+	MASKABLE_EXCEPTION_HV(0x980, 0x980, decrementer)
 
-	STD_EXCEPTION_PSERIES(0xa00, trap_0a)
-	STD_EXCEPTION_PSERIES(0xb00, trap_0b)
+	STD_EXCEPTION_PSERIES(0xa00, 0xa00, trap_0a)
+	STD_EXCEPTION_PSERIES(0xb00, 0xb00, trap_0b)
 
 	. = 0xc00
 	.globl	system_call_pSeries
@@ -196,8 +199,21 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	rfid		/* return to userspace */
 	b	.
 
-	STD_EXCEPTION_PSERIES(0xd00, single_step)
-	STD_EXCEPTION_PSERIES(0xe00, trap_0e)
+	STD_EXCEPTION_PSERIES(0xd00, 0xd00, single_step)
+
+	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
+	 * out of line to handle them
+	 */
+	. = 0xe00
+	b	h_data_storage_hv
+	. = 0xe20
+	b	h_instr_storage_hv
+	. = 0xe40
+	b	emulation_assist_hv
+	. = 0xe50
+	b	hmi_exception_hv
+	. = 0xe60
+	b	hmi_exception_hv
 
 	/* We need to deal with the Altivec unavailable exception
 	 * here which is at 0xf20, thus in the middle of the
@@ -206,39 +222,42 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	 */
 performance_monitor_pSeries_1:
 	. = 0xf00
-	DO_KVM	0xf00
 	b	performance_monitor_pSeries
 
 altivec_unavailable_pSeries_1:
 	. = 0xf20
-	DO_KVM	0xf20
 	b	altivec_unavailable_pSeries
 
 vsx_unavailable_pSeries_1:
 	. = 0xf40
-	DO_KVM	0xf40
 	b	vsx_unavailable_pSeries
 
 #ifdef CONFIG_CBE_RAS
-	HSTD_EXCEPTION_PSERIES(0x1202, cbe_system_error)
+	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
 #endif /* CONFIG_CBE_RAS */
-	STD_EXCEPTION_PSERIES(0x1300, instruction_breakpoint)
+	STD_EXCEPTION_PSERIES(0x1300, 0x1300, instruction_breakpoint)
 #ifdef CONFIG_CBE_RAS
-	HSTD_EXCEPTION_PSERIES(0x1602, cbe_maintenance)
+	STD_EXCEPTION_HV(0x1600, 0x1602, cbe_maintenance)
 #endif /* CONFIG_CBE_RAS */
-	STD_EXCEPTION_PSERIES(0x1700, altivec_assist)
+	STD_EXCEPTION_PSERIES(0x1700, 0x1700, altivec_assist)
 #ifdef CONFIG_CBE_RAS
-	HSTD_EXCEPTION_PSERIES(0x1802, cbe_thermal)
+	STD_EXCEPTION_HV(0x1800, 0x1802, cbe_thermal)
 #endif /* CONFIG_CBE_RAS */
 
 	. = 0x3000
 
-/*** pSeries interrupt support ***/
+/*** Out of line interrupts support ***/
+
+	/* moved from 0xe00 */
+	STD_EXCEPTION_HV(., 0xe00, h_data_storage)
+	STD_EXCEPTION_HV(., 0xe20, h_instr_storage)
+	STD_EXCEPTION_HV(., 0xe40, emulation_assist)
+	STD_EXCEPTION_HV(., 0xe60, hmi_exception) /* need to flush cache ? */
 
 	/* moved from 0xf00 */
-	STD_EXCEPTION_PSERIES(., performance_monitor)
-	STD_EXCEPTION_PSERIES(., altivec_unavailable)
-	STD_EXCEPTION_PSERIES(., vsx_unavailable)
+	STD_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
+	STD_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
+	STD_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
 
 /*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
@@ -368,6 +387,8 @@ machine_check_common:
 	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
 	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
+        STD_EXCEPTION_COMMON(0xe40, emulation_assist, .program_check_exception)
+        STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
 	STD_EXCEPTION_COMMON_IDLE(0xf00, performance_monitor, .performance_monitor_exception)
 	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
 #ifdef CONFIG_ALTIVEC
@@ -445,6 +466,19 @@ data_access_common:
 	li	r5,0x300
 	b	.do_hash_page	 	/* Try to handle as hpte fault */
 
+	.align  7
+        .globl  h_data_storage_common
+h_data_storage_common:
+        mfspr   r10,SPRN_HDAR
+        std     r10,PACA_EXGEN+EX_DAR(r13)
+        mfspr   r10,SPRN_HDSISR
+        stw     r10,PACA_EXGEN+EX_DSISR(r13)
+        EXCEPTION_PROLOG_COMMON(0xe00, PACA_EXGEN)
+        bl      .save_nvgprs
+        addi    r3,r1,STACK_FRAME_OVERHEAD
+        bl      .unknown_exception
+        b       .ret_from_except
+
 	.align	7
 	.globl instruction_access_common
 instruction_access_common:
@@ -454,6 +488,8 @@ instruction_access_common:
 	li	r5,0x400
 	b	.do_hash_page		/* Try to handle as hpte fault */
 
+        STD_EXCEPTION_COMMON(0xe20, h_instr_storage, .unknown_exception)
+
 /*
  * Here is the common SLB miss user that is used when going to virtual
  * mode for SLB misses, that is currently not used
-- 
1.7.1
