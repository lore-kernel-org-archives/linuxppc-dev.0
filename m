Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw45f5D82zDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:44:54 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hh10so4713612pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:44:54 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 04/14] powerpc/pseries: move decrementer exception vector out
 of line
Date: Thu, 21 Jul 2016 16:44:03 +1000
Message-Id: <1469083453-9279-5-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation for extending the reach of exception handler loading,
decrementer interrupt has to be moved out of line. The in-line version
is already 0x80 bytes long in worst case, so there is no more room for
instructions.

This is done to make intermediate patch steps build and run. It gets
reverted in a later patch.

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h |  6 ++++++
 arch/powerpc/kernel/exceptions-64s.S     | 11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 93ae809..addc19b 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -438,6 +438,12 @@ label##_pSeries:							\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_STD, SOFTEN_TEST_PR)
 
+#define MASKABLE_EXCEPTION_PSERIES_OOL(vec, label)			\
+	.globl label##_pSeries;						\
+label##_pSeries:							\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_PR, vec);		\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD);
+
 #define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
 	. = loc;							\
 	.globl label##_hv;						\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 18befa5..79eb752 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -279,9 +279,11 @@ hardware_interrupt_hv:
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x800)
 
 	. = 0x900
-	.globl decrementer_pSeries
-decrementer_pSeries:
-	_MASKABLE_EXCEPTION_PSERIES(0x900, decrementer, EXC_STD, SOFTEN_TEST_PR)
+	.globl decrementer_pseries_trampoline
+decrementer_pseries_trampoline:
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	decrementer_pSeries
 
 	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
 
@@ -593,6 +595,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 #endif
 
 	.align	7
+	/* moved from 0x900 */
+	MASKABLE_EXCEPTION_PSERIES_OOL(0x900, decrementer)
+
 	/* moved from 0xe00 */
 	STD_EXCEPTION_HV_OOL(0xe02, h_data_storage)
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0xe02)
-- 
2.8.1
