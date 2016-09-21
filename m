Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWS3pMVzDshP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:56 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id 21so2039060pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 36/41] powerpc/64s: consolidate Debug 0x1600 interrupt
Date: Wed, 21 Sep 2016 17:44:02 +1000
Message-Id: <20160921074407.4885-37-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3172724..3328425 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1243,13 +1243,14 @@ COMMON_HANDLER_HV(denorm_common, 0x1500, unknown_exception)
 
 #ifdef CONFIG_CBE_RAS
 VECTOR_HANDLER_REAL_HV(cbe_maintenance, 0x1600, 0x1700)
-
+VECTOR_HANDLER_VIRT_NONE(0x5600, 0x5700)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1600)
-
+COMMON_HANDLER(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1600, 0x1700)
 #endif
 
+
 VECTOR_HANDLER_REAL(altivec_assist, 0x1700, 0x1800)
 
 TRAMP_KVM(PACA_EXGEN, 0x1700)
@@ -1413,8 +1414,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 */
 
 
-VECTOR_HANDLER_VIRT_NONE(0x5600, 0x5700)
-
 VECTOR_HANDLER_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
 
 VECTOR_HANDLER_VIRT_NONE(0x5800, 0x5900)
@@ -1438,7 +1437,6 @@ __end_interrupts:
 UNUSE_FIXED_SECTION(virt_trampolines)
 
 #ifdef CONFIG_CBE_RAS
-COMMON_HANDLER(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 COMMON_HANDLER(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
-- 
2.9.3
