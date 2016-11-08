Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCrZw1FByzDvQg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 01:01:44 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y68so19673041pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 06:01:44 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 1/3] powerpc: add NMI IPI infrastructure
Date: Wed,  9 Nov 2016 01:01:23 +1100
Message-Id: <20161108140125.21455-2-npiggin@gmail.com>
In-Reply-To: <20161108140125.21455-1-npiggin@gmail.com>
References: <20161108140125.21455-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add an NMI IPI system that handles platform differences and concurrency
and reentrancy issues.

The platform does not have to implement a true non-maskable interrupt.
The default is to simply uses the debugger break IPI message.

The debugger break users (debugger and crash) have been reimplemented
on top of the NMI.

smp_send_stop has also been implemented as NMI.
---
 arch/powerpc/include/asm/smp.h          |   2 +-
 arch/powerpc/kernel/smp.c               | 271 ++++++++++++++++++++++++++------
 arch/powerpc/platforms/cell/interrupt.c |   2 +-
 arch/powerpc/platforms/ps3/smp.c        |   4 +-
 4 files changed, 227 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 0d02c11..055918d 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -115,7 +115,7 @@ extern int cpu_to_core_id(int cpu);
 #define PPC_MSG_CALL_FUNCTION   0
 #define PPC_MSG_RESCHEDULE      1
 #define PPC_MSG_TICK_BROADCAST	2
-#define PPC_MSG_DEBUGGER_BREAK  3
+#define PPC_MSG_NMI_IPI_SAFE	3
 
 /* This is only used by the powernv kernel */
 #define PPC_MSG_RM_HOST_ACTION	4
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9c6f3fd..959d9dc 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -85,8 +85,6 @@ volatile unsigned int cpu_callin_map[NR_CPUS];
 
 int smt_enabled_at_boot = 1;
 
-static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
-
 /*
  * Returns 1 if the specified cpu should be brought up during boot.
  * Used to inhibit booting threads if they've been disabled or
@@ -157,17 +155,9 @@ static irqreturn_t tick_broadcast_ipi_action(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t debug_ipi_action(int irq, void *data)
+static irqreturn_t nmi_ipi_safe_action(int irq, void *data)
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
 
@@ -175,14 +165,14 @@ static irq_handler_t smp_ipi_action[] = {
 	[PPC_MSG_CALL_FUNCTION] =  call_function_action,
 	[PPC_MSG_RESCHEDULE] = reschedule_action,
 	[PPC_MSG_TICK_BROADCAST] = tick_broadcast_ipi_action,
-	[PPC_MSG_DEBUGGER_BREAK] = debug_ipi_action,
+	[PPC_MSG_NMI_IPI_SAFE] = nmi_ipi_safe_action,
 };
 
 const char *smp_ipi_name[] = {
 	[PPC_MSG_CALL_FUNCTION] =  "ipi call function",
 	[PPC_MSG_RESCHEDULE] = "ipi reschedule",
 	[PPC_MSG_TICK_BROADCAST] = "ipi tick-broadcast",
-	[PPC_MSG_DEBUGGER_BREAK] = "ipi debugger",
+	[PPC_MSG_NMI_IPI_SAFE] = "nmi ipi",
 };
 
 /* optional function to request ipi, for controllers with >= 4 ipis */
@@ -190,14 +180,9 @@ int smp_request_message_ipi(int virq, int msg)
 {
 	int err;
 
-	if (msg < 0 || msg > PPC_MSG_DEBUGGER_BREAK) {
+	if (msg < 0 || msg > PPC_MSG_NMI_IPI_SAFE) {
 		return -EINVAL;
 	}
-#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC)
-	if (msg == PPC_MSG_DEBUGGER_BREAK) {
-		return 1;
-	}
-#endif
 	err = request_irq(virq, smp_ipi_action[msg],
 			  IRQF_PERCPU | IRQF_NO_THREAD | IRQF_NO_SUSPEND,
 			  smp_ipi_name[msg], NULL);
@@ -277,8 +262,8 @@ irqreturn_t smp_ipi_demux(void)
 			scheduler_ipi();
 		if (all & IPI_MESSAGE(PPC_MSG_TICK_BROADCAST))
 			tick_broadcast_ipi_handler();
-		if (all & IPI_MESSAGE(PPC_MSG_DEBUGGER_BREAK))
-			debug_ipi_action(0, NULL);
+		if (all & IPI_MESSAGE(PPC_MSG_NMI_IPI_SAFE))
+			nmi_ipi_safe_action(0, NULL);
 	} while (info->messages);
 
 	return IRQ_HANDLED;
@@ -315,6 +300,210 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 		do_message_pass(cpu, PPC_MSG_CALL_FUNCTION);
 }
 
+/*
+ * "NMI IPI" infrastructure. The entire NMI call runs single threaded and with
+ * interrupts disabled, to avoid deadlocks and make message passing simpler.
+ * It runs synchronously until all targets enter the nmi handler (or the caller
+ * times out and fails), at which point the caller is released. No new NMI can
+ * be initiated until targets exit the handler.
+ *
+ * In the case of a caller timeout but the IPI subsequently being taken on a
+ * target, there is some logic to gracefully ignore the IPI, however platform
+ * code may not be able to distinguish this from a different source of NMI,
+ * so it may end up doing something like entering a debug mode.
+ *
+ * The NMI can be "safe" or "hard". Safe should not be dangerous to the system,
+ * but may not always succeed in interrupting the target. Hard is more likely
+ * to succeed but may not be recoverable afterwards, so must be used carefully.
+ */
+#define NMI_IPI_ALLBUTSELF		-1
+
+#define NMI_IPI_FUNCTION_STOP		1
+#define NMI_IPI_FUNCTION_DEBUG		2
+#define NMI_IPI_FUNCTION_CRASH		3
+
+static atomic_t __nmi_ipi_lock = ATOMIC_INIT(0);
+static struct cpumask nmi_ipi_pending_mask;
+static int nmi_ipi_busy_count = 0;
+static int nmi_ipi_function = 0;
+static void *nmi_ipi_data = NULL;
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
+static void __noreturn stop_this_cpu(void)
+{
+	/* Remove this CPU */
+	set_cpu_online(smp_processor_id(), false);
+
+	local_irq_disable();
+	hard_irq_disable();
+	while (1)
+		cpu_relax();
+}
+
+/*
+ * Platform NMI handler calls this to ack
+ */
+int smp_handle_nmi_ipi(struct pt_regs *regs)
+{
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
+	cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
+	nmi_ipi_busy_count++;
+	nmi_ipi_unlock();
+
+	ret = 1;
+	if (nmi_ipi_function == NMI_IPI_FUNCTION_STOP) {
+		nmi_ipi_lock();
+		nmi_ipi_busy_count--;
+		nmi_ipi_unlock_end(&flags);
+
+		stop_this_cpu();
+
+#ifdef CONFIG_DEBUGGER
+	} else if (nmi_ipi_function == NMI_IPI_FUNCTION_DEBUG) {
+		debugger_ipi(regs);
+#endif
+
+#ifdef CONFIG_KEXEC
+	} else if (nmi_ipi_function == NMI_IPI_FUNCTION_CRASH) {
+		void (*crash_fn)(struct pt_regs *) = nmi_ipi_data;
+		crash_fn(regs);
+#endif
+
+	} else {
+		pr_warn("Unknown NMI IPI on cpu:%d\n", me);
+	}
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
+	do_message_pass(cpu, PPC_MSG_NMI_IPI_SAFE);
+}
+
+/*
+ * - cpu is the target CPU, can be NMI_IPI_ALLBUTSELF. Must not be current CPU.
+ * - function is one of NMI_IPI_FUNCTION_.
+ * - data is for the function handler to use.
+ * - safe_udelay > 0 if the "safe" NMI is to be used, specifies delay before
+ *   giving up waiting for targets to enter the handler.
+ * - hard_udelay > 0 similarly to use "hard" NMI. If both are > 0, safe is
+ *   attempted first, then hard. If the platform does not support hard, then
+ *   safe will be used.
+ */
+int smp_send_nmi_ipi(int cpu, int function, void *data,
+		u64 safe_udelay, u64 hard_udelay)
+{
+	unsigned long flags;
+	int c, me = raw_smp_processor_id();
+	int ret = 1;
+
+	BUG_ON(cpu == me);
+	BUG_ON(cpu < 0 && cpu != NMI_IPI_ALLBUTSELF);
+
+	if (unlikely(!smp_ops))
+		return 0;
+
+	/* Have no real NMI capability yet */
+	safe_udelay += hard_udelay;
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
+	nmi_ipi_function = function;
+	nmi_ipi_data = data;
+
+	if (cpu < 0) {
+		/* ALLBUTSELF */
+		cpumask_copy(&nmi_ipi_pending_mask, cpu_online_mask);
+		cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
+	} else {
+		/* cpumask starts clear */
+		cpumask_set_cpu(cpu, &nmi_ipi_pending_mask);
+	}
+	nmi_ipi_busy_count++;
+	nmi_ipi_unlock();
+
+	if (safe_udelay) {
+		for_each_cpu(c, &nmi_ipi_pending_mask)
+			do_smp_send_nmi_ipi(c);
+
+		do {
+			safe_udelay--;
+			udelay(1);
+			if (cpumask_empty(&nmi_ipi_pending_mask))
+				goto done;
+		} while (safe_udelay);
+	}
+
+	ret = 0; /* Could not gather all CPUs */
+	cpumask_clear(&nmi_ipi_pending_mask);
+done:
+	nmi_ipi_lock();
+	nmi_ipi_busy_count--;
+	nmi_ipi_unlock_end(&flags);
+
+	put_online_cpus();
+
+	return ret;
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void tick_broadcast(const struct cpumask *mask)
 {
@@ -325,45 +514,31 @@ void tick_broadcast(const struct cpumask *mask)
 }
 #endif
 
-#if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
+#ifdef CONFIG_DEBUGGER
 void smp_send_debugger_break(void)
 {
-	int cpu;
-	int me = raw_smp_processor_id();
-
-	if (unlikely(!smp_ops))
-		return;
-
-	for_each_online_cpu(cpu)
-		if (cpu != me)
-			do_message_pass(cpu, PPC_MSG_DEBUGGER_BREAK);
+	smp_send_nmi_ipi(NMI_IPI_ALLBUTSELF,
+			NMI_IPI_FUNCTION_DEBUG, NULL,
+			1000000, 0);
 }
 #endif
 
 #ifdef CONFIG_KEXEC
 void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 {
-	crash_ipi_function_ptr = crash_ipi_callback;
-	if (crash_ipi_callback) {
-		mb();
-		smp_send_debugger_break();
-	}
+	smp_send_nmi_ipi(NMI_IPI_ALLBUTSELF,
+			NMI_IPI_FUNCTION_CRASH, crash_ipi_callback,
+			0, 1000000);
 }
 #endif
 
-static void stop_this_cpu(void *dummy)
-{
-	/* Remove this CPU */
-	set_cpu_online(smp_processor_id(), false);
-
-	local_irq_disable();
-	while (1)
-		;
-}
-
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 0);
+	smp_send_nmi_ipi(NMI_IPI_ALLBUTSELF,
+			NMI_IPI_FUNCTION_STOP, NULL,
+			0, 1000000);
+
+	stop_this_cpu();
 }
 
 struct thread_info *current_set[NR_CPUS];
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index a6bbbab..fcc94c8 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -211,7 +211,7 @@ void iic_request_IPIs(void)
 	iic_request_ipi(PPC_MSG_CALL_FUNCTION);
 	iic_request_ipi(PPC_MSG_RESCHEDULE);
 	iic_request_ipi(PPC_MSG_TICK_BROADCAST);
-	iic_request_ipi(PPC_MSG_DEBUGGER_BREAK);
+	iic_request_ipi(PPC_MSG_NMI_IPI_SAFE);
 }
 
 #endif /* CONFIG_SMP */
diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index 60154d0..5b1fb70 100644
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -77,7 +77,7 @@ static void __init ps3_smp_probe(void)
 		BUILD_BUG_ON(PPC_MSG_CALL_FUNCTION    != 0);
 		BUILD_BUG_ON(PPC_MSG_RESCHEDULE       != 1);
 		BUILD_BUG_ON(PPC_MSG_TICK_BROADCAST   != 2);
-		BUILD_BUG_ON(PPC_MSG_DEBUGGER_BREAK   != 3);
+		BUILD_BUG_ON(PPC_MSG_NMI_IPI_SAFE   != 3);
 
 		for (i = 0; i < MSG_COUNT; i++) {
 			result = ps3_event_receive_port_setup(cpu, &virqs[i]);
@@ -96,7 +96,7 @@ static void __init ps3_smp_probe(void)
 				ps3_register_ipi_irq(cpu, virqs[i]);
 		}
 
-		ps3_register_ipi_debug_brk(cpu, virqs[PPC_MSG_DEBUGGER_BREAK]);
+		ps3_register_ipi_debug_brk(cpu, virqs[PPC_MSG_NMI_IPI_SAFE]);
 
 		DBG(" <- %s:%d: (%d)\n", __func__, __LINE__, cpu);
 	}
-- 
2.10.2
