Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsp86H8gzF0fW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 14/16] powerpc/64s: Remove PSERIES naming from the MASKABLE
 macros
Date: Thu, 26 Jul 2018 23:07:15 +1000
Message-Id: <20180726130717.18761-15-mpe@ellerman.id.au>
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

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 24 ++++++++++--------------
 arch/powerpc/include/asm/head-64.h       |  8 ++++----
 arch/powerpc/kernel/exceptions-64s.S     |  8 ++++----
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 020f78995a3d..75af99251501 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -622,45 +622,41 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define SOFTEN_NOTEST_PR(vec, bitmask)	_SOFTEN_TEST(EXC_STD, vec, bitmask)
 #define SOFTEN_NOTEST_HV(vec, bitmask)	_SOFTEN_TEST(EXC_HV, vec, bitmask)
 
-#define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)	\
+#define __MASKABLE_EXCEPTION(vec, label, h, extra, bitmask)		\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
 	EXCEPTION_PROLOG_2(label, h);
 
-#define MASKABLE_EXCEPTION_PSERIES(loc, vec, label, bitmask)		\
-	__MASKABLE_EXCEPTION_PSERIES(vec, label,			\
-				     EXC_STD, SOFTEN_TEST_PR, bitmask)
+#define MASKABLE_EXCEPTION(loc, vec, label, bitmask)			\
+	__MASKABLE_EXCEPTION(vec, label, EXC_STD, SOFTEN_TEST_PR, bitmask)
 
-#define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label, bitmask)		\
+#define MASKABLE_EXCEPTION_OOL(vec, label, bitmask)			\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec, bitmask);\
 	EXCEPTION_PROLOG_2(label, EXC_STD)
 
 #define MASKABLE_EXCEPTION_HV(loc, vec, label, bitmask)			\
-	__MASKABLE_EXCEPTION_PSERIES(vec, label,			\
-				     EXC_HV, SOFTEN_TEST_HV, bitmask)
+	__MASKABLE_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_EXCEPTION_HV_OOL(vec, label, bitmask)			\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
 	EXCEPTION_PROLOG_2(label, EXC_HV)
 
-#define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask) \
+#define __MASKABLE_RELON_EXCEPTION(vec, label, h, extra, bitmask)	\
 	SET_SCRATCH0(r13);    /* save r13 */				\
 	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
 	EXCEPTION_PROLOG_2_RELON(label, h)
 
-#define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label, bitmask)	\
-	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					   EXC_STD, SOFTEN_NOTEST_PR, bitmask)
+#define MASKABLE_RELON_EXCEPTION(loc, vec, label, bitmask)		\
+	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
-#define MASKABLE_RELON_EXCEPTION_PSERIES_OOL(vec, label, bitmask)	\
+#define MASKABLE_RELON_EXCEPTION_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
 	EXCEPTION_PROLOG_2(label, EXC_STD);
 
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, bitmask)		\
-	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					   EXC_HV, SOFTEN_TEST_HV, bitmask)
+	__MASKABLE_RELON_EXCEPTION(vec, label, EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 640d354a3ab3..5678f82cf355 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -270,12 +270,12 @@ end_##sname:
 
 #define EXC_REAL_MASKABLE(name, start, size, bitmask)			\
 	EXC_REAL_BEGIN(name, start, size);				\
-	MASKABLE_EXCEPTION_PSERIES(start, start, name##_common, bitmask);\
+	MASKABLE_EXCEPTION(start, start, name##_common, bitmask);	\
 	EXC_REAL_END(name, start, size);
 
 #define EXC_VIRT_MASKABLE(name, start, size, realvec, bitmask)		\
 	EXC_VIRT_BEGIN(name, start, size);				\
-	MASKABLE_RELON_EXCEPTION_PSERIES(start, realvec, name##_common, bitmask);\
+	MASKABLE_RELON_EXCEPTION(start, realvec, name##_common, bitmask);\
 	EXC_VIRT_END(name, start, size);
 
 #define EXC_REAL_HV(name, start, size)					\
@@ -306,7 +306,7 @@ end_##sname:
 
 #define __TRAMP_REAL_OOL_MASKABLE(name, vec, bitmask)			\
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
-	MASKABLE_EXCEPTION_PSERIES_OOL(vec, name##_common, bitmask);	\
+	MASKABLE_EXCEPTION_OOL(vec, name##_common, bitmask);
 
 #define EXC_REAL_OOL_MASKABLE(name, start, size, bitmask)		\
 	__EXC_REAL_OOL_MASKABLE(name, start, size);			\
@@ -357,7 +357,7 @@ end_##sname:
 
 #define __TRAMP_VIRT_OOL_MASKABLE(name, realvec, bitmask)		\
 	TRAMP_VIRT_BEGIN(tramp_virt_##name);				\
-	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common, bitmask);\
+	MASKABLE_RELON_EXCEPTION_OOL(realvec, name##_common, bitmask);
 
 #define EXC_VIRT_OOL_MASKABLE(name, start, size, realvec, bitmask)	\
 	__EXC_VIRT_OOL_MASKABLE(name, start, size);			\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0787814e309b..54abb72a5ae1 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -770,11 +770,11 @@ EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x100)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
-		__MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+		__MASKABLE_EXCEPTION(0x500, hardware_interrupt_common,
 					    EXC_HV, SOFTEN_TEST_HV,
 					    IRQS_DISABLED)
 	FTR_SECTION_ELSE
-		__MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+		__MASKABLE_EXCEPTION(0x500, hardware_interrupt_common,
 					    EXC_STD, SOFTEN_TEST_PR,
 					    IRQS_DISABLED)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
@@ -784,11 +784,11 @@ EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
 	.globl hardware_interrupt_relon_hv;
 hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
-		__MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+		__MASKABLE_RELON_EXCEPTION(0x500, hardware_interrupt_common,
 						  EXC_HV, SOFTEN_TEST_HV,
 						  IRQS_DISABLED)
 	FTR_SECTION_ELSE
-		__MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+		__MASKABLE_RELON_EXCEPTION(0x500, hardware_interrupt_common,
 						  EXC_STD, SOFTEN_TEST_PR,
 						  IRQS_DISABLED)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-- 
2.14.1
