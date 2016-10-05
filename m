Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2H37yHzDrMF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 20/42] powerpc/64s: Consolidate Trace 0xd00 interrupt
Date: Wed,  5 Oct 2016 11:22:42 +1100
Message-Id: <1475626984-18770-21-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 6d4d7800895a..f47c36d605d6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -902,8 +902,9 @@ TRAMP_KVM(PACA_EXGEN, 0xc00)
 
 
 EXC_REAL(single_step, 0xd00, 0xe00)
-
+EXC_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
 TRAMP_KVM(PACA_EXGEN, 0xd00)
+EXC_COMMON(single_step_common, 0xd00, single_step_exception)
 
 
 	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
@@ -1213,7 +1214,6 @@ TRAMP_REAL_BEGIN(kvmppc_skip_Hinterrupt)
 /*** Common interrupt handlers ***/
 
 
-EXC_COMMON(single_step_common, 0xd00, single_step_exception)
 EXC_COMMON(trap_0e_common, 0xe00, unknown_exception)
 EXC_COMMON(emulation_assist_common, 0xe40, emulation_assist_interrupt)
 EXC_COMMON_ASYNC(hmi_exception_common, 0xe60, handle_hmi_exception)
@@ -1248,8 +1248,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT(single_step, 0x4d00, 0x4e00, 0xd00)
-
 EXC_VIRT_BEGIN(unused, 0x4e00, 0x4e20)
 	b       .       /* Can't happen, see v2.07 Book III-S section 6.5 */
 EXC_VIRT_END(unused, 0x4e00, 0x4e20)
-- 
2.7.4
