Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKRGj0r8YzDrLF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 23:22:53 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id 125so12716719pgi.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 06:22:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH] powerpc: improve accounting of non maskable interrupts
Date: Sat, 29 Jul 2017 23:22:11 +1000
Message-Id: <20170729132212.8081-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a case of double counting MCEs on PowerNV.

Adds a counter for the system reset interrupt, which will
see more use as a debugging NMI.

Adds a soft-NMI counter for the 64s watchdog. Although this could cause
confusion because it only fires when interrupts are soft-disabled, so it
won't increment much even when the watchdog is running.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
I can split these out or drop any objectionable bits. At least the
MCE we should fix, not sure if the other bits are wanted.

Thanks,
Nick

 arch/powerpc/include/asm/hardirq.h |  4 ++++
 arch/powerpc/kernel/irq.c          | 16 ++++++++++++++++
 arch/powerpc/kernel/traps.c        |  9 +++++++++
 arch/powerpc/kernel/watchdog.c     |  3 +++
 4 files changed, 32 insertions(+)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 8add8b861e8d..a3c83ec416c6 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -12,6 +12,10 @@ typedef struct {
 	unsigned int mce_exceptions;
 	unsigned int spurious_irqs;
 	unsigned int hmi_exceptions;
+	unsigned int sreset_irqs;
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) && defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH)
+	unsigned int soft_nmi_irqs;
+#endif
 #ifdef CONFIG_PPC_DOORBELL
 	unsigned int doorbell_irqs;
 #endif
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 0bcec745a672..36250df64615 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -470,6 +470,18 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "  Hypervisor Maintenance Interrupts\n");
 	}
 
+	seq_printf(p, "%*s: ", prec, "NMI");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).sreset_irqs);
+	seq_printf(p, "  System Reset interrupts\n");
+
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) && defined(CONFIG_HAVE_HARDLOCKUP_DETECTOR_ARCH)
+	seq_printf(p, "%*s: ", prec, "WDG");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).soft_nmi_irqs);
+	seq_printf(p, "  Watchdog soft-NMI interrupts\n");
+#endif
+
 #ifdef CONFIG_PPC_DOORBELL
 	if (cpu_has_feature(CPU_FTR_DBELL)) {
 		seq_printf(p, "%*s: ", prec, "DBL");
@@ -494,6 +506,10 @@ u64 arch_irq_stat_cpu(unsigned int cpu)
 	sum += per_cpu(irq_stat, cpu).spurious_irqs;
 	sum += per_cpu(irq_stat, cpu).timer_irqs_others;
 	sum += per_cpu(irq_stat, cpu).hmi_exceptions;
+	sum += per_cpu(irq_stat, cpu).sreset_irqs;
+#ifdef CONFIG_HARDLOCKUP_DETECTOR
+	sum += per_cpu(irq_stat, cpu).soft_nmi_irqs;
+#endif
 #ifdef CONFIG_PPC_DOORBELL
 	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
 #endif
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bfcfd9ef09f2..6a892ca7bf18 100644
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
@@ -755,7 +757,14 @@ void machine_check_exception(struct pt_regs *regs)
 	enum ctx_state prev_state = exception_enter();
 	int recover = 0;
 
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* 64s accounts the mce in machine_check_early when in HVMODE */
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
+		__this_cpu_inc(irq_stat.mce_exceptions);
+#else
 	__this_cpu_inc(irq_stat.mce_exceptions);
+#endif
+
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
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
