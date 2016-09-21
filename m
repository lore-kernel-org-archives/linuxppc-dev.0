Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBW13zjwzDsh8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:45:33 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id s3so576341pay.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:45:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 26/41] powerpc/64s: consolidate Reserved 0xec0,
 0xee0 interrupts
Date: Wed, 21 Sep 2016 17:43:52 +1000
Message-Id: <20160921074407.4885-27-npiggin@gmail.com>
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
 arch/powerpc/kernel/exceptions-64s.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7b76b79..f052fee 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1020,6 +1020,8 @@ COMMON_HANDLER_ASYNC(h_virt_irq_common, 0xea0, do_IRQ)
 
 
 VECTOR_HANDLER_REAL_NONE(0xec0, 0xf00)
+VECTOR_HANDLER_VIRT_NONE(0x4ec0, 0x4f00)
+
 
 __VECTOR_HANDLER_REAL_OOL(performance_monitor, 0xf00, 0xf20)
 
@@ -1327,7 +1329,6 @@ COMMON_HANDLER(altivec_assist_common, 0x1700, unknown_exception)
 
 
 
-VECTOR_HANDLER_VIRT_NONE(0x4ec0, 0x4f00)
 
 __VECTOR_HANDLER_VIRT_OOL(performance_monitor, 0x4f00, 0x4f20)
 
-- 
2.9.3
