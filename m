Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5B702C0367
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 21:45:12 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 29 Nov 2013 03:45:10 -0700
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 245E019D8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 03:45:02 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAT8h5pC59900082
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 09:43:05 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rATAj55E013733
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 03:45:07 -0700
Subject: [PATCH V4 2/9] powerpc: Implement tick broadcast IPI as a fixed IPI
 message
To: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, rjw@sisk.pl, galak@kernel.crashing.org,
 benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 29 Nov 2013 16:11:43 +0530
Message-ID: <20131129104142.651.21640.stgit@preeti.in.ibm.com>
In-Reply-To: <20131129104010.651.23117.stgit@preeti.in.ibm.com>
References: <20131129104010.651.23117.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

For scalability and performance reasons, we want the tick broadcast IPIs
to be handled as efficiently as possible. Fixed IPI messages
are one of the most efficient mechanisms available - they are faster than
the smp_call_function mechanism because the IPI handlers are fixed and hence
they don't involve costly operations such as adding IPI handlers to the target
CPU's function queue, acquiring locks for synchronization etc.

Luckily we have an unused IPI message slot, so use that to implement
tick broadcast IPIs efficiently.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
[Functions renamed to tick_broadcast* and Changelog modified by
 Preeti U. Murthy<preeti@linux.vnet.ibm.com>]
Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
Acked-by: Geoff Levand <geoff@infradead.org> [For the PS3 part]
---

 arch/powerpc/include/asm/smp.h          |    2 +-
 arch/powerpc/include/asm/time.h         |    1 +
 arch/powerpc/kernel/smp.c               |   19 +++++++++++++++----
 arch/powerpc/kernel/time.c              |    5 +++++
 arch/powerpc/platforms/cell/interrupt.c |    2 +-
 arch/powerpc/platforms/ps3/smp.c        |    2 +-
 6 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 9f7356b..ff51046 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -120,7 +120,7 @@ extern int cpu_to_core_id(int cpu);
  * in /proc/interrupts will be wrong!!! --Troy */
 #define PPC_MSG_CALL_FUNCTION   0
 #define PPC_MSG_RESCHEDULE      1
-#define PPC_MSG_UNUSED		2
+#define PPC_MSG_TICK_BROADCAST	2
 #define PPC_MSG_DEBUGGER_BREAK  3
 
 /* for irq controllers that have dedicated ipis per message (4) */
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index c1f2676..1d428e6 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -28,6 +28,7 @@ extern struct clock_event_device decrementer_clockevent;
 struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
 extern void GregorianDay(struct rtc_time *tm);
+extern void tick_broadcast_ipi_handler(void);
 
 extern void generic_calibrate_decr(void);
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index c2bd8d6..c77c6d7 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -35,6 +35,7 @@
 #include <asm/ptrace.h>
 #include <linux/atomic.h>
 #include <asm/irq.h>
+#include <asm/hw_irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
@@ -145,9 +146,9 @@ static irqreturn_t reschedule_action(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t unused_action(int irq, void *data)
+static irqreturn_t tick_broadcast_ipi_action(int irq, void *data)
 {
-	/* This slot is unused and hence available for use, if needed */
+	tick_broadcast_ipi_handler();
 	return IRQ_HANDLED;
 }
 
@@ -168,14 +169,14 @@ static irqreturn_t debug_ipi_action(int irq, void *data)
 static irq_handler_t smp_ipi_action[] = {
 	[PPC_MSG_CALL_FUNCTION] =  call_function_action,
 	[PPC_MSG_RESCHEDULE] = reschedule_action,
-	[PPC_MSG_UNUSED] = unused_action,
+	[PPC_MSG_TICK_BROADCAST] = tick_broadcast_ipi_action,
 	[PPC_MSG_DEBUGGER_BREAK] = debug_ipi_action,
 };
 
 const char *smp_ipi_name[] = {
 	[PPC_MSG_CALL_FUNCTION] =  "ipi call function",
 	[PPC_MSG_RESCHEDULE] = "ipi reschedule",
-	[PPC_MSG_UNUSED] = "ipi unused",
+	[PPC_MSG_TICK_BROADCAST] = "ipi tick-broadcast",
 	[PPC_MSG_DEBUGGER_BREAK] = "ipi debugger",
 };
 
@@ -251,6 +252,8 @@ irqreturn_t smp_ipi_demux(void)
 			generic_smp_call_function_interrupt();
 		if (all & IPI_MESSAGE(PPC_MSG_RESCHEDULE))
 			scheduler_ipi();
+		if (all & IPI_MESSAGE(PPC_MSG_TICK_BROADCAST))
+			tick_broadcast_ipi_handler();
 		if (all & IPI_MESSAGE(PPC_MSG_DEBUGGER_BREAK))
 			debug_ipi_action(0, NULL);
 	} while (info->messages);
@@ -289,6 +292,14 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 		do_message_pass(cpu, PPC_MSG_CALL_FUNCTION);
 }
 
+void tick_broadcast(const struct cpumask *mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask)
+		do_message_pass(cpu, PPC_MSG_TICK_BROADCAST);
+}
+
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 void smp_send_debugger_break(void)
 {
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index b3b1441..42269c7 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -813,6 +813,11 @@ static void decrementer_set_mode(enum clock_event_mode mode,
 		decrementer_set_next_event(DECREMENTER_MAX, dev);
 }
 
+/* Interrupt handler for the timer broadcast IPI */
+void tick_broadcast_ipi_handler(void)
+{
+}
+
 static void register_decrementer_clockevent(int cpu)
 {
 	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index adf3726..8a106b4 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -215,7 +215,7 @@ void iic_request_IPIs(void)
 {
 	iic_request_ipi(PPC_MSG_CALL_FUNCTION);
 	iic_request_ipi(PPC_MSG_RESCHEDULE);
-	iic_request_ipi(PPC_MSG_UNUSED);
+	iic_request_ipi(PPC_MSG_TICK_BROADCAST);
 	iic_request_ipi(PPC_MSG_DEBUGGER_BREAK);
 }
 
diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index 00d1a7c..b358bec 100644
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -76,7 +76,7 @@ static int __init ps3_smp_probe(void)
 
 		BUILD_BUG_ON(PPC_MSG_CALL_FUNCTION    != 0);
 		BUILD_BUG_ON(PPC_MSG_RESCHEDULE       != 1);
-		BUILD_BUG_ON(PPC_MSG_UNUSED	      != 2);
+		BUILD_BUG_ON(PPC_MSG_TICK_BROADCAST   != 2);
 		BUILD_BUG_ON(PPC_MSG_DEBUGGER_BREAK   != 3);
 
 		for (i = 0; i < MSG_COUNT; i++) {
