Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2D5j76zDrP5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 15/42] powerpc/64s: Consolidate Decrementer 0x900 interrupt
Date: Wed,  5 Oct 2016 11:22:37 +1100
Message-Id: <1475626984-18770-16-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ac727633cbb1..01d5af00f2e2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -837,6 +837,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 
 
 EXC_REAL_MASKABLE(decrementer, 0x900, 0x980)
+EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
+TRAMP_KVM(PACA_EXGEN, 0x900)
+EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
+
 
 EXC_REAL_HV(hdecrementer, 0x980, 0xa00)
 
@@ -969,7 +973,6 @@ EXC_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM(PACA_EXGEN, 0x900)
 TRAMP_KVM_HV(PACA_EXGEN, 0x980)
 
 #ifdef CONFIG_PPC_DENORMALISATION
@@ -1190,7 +1193,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 
 /*** Common interrupt handlers ***/
 
-EXC_COMMON_ASYNC(decrementer_common, 0x900, timer_interrupt)
 EXC_COMMON(hdecrementer_common, 0x980, hdec_interrupt)
 
 #ifdef CONFIG_PPC_DOORBELL
@@ -1234,7 +1236,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_MASKABLE(decrementer, 0x4900, 0x4980, 0x900)
 EXC_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
 EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
 EXC_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
-- 
2.7.4
