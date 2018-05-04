Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKy2bFwzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:20:22 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id v63so17919551pfk.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:20:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 11/11] powerpc/time: account broadcast timer event interrupts
 separately
Date: Sat,  5 May 2018 03:19:35 +1000
Message-Id: <20180504171935.25410-12-npiggin@gmail.com>
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

These are not local timer interrupts but IPIs. It's good to be able
to see how timer offloading is behaving, so split these out into
their own category.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hardirq.h | 1 +
 arch/powerpc/kernel/irq.c          | 6 ++++++
 arch/powerpc/kernel/time.c         | 5 +----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 5986d473722b..20b01897ea5d 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -8,6 +8,7 @@
 typedef struct {
 	unsigned int __softirq_pending;
 	unsigned int timer_irqs_event;
+	unsigned int broadcast_irqs_event;
 	unsigned int timer_irqs_others;
 	unsigned int pmu_irqs;
 	unsigned int mce_exceptions;
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 6569b5ffff93..627db34bb79d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -518,6 +518,11 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_event);
         seq_printf(p, "  Local timer interrupts for timer event device\n");
 
+	seq_printf(p, "%*s: ", prec, "BCT");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).broadcast_irqs_event);
+	seq_printf(p, "  Broadcast timer interrupts for timer event device\n");
+
 	seq_printf(p, "%*s: ", prec, "LOC");
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_others);
@@ -577,6 +582,7 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 {
 	u64 sum = per_cpu(irq_stat, cpu).timer_irqs_event;
 
+	sum += per_cpu(irq_stat, cpu).broadcast_irqs_event;
 	sum += per_cpu(irq_stat, cpu).pmu_irqs;
 	sum += per_cpu(irq_stat, cpu).mce_exceptions;
 	sum += per_cpu(irq_stat, cpu).spurious_irqs;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 23921f7b6e67..ed6b2abdde15 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -647,13 +647,10 @@ EXPORT_SYMBOL(timer_interrupt);
 void timer_broadcast_interrupt(void)
 {
 	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
-	struct pt_regs *regs = get_irq_regs();
 
-	trace_timer_interrupt_entry(regs);
 	*next_tb = ~(u64)0;
 	tick_receive_broadcast();
-	__this_cpu_inc(irq_stat.timer_irqs_event);
-	trace_timer_interrupt_exit(regs);
+	__this_cpu_inc(irq_stat.broadcast_irqs_event);
 }
 #endif
 
-- 
2.17.0
