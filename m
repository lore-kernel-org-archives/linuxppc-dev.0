Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8cL4SVqzDwKh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:42 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id w68so3191345pgw.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:42 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 07/10] powerpc: add NMI IPI infrastructure
Date: Tue, 20 Dec 2016 04:30:08 +1000
Message-Id: <20161219183011.28310-8-npiggin@gmail.com>
In-Reply-To: <20161219183011.28310-1-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a simple NMI IPI system that handles concurrency and reentrancy.

The platform does not have to implement a true non-maskable interrupt,
the default is to simply use the debugger break IPI message. This has
now been co-opted for a general IPI message, and users (debugger and
crash) have been reimplemented on top of the NMI system.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig                    |   5 +
 arch/powerpc/include/asm/smp.h          |  14 +-
 arch/powerpc/kernel/smp.c               | 247 +++++++++++++++++++++++++++-----
 arch/powerpc/platforms/cell/interrupt.c |   2 +-
 arch/powerpc/platforms/ps3/smp.c        |   4 +-
 5 files changed, 230 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3da87e198878..e7186db87e18 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -38,6 +38,11 @@ config NR_IRQS
 	  /proc/interrupts. If you configure your system to have too few,
 	  drivers will fail to load or worse - handle with care.
 
+config NMI_IPI
+	bool
+	depends on SMP && (DEBUGGER || KEXEC_CORE)
+	default y
+
 config STACKTRACE_SUPPORT
 	bool
 	default y
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 32db16d2e7ad..693a68f4ac8b 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -112,14 +112,22 @@ extern int cpu_to_core_id(int cpu);
  *
  * Make sure this matches openpic_request_IPIs in open_pic.c, or what shows up
  * in /proc/interrupts will be wrong!!! --Troy */
-#define PPC_MSG_CALL_FUNCTION   0
-#define PPC_MSG_RESCHEDULE      1
+#define PPC_MSG_CALL_FUNCTION	0
+#define PPC_MSG_RESCHEDULE	1
 #define PPC_MSG_TICK_BROADCAST	2
-#define PPC_MSG_DEBUGGER_BREAK  3
+#define PPC_MSG_NMI_IPI		3
 
 /* This is only used by the powernv kernel */
 #define PPC_MSG_RM_HOST_ACTION	4
 
+#define NMI_IPI_ALL_OTHERS		-2
+
+#ifdef CONFIG_NMI_IPI
+extern int smp_handle_nmi_ipi(struct pt_regs *regs);
+#else
+static inline int smp_handle_nmi_ipi(struct pt_regs *regs) { return 0; }
+#endif
+
 /* for irq controllers that have dedicated ipis per message (4) */
 extern int smp_request_message_ipi(int virq, int message);
 extern const char *smp_ipi_name[];
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 893bd7f79be6..81256522985d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -85,8 +85,6 @@ volatile unsigned int cpu_callin_map[NR_CPUS];
 
 int smt_enabled_at_boot = 1;
 
-static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
-
 /*
  * Returns 1 if the specified cpu should be brought up during boot.
  * Used to inhibit booting threads if they've been disabled or
@@ -157,32 +155,33 @@ static irqreturn_t tick_broadcast_ipi_action(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t debug_ipi_action(int irq, void *data)
+#ifdef CONFIG_NMI_IPI
+static irqreturn_t nmi_ipi_action(int irq, void *data)
 {
-	if (crash_ipi_function_ptr) {
-		crash_ipi_function_ptr(get_irq_regs());
-		return IRQ_HANDLED;
-	}
-
-#ifdef CONFIG_DEBUGGER
-	debugger_ipi(get_irq_regs());
-#endif /* CONFIG_DEBUGGER */
-
+	smp_handle_nmi_ipi(get_irq_regs());
 	return IRQ_HANDLED;
 }
+#endif
 
 static irq_handler_t smp_ipi_action[] = {
 	[PPC_MSG_CALL_FUNCTION] =  call_function_action,
 	[PPC_MSG_RESCHEDULE] = reschedule_action,
 	[PPC_MSG_TICK_BROADCAST] = tick_broadcast_ipi_action,
-	[PPC_MSG_DEBUGGER_BREAK] = debug_ipi_action,
+#ifdef CONFIG_NMI_IPI
+	[PPC_MSG_NMI_IPI] = nmi_ipi_action,
+#endif
 };
 
+/*
+ * The NMI IPI is a fallback and not truly non-maskable. It is simpler
+ * than going through the call function infrastructure, and strongly
+ * serialized, so it is more appropriate for debugging.
+ */
 const char *smp_ipi_name[] = {
 	[PPC_MSG_CALL_FUNCTION] =  "ipi call function",
 	[PPC_MSG_RESCHEDULE] = "ipi reschedule",
 	[PPC_MSG_TICK_BROADCAST] = "ipi tick-broadcast",
-	[PPC_MSG_DEBUGGER_BREAK] = "ipi debugger",
+	[PPC_MSG_NMI_IPI] = "nmi ipi",
 };
 
 /* optional function to request ipi, for controllers with >= 4 ipis */
@@ -190,14 +189,13 @@ int smp_request_message_ipi(int virq, int msg)
 {
 	int err;
 
-	if (msg < 0 || msg > PPC_MSG_DEBUGGER_BREAK) {
+	if (msg < 0 || msg > PPC_MSG_NMI_IPI)
 		return -EINVAL;
-	}
-#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC_CORE)
-	if (msg == PPC_MSG_DEBUGGER_BREAK) {
+#ifndef CONFIG_NMI_IPI
+	if (msg == PPC_MSG_NMI_IPI)
 		return 1;
-	}
 #endif
+
 	err = request_irq(virq, smp_ipi_action[msg],
 			  IRQF_PERCPU | IRQF_NO_THREAD | IRQF_NO_SUSPEND,
 			  smp_ipi_name[msg], NULL);
@@ -277,8 +275,10 @@ irqreturn_t smp_ipi_demux(void)
 			scheduler_ipi();
 		if (all & IPI_MESSAGE(PPC_MSG_TICK_BROADCAST))
 			tick_broadcast_ipi_handler();
-		if (all & IPI_MESSAGE(PPC_MSG_DEBUGGER_BREAK))
-			debug_ipi_action(0, NULL);
+#ifdef CONFIG_NMI_IPI
+		if (all & IPI_MESSAGE(PPC_MSG_NMI_IPI))
+			nmi_ipi_action(0, NULL);
+#endif
 	} while (info->messages);
 
 	return IRQ_HANDLED;
@@ -315,6 +315,188 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 		do_message_pass(cpu, PPC_MSG_CALL_FUNCTION);
 }
 
+#ifdef CONFIG_NMI_IPI
+
+/*
+ * "NMI IPI" system.
+ *
+ * NMI IPIs may not be recoverable, so should not be used as ongoing part of
+ * a running system. They can be used for crash, debug, halt/reboot, etc.
+ *
+ * NMI IPIs are globally single threaded. No more than one in progress at
+ * any time.
+ *
+ * The IPI call waits with interrupts disabled until all targets enter the
+ * NMI handler, then the call returns.
+ *
+ * No new NMI can be initiated until targets exit the handler.
+ *
+ * The IPI call may time out without all targets entering the NMI handler.
+ * In that case, there is some logic to recover (and ignore subsequent
+ * NMI interrupts that may eventually be raised), but the platform interrupt
+ * handler may not be able to distinguish this from other exception causes,
+ * which may cause a crash.
+ */
+
+static atomic_t __nmi_ipi_lock = ATOMIC_INIT(0);
+static struct cpumask nmi_ipi_pending_mask;
+static int nmi_ipi_busy_count = 0;
+static void (*nmi_ipi_function)(struct pt_regs *) = NULL;
+
+static void nmi_ipi_lock_start(unsigned long *flags)
+{
+	raw_local_irq_save(*flags);
+	hard_irq_disable();
+	while (atomic_cmpxchg(&__nmi_ipi_lock, 0, 1) == 1) {
+		raw_local_irq_restore(*flags);
+		cpu_relax();
+		raw_local_irq_save(*flags);
+		hard_irq_disable();
+	}
+}
+
+static void nmi_ipi_lock(void)
+{
+	while (atomic_cmpxchg(&__nmi_ipi_lock, 0, 1) == 1)
+		cpu_relax();
+}
+
+static void nmi_ipi_unlock(void)
+{
+	smp_mb();
+	WARN_ON(atomic_read(&__nmi_ipi_lock) != 1);
+	atomic_set(&__nmi_ipi_lock, 0);
+}
+
+static void nmi_ipi_unlock_end(unsigned long *flags)
+{
+	nmi_ipi_unlock();
+	raw_local_irq_restore(*flags);
+}
+
+/*
+ * Platform NMI handler calls this to ack
+ */
+int smp_handle_nmi_ipi(struct pt_regs *regs)
+{
+	void (*fn)(struct pt_regs *);
+	unsigned long flags;
+	int me = raw_smp_processor_id();
+	int ret = 0;
+
+	/*
+	 * Unexpected NMIs are possible here because the interrupt may not
+	 * be able to distinguish NMI IPIs from other types of NMIs, or
+	 * because the caller may have timed out.
+	 */
+	nmi_ipi_lock_start(&flags);
+	if (!nmi_ipi_busy_count)
+		goto out;
+	if (!cpumask_test_cpu(me, &nmi_ipi_pending_mask))
+		goto out;
+
+	fn = nmi_ipi_function;
+	if (!fn)
+		goto out;
+
+	cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
+	nmi_ipi_busy_count++;
+	nmi_ipi_unlock();
+
+	ret = 1;
+
+	fn(regs);
+
+	nmi_ipi_lock();
+	nmi_ipi_busy_count--;
+out:
+	nmi_ipi_unlock_end(&flags);
+
+	return ret;
+}
+
+static void do_smp_send_nmi_ipi(int cpu)
+{
+	if (cpu >= 0) {
+		do_message_pass(cpu, PPC_MSG_NMI_IPI);
+	} else {
+		unsigned int c;
+
+		for_each_online_cpu(c) {
+			if (c == raw_smp_processor_id())
+				continue;
+			do_message_pass(cpu, PPC_MSG_NMI_IPI);
+		}
+	}
+}
+
+/*
+ * - cpu is the target CPU (must not be this CPU), or NMI_IPI_ALL_OTHERS.
+ * - fn is the target callback function.
+ * - delay_us > 0 is the delay before giving up waiting for targets to
+ *   enter the handler, == 0 specifies indefinite delay.
+ */
+static int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
+{
+	unsigned long flags;
+	int me = raw_smp_processor_id();
+	int ret = 1;
+
+	BUG_ON(cpu == me);
+	BUG_ON(cpu < 0 && cpu != NMI_IPI_ALL_OTHERS);
+
+	if (unlikely(!smp_ops))
+		return 0;
+
+	get_online_cpus();
+
+	/* Take the nmi_ipi_busy count/lock with interrupts hard disabled */
+	nmi_ipi_lock_start(&flags);
+	while (nmi_ipi_busy_count) {
+		nmi_ipi_unlock_end(&flags);
+		cpu_relax();
+		nmi_ipi_lock_start(&flags);
+	}
+
+	nmi_ipi_function = fn;
+
+	if (cpu < 0) {
+		/* ALL_OTHERS */
+		cpumask_copy(&nmi_ipi_pending_mask, cpu_online_mask);
+		cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
+	} else {
+		/* cpumask starts clear */
+		cpumask_set_cpu(cpu, &nmi_ipi_pending_mask);
+	}
+	nmi_ipi_busy_count++;
+	nmi_ipi_unlock();
+
+	do_smp_send_nmi_ipi(cpu);
+
+	while (!cpumask_empty(&nmi_ipi_pending_mask)) {
+		udelay(1);
+		if (delay_us) {
+			delay_us--;
+			if (!delay_us)
+				break;
+		}
+	}
+
+	nmi_ipi_lock();
+	if (!cpumask_empty(&nmi_ipi_pending_mask)) {
+		/* Could not gather all CPUs */
+		ret = 0;
+		cpumask_clear(&nmi_ipi_pending_mask);
+	}
+	nmi_ipi_busy_count--;
+	nmi_ipi_unlock_end(&flags);
+
+	put_online_cpus();
+
+	return ret;
+}
+#endif /* CONFIG_NMI_IPI */
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void tick_broadcast(const struct cpumask *mask)
 {
@@ -325,29 +507,22 @@ void tick_broadcast(const struct cpumask *mask)
 }
 #endif
 
-#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
-void smp_send_debugger_break(void)
+#ifdef CONFIG_DEBUGGER
+void debugger_ipi_callback(struct pt_regs *regs)
 {
-	int cpu;
-	int me = raw_smp_processor_id();
-
-	if (unlikely(!smp_ops))
-		return;
+	debugger_ipi(regs);
+}
 
-	for_each_online_cpu(cpu)
-		if (cpu != me)
-			do_message_pass(cpu, PPC_MSG_DEBUGGER_BREAK);
+void smp_send_debugger_break(void)
+{
+	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, debugger_ipi_callback, 1000000);
 }
 #endif
 
 #ifdef CONFIG_KEXEC_CORE
 void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 {
-	crash_ipi_function_ptr = crash_ipi_callback;
-	if (crash_ipi_callback) {
-		mb();
-		smp_send_debugger_break();
-	}
+	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback, 1000000);
 }
 #endif
 
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index a6bbbaba14a3..871d38479a25 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -211,7 +211,7 @@ void iic_request_IPIs(void)
 	iic_request_ipi(PPC_MSG_CALL_FUNCTION);
 	iic_request_ipi(PPC_MSG_RESCHEDULE);
 	iic_request_ipi(PPC_MSG_TICK_BROADCAST);
-	iic_request_ipi(PPC_MSG_DEBUGGER_BREAK);
+	iic_request_ipi(PPC_MSG_NMI_IPI);
 }
 
 #endif /* CONFIG_SMP */
diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index 60154d08debf..1d1ad5df106f 100644
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -77,7 +77,7 @@ static void __init ps3_smp_probe(void)
 		BUILD_BUG_ON(PPC_MSG_CALL_FUNCTION    != 0);
 		BUILD_BUG_ON(PPC_MSG_RESCHEDULE       != 1);
 		BUILD_BUG_ON(PPC_MSG_TICK_BROADCAST   != 2);
-		BUILD_BUG_ON(PPC_MSG_DEBUGGER_BREAK   != 3);
+		BUILD_BUG_ON(PPC_MSG_NMI_IPI          != 3);
 
 		for (i = 0; i < MSG_COUNT; i++) {
 			result = ps3_event_receive_port_setup(cpu, &virqs[i]);
@@ -96,7 +96,7 @@ static void __init ps3_smp_probe(void)
 				ps3_register_ipi_irq(cpu, virqs[i]);
 		}
 
-		ps3_register_ipi_debug_brk(cpu, virqs[PPC_MSG_DEBUGGER_BREAK]);
+		ps3_register_ipi_debug_brk(cpu, virqs[PPC_MSG_NMI_IPI]);
 
 		DBG(" <- %s:%d: (%d)\n", __func__, __LINE__, cpu);
 	}
-- 
2.11.0
