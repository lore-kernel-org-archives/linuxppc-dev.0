Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2G0NGTzDrPF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 17/42] powerpc/64s: Consolidate Directed Privileged
 Doorbell 0xa00 interrupt
Date: Wed,  5 Oct 2016 11:22:39 +1100
Message-Id: <1475626984-18770-18-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f9fe906feb37..f73a10aaf54a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -849,8 +849,14 @@ EXC_COMMON(hdecrementer_common, 0x980, hdec_interrupt)
 
 
 EXC_REAL_MASKABLE(doorbell_super, 0xa00, 0xb00)
-
+EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
 TRAMP_KVM(PACA_EXGEN, 0xa00)
+#ifdef CONFIG_PPC_DOORBELL
+EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
+#else
+EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
+#endif
+
 
 EXC_REAL(trap_0b, 0xb00, 0xc00)
 
@@ -1197,11 +1203,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-#ifdef CONFIG_PPC_DOORBELL
-EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, doorbell_exception)
-#else
-EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
-#endif
 EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 EXC_COMMON(single_step_common, 0xd00, single_step_exception)
 EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
@@ -1238,7 +1239,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_MASKABLE(doorbell_super, 0x4a00, 0x4b00, 0xa00)
 EXC_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
 
 EXC_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
-- 
2.7.4
