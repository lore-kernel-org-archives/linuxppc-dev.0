Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1yRX2Kj9zDrhr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 01:52:24 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id b18so11995276pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:52:24 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 2/8] powerpc/64s: poison r14 register while in kernel
Date: Thu, 21 Dec 2017 00:52:00 +1000
Message-Id: <20171220145206.12234-3-npiggin@gmail.com>
In-Reply-To: <20171220145206.12234-1-npiggin@gmail.com>
References: <20171220145206.12234-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Poison r14 register with the PIR SPR, an a magic number.
This means it must be treated like r13, saving and restoring the
register on kernel entry/exit, but not restoring it when returning
back to kernel

However r14 will not be a constant like r13, but may be modified by
the kernel, which means it must not be loaded on exception entry if
the exception is coming from the kernel.

This requires loading SRR1 earlier, before the exception mask/kvm
test. That's okay because SRR1 almost always gets loaded anyway.
---
 arch/powerpc/include/asm/exception-64s.h | 121 ++++++++++++++++---------------
 arch/powerpc/include/asm/paca.h          |   5 +-
 arch/powerpc/kernel/asm-offsets.c        |   3 +-
 arch/powerpc/kernel/entry_64.S           |  23 ++++++
 arch/powerpc/kernel/exceptions-64s.S     |  45 ++++++------
 arch/powerpc/kernel/head_64.S            |   5 ++
 arch/powerpc/kernel/idle_book3s.S        |   4 +
 arch/powerpc/kernel/paca.c               |   1 -
 arch/powerpc/kernel/setup_64.c           |   3 +
 arch/powerpc/lib/sstep.c                 |   1 +
 10 files changed, 128 insertions(+), 83 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 54afd1f140a4..dadaa7471755 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -42,16 +42,18 @@
 #define EX_R11		16
 #define EX_R12		24
 #define EX_R13		32
-#define EX_DAR		40
-#define EX_DSISR	48
-#define EX_CCR		52
-#define EX_CFAR		56
-#define EX_PPR		64
+#define EX_R14		40
+#define EX_DAR		48
+#define EX_DSISR	56
+#define EX_CCR		60
+#define EX_CFAR		64
+#define EX_PPR		72
+
 #if defined(CONFIG_RELOCATABLE)
-#define EX_CTR		72
-#define EX_SIZE		10	/* size in u64 units */
+#define EX_CTR		80
+#define EX_SIZE		11	/* size in u64 units */
 #else
-#define EX_SIZE		9	/* size in u64 units */
+#define EX_SIZE		10	/* size in u64 units */
 #endif
 
 /*
@@ -77,9 +79,8 @@
 #ifdef CONFIG_RELOCATABLE
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label);					\
-	mtctr	r12;							\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
+	LOAD_HANDLER(r10,label);					\
+	mtctr	r10;							\
 	li	r10,MSR_RI;						\
 	mtmsrd 	r10,1;			/* Set RI (EE=0) */		\
 	bctr;
@@ -87,7 +88,6 @@
 /* If not relocatable, we can jump directly -- and save messing with LR */
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	li	r10,MSR_RI;						\
 	mtmsrd 	r10,1;			/* Set RI (EE=0) */		\
 	b	label;
@@ -102,7 +102,7 @@
  */
 #define EXCEPTION_RELON_PROLOG_PSERIES(area, label, h, extra, vec)	\
 	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
+	EXCEPTION_PROLOG_1(area, h, extra, vec);				\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
 
 /*
@@ -198,17 +198,21 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
 	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
 
-#define __EXCEPTION_PROLOG_1_PRE(area)					\
+#define __EXCEPTION_PROLOG_1(area, h)					\
+	std	r11,area+EX_R11(r13);					\
+	std	r12,area+EX_R12(r13);					\
+	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
+	GET_SCRATCH0(r11);						\
 	OPT_SAVE_REG_TO_PACA(area+EX_PPR, r9, CPU_FTR_HAS_PPR);		\
 	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
 	SAVE_CTR(r10, area);						\
-	mfcr	r9;
-
-#define __EXCEPTION_PROLOG_1_POST(area)					\
-	std	r11,area+EX_R11(r13);					\
-	std	r12,area+EX_R12(r13);					\
-	GET_SCRATCH0(r10);						\
-	std	r10,area+EX_R13(r13)
+	mfcr	r9;							\
+	std	r11,area+EX_R13(r13);					\
+	std	r14,area+EX_R14(r13);					\
+	andi.	r10,r12,MSR_PR;						\
+	beq	1f;							\
+	ld	r14,PACA_R14(r13);					\
+1:
 
 /*
  * This version of the EXCEPTION_PROLOG_1 will carry
@@ -216,30 +220,27 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
  * checking of the interrupt maskable level in the SOFTEN_TEST.
  * Intended to be used in MASKABLE_EXCPETION_* macros.
  */
-#define MASKABLE_EXCEPTION_PROLOG_1(area, extra, vec, bitmask)			\
-	__EXCEPTION_PROLOG_1_PRE(area);					\
-	extra(vec, bitmask);						\
-	__EXCEPTION_PROLOG_1_POST(area);
+#define MASKABLE_EXCEPTION_PROLOG_1(area, h, extra, vec, bitmask)	\
+	__EXCEPTION_PROLOG_1(area, h);					\
+	extra(vec, bitmask);
 
 /*
  * This version of the EXCEPTION_PROLOG_1 is intended
  * to be used in STD_EXCEPTION* macros
  */
-#define _EXCEPTION_PROLOG_1(area, extra, vec)				\
-	__EXCEPTION_PROLOG_1_PRE(area);					\
-	extra(vec);							\
-	__EXCEPTION_PROLOG_1_POST(area);
+#define _EXCEPTION_PROLOG_1(area, h, extra, vec)			\
+	__EXCEPTION_PROLOG_1(area, h);					\
+	extra(vec);
 
-#define EXCEPTION_PROLOG_1(area, extra, vec)				\
-	_EXCEPTION_PROLOG_1(area, extra, vec)
+#define EXCEPTION_PROLOG_1(area, h, extra, vec)				\
+	_EXCEPTION_PROLOG_1(area, h, extra, vec)
 
 #define __EXCEPTION_PROLOG_PSERIES_1(label, h)				\
-	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label)						\
-	mtspr	SPRN_##h##SRR0,r12;					\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
+	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	mtspr	SPRN_##h##SRR1,r10;					\
+	LOAD_HANDLER(r10,label)						\
+	mtspr	SPRN_##h##SRR0,r10;					\
 	h##rfid;							\
 	b	.	/* prevent speculative execution */
 #define EXCEPTION_PROLOG_PSERIES_1(label, h)				\
@@ -247,13 +248,12 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 /* _NORI variant keeps MSR_RI clear */
 #define __EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)			\
+	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	xori	r10,r10,MSR_RI;		/* Clear MSR_RI */		\
-	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER(r12,label)						\
-	mtspr	SPRN_##h##SRR0,r12;					\
-	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	mtspr	SPRN_##h##SRR1,r10;					\
+	LOAD_HANDLER(r10,label)						\
+	mtspr	SPRN_##h##SRR0,r10;					\
 	h##rfid;							\
 	b	.	/* prevent speculative execution */
 
@@ -262,7 +262,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define EXCEPTION_PROLOG_PSERIES(area, label, h, extra, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
+	EXCEPTION_PROLOG_1(area, h, extra, vec);			\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
 #define __KVMTEST(h, n)							\
@@ -336,7 +336,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 /* Do not enable RI */
 #define EXCEPTION_PROLOG_PSERIES_NORI(area, label, h, extra, vec)	\
 	EXCEPTION_PROLOG_0(area);					\
-	EXCEPTION_PROLOG_1(area, extra, vec);				\
+	EXCEPTION_PROLOG_1(area, h, extra, vec);			\
 	EXCEPTION_PROLOG_PSERIES_1_NORI(label, h);
 
 
@@ -349,8 +349,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	ld	r10,area+EX_PPR(r13);					\
 	std	r10,HSTATE_PPR(r13);					\
 	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
+	ld	r10,area+EX_R12(r13);					\
+	std	r10,HSTATE_SCRATCH0(r13);				\
 	ld	r10,area+EX_R10(r13);					\
-	std	r12,HSTATE_SCRATCH0(r13);				\
 	sldi	r12,r9,32;						\
 	ori	r12,r12,(n);						\
 	/* This reloads r9 before branching to kvmppc_interrupt */	\
@@ -363,8 +364,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	ld	r10,area+EX_PPR(r13);					\
 	std	r10,HSTATE_PPR(r13);					\
 	END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948);	\
+	ld	r10,area+EX_R12(r13);					\
+	std	r10,HSTATE_SCRATCH0(r13);				\
 	ld	r10,area+EX_R10(r13);					\
-	std	r12,HSTATE_SCRATCH0(r13);				\
 	sldi	r12,r9,32;						\
 	ori	r12,r12,(n);						\
 	/* This reloads r9 before branching to kvmppc_interrupt */	\
@@ -372,6 +374,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 89:	mtocrf	0x80,r9;						\
 	ld	r9,area+EX_R9(r13);					\
 	ld	r10,area+EX_R10(r13);					\
+	ld	r12,area+EX_R12(r13);					\
 	b	kvmppc_skip_##h##interrupt
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
@@ -393,7 +396,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	std	r12,_MSR(r1);		/* save SRR1 in stackframe	*/ \
 	std	r10,0(r1);		/* make stack chain pointer	*/ \
 	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
-	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
+	std	r10,GPR1(r1)		/* save r1 in stackframe	*/
 
 
 /*
@@ -430,16 +433,18 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 /* Save original regs values from save area to stack frame. */
 #define EXCEPTION_PROLOG_COMMON_2(area)					   \
-	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
+	ld	r9,area+EX_R9(r13);	/* move r9-r14 to stackframe	*/ \
 	ld	r10,area+EX_R10(r13);					   \
 	std	r9,GPR9(r1);						   \
 	std	r10,GPR10(r1);						   \
-	ld	r9,area+EX_R11(r13);	/* move r11 - r13 to stackframe	*/ \
+	ld	r9,area+EX_R11(r13);					   \
 	ld	r10,area+EX_R12(r13);					   \
-	ld	r11,area+EX_R13(r13);					   \
 	std	r9,GPR11(r1);						   \
 	std	r10,GPR12(r1);						   \
-	std	r11,GPR13(r1);						   \
+	ld	r9,area+EX_R13(r13);					   \
+	ld	r10,area+EX_R14(r13);					   \
+	std	r9,GPR13(r1);						   \
+	std	r10,GPR14(r1);						   \
 	BEGIN_FTR_SECTION_NESTED(66);					   \
 	ld	r10,area+EX_CFAR(r13);					   \
 	std	r10,ORIG_GPR3(r1);					   \
@@ -480,7 +485,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	b hdlr;
 
 #define STD_EXCEPTION_PSERIES_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_STD, KVMTEST_PR, vec);	\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define STD_EXCEPTION_HV(loc, vec, label)			\
@@ -489,7 +494,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				 EXC_HV, KVMTEST_HV, vec);
 
 #define STD_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_HV, KVMTEST_HV, vec);	\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 #define STD_RELON_EXCEPTION_PSERIES(loc, vec, label)	\
@@ -498,7 +503,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label, EXC_STD, NOTEST, vec);
 
 #define STD_RELON_EXCEPTION_PSERIES_OOL(vec, label)		\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_STD, NOTEST, vec);		\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
@@ -507,7 +512,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				       EXC_HV, KVMTEST_HV, vec);
 
 #define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_HV, KVMTEST_HV, vec);	\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
 
 /* This associate vector numbers with bits in paca->irq_happened */
@@ -548,7 +553,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, h, extra, vec, bitmask);\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
 #define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)	\
@@ -559,7 +564,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_STD, SOFTEN_TEST_PR, bitmask)
 
 #define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label, bitmask)		\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_STD, SOFTEN_TEST_PR, vec, bitmask);\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
 
 #define MASKABLE_EXCEPTION_HV(loc, vec, label, bitmask)			\
@@ -567,13 +572,13 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 				    EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_HV, SOFTEN_TEST_HV, vec, bitmask);\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
 
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask) \
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, h, extra, vec, bitmask);\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
 
 #define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)\
@@ -584,7 +589,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 					  EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_PSERIES_OOL(vec, label, bitmask)	\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_STD, SOFTEN_NOTEST_PR, vec, bitmask);\
 	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD);
 
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, bitmask)		\
@@ -592,7 +597,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 					  EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
-	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec, bitmask);\
+	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_HV, SOFTEN_NOTEST_HV, vec, bitmask);\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
 
 /*
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index e2ee193eb24d..cd6a9a010895 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -34,6 +34,9 @@
 #include <asm/cpuidle.h>
 
 register struct paca_struct *local_paca asm("r13");
+#ifdef CONFIG_PPC_BOOK3S
+register u64 local_r14 asm("r14");
+#endif
 
 #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
 extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
@@ -65,7 +68,6 @@ struct paca_struct {
 	 * read-only (after boot) fields in the first cacheline to
 	 * avoid cacheline bouncing.
 	 */
-
 	struct lppaca *lppaca_ptr;	/* Pointer to LpPaca for PLIC */
 #endif /* CONFIG_PPC_BOOK3S */
 	/*
@@ -104,6 +106,7 @@ struct paca_struct {
 	 */
 	/* used for most interrupts/exceptions */
 	u64 exgen[EX_SIZE] __attribute__((aligned(0x80)));
+	u64 r14;
 	u64 exslb[EX_SIZE];	/* used for SLB/segment table misses
  				 * on the linear mapping */
 	/* SLB related definitions */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index db8407483c9e..32d393f55a96 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -218,8 +218,9 @@ int main(void)
 	OFFSET(PACACONTEXTSLLP, paca_struct, mm_ctx_sllp);
 #endif /* CONFIG_PPC_MM_SLICES */
 	OFFSET(PACA_EXGEN, paca_struct, exgen);
-	OFFSET(PACA_EXMC, paca_struct, exmc);
+	OFFSET(PACA_R14, paca_struct, r14);
 	OFFSET(PACA_EXSLB, paca_struct, exslb);
+	OFFSET(PACA_EXMC, paca_struct, exmc);
 	OFFSET(PACA_EXNMI, paca_struct, exnmi);
 	OFFSET(PACALPPACAPTR, paca_struct, lppaca_ptr);
 	OFFSET(PACA_SLBSHADOWPTR, paca_struct, slb_shadow_ptr);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b9bf44635b10..592e4b36065f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -37,6 +37,11 @@
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
 #include <asm/export.h>
+#ifdef CONFIG_PPC_BOOK3S
+#include <asm/exception-64s.h>
+#else
+#include <asm/exception-64e.h>
+#endif
 
 /*
  * System calls.
@@ -65,11 +70,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 	addi	r1,r1,-INT_FRAME_SIZE
 	beq-	1f
 	ld	r1,PACAKSAVE(r13)
+#ifdef CONFIG_PPC_BOOK3S
+	ld	r14,PACA_R14(r13)
+#endif
 1:	std	r10,0(r1)
 	std	r11,_NIP(r1)
 	std	r12,_MSR(r1)
 	std	r0,GPR0(r1)
 	std	r10,GPR1(r1)
+#ifdef CONFIG_PPC_BOOK3S
+	ld	r10,PACA_EXGEN+EX_R14(r13)
+	std	r10,GPR14(r1)
+#endif
 	beq	2f			/* if from kernel mode */
 	ACCOUNT_CPU_USER_ENTRY(r13, r10, r11)
 2:	std	r2,GPR2(r1)
@@ -250,6 +262,11 @@ system_call_exit:
 BEGIN_FTR_SECTION
 	stdcx.	r0,0,r1			/* to clear the reservation */
 END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
+	LOAD_REG_IMMEDIATE(r10, 0xdeadbeefULL << 32)
+	mfspr	r11,SPRN_PIR
+	or	r10,r10,r11
+	tdne	r10,r14
+
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
 
@@ -261,6 +278,9 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	ld	r13,GPR13(r1)	/* only restore r13 if returning to usermode */
+#ifdef CONFIG_PPC_BOOK3S
+	ld	r14,GPR14(r1)	/* only restore r14 if returning to usermode */
+#endif
 1:	ld	r2,GPR2(r1)
 	ld	r1,GPR1(r1)
 	mtlr	r4
@@ -874,6 +894,9 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
 	REST_GPR(13, r1)
+#ifdef CONFIG_PPC_BOOK3S
+	REST_GPR(14, r1)
+#endif
 1:
 	mtspr	SPRN_SRR1,r3
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 189c456450e2..ca962bf85b8a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -196,7 +196,7 @@ EXC_REAL_END(machine_check, 0x200, 0x100)
 EXC_VIRT_NONE(0x4200, 0x100)
 TRAMP_REAL_BEGIN(machine_check_powernv_early)
 BEGIN_FTR_SECTION
-	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
+	EXCEPTION_PROLOG_1(PACA_EXMC, EXC_STD, NOTEST, 0x200)
 	/*
 	 * Register contents:
 	 * R13		= PACA
@@ -248,7 +248,7 @@ BEGIN_FTR_SECTION
 	mfspr	r11,SPRN_DSISR		/* Save DSISR */
 	std	r11,_DSISR(r1)
 	std	r9,_CCR(r1)		/* Save CR in stackframe */
-	/* Save r9 through r13 from EXMC save area to stack frame. */
+	/* Save r9 through r14 from EXMC save area to stack frame. */
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
 	mfmsr	r11			/* get MSR value */
 	ori	r11,r11,MSR_ME		/* turn on ME bit */
@@ -278,7 +278,7 @@ machine_check_fwnmi:
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 machine_check_pSeries_0:
-	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
+	EXCEPTION_PROLOG_1(PACA_EXMC, EXC_STD, KVMTEST_PR, 0x200)
 	/*
 	 * MSR_RI is not enabled, because PACA_EXMC is being used, so a
 	 * nested machine check corrupts it. machine_check_common enables
@@ -338,8 +338,7 @@ EXC_COMMON_BEGIN(machine_check_common)
 	lhz	r12,PACA_IN_MCE(r13);			\
 	subi	r12,r12,1;				\
 	sth	r12,PACA_IN_MCE(r13);			\
-	REST_GPR(11, r1);				\
-	REST_2GPRS(12, r1);				\
+	REST_4GPRS(11, r1);				\
 	/* restore original r1. */			\
 	ld	r1,GPR1(r1)
 
@@ -514,7 +513,7 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, EXC_STD, KVMTEST_PR, 0x380)
 	mr	r12,r3	/* save r3 */
 	mfspr	r3,SPRN_DAR
 	mfspr	r11,SPRN_SRR1
@@ -525,7 +524,7 @@ EXC_REAL_END(data_access_slb, 0x380, 0x80)
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, EXC_STD, NOTEST, 0x380)
 	mr	r12,r3	/* save r3 */
 	mfspr	r3,SPRN_DAR
 	mfspr	r11,SPRN_SRR1
@@ -558,7 +557,7 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, EXC_STD, KVMTEST_PR, 0x480)
 	mr	r12,r3	/* save r3 */
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r11,SPRN_SRR1
@@ -569,7 +568,7 @@ EXC_REAL_END(instruction_access_slb, 0x480, 0x80)
 EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
 	SET_SCRATCH0(r13)
 	EXCEPTION_PROLOG_0(PACA_EXSLB)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, EXC_STD, NOTEST, 0x480)
 	mr	r12,r3	/* save r3 */
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r11,SPRN_SRR1
@@ -639,6 +638,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
 	ld	r12,PACA_EXSLB+EX_R12(r13)
+	ld	r14,PACA_EXSLB+EX_R14(r13)
 	ld	r13,PACA_EXSLB+EX_R13(r13)
 	rfid
 	b	.	/* prevent speculative execution */
@@ -806,7 +806,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 #endif
 
 
-EXC_REAL_MASKABLE(decrementer, 0x900, 0x80, IRQ_SOFT_MASK_STD)
+EXC_REAL_OOL_MASKABLE(decrementer, 0x900, 0x80, IRQ_SOFT_MASK_STD)
 EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x80, 0x900, IRQ_SOFT_MASK_STD)
 TRAMP_KVM(PACA_EXGEN, 0x900)
 EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
@@ -907,6 +907,7 @@ EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 	mtspr	SPRN_SRR0,r10 ; 				\
 	ld	r10,PACAKMSR(r13) ;				\
 	mtspr	SPRN_SRR1,r10 ; 				\
+	std	r14,PACA_EXGEN+EX_R14(r13);			\
 	rfid ; 							\
 	b	. ;	/* prevent speculative execution */
 
@@ -942,6 +943,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	mfspr	r12,SPRN_SRR1 ;					\
 	li	r10,MSR_RI ;					\
 	mtmsrd 	r10,1 ;						\
+	std	r14,PACA_EXGEN+EX_R14(r13);			\
 	bctr ;
 #else
 	/* We can branch directly */
@@ -950,6 +952,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	mfspr	r12,SPRN_SRR1 ;					\
 	li	r10,MSR_RI ;					\
 	mtmsrd 	r10,1 ;			/* Set RI (EE=0) */	\
+	std	r14,PACA_EXGEN+EX_R14(r13);			\
 	b	system_call_common ;
 #endif
 
@@ -1035,12 +1038,11 @@ __TRAMP_REAL_OOL_MASKABLE_HV(hmi_exception, 0xe60, IRQ_SOFT_MASK_STD)
 EXC_VIRT_NONE(0x4e60, 0x20)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 TRAMP_REAL_BEGIN(hmi_exception_early)
-	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
+	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_HV, KVMTEST_HV, 0xe60)
 	mr	r10,r1			/* Save r1 */
 	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack for realmode */
 	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
 	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
-	mfspr	r12,SPRN_HSRR1		/* Save HSRR1 */
 	EXCEPTION_PROLOG_COMMON_1()
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
@@ -1236,7 +1238,7 @@ EXC_VIRT_NONE(0x5400, 0x100)
 EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x1500)
+	EXCEPTION_PROLOG_1(PACA_EXGEN, EXC_HV, NOTEST, 0x1500)
 
 #ifdef CONFIG_PPC_DENORMALISATION
 	mfspr	r10,SPRN_HSRR1
@@ -1319,6 +1321,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	ld	r10,PACA_EXGEN+EX_R10(r13)
 	ld	r11,PACA_EXGEN+EX_R11(r13)
 	ld	r12,PACA_EXGEN+EX_R12(r13)
+	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r13,PACA_EXGEN+EX_R13(r13)
 	HRFID
 	b	.
@@ -1364,9 +1367,6 @@ EXC_VIRT_NONE(0x5800, 0x100)
 
 #define MASKED_DEC_HANDLER(_H)				\
 3: /* soft-nmi */					\
-	std	r12,PACA_EXGEN+EX_R12(r13);		\
-	GET_SCRATCH0(r10);				\
-	std	r10,PACA_EXGEN+EX_R13(r13);		\
 	EXCEPTION_PROLOG_PSERIES_1(soft_nmi_common, _H)
 
 /*
@@ -1404,7 +1404,6 @@ EXC_COMMON_BEGIN(soft_nmi_common)
  */
 #define MASKED_INTERRUPT(_H)				\
 masked_##_H##interrupt:					\
-	std	r11,PACA_EXGEN+EX_R11(r13);		\
 	lbz	r11,PACAIRQHAPPENED(r13);		\
 	or	r11,r11,r10;				\
 	stb	r11,PACAIRQHAPPENED(r13);		\
@@ -1416,13 +1415,13 @@ masked_##_H##interrupt:					\
 	b	MASKED_DEC_HANDLER_LABEL;		\
 1:	andi.	r10,r10,(PACA_IRQ_DBELL|PACA_IRQ_HMI);	\
 	bne	2f;					\
-	mfspr	r10,SPRN_##_H##SRR1;			\
-	xori	r10,r10,MSR_EE; /* clear MSR_EE */	\
-	mtspr	SPRN_##_H##SRR1,r10;			\
+	xori	r12,r12,MSR_EE; /* clear MSR_EE */	\
+	mtspr	SPRN_##_H##SRR1,r12;			\
 2:	mtcrf	0x80,r9;				\
 	ld	r9,PACA_EXGEN+EX_R9(r13);		\
 	ld	r10,PACA_EXGEN+EX_R10(r13);		\
 	ld	r11,PACA_EXGEN+EX_R11(r13);		\
+	ld	r12,PACA_EXGEN+EX_R12(r13);		\
 	/* returns to kernel where r13 must be set up, so don't restore it */ \
 	##_H##rfid;					\
 	b	.;					\
@@ -1648,10 +1647,12 @@ bad_stack:
 	SAVE_2GPRS(9,r1)
 	ld	r9,EX_R11(r3)
 	ld	r10,EX_R12(r3)
-	ld	r11,EX_R13(r3)
 	std	r9,GPR11(r1)
 	std	r10,GPR12(r1)
-	std	r11,GPR13(r1)
+	ld	r9,EX_R13(r3)
+	ld	r10,EX_R14(r3)
+	std	r9,GPR13(r1)
+	std	r10,GPR14(r1)
 BEGIN_FTR_SECTION
 	ld	r10,EX_CFAR(r3)
 	std	r10,ORIG_GPR3(r1)
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 87b2c2264118..5a9ec06eab14 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -413,6 +413,11 @@ generic_secondary_common_init:
 	b	kexec_wait		/* next kernel might do better	 */
 
 2:	SET_PACA(r13)
+	LOAD_REG_IMMEDIATE(r14, 0xdeadbeef << 32)
+	mfspr	r3,SPRN_PIR
+	or	r14,r14,r3
+	std	r14,PACA_R14(r13)
+
 #ifdef CONFIG_PPC_BOOK3E
 	addi	r12,r13,PACA_EXTLB	/* and TLB exc frame in another  */
 	mtspr	SPRN_SPRG_TLB_EXFRAME,r12
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 5065c4cb5f12..3b6de0ba4e03 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -195,6 +195,7 @@ pnv_powersave_common:
 
 	/* Continue saving state */
 	SAVE_GPR(2, r1)
+	SAVE_GPR(14, r1) /* XXX: check if we need to save/restore or can rely on PACA_R14 reload */
 	SAVE_NVGPRS(r1)
 	mfcr	r5
 	std	r5,_CCR(r1)
@@ -464,6 +465,7 @@ power9_dd1_recover_paca:
 	/* Load paca->thread_sibling_pacas[i] into r13 */
 	ldx	r13, r4, r5
 	SET_PACA(r13)
+	/* R14 will be restored */
 	/*
 	 * Indicate that we have lost NVGPR state
 	 * which needs to be restored from the stack.
@@ -926,6 +928,7 @@ fastsleep_workaround_at_exit:
 .global pnv_wakeup_loss
 pnv_wakeup_loss:
 	ld	r1,PACAR1(r13)
+	REST_GPR(14, r1)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
@@ -950,6 +953,7 @@ pnv_wakeup_noloss:
 	cmpwi	r0,0
 	bne	pnv_wakeup_loss
 	ld	r1,PACAR1(r13)
+	REST_GPR(14, r1)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index d6597038931d..2491e9cd8d24 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -198,7 +198,6 @@ void setup_paca(struct paca_struct *new_paca)
 		mtspr(SPRN_SPRG_HPACA, local_paca);
 #endif
 	mtspr(SPRN_SPRG_PACA, local_paca);
-
 }
 
 static int __initdata paca_size;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index a4408a7e6f14..9a4c5bf35d92 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -192,6 +192,9 @@ static void __init fixup_boot_paca(void)
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
 	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
+	/* Set r14 and paca_r14 to debug value */
+	get_paca()->r14 = (0xdeadbeefULL << 32) | mfspr(SPRN_PIR);
+	local_r14 = get_paca()->r14;
 }
 
 static void __init configure_exceptions(void)
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 70274b7b4773..b1b8f9f88083 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -3073,6 +3073,7 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
 		regs->gpr[11] = regs->nip + 4;
 		regs->gpr[12] = regs->msr & MSR_MASK;
 		regs->gpr[13] = (unsigned long) get_paca();
+		regs->gpr[14] = local_r14;
 		regs->nip = (unsigned long) &system_call_common;
 		regs->msr = MSR_KERNEL;
 		return 1;
-- 
2.15.0
