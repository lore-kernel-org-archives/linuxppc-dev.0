Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9EC572C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:06 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Nov 2012 14:47:52 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAF4dR1H1901052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:39:27 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAF4nxka029727
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:49:59 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/7] powerpc: Add book3s privileged doorbell exception vectors
Date: Thu, 15 Nov 2012 15:49:46 +1100
Message-Id: <1352954990-2858-4-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
References: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Directed Privileged Doorbell Interrupts come in at 0xa00 (or
0xc000000000004a00 if relocation on exception is enabled), so add
exception vectors at these locations.

If doorbell support is not compiled in we handle it as an
unknown_exception.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Tested-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/exception-64s.h |    1 +
 arch/powerpc/kernel/exceptions-64s.S     |    9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 9d5367e..b1edd80 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -305,6 +305,7 @@ label##_relon_hv:					\
 #define SOFTEN_VALUE_0x502	PACA_IRQ_EE
 #define SOFTEN_VALUE_0x900	PACA_IRQ_DEC
 #define SOFTEN_VALUE_0x982	PACA_IRQ_DEC
+#define SOFTEN_VALUE_0xa00	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe80	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe82	PACA_IRQ_DBELL
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d08a3cd..176bf99 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -252,7 +252,7 @@ hardware_interrupt_hv:
 	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
 	STD_EXCEPTION_HV(0x980, 0x982, hdecrementer)
 
-	STD_EXCEPTION_PSERIES(0xa00, 0xa00, trap_0a)
+	MASKABLE_EXCEPTION_PSERIES(0xa00, 0xa00, doorbell_super)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xa00)
 
 	STD_EXCEPTION_PSERIES(0xb00, 0xb00, trap_0b)
@@ -655,7 +655,11 @@ machine_check_common:
 	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
 	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
 	STD_EXCEPTION_COMMON(0x980, hdecrementer, .hdec_interrupt)
-	STD_EXCEPTION_COMMON(0xa00, trap_0a, .unknown_exception)
+#ifdef CONFIG_PPC_DOORBELL
+	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, .doorbell_exception)
+#else
+	STD_EXCEPTION_COMMON_ASYNC(0xa00, doorbell_super, .unknown_exception)
+#endif
 	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
 	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
@@ -755,6 +759,7 @@ hardware_interrupt_relon_hv:
 	STD_RELON_EXCEPTION_PSERIES(0x4800, 0x800, fp_unavailable)
 	MASKABLE_RELON_EXCEPTION_PSERIES(0x4900, 0x900, decrementer)
 	STD_RELON_EXCEPTION_HV(0x4980, 0x982, hdecrementer)
+	MASKABLE_RELON_EXCEPTION_PSERIES(0x4a00, 0xa00, doorbell_super)
 	STD_RELON_EXCEPTION_PSERIES(0x4b00, 0xb00, trap_0b)
 
 	. = 0x4c00
-- 
1.7.10.4
