Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSp434X3zDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:25:48 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSp34SD7z9t1N
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:25:47 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/17] powerpc/irq: Add support for HV virtualization
 interrupts
Date: Mon, 27 Jun 2016 22:25:18 +1000
Message-Id: <1467030333-31435-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This will be delivering external interrupts from the XIVE to the
Hypervisor. We treat it as a normal external interrupt for the
lazy irq disable code (so it will be replayed as a 0x500) and
route it to do_IRQ.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h |  2 ++
 arch/powerpc/include/asm/reg.h           |  1 +
 arch/powerpc/kernel/cpu_setup_power.S    |  2 ++
 arch/powerpc/kernel/exceptions-64s.S     | 19 +++++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 93ae809..c7d2773 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -403,6 +403,8 @@ label##_relon_hv:						\
 #define SOFTEN_VALUE_0xe82	PACA_IRQ_DBELL
 #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
 #define SOFTEN_VALUE_0xe62	PACA_IRQ_HMI
+#define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
+#define SOFTEN_VALUE_0xea2	PACA_IRQ_EE
 
 #define __SOFTEN_TEST(h, vec)						\
 	lbz	r10,PACASOFTIRQEN(r13);					\
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a0948f4..d5aabe1 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -346,6 +346,7 @@
 #define   LPCR_LPES1   0x00000004      /* LPAR Env selector 1 */
 #define   LPCR_LPES_SH	2
 #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
+#define   LPCR_HVICE   0x00000002      /* P9: HV interrupt enable */
 #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
 #define   LPCR_UPRT    0x00400000      /* Use Process Table (ISA 3) */
 #ifndef SPRN_LPID
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 584e119..fd77440 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -94,6 +94,7 @@ _GLOBAL(__setup_cpu_power9)
 	mtspr	SPRN_LPID,r0
 	mfspr	r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
+	ori	r3, r3, LPCR_HVICE
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
@@ -111,6 +112,7 @@ _GLOBAL(__restore_cpu_power9)
 	mtspr	SPRN_LPID,r0
 	mfspr   r3,SPRN_LPCR
 	ori	r3, r3, LPCR_PECEDH
+	ori	r3, r3, LPCR_HVICE
 	bl	__init_LPCR
 	bl	__init_HFSCR
 	bl	__init_tlb_power9
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c94406..5726d84 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -351,6 +351,12 @@ hv_doorbell_trampoline:
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_doorbell_hv
 
+	. = 0xea0
+hv_virt_irq_trampoline:
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	h_virt_irq_hv
+
 	/* We need to deal with the Altivec unavailable exception
 	 * here which is at 0xf20, thus in the middle of the
 	 * prolog code of the PerformanceMonitor one. A little
@@ -601,6 +607,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	MASKABLE_EXCEPTION_HV_OOL(0xe82, h_doorbell)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe82)
 
+	MASKABLE_EXCEPTION_HV_OOL(0xea2, h_virt_irq)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xea2)
+
 	/* moved from 0xf00 */
 	STD_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
 	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf00)
@@ -680,6 +689,8 @@ _GLOBAL(__replay_interrupt)
 BEGIN_FTR_SECTION
 	cmpwi	r3,0xe80
 	beq	h_doorbell_common
+	cmpwi	r3,0xea0
+	beq	h_virt_irq_common
 FTR_SECTION_ELSE
 	cmpwi	r3,0xa00
 	beq	doorbell_super_common
@@ -754,6 +765,7 @@ kvmppc_skip_Hinterrupt:
 #else
 	STD_EXCEPTION_COMMON_ASYNC(0xe80, h_doorbell, unknown_exception)
 #endif
+	STD_EXCEPTION_COMMON_ASYNC(0xea0, h_virt_irq, do_IRQ)
 	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, performance_monitor_exception)
 	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, instruction_breakpoint_exception)
 	STD_EXCEPTION_COMMON(0x1502, denorm, unknown_exception)
@@ -877,6 +889,12 @@ h_doorbell_relon_trampoline:
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_doorbell_relon_hv
 
+	. = 0x4ea0
+h_virt_irq_relon_trampoline:
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	h_virt_irq_relon_hv
+
 	. = 0x4f00
 performance_monitor_relon_pseries_trampoline:
 	SET_SCRATCH0(r13)
@@ -1137,6 +1155,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
 	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
 	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xea0, h_virt_irq)
 
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
-- 
2.7.4
