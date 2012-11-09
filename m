Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 06/14] powerpc: Add new macros needed for relocation on
 exceptions
Date: Fri,  9 Nov 2012 17:19:04 +1100
Message-Id: <1352441953-29096-7-git-send-email-mikey@neuling.org>
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

The below macros are copies of the macros used at the 0x0 offset but modified
to handle the MMU being on.  In these macros we use the link register to jump
to the secondary handlers rather than using RFID (RFID was also use to turn on
the MMU).

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/exception-64s.h |   90 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/exceptions-64s.S     |   25 +++++++++
 2 files changed, 115 insertions(+)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 9258daa..10787d3 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -48,6 +48,35 @@
 #define EX_LR		72
 #define EX_CFAR		80
 
+#ifdef CONFIG_RELOCATABLE
+#define EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
+	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
+	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
+	LOAD_HANDLER(r12,label);					\
+	mtlr	r12;							\
+	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
+	li	r10,MSR_RI;						\
+	mtmsrd 	r10,1;			/* Set RI (EE=0) */		\
+	blr;
+#else
+/* If not relocatable, we can jump directly -- and save messing with LR */
+#define EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
+	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
+	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
+	li	r10,MSR_RI;						\
+	mtmsrd 	r10,1;			/* Set RI (EE=0) */		\
+	b	label;
+#endif
+
+/*
+ * As EXCEPTION_PROLOG_PSERIES(), except we've already got relocation on
+ * so no need to rfid.  Save lr in case we're CONFIG_RELOCATABLE, in which
+ * case EXCEPTION_RELON_PROLOG_PSERIES_1 will be using lr.
+ */
+#define EXCEPTION_RELON_PROLOG_PSERIES(area, label, h, extra, vec)	\
+	EXCEPTION_PROLOG_1(area, extra, vec);				\
+	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
+
 /*
  * We're short on space and time in the exception prolog, so we can't
  * use the normal SET_REG_IMMEDIATE macro. Normally we just need the
@@ -62,6 +91,22 @@
 #define EXC_HV	H
 #define EXC_STD
 
+#if defined(CONFIG_RELOCATABLE)
+/*
+ * If we support interrupts with relocation on AND we're a relocatable
+ * kernel, we need to use LR to get to the 2nd level handler.  So, save/restore
+ * it when required.
+ */
+#define SAVE_LR(reg, area)	mflr	reg ; 	std	reg,area+EX_LR(r13)
+#define GET_LR(reg, area) 			ld	reg,area+EX_LR(r13)
+#define RESTORE_LR(reg, area)	ld	reg,area+EX_LR(r13) ; mtlr reg
+#else
+/* ...else LR is unused and in register. */
+#define SAVE_LR(reg, area)
+#define GET_LR(reg, area) 	mflr	reg
+#define RESTORE_LR(reg, area)
+#endif
+
 #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
 	GET_PACA(r13);							\
 	std	r9,area+EX_R9(r13);	/* save r9 - r12 */		\
@@ -233,6 +278,26 @@ label##_hv:						\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_HV, KVMTEST, vec)
 
+#define STD_RELON_EXCEPTION_PSERIES(loc, vec, label)	\
+	. = loc;					\
+	.globl label##_relon_pSeries;			\
+label##_relon_pSeries:					\
+	HMT_MEDIUM;					\
+	/* No guest interrupts come through here */	\
+	SET_SCRATCH0(r13);		/* save r13 */	\
+	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
+				       EXC_STD, KVMTEST_PR, vec)
+
+#define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
+	. = loc;					\
+	.globl label##_relon_hv;			\
+label##_relon_hv:					\
+	HMT_MEDIUM;					\
+	/* No guest interrupts come through here */	\
+	SET_SCRATCH0(r13);	/* save r13 */		\
+	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
+				       EXC_HV, KVMTEST, vec)
+
 /* This associate vector numbers with bits in paca->irq_happened */
 #define SOFTEN_VALUE_0x500	PACA_IRQ_EE
 #define SOFTEN_VALUE_0x502	PACA_IRQ_EE
@@ -258,6 +323,9 @@ label##_hv:						\
 	KVMTEST(vec);							\
 	_SOFTEN_TEST(EXC_STD, vec)
 
+#define SOFTEN_NOTEST_PR(vec)		_SOFTEN_TEST(EXC_STD, vec)
+#define SOFTEN_NOTEST_HV(vec)		_SOFTEN_TEST(EXC_HV, vec)
+
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
 	HMT_MEDIUM;							\
 	SET_SCRATCH0(r13);    /* save r13 */				\
@@ -280,6 +348,28 @@ label##_hv:								\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_HV, SOFTEN_TEST_HV)
 
+#define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
+	HMT_MEDIUM;							\
+	SET_SCRATCH0(r13);    /* save r13 */				\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
+	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, h);
+#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
+	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)
+
+#define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label)		\
+	. = loc;							\
+	.globl label##_relon_pSeries;					\
+label##_relon_pSeries:							\
+	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
+					  EXC_STD, SOFTEN_NOTEST_PR)
+
+#define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label)			\
+	. = loc;							\
+	.globl label##_relon_hv;					\
+label##_relon_hv:							\
+	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
+					  EXC_HV, SOFTEN_NOTEST_HV)
+
 /*
  * Our exception common code can be passed various "additions"
  * to specify the behaviour of interrupts, whether to kick the
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 85b3c7e..4dc1a04 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -62,6 +62,31 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	rfid ;							\
 	b	. ;	/* prevent speculative execution */
 
+#if defined(CONFIG_RELOCATABLE)
+	/*
+	 * We can't branch directly; in the direct case we use LR
+	 * and system_call_entry restores LR.  (We thus need to move
+	 * LR to r10 in the RFID case too.)
+	 */
+#define SYSCALL_PSERIES_2_DIRECT				\
+	mflr	r10 ;						\
+	ld	r12,PACAKBASE(r13) ; 				\
+	LOAD_HANDLER(r12, system_call_entry_direct) ;		\
+	mtlr	r12 ;						\
+	mfspr	r12,SPRN_SRR1 ;					\
+	/* Re-use of r13... No spare regs to do this */	\
+	li	r13,MSR_RI ;					\
+	mtmsrd 	r13,1 ;						\
+	GET_PACA(r13) ;	/* get r13 back */			\
+	blr ;
+#else
+	/* We can branch directly */
+#define SYSCALL_PSERIES_2_DIRECT				\
+	mfspr	r12,SPRN_SRR1 ;					\
+	li	r10,MSR_RI ;					\
+	mtmsrd 	r10,1 ;			/* Set RI (EE=0) */	\
+	b	system_call_entry_direct ;
+#endif
 
 /*
  * This is the start of the interrupt handlers for pSeries
-- 
1.7.9.5
