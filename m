Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2N4HBQzDrLx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 35/42] powerpc/64s: Consolidate Instruction Breakpoint
 0x1300 interrupt
Date: Wed,  5 Oct 2016 11:22:57 +1100
Message-Id: <1475626984-18770-36-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 537d29a6e032..0214c97c117d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1141,8 +1141,10 @@ EXC_REAL_NONE(0x1200, 0x1300)
 
 
 EXC_REAL(instruction_breakpoint, 0x1300, 0x1400)
-
+EXC_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
+EXC_COMMON(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
+
 
 EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
@@ -1374,7 +1376,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-EXC_COMMON(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
 EXC_COMMON_HV(denorm_common, 0x1500, unknown_exception)
 #ifdef CONFIG_ALTIVEC
 EXC_COMMON(altivec_assist_common, 0x1700, altivec_assist_exception)
@@ -1398,8 +1399,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
-
 #ifdef CONFIG_PPC_DENORMALISATION
 EXC_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
 	b	exc_real_0x1500_denorm_exception_hv
-- 
2.7.4
