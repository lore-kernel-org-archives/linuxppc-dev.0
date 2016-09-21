Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBVd1fw4zDsh3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:13 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id oz2so1949011pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/41] powerpc/64s: consolidate Reserved 0xb00 interrupt
Date: Wed, 21 Sep 2016 17:43:43 +1000
Message-Id: <20160921074407.4885-18-npiggin@gmail.com>
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
index 4c4bdda..e614a58 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -856,8 +856,10 @@ COMMON_HANDLER_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
 
 
 VECTOR_HANDLER_REAL(trap_0b, 0xb00, 0xc00)
-
+VECTOR_HANDLER_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
 TRAMP_KVM(PACA_EXGEN, 0xb00)
+COMMON_HANDLER(trap_0b_common, 0xb00, unknown_exception)
+
 
 VECTOR_HANDLER_REAL_BEGIN(system_call, 0xc00, 0xd00)
 	 /*
@@ -1204,7 +1206,6 @@ TRAMP_HANDLER_END(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-COMMON_HANDLER(trap_0b_common, 0xb00, unknown_exception)
 COMMON_HANDLER(single_step_common, 0xd00, single_step_exception)
 COMMON_HANDLER(trap_0e_common, 0xe00, unknown_exception)
 COMMON_HANDLER(emulation_assist_common, 0xe40, emulation_assist_interrupt)
@@ -1243,8 +1244,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
-
 VECTOR_HANDLER_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
 	HMT_MEDIUM
 	SYSCALL_PSERIES_1
-- 
2.9.3
