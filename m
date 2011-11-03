Return-Path: <anton@samba.org>
Message-Id: <20111103010111.951358660@samba.org>
Date: Thu, 03 Nov 2011 11:59:24 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 johnstul@us.ibm.com
Subject: [PATCH 2/4] powerpc/time: Use clocksource_register_hz
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

Use clocksource_register_hz which calculates the shift/mult
factors for us.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/time.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-03 10:19:59.493679032 +1100
+++ linux-build/arch/powerpc/kernel/time.c	2011-11-03 10:20:00.965704053 +1100
@@ -86,8 +86,6 @@ static struct clocksource clocksource_rt
 	.rating       = 400,
 	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
 	.mask         = CLOCKSOURCE_MASK(64),
-	.shift        = 22,
-	.mult         = 0,	/* To be filled in */
 	.read         = rtc_read,
 };
 
@@ -97,8 +95,6 @@ static struct clocksource clocksource_ti
 	.rating       = 400,
 	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
 	.mask         = CLOCKSOURCE_MASK(64),
-	.shift        = 22,
-	.mult         = 0,	/* To be filled in */
 	.read         = timebase_read,
 };
 
@@ -875,9 +871,7 @@ static void __init clocksource_init(void
 	else
 		clock = &clocksource_timebase;
 
-	clock->mult = clocksource_hz2mult(tb_ticks_per_sec, clock->shift);
-
-	if (clocksource_register(clock)) {
+	if (clocksource_register_hz(clock, tb_ticks_per_sec)) {
 		printk(KERN_ERR "clocksource: %s is already registered\n",
 		       clock->name);
 		return;
