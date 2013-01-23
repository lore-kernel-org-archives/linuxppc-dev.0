Return-Path: <Fan.Du@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BE842C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 19:06:21 +1100 (EST)
From: Fan Du <fan.du@windriver.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>
Subject: [PATCH] powerpc: make irq_stat.timers_irqs counting more specific
Date: Wed, 23 Jan 2013 16:06:11 +0800
Message-ID: <1358928371-18479-1-git-send-email-fan.du@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, fan.du@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current irq_stat.timers_irqs counting doesn't discriminate timer event handler
and other timer interrupt(like arch_irq_work_raise). Sometimes we need to know
exactly how much interrupts timer event handler fired, so let's be more specific
on this.

Signed-off-by: Fan Du <fan.du@windriver.com>
---
 arch/powerpc/include/asm/hardirq.h |    3 ++-
 arch/powerpc/kernel/irq.c          |   12 +++++++++---
 arch/powerpc/kernel/time.c         |    3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 3147a29..ff8bfdc 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -6,7 +6,8 @@
 
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int timer_irqs;
+	unsigned int timer_irqs_event;
+	unsigned int timer_irqs_others;
 	unsigned int pmu_irqs;
 	unsigned int mce_exceptions;
 	unsigned int spurious_irqs;
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 71413f4..101127d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -349,8 +349,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "LOC");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs);
-        seq_printf(p, "  Local timer interrupts\n");
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_event);
+        seq_printf(p, "  Local timer interrupts for timer event device\n");
+
+	seq_printf(p, "%*s: ", prec, "LOC");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).timer_irqs_others);
+        seq_printf(p, "  Local timer interrupts for others\n");
 
 	seq_printf(p, "%*s: ", prec, "SPU");
 	for_each_online_cpu(j)
@@ -375,11 +380,12 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  */
 u64 arch_irq_stat_cpu(unsigned int cpu)
 {
-	u64 sum = per_cpu(irq_stat, cpu).timer_irqs;
+	u64 sum = per_cpu(irq_stat, cpu).timer_irqs_event;
 
 	sum += per_cpu(irq_stat, cpu).pmu_irqs;
 	sum += per_cpu(irq_stat, cpu).mce_exceptions;
 	sum += per_cpu(irq_stat, cpu).spurious_irqs;
+	sum += per_cpu(irq_stat, cpu).timer_irqs_others;
 
 	return sum;
 }
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index b3b1435..7e7c553 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -504,7 +504,6 @@ void timer_interrupt(struct pt_regs * regs)
 	 */
 	may_hard_irq_enable();
 
-	__get_cpu_var(irq_stat).timer_irqs++;
 
 #if defined(CONFIG_PPC32) && defined(CONFIG_PMAC)
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
@@ -526,10 +525,12 @@ void timer_interrupt(struct pt_regs * regs)
 		*next_tb = ~(u64)0;
 		if (evt->event_handler)
 			evt->event_handler(evt);
+		__get_cpu_var(irq_stat).timer_irqs_event++;
 	} else {
 		now = *next_tb - now;
 		if (now <= DECREMENTER_MAX)
 			set_dec((int)now);
+		__get_cpu_var(irq_stat).timer_irqs_others++;
 	}
 
 #ifdef CONFIG_PPC64
-- 
1.7.1
