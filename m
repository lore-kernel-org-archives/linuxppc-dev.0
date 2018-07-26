Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsp01m0PzF0gL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 07/16] powerpc/64s: Rename EXCEPTION_PROLOG_PSERIES_1 to
 EXCEPTION_PROLOG_2
Date: Thu, 26 Jul 2018 23:07:08 +1000
Message-Id: <20180726130717.18761-8-mpe@ellerman.id.au>
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

As with the other patches in this series, we are removing the
"PSERIES" from the name as it's no longer meaningful.

In this case it's not simply a case of removing the "PSERIES" as that
would result in a clash with the existing EXCEPTION_PROLOG_1.

Instead we name this one EXCEPTION_PROLOG_2, as it's usually used in
sequence after 0 and 1.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 20 ++++++++++----------
 arch/powerpc/kernel/exceptions-64s.S     |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 1754b0cc0c2f..82d137778cb1 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -316,7 +316,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_1(area, extra, vec)				\
 	_EXCEPTION_PROLOG_1(area, extra, vec)
 
-#define __EXCEPTION_PROLOG_PSERIES_1(label, h)				\
+#define __EXCEPTION_PROLOG_2(label, h)					\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	LOAD_HANDLER(r12,label)						\
@@ -325,8 +325,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtspr	SPRN_##h##SRR1,r10;					\
 	h##RFI_TO_KERNEL;						\
 	b	.	/* prevent speculative execution */
-#define EXCEPTION_PROLOG_PSERIES_1(label, h)				\
-	__EXCEPTION_PROLOG_PSERIES_1(label, h)
+#define EXCEPTION_PROLOG_2(label, h)					\
+	__EXCEPTION_PROLOG_2(label, h)
 
 /* _NORI variant keeps MSR_RI clear */
 #define __EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)			\
@@ -347,7 +347,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	SET_SCRATCH0(r13);		/* save r13 */			\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
-	EXCEPTION_PROLOG_PSERIES_1(label, h);
+	EXCEPTION_PROLOG_2(label, h);
 
 #define __KVMTEST(h, n)							\
 	lbz	r10,HSTATE_IN_GUEST(r13);				\
@@ -564,7 +564,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_EXCEPTION_OOL(vec, label)				\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
-	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
+	EXCEPTION_PROLOG_2(label, EXC_STD)
 
 #define STD_EXCEPTION_HV(loc, vec, label)			\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label,		\
@@ -572,7 +572,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define STD_EXCEPTION_HV_OOL(vec, label)			\
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, vec);	\
-	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
+	EXCEPTION_PROLOG_2(label, EXC_HV)
 
 #define STD_RELON_EXCEPTION(loc, vec, label)		\
 	/* No guest interrupts come through here */	\
@@ -629,7 +629,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
-	EXCEPTION_PROLOG_PSERIES_1(label, h);
+	EXCEPTION_PROLOG_2(label, h);
 
 #define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)	\
 	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)
@@ -640,7 +640,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD)
+	EXCEPTION_PROLOG_2(label, EXC_STD)
 
 #define MASKABLE_EXCEPTION_HV(loc, vec, label, bitmask)			\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
@@ -648,7 +648,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
-	EXCEPTION_PROLOG_PSERIES_1(label, EXC_HV)
+	EXCEPTION_PROLOG_2(label, EXC_HV)
 
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask) \
 	SET_SCRATCH0(r13);    /* save r13 */				\
@@ -665,7 +665,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define MASKABLE_RELON_EXCEPTION_PSERIES_OOL(vec, label, bitmask)	\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
-	EXCEPTION_PROLOG_PSERIES_1(label, EXC_STD);
+	EXCEPTION_PROLOG_2(label, EXC_STD);
 
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, bitmask)		\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index eef60edc5f7f..d1a189f296f3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1329,7 +1329,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 #endif
 
 	KVMTEST_HV(0x1500)
-	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
+	EXCEPTION_PROLOG_2(denorm_common, EXC_HV)
 EXC_REAL_END(denorm_exception_hv, 0x1500, 0x100)
 
 #ifdef CONFIG_PPC_DENORMALISATION
@@ -1449,7 +1449,7 @@ EXC_VIRT_NONE(0x5800, 0x100)
 	std	r12,PACA_EXGEN+EX_R12(r13);		\
 	GET_SCRATCH0(r10);				\
 	std	r10,PACA_EXGEN+EX_R13(r13);		\
-	EXCEPTION_PROLOG_PSERIES_1(soft_nmi_common, _H)
+	EXCEPTION_PROLOG_2(soft_nmi_common, _H)
 
 /*
  * Branch to soft_nmi_interrupt using the emergency stack. The emergency
-- 
2.14.1
