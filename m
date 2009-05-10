Return-Path: <anton@ozlabs.org>
Date: Mon, 11 May 2009 09:37:36 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Improve decrementer accuracy
Message-ID: <20090510233736.GI15891@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have been looking at sources of OS jitter and notice that after a long
NO_HZ idle period we wakeup too early:

relative time (us)    event
                      timer irq exit
    999946.405        timer irq entry
         4.835        timer irq exit
        21.685        timer irq entry
         3.540          timer (tick_sched_timer) entry

Here we slept for just under a second then took a timer interrupt that did
nothing. 21.685 us later we wake up again and do the work.

We set a rather low shift value of 16 for the decrementer clockevent, which I
think is causing this issue. On this box we have a 207MHz decrementer and see:

clockevent: decrementer mult[3501] shift[16] cpu[0]

For calculations of large intervals this mult/shift combination could be
off by a significant amount. I notice the sparc code has a loop that iterates
to find a mult/shift combination that maximises the shift value while
keeping mult under 32bit. With the patch below we get:

clockevent: decrementer mult[35015c20] shift[32] cpu[15]

And we no longer see the spurious wakeups.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

- I haven't tested if it does the right thing on 32bit yet

- Should we do something similar to the timebase? We use a 22 bit shift
  there but time might drift if that isnt accurate enough.

Index: linux-2.6/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/time.c	2009-05-10 19:48:39.000000000 +1000
+++ linux-2.6/arch/powerpc/kernel/time.c	2009-05-11 09:36:25.000000000 +1000
@@ -110,7 +110,7 @@
 static struct clock_event_device decrementer_clockevent = {
        .name           = "decrementer",
        .rating         = 200,
-       .shift          = 16,
+       .shift          = 0,	/* To be filled in */
        .mult           = 0,	/* To be filled in */
        .irq            = 0,
        .set_next_event = decrementer_set_next_event,
@@ -852,6 +852,22 @@
 		decrementer_set_next_event(DECREMENTER_MAX, dev);
 }
 
+static void __init setup_clockevent_multiplier(unsigned long hz)
+{
+	u64 mult, shift = 32;
+
+	while (1) {
+		mult = div_sc(hz, NSEC_PER_SEC, shift);
+		if (mult && (mult >> 32UL) == 0UL)
+			break;
+
+		shift--;
+	}
+
+	decrementer_clockevent.shift = shift;
+	decrementer_clockevent.mult = mult;
+}
+
 static void register_decrementer_clockevent(int cpu)
 {
 	struct clock_event_device *dec = &per_cpu(decrementers, cpu).event;
@@ -869,8 +885,7 @@
 {
 	int cpu = smp_processor_id();
 
-	decrementer_clockevent.mult = div_sc(ppc_tb_freq, NSEC_PER_SEC,
-					     decrementer_clockevent.shift);
+	setup_clockevent_multiplier(ppc_tb_freq);
 	decrementer_clockevent.max_delta_ns =
 		clockevent_delta2ns(DECREMENTER_MAX, &decrementer_clockevent);
 	decrementer_clockevent.min_delta_ns =
