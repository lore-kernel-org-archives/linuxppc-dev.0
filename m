Return-Path: <paulus@ozlabs.org>
Date: Sat, 18 Jun 2011 18:32:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 03/15] powerpc, KVM: Rework KVM checks in first-level
	interrupt handlers
Message-ID: <20110618083223.GD28413@bloggs.ozlabs.ibm.com>
References: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of branching out-of-line with the DO_KVM macro to check if we
are in a KVM guest at the time of an interrupt, this moves the KVM
check inline in the first-level interrupt handlers.  This speeds up
the non-KVM case and makes sure that none of the interrupt handlers
are missing the check.

Because the first-level interrupt handlers are now larger, some things
had to be move out of line in exceptions-64s.S.

This all necessitated some minor changes to the interrupt entry code
in KVM.  This also streamlines the book3s_32 KVM test.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/exception-64s.h   |  121 ++++++++++++------
 arch/powerpc/kernel/exceptions-64s.S       |  189 +++++++++++++++++-----------
 arch/powerpc/kvm/book3s_rmhandlers.S       |   78 ++++++------
 arch/powerpc/kvm/book3s_segment.S          |    7 +
 arch/powerpc/platforms/iseries/exception.S |    2 +-
 arch/powerpc/platforms/iseries/exception.h |    4 +-
 6 files changed, 247 insertions(+), 154 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index f5dfe34..b6a3a44 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -61,19 +61,22 @@
 #define EXC_HV	H
 #define EXC_STD
 
-#define EXCEPTION_PROLOG_1(area)					\
+#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
 	GET_PACA(r13);							\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
 	std	r10,area+EX_R10(r13);					\
-	std	r11,area+EX_R11(r13);					\
-	std	r12,area+EX_R12(r13);					\
 	BEGIN_FTR_SECTION_NESTED(66);					\
 	mfspr	r10,SPRN_CFAR;						\
 	std	r10,area+EX_CFAR(r13);					\
 	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		\
-	GET_SCRATCH0(r9);						\
-	std	r9,area+EX_R13(r13);					\
-	mfcr	r9
+	mfcr	r9;							\
+	extra(vec);							\
+	std	r11,area+EX_R11(r13);					\
+	std	r12,area+EX_R12(r13);					\
+	GET_SCRATCH0(r10);						\
+	std	r10,area+EX_R13(r13)
+#define EXCEPTION_PROLOG_1(area, extra, vec)				\
+	__EXCEPTION_PROLOG_1(area, extra, vec)
 
 #define __EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
@@ -85,13 +88,54 @@
 	mtspr	SPRN_##h##SRR1,r10;					\
 	h##rfid;							\
 	b	.	/* prevent speculative execution */
-#define EXCEPTION_PROLOG_PSERIES_1(label, h) \
+#define EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	__EXCEPTION_PROLOG_PSERIES_1(label, h)
 
-#define EXCEPTION_PROLOG_PSERIES(area, label, h)			\
-	EXCEPTION_PROLOG_1(area);					\
+#define EXCEPTION_PROLOG_PSERIES(area, label, h, extra, vec)		\
+	EXCEPTION_PROLOG_1(area, extra, vec);				\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
+#define __KVMTEST(n)							\
+	lbz	r10,PACA_KVM_SVCPU+SVCPU_IN_GUEST(r13);			\
+	cmpwi	r10,0;							\
+	bne	do_kvm_##n
+
+#define __KVM_HANDLER(area, h, n)					\
+do_kvm_##n:								\
+	ld	r10,area+EX_R10(r13);					\
+	stw	r9,PACA_KVM_SVCPU+SVCPU_SCRATCH1(r13);			\
+	ld	r9,area+EX_R9(r13);					\
+	std	r12,PACA_KVM_SVCPU+SVCPU_SCRATCH0(r13);			\
+	li	r12,n;							\
+	b	kvmppc_interrupt
+
+#define __KVM_HANDLER_SKIP(area, h, n)					\
+do_kvm_##n:								\
+	cmpwi	r10,KVM_GUEST_MODE_SKIP;				\
+	ld	r10,area+EX_R10(r13);					\
+	beq	89f;							\
+	stw	r9,PACA_KVM_SVCPU+SVCPU_SCRATCH1(r13);			\
+	ld	r9,area+EX_R9(r13);					\
+	std	r12,PACA_KVM_SVCPU+SVCPU_SCRATCH0(r13);			\
+	li	r12,n;							\
+	b	kvmppc_interrupt;					\
+89:	mtocrf	0x80,r9;						\
+	ld	r9,area+EX_R9(r13);					\
+	b	kvmppc_skip_##h##interrupt
+
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+#define KVMTEST(n)			__KVMTEST(n)
+#define KVM_HANDLER(area, h, n)		__KVM_HANDLER(area, h, n)
+#define KVM_HANDLER_SKIP(area, h, n)	__KVM_HANDLER_SKIP(area, h, n)
+
+#else
+#define KVMTEST(n)
+#define KVM_HANDLER(area, h, n)
+#define KVM_HANDLER_SKIP(area, h, n)
+#endif
+
+#define NOTEST(n)
+
 /*
  * The common exception prolog is used for all except a few exceptions
  * such as a segment miss on a kernel address.  We have to be prepared
@@ -164,57 +208,54 @@
 	.globl label##_pSeries;				\
 label##_pSeries:					\
 	HMT_MEDIUM;					\
-	DO_KVM	vec;					\
 	SET_SCRATCH0(r13);		/* save r13 */		\
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common, EXC_STD)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
+				 EXC_STD, KVMTEST, vec)
 
 #define STD_EXCEPTION_HV(loc, vec, label)		\
 	. = loc;					\
 	.globl label##_hv;				\
 label##_hv:						\
 	HMT_MEDIUM;					\
-	DO_KVM	vec;					\
-	SET_SCRATCH0(r13);	/* save r13 */		\
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common, EXC_HV)
+	SET_SCRATCH0(r13);	/* save r13 */			\
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
+				 EXC_HV, KVMTEST, vec)
 
-#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h)			\
-	HMT_MEDIUM;							\
-	DO_KVM	vec;							\
-	SET_SCRATCH0(r13);    /* save r13 */				\
-	GET_PACA(r13);							\
-	std	r9,PACA_EXGEN+EX_R9(r13);	/* save r9, r10 */	\
-	std	r10,PACA_EXGEN+EX_R10(r13);				\
+#define __SOFTEN_TEST(h)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
-	mfcr	r9;							\
 	cmpwi	r10,0;							\
-	beq	masked_##h##interrupt;					\
-	GET_SCRATCH0(r10);						\
-	std	r10,PACA_EXGEN+EX_R13(r13);				\
-	std	r11,PACA_EXGEN+EX_R11(r13);				\
-	std	r12,PACA_EXGEN+EX_R12(r13);				\
-	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
-	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
-	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label##_common)				\
-	mtspr	SPRN_##h##SRR0,r12;					\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
-	mtspr	SPRN_##h##SRR1,r10;					\
-	h##rfid;							\
-	b	.	/* prevent speculative execution */
-#define _MASKABLE_EXCEPTION_PSERIES(vec, label, h)			\
-	__MASKABLE_EXCEPTION_PSERIES(vec, label, h)
+	beq	masked_##h##interrupt
+#define _SOFTEN_TEST(h)	__SOFTEN_TEST(h)
+
+#define SOFTEN_TEST(vec)						\
+	KVMTEST(vec);							\
+	_SOFTEN_TEST(EXC_STD)
+
+#define SOFTEN_TEST_HV(vec)						\
+	KVMTEST(vec);							\
+	_SOFTEN_TEST(EXC_HV)
+
+#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
+	HMT_MEDIUM;							\
+	SET_SCRATCH0(r13);    /* save r13 */				\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, h);
+#define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
+	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)
 
 #define MASKABLE_EXCEPTION_PSERIES(loc, vec, label)			\
 	. = loc;							\
 	.globl label##_pSeries;						\
 label##_pSeries:							\
-	_MASKABLE_EXCEPTION_PSERIES(vec, label, EXC_STD)
+	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
+				    EXC_STD, SOFTEN_TEST)
 
 #define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
 	. = loc;							\
 	.globl label##_hv;						\
 label##_hv:								\
-	_MASKABLE_EXCEPTION_PSERIES(vec, label, EXC_HV)
+	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
+				    EXC_HV, SOFTEN_TEST_HV)
 
 #ifdef CONFIG_PPC_ISERIES
 #define DISABLE_INTS				\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a85f487..e76472c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -40,7 +40,6 @@ __start_interrupts:
 	.globl system_reset_pSeries;
 system_reset_pSeries:
 	HMT_MEDIUM;
-	DO_KVM	0x100;
 	SET_SCRATCH0(r13)
 #ifdef CONFIG_PPC_P7_NAP
 BEGIN_FTR_SECTION
@@ -65,67 +64,45 @@ BEGIN_FTR_SECTION
 	beq	.
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE_206)
 #endif /* CONFIG_PPC_P7_NAP */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
+				 NOTEST, 0x100)
 
 	. = 0x200
-_machine_check_pSeries:
-	HMT_MEDIUM
-	DO_KVM	0x200
-	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common, EXC_STD)
+machine_check_pSeries_1:
+	/* This is moved out of line as it can be patched by FW, but
+	 * some code path might still want to branch into the original
+	 * vector
+	 */
+	b	machine_check_pSeries
 
 	. = 0x300
 	.globl data_access_pSeries
 data_access_pSeries:
 	HMT_MEDIUM
-	DO_KVM	0x300
 	SET_SCRATCH0(r13)
+#ifndef CONFIG_POWER4_ONLY
 BEGIN_FTR_SECTION
-	GET_PACA(r13)
-	std	r9,PACA_EXSLB+EX_R9(r13)
-	std	r10,PACA_EXSLB+EX_R10(r13)
-	mfspr	r10,SPRN_DAR
-	mfspr	r9,SPRN_DSISR
-	srdi	r10,r10,60
-	rlwimi	r10,r9,16,0x20
-	mfcr	r9
-	cmpwi	r10,0x2c
-	beq	do_stab_bolted_pSeries
-	ld	r10,PACA_EXSLB+EX_R10(r13)
-	std	r11,PACA_EXGEN+EX_R11(r13)
-	ld	r11,PACA_EXSLB+EX_R9(r13)
-	std	r12,PACA_EXGEN+EX_R12(r13)
-	GET_SCRATCH0(r12)
-	std	r10,PACA_EXGEN+EX_R10(r13)
-	std	r11,PACA_EXGEN+EX_R9(r13)
-	std	r12,PACA_EXGEN+EX_R13(r13)
-	EXCEPTION_PROLOG_PSERIES_1(data_access_common, EXC_STD)
-FTR_SECTION_ELSE
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common, EXC_STD)
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_SLB)
+	b	data_access_check_stab
+data_access_not_stab:
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
+#endif
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common, EXC_STD,
+				 KVMTEST, 0x300)
 
 	. = 0x380
 	.globl data_access_slb_pSeries
 data_access_slb_pSeries:
 	HMT_MEDIUM
-	DO_KVM	0x380
 	SET_SCRATCH0(r13)
-	GET_PACA(r13)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
-	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
-	mfcr	r9
 #ifdef __DISABLED__
 	/* Keep that around for when we re-implement dynamic VSIDs */
 	cmpdi	r3,0
 	bge	slb_miss_user_pseries
 #endif /* __DISABLED__ */
-	std	r10,PACA_EXSLB+EX_R10(r13)
-	std	r11,PACA_EXSLB+EX_R11(r13)
-	std	r12,PACA_EXSLB+EX_R12(r13)
-	GET_SCRATCH0(r10)
-	std	r10,PACA_EXSLB+EX_R13(r13)
-	mfspr	r12,SPRN_SRR1		/* and SRR1 */
+	mfspr	r12,SPRN_SRR1
 #ifndef CONFIG_RELOCATABLE
 	b	.slb_miss_realmode
 #else
@@ -147,24 +124,16 @@ data_access_slb_pSeries:
 	.globl instruction_access_slb_pSeries
 instruction_access_slb_pSeries:
 	HMT_MEDIUM
-	DO_KVM	0x480
 	SET_SCRATCH0(r13)
-	GET_PACA(r13)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
-	std	r9,PACA_EXSLB+EX_R9(r13)	/* save r9 - r12 */
-	mfcr	r9
 #ifdef __DISABLED__
 	/* Keep that around for when we re-implement dynamic VSIDs */
 	cmpdi	r3,0
 	bge	slb_miss_user_pseries
 #endif /* __DISABLED__ */
-	std	r10,PACA_EXSLB+EX_R10(r13)
-	std	r11,PACA_EXSLB+EX_R11(r13)
-	std	r12,PACA_EXSLB+EX_R12(r13)
-	GET_SCRATCH0(r10)
-	std	r10,PACA_EXSLB+EX_R13(r13)
-	mfspr	r12,SPRN_SRR1		/* and SRR1 */
+	mfspr	r12,SPRN_SRR1
 #ifndef CONFIG_RELOCATABLE
 	b	.slb_miss_realmode
 #else
@@ -184,26 +153,46 @@ instruction_access_slb_pSeries:
 hardware_interrupt_pSeries:
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
-		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt, EXC_STD)
+		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
+					    EXC_STD, SOFTEN_TEST)
+		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	FTR_SECTION_ELSE
-		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt, EXC_HV)
+		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
+					    EXC_HV, SOFTEN_TEST_HV)
+		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
 	ALT_FTR_SECTION_END_IFCLR(CPU_FTR_HVMODE_206)
 
 	STD_EXCEPTION_PSERIES(0x600, 0x600, alignment)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x600)
+
 	STD_EXCEPTION_PSERIES(0x700, 0x700, program_check)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x700)
+
 	STD_EXCEPTION_PSERIES(0x800, 0x800, fp_unavailable)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x800)
 
 	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
-	MASKABLE_EXCEPTION_HV(0x980, 0x980, decrementer)
+	MASKABLE_EXCEPTION_HV(0x980, 0x982, decrementer)
 
 	STD_EXCEPTION_PSERIES(0xa00, 0xa00, trap_0a)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xa00)
+
 	STD_EXCEPTION_PSERIES(0xb00, 0xb00, trap_0b)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xb00)
 
 	. = 0xc00
 	.globl	system_call_pSeries
 system_call_pSeries:
 	HMT_MEDIUM
-	DO_KVM	0xc00
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	SET_SCRATCH0(r13)
+	GET_PACA(r13)
+	std	r9,PACA_EXGEN+EX_R9(r13)
+	std	r10,PACA_EXGEN+EX_R10(r13)
+	mfcr	r9
+	KVMTEST(0xc00)
+	GET_SCRATCH0(r13)
+#endif
 BEGIN_FTR_SECTION
 	cmpdi	r0,0x1ebe
 	beq-	1f
@@ -220,6 +209,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	rfid
 	b	.	/* prevent speculative execution */
 
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xc00)
+
 /* Fast LE/BE switch system call */
 1:	mfspr	r12,SPRN_SRR1
 	xori	r12,r12,MSR_LE
@@ -228,6 +219,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	b	.
 
 	STD_EXCEPTION_PSERIES(0xd00, 0xd00, single_step)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xd00)
 
 	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
 	 * out of line to handle them
@@ -262,30 +254,93 @@ vsx_unavailable_pSeries_1:
 
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
 #endif /* CONFIG_CBE_RAS */
+
 	STD_EXCEPTION_PSERIES(0x1300, 0x1300, instruction_breakpoint)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x1300)
+
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1600, 0x1602, cbe_maintenance)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1602)
 #endif /* CONFIG_CBE_RAS */
+
 	STD_EXCEPTION_PSERIES(0x1700, 0x1700, altivec_assist)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x1700)
+
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1800, 0x1802, cbe_thermal)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1802)
 #endif /* CONFIG_CBE_RAS */
 
 	. = 0x3000
 
 /*** Out of line interrupts support ***/
 
+	/* moved from 0x200 */
+machine_check_pSeries:
+	.globl machine_check_fwnmi
+machine_check_fwnmi:
+	HMT_MEDIUM
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common,
+				 EXC_STD, KVMTEST, 0x200)
+	KVM_HANDLER_SKIP(PACA_EXMC, EXC_STD, 0x200)
+
+#ifndef CONFIG_POWER4_ONLY
+	/* moved from 0x300 */
+data_access_check_stab:
+	GET_PACA(r13)
+	std	r9,PACA_EXSLB+EX_R9(r13)
+	std	r10,PACA_EXSLB+EX_R10(r13)
+	mfspr	r10,SPRN_DAR
+	mfspr	r9,SPRN_DSISR
+	srdi	r10,r10,60
+	rlwimi	r10,r9,16,0x20
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+	lbz	r9,PACA_KVM_SVCPU+SVCPU_IN_GUEST(r13)
+	rlwimi	r10,r9,8,0x300
+#endif
+	mfcr	r9
+	cmpwi	r10,0x2c
+	beq	do_stab_bolted_pSeries
+	mtcrf	0x80,r9
+	ld	r9,PACA_EXSLB+EX_R9(r13)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	b	data_access_not_stab
+do_stab_bolted_pSeries:
+	std	r11,PACA_EXSLB+EX_R11(r13)
+	std	r12,PACA_EXSLB+EX_R12(r13)
+	GET_SCRATCH0(r10)
+	std	r10,PACA_EXSLB+EX_R13(r13)
+	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted, EXC_STD)
+#endif /* CONFIG_POWER4_ONLY */
+
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x300)
+	KVM_HANDLER_SKIP(PACA_EXSLB, EXC_STD, 0x380)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x400)
+	KVM_HANDLER(PACA_EXSLB, EXC_STD, 0x480)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x900)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x982)
+
+	.align	7
 	/* moved from 0xe00 */
-	STD_EXCEPTION_HV(., 0xe00, h_data_storage)
-	STD_EXCEPTION_HV(., 0xe20, h_instr_storage)
-	STD_EXCEPTION_HV(., 0xe40, emulation_assist)
-	STD_EXCEPTION_HV(., 0xe60, hmi_exception) /* need to flush cache ? */
+	STD_EXCEPTION_HV(., 0xe02, h_data_storage)
+	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0xe02)
+	STD_EXCEPTION_HV(., 0xe22, h_instr_storage)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe22)
+	STD_EXCEPTION_HV(., 0xe42, emulation_assist)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe42)
+	STD_EXCEPTION_HV(., 0xe62, hmi_exception) /* need to flush cache ? */
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe62)
 
 	/* moved from 0xf00 */
 	STD_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf00)
 	STD_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf20)
 	STD_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
+	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf40)
 
 /*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
@@ -317,14 +372,6 @@ masked_Hinterrupt:
 	hrfid
 	b	.
 
-	.align	7
-do_stab_bolted_pSeries:
-	std	r11,PACA_EXSLB+EX_R11(r13)
-	std	r12,PACA_EXSLB+EX_R12(r13)
-	GET_SCRATCH0(r10)
-	std	r10,PACA_EXSLB+EX_R13(r13)
-	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted, EXC_STD)
-
 #ifdef CONFIG_PPC_PSERIES
 /*
  * Vectors for the FWNMI option.  Share common code.
@@ -334,14 +381,8 @@ do_stab_bolted_pSeries:
 system_reset_fwnmi:
 	HMT_MEDIUM
 	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD)
-
-	.globl machine_check_fwnmi
-      .align 7
-machine_check_fwnmi:
-	HMT_MEDIUM
-	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common, EXC_STD)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
+				 NOTEST, 0x100)
 
 #endif /* CONFIG_PPC_PSERIES */
 
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 5f5d074..dd03689 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -40,37 +40,42 @@
 #define MSR_NOIRQ		MSR_KERNEL & ~(MSR_IR | MSR_DR)
 #define FUNC(name) 		GLUE(.,name)
 
-#elif defined(CONFIG_PPC_BOOK3S_32)
+kvmppc_skip_interrupt:
+	/*
+	 * Here all GPRs are unchanged from when the interrupt happened
+	 * except for r13, which is saved in SPRG_SCRATCH0.
+	 */
+	mfspr	r13, SPRN_SRR0
+	addi	r13, r13, 4
+	mtspr	SPRN_SRR0, r13
+	GET_SCRATCH0(r13)
+	rfid
+	b	.
+
+kvmppc_skip_Hinterrupt:
+	/*
+	 * Here all GPRs are unchanged from when the interrupt happened
+	 * except for r13, which is saved in SPRG_SCRATCH0.
+	 */
+	mfspr	r13, SPRN_HSRR0
+	addi	r13, r13, 4
+	mtspr	SPRN_HSRR0, r13
+	GET_SCRATCH0(r13)
+	hrfid
+	b	.
 
-#define LOAD_SHADOW_VCPU(reg)						\
-	mfspr	reg, SPRN_SPRG_THREAD;					\
-	lwz	reg, THREAD_KVM_SVCPU(reg);				\
-	/* PPC32 can have a NULL pointer - let's check for that */	\
-	mtspr   SPRN_SPRG_SCRATCH1, r12;	/* Save r12 */		\
-	mfcr	r12;							\
-	cmpwi	reg, 0;							\
-	bne	1f;							\
-	mfspr	reg, SPRN_SPRG_SCRATCH0;				\
-	mtcr	r12;							\
-	mfspr	r12, SPRN_SPRG_SCRATCH1;				\
-	b	kvmppc_resume_\intno;					\
-1:;									\
-	mtcr	r12;							\
-	mfspr	r12, SPRN_SPRG_SCRATCH1;				\
-	tophys(reg, reg)
+#elif defined(CONFIG_PPC_BOOK3S_32)
 
 #define SHADOW_VCPU_OFF		0
 #define MSR_NOIRQ		MSR_KERNEL
 #define FUNC(name)		name
 
-#endif
-
 .macro INTERRUPT_TRAMPOLINE intno
 
 .global kvmppc_trampoline_\intno
 kvmppc_trampoline_\intno:
 
-	SET_SCRATCH0(r13)		/* Save r13 */
+	mtspr	SPRN_SPRG_SCRATCH0, r13		/* Save r13 */
 
 	/*
 	 * First thing to do is to find out if we're coming
@@ -78,19 +83,28 @@ kvmppc_trampoline_\intno:
 	 *
 	 * To distinguish, we check a magic byte in the PACA/current
 	 */
-	LOAD_SHADOW_VCPU(r13)
-	PPC_STL	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH0)(r13)
+	mfspr	r13, SPRN_SPRG_THREAD
+	lwz	r13, THREAD_KVM_SVCPU(r13)
+	/* PPC32 can have a NULL pointer - let's check for that */
+	mtspr   SPRN_SPRG_SCRATCH1, r12		/* Save r12 */
 	mfcr	r12
+	cmpwi	r13, 0
+	bne	1f
+2:	mtcr	r12
+	mfspr	r12, SPRN_SPRG_SCRATCH1
+	mfspr	r13, SPRN_SPRG_SCRATCH0		/* r13 = original r13 */
+	b	kvmppc_resume_\intno		/* Get back original handler */
+
+1:	tophys(r13, r13)
 	stw	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH1)(r13)
+	mfspr	r12, SPRN_SPRG_SCRATCH1
+	stw	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH0)(r13)
 	lbz	r12, (SHADOW_VCPU_OFF + SVCPU_IN_GUEST)(r13)
 	cmpwi	r12, KVM_GUEST_MODE_NONE
 	bne	..kvmppc_handler_hasmagic_\intno
 	/* No KVM guest? Then jump back to the Linux handler! */
 	lwz	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH1)(r13)
-	mtcr	r12
-	PPC_LL	r12, (SHADOW_VCPU_OFF + SVCPU_SCRATCH0)(r13)
-	GET_SCRATCH0(r13)			/* r13 = original r13 */
-	b	kvmppc_resume_\intno		/* Get back original handler */
+	b	2b
 
 	/* Now we know we're handling a KVM guest */
 ..kvmppc_handler_hasmagic_\intno:
@@ -112,9 +126,6 @@ INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_MACHINE_CHECK
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_DATA_STORAGE
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_INST_STORAGE
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_EXTERNAL
-#ifdef CONFIG_PPC_BOOK3S_64
-INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_EXTERNAL_HV
-#endif
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_ALIGNMENT
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_PROGRAM
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_FP_UNAVAIL
@@ -124,14 +135,6 @@ INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_TRACE
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_PERFMON
 INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_ALTIVEC
 
-/* Those are only available on 64 bit machines */
-
-#ifdef CONFIG_PPC_BOOK3S_64
-INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_DATA_SEGMENT
-INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_INST_SEGMENT
-INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_VSX
-#endif
-
 /*
  * Bring us back to the faulting code, but skip the
  * faulting instruction.
@@ -163,6 +166,7 @@ kvmppc_handler_skip_ins:
 
 	/* And get back into the code */
 	RFI
+#endif
 
 /*
  * This trampoline brings us back to a real mode handler
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 4512642..4a623eb 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -125,6 +125,9 @@ kvmppc_handler_trampoline_enter_end:
 .global kvmppc_handler_trampoline_exit
 kvmppc_handler_trampoline_exit:
 
+.global kvmppc_interrupt
+kvmppc_interrupt:
+
 	/* Register usage at this point:
 	 *
 	 * SPRG_SCRATCH0  = guest R13
@@ -155,12 +158,16 @@ kvmppc_handler_trampoline_exit:
 	PPC_LL	r2, (SHADOW_VCPU_OFF + SVCPU_HOST_R2)(r13)
 
 	/* Save guest PC and MSR */
+#ifdef CONFIG_PPC64
+BEGIN_FTR_SECTION
 	andi.	r0,r12,0x2
 	beq	1f
 	mfspr	r3,SPRN_HSRR0
 	mfspr	r4,SPRN_HSRR1
 	andi.	r12,r12,0x3ffd
 	b	2f
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE_206)
+#endif
 1:	mfsrr0	r3
 	mfsrr1	r4
 2:
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index 29c02f3..f519ee1 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -167,7 +167,7 @@ BEGIN_FTR_SECTION
 	std	r12,PACA_EXGEN+EX_R13(r13)
 	EXCEPTION_PROLOG_ISERIES_1
 FTR_SECTION_ELSE
-	EXCEPTION_PROLOG_1(PACA_EXGEN)
+	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0)
 	EXCEPTION_PROLOG_ISERIES_1
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_SLB)
 	b	data_access_common
diff --git a/arch/powerpc/platforms/iseries/exception.h b/arch/powerpc/platforms/iseries/exception.h
index bae3fba..50271b5 100644
--- a/arch/powerpc/platforms/iseries/exception.h
+++ b/arch/powerpc/platforms/iseries/exception.h
@@ -39,7 +39,7 @@
 label##_iSeries:							\
 	HMT_MEDIUM;							\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
-	EXCEPTION_PROLOG_1(area);					\
+	EXCEPTION_PROLOG_1(area, NOTEST, 0);				\
 	EXCEPTION_PROLOG_ISERIES_1;					\
 	b	label##_common
 
@@ -48,7 +48,7 @@ label##_iSeries:							\
 label##_iSeries:							\
 	HMT_MEDIUM;							\
 	mtspr	SPRN_SPRG_SCRATCH0,r13;	/* save r13 */			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN);					\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0);			\
 	lbz	r10,PACASOFTIRQEN(r13);					\
 	cmpwi	0,r10,0;						\
 	beq-	label##_iSeries_masked;					\
-- 
1.7.5.4
