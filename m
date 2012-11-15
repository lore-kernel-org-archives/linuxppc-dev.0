Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B896B2C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:07 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Nov 2012 14:47:32 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAF4o0TE58392748
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:00 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAF4nxXU017298
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:00 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/7] powerpc: Add book3s hypervisor doorbell exception vectors
Date: Thu, 15 Nov 2012 15:49:45 +1100
Message-Id: <1352954990-2858-3-git-send-email-imunsie@au1.ibm.com>
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

Directed Hypervisor Doorbell Interrupts come in at 0xe80 (or
0xc000000000004e80 if relocation on exceptions is enabled), so add
exception vectors at these locations.

If doorbell support is not compiled in we handle it as an
unknown_exception.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Tested-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/exception-64s.h |    2 ++
 arch/powerpc/kernel/exceptions-64s.S     |   16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index ad708dd..9d5367e 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -305,6 +305,8 @@ label##_relon_hv:					\
 #define SOFTEN_VALUE_0x502	PACA_IRQ_EE
 #define SOFTEN_VALUE_0x900	PACA_IRQ_DEC
 #define SOFTEN_VALUE_0x982	PACA_IRQ_DEC
+#define SOFTEN_VALUE_0xe80	PACA_IRQ_DBELL
+#define SOFTEN_VALUE_0xe82	PACA_IRQ_DBELL
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4665e82..d08a3cd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -293,6 +293,8 @@ hv_exception_trampoline:
 	b	hmi_exception_hv
 	. = 0xe60
 	b	hmi_exception_hv
+	. = 0xe80
+	b	h_doorbell_hv
 
 	/* We need to deal with the Altivec unavailable exception
 	 * here which is at 0xf20, thus in the middle of the
@@ -514,6 +516,8 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe42)
 	STD_EXCEPTION_HV(., 0xe62, hmi_exception) /* need to flush cache ? */
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe62)
+	MASKABLE_EXCEPTION_HV(., 0xe82, h_doorbell)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe82)
 
 	/* moved from 0xf00 */
 	STD_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
@@ -657,6 +661,11 @@ machine_check_common:
 	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xe40, emulation_assist, .program_check_exception)
 	STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
+#ifdef CONFIG_PPC_DOORBELL
+	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, .doorbell_exception)
+#else
+	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, .unknown_exception)
+#endif
 	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, .performance_monitor_exception)
 	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
 	STD_EXCEPTION_COMMON(0x1502, denorm, .unknown_exception)
@@ -773,9 +782,8 @@ system_call_relon_pSeries:
 	. = 0x4e60
 	b	hmi_exception_relon_hv
 
-	/* For when we support the doorbell interrupt:
-	STD_RELON_EXCEPTION_HYPERVISOR(0x4e80, 0xe80, doorbell_hyper)
-	*/
+	. = 0x4e80
+	b	h_doorbell_relon_hv
 
 performance_monitor_relon_pSeries_1:
 	. = 0x4f00
@@ -1355,6 +1363,8 @@ _GLOBAL(do_stab_bolted)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe40)
 	STD_RELON_EXCEPTION_HV(., 0xe60, hmi_exception)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe60)
+	MASKABLE_RELON_EXCEPTION_HV(., 0xe80, h_doorbell)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe80)
 
 	STD_RELON_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
 	STD_RELON_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
-- 
1.7.10.4
