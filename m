Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D858867B5E
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jun 2005 14:19:35 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 14:19:02 +1000
Message-Id: <1118377143.5986.4.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32: Fix nasty sleep/wakeup problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

(This _is_ for 2.6.12 is possible)

Despite all the care lately in making the powermac sleep/wakeup as
robust as possible, there is still a nasty related to the use of cpufreq
on PMU based machines. Unfortunately, it affects paulus old powerbook so
I have to fix it :)

We didn't manage to understand what is precisely going on, it leads to
memory corruption and might have to do with RAM not beeing properly
refreshed when a cpufreq transition is done right before the sleep.

The best workaround (and less intrusive at this point) we could come up
with is included in this patch. We basically do _not_ force a switch to
high speed on suspend anymore (that is what is causing the problem) on
those machines. We still force a speed switch on wakeup (since we don't
know what speed we are coming back from sleep at, and that seems to work
fine).

Since, during this short interval, the actual CPU speed might be
incorrect, we also hack around by multiplying loops_per_jiffy by 2 (max
speed factor on those machines) during early wakeup stage to make sure
udelay's during that time aren't too short.

For after 2.6.12, we'll change udelay implementation to use the CPU
timebase (which is always constant) instead like we do on ppc64 and thus
get rid of all those problems.

Please apply,

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/pmac_cpufreq.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_cpufreq.c	2005-06-10 13:42:44.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_cpufreq.c	2005-06-10 13:45:44.000000000 +1000
@@ -83,7 +83,7 @@
 static u32 slew_done_gpio;
 static int no_schedule;
 static int has_cpu_l2lve;
-
+static int is_pmu_based;
 
 /* There are only two frequency states for each processor. Values
  * are in kHz for the time being.
@@ -463,7 +463,7 @@
 	 */
 	no_schedule = 1;
 	sleep_freq = cur_freq;
-	if (cur_freq == low_freq)
+	if (cur_freq == low_freq && !is_pmu_based)
 		do_set_cpu_speed(CPUFREQ_HIGH, 0);
 	return 0;
 }
@@ -588,6 +588,7 @@
 		return 1;
 	hi_freq = (*value) / 1000;
 	set_speed_proc = pmu_set_cpu_speed;
+	is_pmu_based = 1;
 
 	return 0;
 }
@@ -692,6 +693,7 @@
 		hi_freq = cur_freq;
 		low_freq = 400000;
 		set_speed_proc = pmu_set_cpu_speed;
+		is_pmu_based = 1;
 	}
 	/* Else check for TiPb 400 & 500 */
 	else if (machine_is_compatible("PowerBook3,2")) {
@@ -703,6 +705,7 @@
 		hi_freq = cur_freq;
 		low_freq = 300000;
 		set_speed_proc = pmu_set_cpu_speed;
+		is_pmu_based = 1;
 	}
 	/* Else check for 750FX */
 	else if (PVR_VER(mfspr(SPRN_PVR)) == 0x7000)
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-06-10 13:42:44.000000000 +1000
+++ linux-work/drivers/macintosh/via-pmu.c	2005-06-10 13:47:30.000000000 +1000
@@ -2593,6 +2593,9 @@
 	/* Restore VIA */
 	restore_via_state();
 
+	/* tweak LPJ before cpufreq is there */
+	loops_per_jiffy *= 2;
+
 	/* Restore video */
 	pmac_call_early_video_resume();
 
@@ -2613,6 +2616,9 @@
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	pmu_wait_complete(&req);
 
+	/* Restore LPJ, cpufreq will adjust the cpu frequency */
+	loops_per_jiffy /= 2;
+
 	pmac_wakeup_devices();
 
 	return 0;
