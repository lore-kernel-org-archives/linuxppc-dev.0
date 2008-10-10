Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9DE2DE17A
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:57:11 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:46 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-ipi-2@bga.com>
In-Reply-To: <patch-ipi-1@bga.com>
Subject: [PATCH 14/16] powerpc: expand vs demux ipi actions per message
Cc: Arnd Bergmann <arnd@arndb.de>
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
the path length by a function call and a mult-way data dependent
switch by registering seperate ipi actions for these simple calls.

Originally I left the ipi action array exposed, but then I realized the
registration code should be common so that decisions like needing the
driver data are common, along with flagging the interrupt per-cpu.

The three users each had their own name array and contents, so I
made a fourth style for all users.  

Signed-off-by: Milton Miller <miltonm@bga.com>
---
Perhaps we should make the common code look like an ipi action handler
and remove this last call?  Currently we still have to allocate a stack
frame to load the return value.

Index: next.git/arch/powerpc/include/asm/smp.h
===================================================================
--- next.git.orig/arch/powerpc/include/asm/smp.h	2008-10-05 00:08:36.000000000 -0500
+++ next.git/arch/powerpc/include/asm/smp.h	2008-10-05 00:16:34.000000000 -0500
@@ -81,6 +81,13 @@ extern int cpu_to_core_id(int cpu);
 #define PPC_MSG_CALL_FUNC_SINGLE	2
 #define PPC_MSG_DEBUGGER_BREAK  3
 
+/*
+ * irq controllers that have dedicated ipis per message and don't
+ * need additional code in the action handler may use this
+ */
+extern int smp_request_message_ipi(int irq, int message);
+extern const char *smp_ipi_name[];
+
 void smp_init_iSeries(void);
 void smp_init_pSeries(void);
 void smp_init_cell(void);
Index: next.git/arch/powerpc/kernel/smp.c
===================================================================
--- next.git.orig/arch/powerpc/kernel/smp.c	2008-10-05 00:08:38.000000000 -0500
+++ next.git/arch/powerpc/kernel/smp.c	2008-10-05 00:19:12.000000000 -0500
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
+int smp_request_message_ipi(int msg, int virq)
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
+		virq, ipi_names[msg], err);
+
+	return err;
+}
+
 void smp_send_reschedule(int cpu)
 {
 	if (likely(smp_ops))
