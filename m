Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVX5L2BzDsgq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:08 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id my20so1945192pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/41] powerpc/64s: consolidate Hypervisor Decrementer 0x980
 interrupt
Date: Wed, 21 Sep 2016 17:43:41 +1000
Message-Id: <20160921074407.4885-16-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 12ea301..c18f48e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -840,6 +840,10 @@ COMMON_HANDLER_ASYNC(decrementer_common, 0x900, timer_interrupt)
 
 
 VECTOR_HANDLER_REAL_HV(hdecrementer, 0x980, 0xa00)
+VECTOR_HANDLER_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
+TRAMP_KVM_HV(PACA_EXGEN, 0x980)
+COMMON_HANDLER(hdecrementer_common, 0x980, hdec_interrupt)
+
 
 VECTOR_HANDLER_REAL_MASKABLE(doorbell_super, 0xa00, 0xb00)
 
@@ -971,7 +975,6 @@ VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
 /*** Out of line interrupts support ***/
 
 	/* moved from 0x200 */
-TRAMP_KVM_HV(PACA_EXGEN, 0x980)
 
 #ifdef CONFIG_PPC_DENORMALISATION
 TRAMP_HANDLER_BEGIN(denorm_assist)
@@ -1194,7 +1197,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 
 /*** Common interrupt handlers ***/
 
-COMMON_HANDLER(hdecrementer_common, 0x980, hdec_interrupt)
 
 #ifdef CONFIG_PPC_DOORBELL
 COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
@@ -1240,7 +1242,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT_HV(hdecrementer, 0x4980, 0x4a00, 0x980)
 VECTOR_HANDLER_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
 VECTOR_HANDLER_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
 
-- 
2.9.3
