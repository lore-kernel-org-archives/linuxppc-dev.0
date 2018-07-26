Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bspB4Yk1zF0fW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 23:07:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	anton@samba.org,
	paulus@samba.org
Subject: [PATCH 16/16] powerpc/64s: Don't use __MASKABLE_EXCEPTION
 unnecessarily
Date: Thu, 26 Jul 2018 23:07:17 +1000
Message-Id: <20180726130717.18761-17-mpe@ellerman.id.au>
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

We only need to use __MASKABLE_EXCEPTION in one of the four cases for
hardware interrupt, so use the helper macros in the other cases.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 54abb72a5ae1..8e1396433eb4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -770,13 +770,9 @@ EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x100)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
-		__MASKABLE_EXCEPTION(0x500, hardware_interrupt_common,
-					    EXC_HV, SOFTEN_TEST_HV,
-					    IRQS_DISABLED)
+		MASKABLE_EXCEPTION_HV(0x500, hardware_interrupt_common, IRQS_DISABLED)
 	FTR_SECTION_ELSE
-		__MASKABLE_EXCEPTION(0x500, hardware_interrupt_common,
-					    EXC_STD, SOFTEN_TEST_PR,
-					    IRQS_DISABLED)
+		MASKABLE_EXCEPTION(0x500, hardware_interrupt_common, IRQS_DISABLED)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 EXC_REAL_END(hardware_interrupt, 0x500, 0x100)
 
@@ -784,13 +780,11 @@ EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x100)
 	.globl hardware_interrupt_relon_hv;
 hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
-		__MASKABLE_RELON_EXCEPTION(0x500, hardware_interrupt_common,
-						  EXC_HV, SOFTEN_TEST_HV,
-						  IRQS_DISABLED)
+		MASKABLE_RELON_EXCEPTION_HV(0x500, hardware_interrupt_common,
+					    IRQS_DISABLED)
 	FTR_SECTION_ELSE
 		__MASKABLE_RELON_EXCEPTION(0x500, hardware_interrupt_common,
-						  EXC_STD, SOFTEN_TEST_PR,
-						  IRQS_DISABLED)
+					   EXC_STD, SOFTEN_TEST_PR, IRQS_DISABLED)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 EXC_VIRT_END(hardware_interrupt, 0x4500, 0x100)
 
-- 
2.14.1
