Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWK47KTzDsh1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:49 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id my20so1946043pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:49 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 33/41] powerpc/64s: consolidate CBE System Error 0x1200
 interrupt
Date: Wed, 21 Sep 2016 17:43:59 +1000
Message-Id: <20160921074407.4885-34-npiggin@gmail.com>
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
index fe5cd85..64255bc 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1132,13 +1132,14 @@ VECTOR_HANDLER_VIRT_NONE(0x4fa0, 0x5200)
 
 #ifdef CONFIG_CBE_RAS
 VECTOR_HANDLER_REAL_HV(cbe_system_error, 0x1200, 0x1300)
-
+VECTOR_HANDLER_VIRT_NONE(0x5200, 0x5300)
 TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1200)
-
+COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1200, 0x1300)
 #endif
 
+
 VECTOR_HANDLER_REAL(instruction_breakpoint, 0x1300, 0x1400)
 
 TRAMP_KVM_SKIP(PACA_EXGEN, 0x1300)
@@ -1400,7 +1401,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-VECTOR_HANDLER_VIRT_NONE(0x5200, 0x5300)
 
 VECTOR_HANDLER_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
 
@@ -1437,7 +1437,6 @@ __end_interrupts:
 UNUSE_FIXED_SECTION(virt_trampolines)
 
 #ifdef CONFIG_CBE_RAS
-COMMON_HANDLER(cbe_system_error_common, 0x1200, cbe_system_error_exception)
 COMMON_HANDLER(cbe_maintenance_common, 0x1600, cbe_maintenance_exception)
 COMMON_HANDLER(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
-- 
2.9.3
