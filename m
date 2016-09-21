Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVb5HBMzDsgh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:11 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id q2so2030144pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/41] powerpc/64s: consolidate Directed Privileged Doorbell
 0xa00 interrupt
Date: Wed, 21 Sep 2016 17:43:42 +1000
Message-Id: <20160921074407.4885-17-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index c18f48e..4c4bdda 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -846,8 +846,14 @@ COMMON_HANDLER(hdecrementer_common, 0x980, hdec_interrupt)
 
 
 VECTOR_HANDLER_REAL_MASKABLE(doorbell_super, 0xa00, 0xb00)
-
+VECTOR_HANDLER_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
 TRAMP_KVM(PACA_EXGEN, 0xa00)
+#ifdef CONFIG_PPC_DOORBELL
+COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
+#else
+COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
+#endif
+
 
 VECTOR_HANDLER_REAL(trap_0b, 0xb00, 0xc00)
 
@@ -1198,11 +1204,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-#ifdef CONFIG_PPC_DOORBELL
-COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
-#else
-COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
-#endif
 COMMON_HANDLER(trap_0b_common, 0xb00, unknown_exception)
 COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
@@ -1242,7 +1243,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
 VECTOR_HANDLER_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
 
 VECTOR_HANDLER_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
-- 
2.9.3
