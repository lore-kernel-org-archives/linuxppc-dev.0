Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKY3HYvzDqlR
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:20:01 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id m21-v6so15863055pgv.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:20:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 04/11] powerpc/64s: micro-optimise __hard_irq_enable() for
 mtmsrd L=1 support
Date: Sat,  5 May 2018 03:19:28 +1000
Message-Id: <20180504171935.25410-5-npiggin@gmail.com>
In-Reply-To: <20180504171935.25410-1-npiggin@gmail.com>
References: <20180504171935.25410-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3S minimum supported ISA version now requires mtmsrd L=1. This
instruction does not require bits other than RI and EE to be supplied,
so __hard_irq_enable() and __hard_irq_disable() does not have to read
the kernel_msr from paca.

Interrupt entry code already relies on L=1 support.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hw_irq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 8004d7887ff6..fbc2d83808aa 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -228,8 +228,8 @@ static inline bool arch_irqs_disabled(void)
 #define __hard_irq_enable()	asm volatile("wrteei 1" : : : "memory")
 #define __hard_irq_disable()	asm volatile("wrteei 0" : : : "memory")
 #else
-#define __hard_irq_enable()	__mtmsrd(local_paca->kernel_msr | MSR_EE, 1)
-#define __hard_irq_disable()	__mtmsrd(local_paca->kernel_msr, 1)
+#define __hard_irq_enable()	__mtmsrd(MSR_EE|MSR_RI, 1)
+#define __hard_irq_disable()	__mtmsrd(MSR_RI, 1)
 #endif
 
 #define hard_irq_disable()	do {					\
-- 
2.17.0
