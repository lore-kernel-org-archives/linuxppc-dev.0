Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMFKF2XflzDsQr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 22:01:21 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id j68so1399442pfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 05:01:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 3/4] powerpc: add irq accounting for system reset interrupts
Date: Tue,  1 Aug 2017 22:00:53 +1000
Message-Id: <20170801120054.3447-4-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hardirq.h | 1 +
 arch/powerpc/kernel/irq.c          | 6 ++++++
 arch/powerpc/kernel/traps.c        | 2 ++
 arch/powerpc/kernel/watchdog.c     | 3 +++
 4 files changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 8add8b861e8d..64b73b03d473 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -12,6 +12,7 @@ typedef struct {
 	unsigned int mce_exceptions;
 	unsigned int spurious_irqs;
 	unsigned int hmi_exceptions;
+	unsigned int sreset_irqs;
 #ifdef CONFIG_PPC_DOORBELL
 	unsigned int doorbell_irqs;
 #endif
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 0bcec745a672..5c18335580b6 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -470,6 +470,11 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "  Hypervisor Maintenance Interrupts\n");
 	}
 
+	seq_printf(p, "%*s: ", prec, "NMI");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).sreset_irqs);
+	seq_printf(p, "  System Reset interrupts\n");
+
 #ifdef CONFIG_PPC_DOORBELL
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		seq_printf(p, "%*s: ", prec, "DBL");
@@ -494,6 +499,7 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 	sum += per_cpu(irq_stat, cpu).spurious_irqs;
 	sum += per_cpu(irq_stat, cpu).timer_irqs_others;
 	sum += per_cpu(irq_stat, cpu).hmi_exceptions;
+	sum += per_cpu(irq_stat, cpu).sreset_irqs;
 #ifdef CONFIG_PPC_DOORBELL
 	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
 #endif
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5adfea2dc822..6a892ca7bf18 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -288,6 +288,8 @@ void system_reset_exception(struct pt_regs *regs)
 	if (!nested)
 		nmi_enter();
 
+	__this_cpu_inc(irq_stat.sreset_irqs);
+
 	/* See if any machine dependent calls */
 	if (ppc_md.system_reset_exception) {
 		if (ppc_md.system_reset_exception(regs))
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index b67f8b03a32d..4b9a567c9975 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -204,6 +204,9 @@ void soft_nmi_interrupt(struct pt_regs *regs)
 		return;
 
 	nmi_enter();
+
+	__this_cpu_inc(irq_stat.soft_nmi_irqs);
+
 	tb = get_tb();
 	if (tb - per_cpu(wd_timer_tb, cpu) >= wd_panic_timeout_tb) {
 		per_cpu(wd_timer_tb, cpu) = tb;
-- 
2.11.0
