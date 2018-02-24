Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zpKBD1hv7zF1lD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 18:15:48 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id f23so6233198plr.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 23:15:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/3] powerpc/64s: micro-optimise __hard_irq_enable() for
 mtmsrd L=1 support
Date: Sat, 24 Feb 2018 17:15:27 +1000
Message-Id: <20180224071527.5053-4-npiggin@gmail.com>
In-Reply-To: <20180224071527.5053-1-npiggin@gmail.com>
References: <20180224071527.5053-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3S minimum supported ISA version now requires mtmsrd L=1. This
instruction does not require bits other than RI and EE to be
supplied, so __hard_irq_enable() and __hard_irq_disable() does not
have to read the kernel_msr from paca.

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
2.16.1
