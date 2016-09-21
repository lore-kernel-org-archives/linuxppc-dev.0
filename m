Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBWJ0PdJzDsgl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:47 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id s3so576606pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 32/41] powerpc/64s: consolidate Reserved 0xfa0-0x1200
 interrupts
Date: Wed, 21 Sep 2016 17:43:58 +1000
Message-Id: <20160921074407.4885-33-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5a3db33..fe5cd85 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1127,6 +1127,7 @@ COMMON_HANDLER(h_facility_unavailable_common, 0xf80, facility_unavailable_except
 
 
 VECTOR_HANDLER_REAL_NONE(0xfa0, 0x1200)
+VECTOR_HANDLER_VIRT_NONE(0x4fa0, 0x5200)
 
 
 #ifdef CONFIG_CBE_RAS
@@ -1399,8 +1400,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 	 * come here.
 	 */
 
-VECTOR_HANDLER_VIRT_NONE(0x4fa0, 0x5200)
-
 VECTOR_HANDLER_VIRT_NONE(0x5200, 0x5300)
 
 VECTOR_HANDLER_VIRT(instruction_breakpoint, 0x5300, 0x5400, 0x1300)
-- 
2.9.3
