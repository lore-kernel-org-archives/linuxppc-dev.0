Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsp16MlDzF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 09/16] powerpc/64s: Rename EXCEPTION_RELON_PROLOG_PSERIES_1
Date: Thu, 26 Jul 2018 23:07:10 +1000
Message-Id: <20180726130717.18761-10-mpe@ellerman.id.au>
In-Reply-To: <20180726130717.18761-1-mpe@ellerman.id.au>
References: <20180726130717.18761-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The EXCEPTION_RELON_PROLOG_PSERIES_1() macro does the same job as
EXCEPTION_PROLOG_2 (which we just recently created), except for
"RELON" (relocation on) exceptions.

So rename it as such.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 445134f3a227..3674557d58dc 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -156,7 +156,7 @@
 	b	hrfi_flush_fallback
 
 #ifdef CONFIG_RELOCATABLE
-#define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
+#define __EXCEPTION_PROLOG_2_RELON(label, h)				\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	LOAD_HANDLER(r12,label);					\
 	mtctr	r12;							\
@@ -166,26 +166,26 @@
 	bctr;
 #else
 /* If not relocatable, we can jump directly -- and save messing with LR */
-#define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
+#define __EXCEPTION_PROLOG_2_RELON(label, h)				\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	li	r10,MSR_RI;						\
 	mtmsrd 	r10,1;			/* Set RI (EE=0) */		\
 	b	label;
 #endif
-#define EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
-	__EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
+#define EXCEPTION_PROLOG_2_RELON(label, h)				\
+	__EXCEPTION_PROLOG_2_RELON(label, h)
 
 /*
  * As EXCEPTION_PROLOG_PSERIES(), except we've already got relocation on
  * so no need to rfid.  Save lr in case we're CONFIG_RELOCATABLE, in which
- * case EXCEPTION_RELON_PROLOG_PSERIES_1 will be using lr.
+ * case EXCEPTION_PROLOG_2_RELON will be using LR.
  */
 #define EXCEPTION_RELON_PROLOG_PSERIES(area, label, h, extra, vec)	\
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
+	EXCEPTION_PROLOG_2_RELON(label, h)
 
 /*
  * We're short on space and time in the exception prolog, so we can't
@@ -580,7 +580,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_RELON_EXCEPTION_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, vec);		\
-	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_STD)
+	EXCEPTION_PROLOG_2_RELON(label, EXC_STD)
 
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label,	\
@@ -588,7 +588,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
-	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
+	EXCEPTION_PROLOG_2_RELON(label, EXC_HV)
 
 /* This associate vector numbers with bits in paca->irq_happened */
 #define SOFTEN_VALUE_0x500	PACA_IRQ_EE
@@ -654,7 +654,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
+	EXCEPTION_PROLOG_2_RELON(label, h)
 
 #define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)\
 	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)
@@ -673,7 +673,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
-	EXCEPTION_RELON_PROLOG_PSERIES_1(label, EXC_HV)
+	EXCEPTION_PROLOG_2_RELON(label, EXC_HV)
 
 /*
  * Our exception common code can be passed various "additions"
-- 
2.14.1
