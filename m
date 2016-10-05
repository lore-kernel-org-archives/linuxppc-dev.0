Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2M6KdzzDrMn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 33/42] powerpc/64s: Consolidate Reserved 0xfa0-0x1200
 interrupts
Date: Wed,  5 Oct 2016 11:22:55 +1100
Message-Id: <1475626984-18770-34-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d88024384bc6..34d439018ddd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1128,6 +1128,7 @@ EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
 
 
 EXC_REAL_NONE(0xfa0, 0x1200)
+EXC_VIRT_NONE(0x4fa0, 0x5200)
 
 #ifdef CONFIG_CBE_RAS
 EXC_REAL_HV(cbe_system_error, 0x1200, 0x1300)
@@ -1396,8 +1397,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_NONE(0x4fa0, 0x5200)
-
 EXC_VIRT_NONE(0x5200, 0x5300)
 
 EXC_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
-- 
2.7.4
