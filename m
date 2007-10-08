Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18186.50261.275896.847277@cargo.ozlabs.ibm.com>
Date: Tue, 9 Oct 2007 09:59:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Prevent decrementer clockevents from firing early
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On old powermacs, we sometimes set the decrementer to 1 in order to
trigger a decrementer interrupt, which we use to handle an interrupt
that was pending at the time when it was re-enabled.  This was causing
the decrementer clock event device to call the event function for the
next event early, which was causing problems when high-res timers were
not enabled.

This fixes the problem by recording the timebase value at which the
next event should occur, and checking the current timebase against the
recorded value in timer_interrupt.  If it isn't time for the next
event, it just reprograms the decrementer and returns.

This also subtracts 1 from the value stored into the decrementer,
which is appropriate because the decrementer interrupts on the
transition from 0 to -1, not when the decrementer reaches 0.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index d20947c..1481e6f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -118,6 +118,7 @@ static struct clock_event_device decrementer_clockevent = {
 
 static DEFINE_PER_CPU(struct clock_event_device, decrementers);
 void init_decrementer_clockevent(void);
+static DEFINE_PER_CPU(u64, decrementer_next_tb);
 
 #ifdef CONFIG_PPC_ISERIES
 static unsigned long __initdata iSeries_recal_titan;
@@ -541,6 +542,7 @@ void timer_interrupt(struct pt_regs * regs)
 	struct pt_regs *old_regs;
 	int cpu = smp_processor_id();
 	struct clock_event_device *evt = &per_cpu(decrementers, cpu);
+	u64 now;
 
 	/* Ensure a positive value is written to the decrementer, or else
 	 * some CPUs will continuue to take decrementer exceptions */
@@ -551,6 +553,14 @@ void timer_interrupt(struct pt_regs * regs)
 		do_IRQ(regs);
 #endif
 
+	now = get_tb();
+	if (now < per_cpu(decrementer_next_tb, cpu)) {
+		/* not time for this event yet */
+		now = per_cpu(decrementer_next_tb, cpu) - now;
+		if (now <= DECREMENTER_MAX)
+			set_dec((unsigned int)now - 1);
+		return;
+	}
 	old_regs = set_irq_regs(regs);
 	irq_enter();
 
@@ -797,6 +807,10 @@ void __init clocksource_init(void)
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
+	__get_cpu_var(decrementer_next_tb) = get_tb() + evt;
+	/* The decrementer interrupts on the 0 -> -1 transition */
+	if (evt)
+		--evt;
 	set_dec(evt);
 	return 0;
 }
