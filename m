Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bsp56X9JzF0hg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 13/16] powerpc/64s: Drop _MASKABLE_RELON_EXCEPTION_PSERIES()
Date: Thu, 26 Jul 2018 23:07:14 +1000
Message-Id: <20180726130717.18761-14-mpe@ellerman.id.au>
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

_MASKABLE_RELON_EXCEPTION_PSERIES() does nothing useful, update all
callers to use __MASKABLE_RELON_EXCEPTION_PSERIES() directly.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 11 ++++-------
 arch/powerpc/kernel/exceptions-64s.S     |  4 ++--
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 70c3810c6476..020f78995a3d 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -650,20 +650,17 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec, bitmask);	\
 	EXCEPTION_PROLOG_2_RELON(label, h)
 
-#define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)\
-	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra, bitmask)
-
 #define MASKABLE_RELON_EXCEPTION_PSERIES(loc, vec, label, bitmask)	\
-	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					  EXC_STD, SOFTEN_NOTEST_PR, bitmask)
+	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
+					   EXC_STD, SOFTEN_NOTEST_PR, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_PSERIES_OOL(vec, label, bitmask)	\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_PR, vec, bitmask);\
 	EXCEPTION_PROLOG_2(label, EXC_STD);
 
 #define MASKABLE_RELON_EXCEPTION_HV(loc, vec, label, bitmask)		\
-	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
-					  EXC_HV, SOFTEN_TEST_HV, bitmask)
+	__MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
+					   EXC_HV, SOFTEN_TEST_HV, bitmask)
 
 #define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label, bitmask)		\
 	MASKABLE_EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec, bitmask);\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 67be3e72c7d1..0787814e309b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -784,11 +784,11 @@ EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
 	.globl hardware_interrupt_relon_hv;
 hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+		__MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
 						  EXC_HV, SOFTEN_TEST_HV,
 						  IRQS_DISABLED)
 	FTR_SECTION_ELSE
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+		__MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
 						  EXC_STD, SOFTEN_TEST_PR,
 						  IRQS_DISABLED)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-- 
2.14.1
