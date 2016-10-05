Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2N326GzDrMq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 34/42] powerpc/64s: Consolidate CBE System Error 0x1200
 interrupt
Date: Wed,  5 Oct 2016 11:22:56 +1100
Message-Id: <1475626984-18770-35-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/kernel/exceptions-64s.S | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 34d439018ddd..537d29a6e032 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1132,13 +1132,14 @@ EXC_VIRT_NONE(0x4fa0, 0x5200)
 
 #ifdef CONFIG_CBE_RAS
 EXC_REAL_HV(cbe_system_error, 0x1200, 0x1300)
-
+EXC_VIRT_NONE(0x5200, 0x5300)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1200)
-
+EXC_COMMON(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 #else /* CONFIG_CBE_RAS */
 EXC_REAL_NONE(0x1200, 0x1300)
 #endif
 
+
 EXC_REAL(instruction_breakpoint, 0x1300, 0x1400)
 
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
@@ -1397,8 +1398,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_NONE(0x5200, 0x5300)
-
 EXC_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
 
 #ifdef CONFIG_PPC_DENORMALISATION
@@ -1433,7 +1432,6 @@ __end_interrupts:
 DEFINE_FIXED_SYMBOL(__end_interrupts)
 
 #ifdef CONFIG_CBE_RAS
-EXC_COMMON(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 EXC_COMMON(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
-- 
2.7.4
