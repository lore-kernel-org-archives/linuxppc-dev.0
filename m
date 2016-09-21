Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWM5h55zDsgg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:51 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id 21so2038983pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 34/41] powerpc/64s: consolidate Instruction Breakpoint 0x1300
 interrupt
Date: Wed, 21 Sep 2016 17:44:00 +1000
Message-Id: <20160921074407.4885-35-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 64255bc..3e5f566 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1141,8 +1141,10 @@ VECTOR_HANDLER_REAL_NONE(0x1200, 0x1300)
 
 
 VECTOR_HANDLER_REAL(instruction_breakpoint, 0x1300, 0x1400)
-
+VECTOR_HANDLER_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
+COMMON_HANDLER(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
+
 
 VECTOR_HANDLER_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x1600)
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
@@ -1377,7 +1379,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-COMMON_HANDLER(instruction_breakpoint_common, 0x1300, instruction_breakpoint_exception)
 COMMON_HANDLER_HV(denorm_common, 0x1500, unknown_exception)
 #ifdef CONFIG_ALTIVEC
 COMMON_HANDLER(altivec_assist_common, 0x1700, altivec_assist_exception)
@@ -1402,8 +1403,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 */
 
 
-VECTOR_HANDLER_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
-
 #ifdef CONFIG_PPC_DENORMALISATION
 VECTOR_HANDLER_VIRT_BEGIN(denorm_exception, 0x5500, 0x5600)
 	b	exc_0x1500_denorm_exception_hv
-- 
2.9.3
