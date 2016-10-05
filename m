Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc2P1rMWzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 37/42] powerpc/64s: Consolidate Debug 0x1600 interrupt
Date: Wed,  5 Oct 2016 11:22:59 +1100
Message-Id: <1475626984-18770-38-git-send-email-mpe@ellerman.id.au>
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
index 04d25c76adee..40da203d4a07 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1242,13 +1242,14 @@ EXC_COMMON_HV(denorm_common, 0x1500, unknown_exception)
 
 #ifdef CONFIG_CBE_RAS
 EXC_REAL_HV(cbe_maintenance, 0x1600, 0x1700)
-
+EXC_VIRT_NONE(0x5600, 0x5700)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
-
+EXC_COMMON(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 #else /* CONFIG_CBE_RAS */
 EXC_REAL_NONE(0x1600, 0x1700)
 #endif
 
+
 EXC_REAL(altivec_assist, 0x1700, 0x1800)
 
 TRAMP_KVM(PACA_EXGEN, 0x1700)
@@ -1409,8 +1410,6 @@ EXC_COMMON(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-EXC_VIRT_NONE(0x5600, 0x5700)
-
 EXC_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
 
 EXC_VIRT_NONE(0x5800, 0x5900)
@@ -1433,7 +1432,6 @@ __end_interrupts:
 DEFINE_FIXED_SYMBOL(__end_interrupts)
 
 #ifdef CONFIG_CBE_RAS
-EXC_COMMON(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
-- 
2.7.4
