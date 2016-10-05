Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2G1mx8zDrP5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 18/42] powerpc/64s: Consolidate Reserved 0xb00 interrupt
Date: Wed,  5 Oct 2016 11:22:40 +1100
Message-Id: <1475626984-18770-19-git-send-email-mpe@ellerman.id.au>
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
index f73a10aaf54a..54dd9b8aba9a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -859,8 +859,10 @@ EXC_COMMON_ASYNC(doorbell_super_common, 0xa00, unknown_exception)
 
 
 EXC_REAL(trap_0b, 0xb00, 0xc00)
-
+EXC_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
 TRAMP_KVM(PACA_EXGEN, 0xb00)
+EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
+
 
 EXC_REAL_BEGIN(system_call, 0xc00, 0xd00)
 	 /*
@@ -1203,7 +1205,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 EXC_COMMON(single_step_common, 0xd00, single_step_exception)
 EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
 EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
@@ -1239,8 +1240,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
-
 EXC_VIRT_BEGIN(system_call, 0x4c00, 0x4d00)
 	HMT_MEDIUM
 	SYSCALL_PSERIES_1
-- 
2.7.4
