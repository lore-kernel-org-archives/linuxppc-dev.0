Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2C33ZlzDrM1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 11/42] powerpc/64s: Consolidate External 0x500 interrupt
Date: Wed,  5 Oct 2016 11:22:33 +1100
Message-Id: <1475626984-18770-12-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d084b0efd287..270a02b71b96 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -758,6 +758,19 @@ do_kvm_0x500:
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 EXC_REAL_END(hardware_interrupt, 0x500, 0x600)
 
+EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
+	.globl hardware_interrupt_relon_hv;
+hardware_interrupt_relon_hv:
+	BEGIN_FTR_SECTION
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
+	FTR_SECTION_ELSE
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
+	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+EXC_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
+
+EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
+
+
 EXC_REAL(alignment, 0x600, 0x700)
 
 TRAMP_KVM(PACA_EXGEN, 0x600)
@@ -1124,7 +1137,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 
 /*** Common interrupt handlers ***/
 
-EXC_COMMON_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
 EXC_COMMON(hdecrementer_common, 0x980, hdec_interrupt)
 
@@ -1169,16 +1181,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
-	.globl hardware_interrupt_relon_hv;
-hardware_interrupt_relon_hv:
-	BEGIN_FTR_SECTION
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
-	FTR_SECTION_ELSE
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
-	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-EXC_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
-
 EXC_VIRT(alignment, 0x4600, 0x4700, 0x600)
 EXC_VIRT(program_check, 0x4700, 0x4800, 0x700)
 EXC_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
-- 
2.7.4
