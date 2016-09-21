Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVK3l7gzDshH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:57 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id s3so575629pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/41] powerpc/64s: consolidate External 0x500 interrupt
Date: Wed, 21 Sep 2016 17:43:36 +1000
Message-Id: <20160921074407.4885-11-npiggin@gmail.com>
In-Reply-To: <20160921074407.4885-1-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0320b60..fc5ad5c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -752,6 +752,19 @@ do_kvm_0x500:
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 VECTOR_HANDLER_REAL_END(hardware_interrupt, 0x500, 0x600)
 
+VECTOR_HANDLER_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
+	.globl hardware_interrupt_relon_hv;
+hardware_interrupt_relon_hv:
+	BEGIN_FTR_SECTION
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
+	FTR_SECTION_ELSE
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, FIXED_SECTION_REL_ADDR(text, hardware_interrupt_common), EXC_STD, SOFTEN_TEST_PR)
+	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
+VECTOR_HANDLER_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
+
+COMMON_HANDLER_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
+
+
 VECTOR_HANDLER_REAL(alignment, 0x600, 0x700)
 
 TRAMP_KVM(PACA_EXGEN, 0x600)
@@ -1122,7 +1135,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 
 /*** Common interrupt handlers ***/
 
-COMMON_HANDLER_ASYNC(hardware_interrupt_common, 0x500, do_IRQ)
 COMMON_HANDLER_ASYNC(decrementer_common, 0x900, timer_interrupt)
 COMMON_HANDLER(hdecrementer_common, 0x980, hdec_interrupt)
 
@@ -1170,16 +1182,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT_BEGIN(hardware_interrupt, 0x4500, 0x4600)
-	.globl hardware_interrupt_relon_hv;
-hardware_interrupt_relon_hv:
-	BEGIN_FTR_SECTION
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
-	FTR_SECTION_ELSE
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, FIXED_SECTION_REL_ADDR(text, hardware_interrupt_common), EXC_STD, SOFTEN_TEST_PR)
-	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
-VECTOR_HANDLER_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
-
 VECTOR_HANDLER_VIRT(alignment, 0x4600, 0x4700, 0x600)
 VECTOR_HANDLER_VIRT(program_check, 0x4700, 0x4800, 0x700)
 VECTOR_HANDLER_VIRT(fp_unavailable, 0x4800, 0x4900, 0x800)
-- 
2.9.3
