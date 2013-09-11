Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DA7EE2C0460
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 12:54:12 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 10 Sep 2013 22:54:10 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 16FB26E8028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 22:54:07 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8B2s76V66650152
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 02:54:07 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8B2s4gH016042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 23:54:07 -0300
Subject: [PATCH V3 2/6] powerpc: Implement broadcast timer interrupt as an
 IPI message
To: benh@kernel.crashing.org, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, rjw@sisk.pl, galak@kernel.crashing.org,
 fweisbec@gmail.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 11 Sep 2013 08:21:22 +0530
Message-ID: <20130911025122.27726.84259.stgit@preeti.in.ibm.com>
In-Reply-To: <20130911024906.27726.4735.stgit@preeti.in.ibm.com>
References: <20130911024906.27726.4735.stgit@preeti.in.ibm.com>
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

For scalability and performance reasons, we want the broadcast IPIs
to be handled as efficiently as possible. Fixed IPI messages
are one of the most efficient mechanisms available - they are faster
than the smp_call_function mechanism because the IPI handlers are fixed
and hence they don't involve costly operations such as adding IPI handlers
to the target CPU's function queue, acquiring locks for synchronization etc.

Luckily we have an unused IPI message slot, so use that to implement
broadcast timer interrupts efficiently.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
[Changelog modified by preeti@linux.vnet.ibm.com]
Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/smp.h          |    3 ++-
 arch/powerpc/include/asm/time.h         |    1 +
 arch/powerpc/kernel/smp.c               |   19 +++++++++++++++----
 arch/powerpc/kernel/time.c              |    4 ++++
 arch/powerpc/platforms/cell/interrupt.c |    2 +-
 arch/powerpc/platforms/ps3/smp.c        |    2 +-
 scripts/kconfig/streamline_config.pl    |    0 
 7 files changed, 24 insertions(+), 7 deletions(-)
 mode change 100644 => 100755 scripts/kconfig/streamline_config.pl

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index a632b6e..22f6d63 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -117,7 +117,7 @@ extern int cpu_to_core_id(int cpu);
  *
  * Make sure this matches openpic_request_IPIs in open_pic.c, or what shows up
  * in /proc/interrupts will be wrong!!! --Troy */
-#define PPC_MSG_UNUSED		0
+#define PPC_MSG_TIMER		0
 #define PPC_MSG_RESCHEDULE      1
 #define PPC_MSG_CALL_FUNC_SINGLE	2
 #define PPC_MSG_DEBUGGER_BREAK  3
@@ -194,6 +194,7 @@ extern struct smp_ops_t *smp_ops;
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+extern void arch_send_tick_broadcast(const struct cpumask *mask);
 
 /* Definitions relative to the secondary CPU spin loop
  * and entry point. Not all of them exist on both 32 and
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index c1f2676..4e35282 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -28,6 +28,7 @@ extern struct clock_event_device decrementer_clockevent;
 struct rtc_time;
 extern void to_tm(int tim, struct rtc_time * tm);
 extern void GregorianDay(struct rtc_time *tm);
+extern void decrementer_timer_interrupt(void);
 
 extern void generic_calibrate_decr(void);
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index bc41e9f..d3b7014 100644
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
@@ -111,9 +112,9 @@ int smp_generic_kick_cpu(int nr)
 }
 #endif /* CONFIG_PPC64 */
 
-static irqreturn_t unused_action(int irq, void *data)
+static irqreturn_t timer_action(int irq, void *data)
 {
-	/* This slot is unused and hence available for use, if needed */
+	decrementer_timer_interrupt();
 	return IRQ_HANDLED;
 }
 
@@ -144,14 +145,14 @@ static irqreturn_t debug_ipi_action(int irq, void *data)
 }
 
 static irq_handler_t smp_ipi_action[] = {
-	[PPC_MSG_UNUSED] =  unused_action, /* Slot available for future use */
+	[PPC_MSG_TIMER] =  timer_action,
 	[PPC_MSG_RESCHEDULE] = reschedule_action,
 	[PPC_MSG_CALL_FUNC_SINGLE] = call_function_single_action,
 	[PPC_MSG_DEBUGGER_BREAK] = debug_ipi_action,
 };
 
 const char *smp_ipi_name[] = {
-	[PPC_MSG_UNUSED] =  "ipi unused",
+	[PPC_MSG_TIMER] =  "ipi timer",
 	[PPC_MSG_RESCHEDULE] = "ipi reschedule",
 	[PPC_MSG_CALL_FUNC_SINGLE] = "ipi call function single",
 	[PPC_MSG_DEBUGGER_BREAK] = "ipi debugger",
@@ -221,6 +222,8 @@ irqreturn_t smp_ipi_demux(void)
 		all = xchg(&info->messages, 0);
 
 #ifdef __BIG_ENDIAN
+		if (all & (1 << (24 - 8 * PPC_MSG_TIMER)))
+			decrementer_timer_interrupt();
 		if (all & (1 << (24 - 8 * PPC_MSG_RESCHEDULE)))
 			scheduler_ipi();
 		if (all & (1 << (24 - 8 * PPC_MSG_CALL_FUNC_SINGLE)))
@@ -266,6 +269,14 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 		do_message_pass(cpu, PPC_MSG_CALL_FUNC_SINGLE);
 }
 
+void arch_send_tick_broadcast(const struct cpumask *mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask)
+		do_message_pass(cpu, PPC_MSG_TIMER);
+}
+
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 void smp_send_debugger_break(void)
 {
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 65ab9e9..0dfa0c5 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -813,6 +813,10 @@ static void decrementer_set_mode(enum clock_event_mode mode,
 		decrementer_set_next_event(DECREMENTER_MAX, dev);
 }
 
+void decrementer_timer_interrupt(void)
+{
+}
+
 static void register_decrementer_clockevent(int cpu)
 {
 	struct clock_event_device *dec = &per_cpu(decrementers, cpu);
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 28166e4..1359113 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -213,7 +213,7 @@ static void iic_request_ipi(int msg)
 
 void iic_request_IPIs(void)
 {
-	iic_request_ipi(PPC_MSG_UNUSED);
+	iic_request_ipi(PPC_MSG_TIMER);
 	iic_request_ipi(PPC_MSG_RESCHEDULE);
 	iic_request_ipi(PPC_MSG_CALL_FUNC_SINGLE);
 	iic_request_ipi(PPC_MSG_DEBUGGER_BREAK);
diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index 488f069..5cb742a 100644
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -74,7 +74,7 @@ static int __init ps3_smp_probe(void)
 		* to index needs to be setup.
 		*/
 
-		BUILD_BUG_ON(PPC_MSG_UNUSED	      != 0);
+		BUILD_BUG_ON(PPC_MSG_TIMER	      != 0);
 		BUILD_BUG_ON(PPC_MSG_RESCHEDULE       != 1);
 		BUILD_BUG_ON(PPC_MSG_CALL_FUNC_SINGLE != 2);
 		BUILD_BUG_ON(PPC_MSG_DEBUGGER_BREAK   != 3);
diff --git a/scripts/kconfig/streamline_config.pl b/scripts/kconfig/streamline_config.pl
old mode 100644
new mode 100755
