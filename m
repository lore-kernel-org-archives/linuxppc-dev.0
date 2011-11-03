Return-Path: <anton@samba.org>
Message-Id: <20111103010111.868598561@samba.org>
Date: Thu, 03 Nov 2011 11:59:23 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 johnstul@us.ibm.com
Subject: [PATCH 1/4] powerpc/time: Use clockevents_calc_mult_shift
References: <20111103005922.854058953@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can use clockevents_calc_mult_shift instead of doing all
the work ourselves.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/time.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-03 10:19:55.225606490 +1100
+++ linux-build/arch/powerpc/kernel/time.c	2011-11-03 10:19:59.493679032 +1100
@@ -112,8 +112,6 @@ static void decrementer_set_mode(enum cl
 static struct clock_event_device decrementer_clockevent = {
        .name           = "decrementer",
        .rating         = 200,
-       .shift          = 0,	/* To be filled in */
-       .mult           = 0,	/* To be filled in */
        .irq            = 0,
        .set_next_event = decrementer_set_next_event,
        .set_mode       = decrementer_set_mode,
@@ -904,31 +902,6 @@ static void decrementer_set_mode(enum cl
 		decrementer_set_next_event(DECREMENTER_MAX, dev);
 }
 
-static inline uint64_t div_sc64(unsigned long ticks, unsigned long nsec,
-				int shift)
-{
-	uint64_t tmp = ((uint64_t)ticks) << shift;
-
-	do_div(tmp, nsec);
-	return tmp;
-}
-
-static void __init setup_clockevent_multiplier(unsigned long hz)
-{
-	u64 mult, shift = 32;
-
-	while (1) {
-		mult = div_sc64(hz, NSEC_PER_SEC, shift);
-		if (mult && (mult >> 32UL) == 0UL)
-			break;
-
-		shift--;
-	}
-
-	decrementer_clockevent.shift = shift;
-	decrementer_clockevent.mult = mult;
-}
-
 static void register_decrementer_clockevent(int cpu)
 {
 	struct clock_event_device *dec = &per_cpu(decrementers, cpu).event;
@@ -946,7 +919,8 @@ static void __init init_decrementer_cloc
 {
 	int cpu = smp_processor_id();
 
-	setup_clockevent_multiplier(ppc_tb_freq);
+	clockevents_calc_mult_shift(&decrementer_clockevent, ppc_tb_freq, 4);
+
 	decrementer_clockevent.max_delta_ns =
 		clockevent_delta2ns(DECREMENTER_MAX, &decrementer_clockevent);
 	decrementer_clockevent.min_delta_ns =
