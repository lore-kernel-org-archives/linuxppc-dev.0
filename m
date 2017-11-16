Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd5ZX5jtNzDqyR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:01:08 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 4so11988653pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 08:01:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/4] powerpc: define __ARCH_IRQ_EXIT_IRQS_DISABLED
Date: Fri, 17 Nov 2017 02:00:49 +1000
Message-Id: <20171116160052.18672-2-npiggin@gmail.com>
In-Reply-To: <20171116160052.18672-1-npiggin@gmail.com>
References: <20171116160052.18672-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc calls irq_exit() with local irqs disabled, therefore it
can define __ARCH_IRQ_EXIT_IRQS_DISABLED.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hardirq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 456f9e7b8d83..5986d473722b 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -29,6 +29,7 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 #define local_softirq_pending()	__this_cpu_read(irq_stat.__softirq_pending)
 
 #define __ARCH_SET_SOFTIRQ_PENDING
+#define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
 #define set_softirq_pending(x) __this_cpu_write(irq_stat.__softirq_pending, (x))
 #define or_softirq_pending(x) __this_cpu_or(irq_stat.__softirq_pending, (x))
-- 
2.15.0
