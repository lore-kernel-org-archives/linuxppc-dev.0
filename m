Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18216.26159.925871.350286@cargo.ozlabs.ibm.com>
Date: Wed, 31 Oct 2007 22:25:35 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC] Fix off-by-one error in setting decrementer on Book
	E/4xx (v2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The decrementer in Book E and 4xx processors interrupts on the
transition from 1 to 0, rather than on the 0 to -1 transition as on
64-bit server and 32-bit "classic" (6xx/7xx/7xxx) processors.  At the
moment we subtract 1 from the count of how many decrementer ticks are
required before the next interrupt before putting it into the
decrementer, which is correct for server/classic processors, but could
possibly cause the interrupt to happen too early on Book E and 4xx if
the timebase/decrementer frequency is low.

This fixes the problem by making set_dec subtract 1 from the count for
server and classic processors, instead of having the callers subtract
1.  Since set_dec already had a bunch of ifdefs to handle different
processor types, there is no net increase in ugliness. :)

Note that calling set_dec(0) may not generate an interrupt on some
processors.  To make sure that decrementer_set_next_event always calls
set_dec with an interval of at least 1 tick, we set min_delta_ns of
the decrementer_clockevent to correspond to 2 ticks (2 rather than 1
to compensate for truncations in the conversions between ticks and
ns).

This also removes a redundant call to set the decrementer to
0x7fffffff - it was already set to that earlier in timer_interrupt.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Hopefully this version is correct now. :)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 9eb3284..99ebcd3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -586,7 +586,7 @@ void timer_interrupt(struct pt_regs * regs)
 		/* not time for this event yet */
 		now = per_cpu(decrementer_next_tb, cpu) - now;
 		if (now <= DECREMENTER_MAX)
-			set_dec((unsigned int)now - 1);
+			set_dec((int)now);
 		return;
 	}
 	old_regs = set_irq_regs(regs);
@@ -611,8 +611,6 @@ void timer_interrupt(struct pt_regs * regs)
 
 	if (evt->event_handler)
 		evt->event_handler(evt);
-	else
-		evt->set_next_event(DECREMENTER_MAX, evt);
 
 #ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES) && hvlpevent_is_pending())
@@ -836,9 +834,6 @@ static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
 	__get_cpu_var(decrementer_next_tb) = get_tb_or_rtc() + evt;
-	/* The decrementer interrupts on the 0 -> -1 transition */
-	if (evt)
-		--evt;
 	set_dec(evt);
 	return 0;
 }
@@ -871,7 +866,8 @@ void init_decrementer_clockevent(void)
 					     decrementer_clockevent.shift);
 	decrementer_clockevent.max_delta_ns =
 		clockevent_delta2ns(DECREMENTER_MAX, &decrementer_clockevent);
-	decrementer_clockevent.min_delta_ns = 1000;
+	decrementer_clockevent.min_delta_ns =
+		clockevent_delta2ns(2, &decrementer_clockevent);
 
 	register_decrementer_clockevent(cpu);
 }
diff --git a/include/asm-powerpc/time.h b/include/asm-powerpc/time.h
index f058955..780f826 100644
--- a/include/asm-powerpc/time.h
+++ b/include/asm-powerpc/time.h
@@ -176,25 +176,31 @@ static inline unsigned int get_dec(void)
 #endif
 }
 
+/*
+ * Note: Book E and 4xx processors differ from other PowerPC processors
+ * in when the decrementer generates its interrupt: on the 1 to 0
+ * transition for Book E/4xx, but on the 0 to -1 transition for others.
+ */
 static inline void set_dec(int val)
 {
 #if defined(CONFIG_40x)
 	mtspr(SPRN_PIT, val);
 #elif defined(CONFIG_8xx_CPU6)
-	set_dec_cpu6(val);
+	set_dec_cpu6(val - 1);
 #else
+#ifndef CONFIG_BOOKE
+	--val;
+#endif
 #ifdef CONFIG_PPC_ISERIES
-	int cur_dec;
-
 	if (firmware_has_feature(FW_FEATURE_ISERIES) &&
 			get_lppaca()->shared_proc) {
 		get_lppaca()->virtual_decr = val;
-		cur_dec = get_dec();
-		if (cur_dec > val)
+		if (get_dec() > val)
 			HvCall_setVirtualDecr();
-	} else
+		return;
+	}
 #endif
-		mtspr(SPRN_DEC, val);
+	mtspr(SPRN_DEC, val);
 #endif /* not 40x or 8xx_CPU6 */
 }
 
