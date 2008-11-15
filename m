Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C0185DDDF5
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 05:47:46 +1100 (EST)
Date: Sat, 15 Nov 2008 00:11:49 -0600
From: Milton Miller <miltonm@bga.com>
To: paulus@samba.org,
Subject: [patch v3] smp-ipi-names
Message-Id: <112267295096b8b45671.846930886.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the new generic smp call function helpers, I noticed the code in
smp_message_recv was a single function call in many cases.  While
getting the message number from the ipi data is easy, we can reduce
the path length by a function and data dependent switch by registering
seperate ipi actions for these simple calls.

Originally I left the ipi action array exposed, but then I realized the
registration code should be common too.

The three users each had their own name array, so I made a fourth
to convert all users to use a common one.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Perhaps we should make the common code look like an ipi action handler
and remove this last call?  Currently we still have to allocate a stack
frame to load the return value.

v2: fix arg reversal noted by Geert Uytterhoeven

v3: fix missed variable rename in WARN

I was going to make the variable local, then wanted it global for
the error request cases, and missed the instance when WARN was not
evaluating the printk for powerpc.

Unfornately, it appears that we are somewhat unique with one external
interrupt but multiple ipi vectors: a grep of arch/*/kernel/* for
generic_call_function_interrupt shows:

alpha, arm, ia64, parisc, 390 demux messages on a sw bitvector (although
many use spinlock/read/clear/unlock vs our test and clear bit), and
x86, mips, and m32r demux before get_irq, directly calling irq_enter/irq_exit,
leaving sh as the only one that has multiple ipis but uses request_irq/get_irq,
and they clear the source bit in the caller to the message demux and would
have minimal benefit from a signature change (they could get tail call
but not direct call).  They could gain to a similar change to this.

Index: next.git/arch/powerpc/include/asm/smp.h
===================================================================
--- next.git.orig/arch/powerpc/include/asm/smp.h	2008-10-22 07:10:11.000000000 -0500
+++ next.git/arch/powerpc/include/asm/smp.h	2008-11-10 22:37:52.000000000 -0600
@@ -81,6 +81,13 @@ extern int cpu_to_core_id(int cpu);
 #define PPC_MSG_CALL_FUNC_SINGLE	2
 #define PPC_MSG_DEBUGGER_BREAK  3
 
+/*
+ * irq controllers that have dedicated ipis per message and don't
+ * need additional code in the action handler may use this
+ */
+extern int smp_request_message_ipi(int virq, int message);
+extern const char *smp_ipi_name[];
+
 void smp_init_iSeries(void);
 void smp_init_pSeries(void);
 void smp_init_cell(void);
Index: next.git/arch/powerpc/kernel/smp.c
===================================================================
--- next.git.orig/arch/powerpc/kernel/smp.c	2008-10-22 07:10:11.000000000 -0500
+++ next.git/arch/powerpc/kernel/smp.c	2008-11-10 22:38:16.000000000 -0600
@@ -123,6 +123,65 @@ void smp_message_recv(int msg)
 	}
 }
 
+static irqreturn_t call_function_action(int irq, void *data)
+{
+	generic_smp_call_function_interrupt();
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t reschedule_action(int irq, void *data)
+{
+	/* we just need the return path side effect of checking need_resched */
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t call_function_single_action(int irq, void *data)
+{
+	generic_smp_call_function_single_interrupt();
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t debug_ipi_action(int irq, void *data)
+{
+	smp_message_recv(PPC_MSG_DEBUGGER_BREAK);
+	return IRQ_HANDLED;
+}
+
+static irq_handler_t smp_ipi_action[] = {
+	[PPC_MSG_CALL_FUNCTION] =  call_function_action,
+	[PPC_MSG_RESCHEDULE] = reschedule_action,
+	[PPC_MSG_CALL_FUNC_SINGLE] = call_function_single_action,
+	[PPC_MSG_DEBUGGER_BREAK] = debug_ipi_action,
+};
+
+const char *smp_ipi_name[] = {
+	[PPC_MSG_CALL_FUNCTION] =  "ipi call function",
+	[PPC_MSG_RESCHEDULE] = "ipi reschedule",
+	[PPC_MSG_CALL_FUNC_SINGLE] = "ipi call function single",
+	[PPC_MSG_DEBUGGER_BREAK] = "ipi debugger",
+};
+
+/* optional function to request ipi, for controllers with >= 4 ipis */
+int smp_request_message_ipi(int virq, int msg)
+{
+	int err;
+
+	if (msg < 0 || msg > PPC_MSG_DEBUGGER_BREAK) {
+		return -EINVAL;
+	}
+#if !defined(CONFIG_DEBUGGER) && !defined(CONFIG_KEXEC)
+	if (msg == PPC_MSG_DEBUGGER_BREAK) {
+		return 1;
+	}
+#endif
+	err = request_irq(virq, smp_ipi_action[msg], IRQF_DISABLED|IRQF_PERCPU,
+			  smp_ipi_name[msg], 0);
+	WARN(err < 0, "unable to request_irq %d for %s (rc %d)\n",
+		virq, smp_ipi_name[msg], err);
+
+	return err;
+}
+
 void smp_send_reschedule(int cpu)
 {
 	if (likely(smp_ops))
