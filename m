Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMFKJ08VxzDsPn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 22:01:24 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u185so2402323pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 05:01:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 4/4] powerpc: add irq accounting for watchdog interrupts
Date: Tue,  1 Aug 2017 22:00:54 +1000
Message-Id: <20170801120054.3447-5-npiggin@gmail.com>
In-Reply-To: <20170801120054.3447-1-npiggin@gmail.com>
References: <20170801120054.3447-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds an irq counter for the watchdog soft-NMI. This interrupt
only fires when interrupts are soft-disabled, so it will not
increment much even when the watchdog is running. However it's
useful for debugging and sanity checking.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hardirq.h |  3 +++
 arch/powerpc/kernel/irq.c          | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 64b73b03d473..c97603d617e3 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -13,6 +13,9 @@ typedef struct {
 	unsigned int spurious_irqs;
 	unsigned int hmi_exceptions;
 	unsigned int sreset_irqs;
+#ifdef CONFIG_PPC_WATCHDOG
+	unsigned int soft_nmi_irqs;
+#endif
 #ifdef CONFIG_PPC_DOORBELL
 	unsigned int doorbell_irqs;
 #endif
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5c18335580b6..77a7f7514327 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -475,6 +475,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).sreset_irqs);
 	seq_printf(p, "  System Reset interrupts\n");
 
+#ifdef CONFIG_PPC_WATCHDOG
+	seq_printf(p, "%*s: ", prec, "WDG");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).soft_nmi_irqs);
+	seq_printf(p, "  Watchdog soft-NMI interrupts\n");
+#endif
+
 #ifdef CONFIG_PPC_DOORBELL
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		seq_printf(p, "%*s: ", prec, "DBL");
@@ -500,6 +507,9 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 	sum += per_cpu(irq_stat, cpu).timer_irqs_others;
 	sum += per_cpu(irq_stat, cpu).hmi_exceptions;
 	sum += per_cpu(irq_stat, cpu).sreset_irqs;
+#ifdef CONFIG_PPC_WATCHDOG
+	sum += per_cpu(irq_stat, cpu).soft_nmi_irqs;
+#endif
 #ifdef CONFIG_PPC_DOORBELL
 	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
 #endif
-- 
2.11.0
