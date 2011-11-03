Return-Path: <anton@samba.org>
Message-Id: <20111103010112.114553477@samba.org>
Date: Thu, 03 Nov 2011 11:59:26 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 johnstul@us.ibm.com
Subject: [PATCH 4/4] powerpc/time: Fix some style issues
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

Fix some formatting issues and use the DECREMENTER_MAX
define instead of 0x7fffffff.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/time.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-03 10:20:02.117723634 +1100
+++ linux-build/arch/powerpc/kernel/time.c	2011-11-03 10:20:03.101740361 +1100
@@ -82,20 +82,20 @@
 
 static cycle_t rtc_read(struct clocksource *);
 static struct clocksource clocksource_rtc = {
-	.name         = "rtc",
-	.rating       = 400,
-	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
-	.mask         = CLOCKSOURCE_MASK(64),
-	.read         = rtc_read,
+	.name		= "rtc",
+	.rating		= 400,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.read		= rtc_read,
 };
 
 static cycle_t timebase_read(struct clocksource *);
 static struct clocksource clocksource_timebase = {
-	.name         = "timebase",
-	.rating       = 400,
-	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
-	.mask         = CLOCKSOURCE_MASK(64),
-	.read         = timebase_read,
+	.name		= "timebase",
+	.rating		= 400,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.read		= timebase_read,
 };
 
 #define DECREMENTER_MAX	0x7fffffff
@@ -106,12 +106,12 @@ static void decrementer_set_mode(enum cl
 				 struct clock_event_device *dev);
 
 static struct clock_event_device decrementer_clockevent = {
-       .name           = "decrementer",
-       .rating         = 200,
-       .irq            = 0,
-       .set_next_event = decrementer_set_next_event,
-       .set_mode       = decrementer_set_mode,
-       .features       = CLOCK_EVT_FEAT_ONESHOT,
+	.name		= "decrementer",
+	.rating		= 200,
+	.irq		= 0,
+	.set_next_event	= decrementer_set_next_event,
+	.set_mode	= decrementer_set_mode,
+	.features	= CLOCK_EVT_FEAT_ONESHOT,
 };
 
 static DEFINE_PER_CPU(struct clock_event_device, decrementers);
@@ -430,7 +430,7 @@ EXPORT_SYMBOL(profile_pc);
 /* 
  * This function recalibrates the timebase based on the 49-bit time-of-day
  * value in the Titan chip.  The Titan is much more accurate than the value
- * returned by the service processor for the timebase frequency.  
+ * returned by the service processor for the timebase frequency.
  */
 
 static int __init iSeries_tb_recal(void)
@@ -628,9 +628,9 @@ static void generic_suspend_disable_irqs
 	 * with suspending.
 	 */
 
-	set_dec(0x7fffffff);
+	set_dec(DECREMENTER_MAX);
 	local_irq_disable();
-	set_dec(0x7fffffff);
+	set_dec(DECREMENTER_MAX);
 }
 
 static void generic_suspend_enable_irqs(void)
@@ -965,10 +965,10 @@ void __init time_init(void)
 	boot_tb = get_tb_or_rtc();
 
 	/* If platform provided a timezone (pmac), we correct the time */
-        if (timezone_offset) {
+	if (timezone_offset) {
 		sys_tz.tz_minuteswest = -timezone_offset / 60;
 		sys_tz.tz_dsttime = 0;
-        }
+	}
 
 	vdso_data->tb_update_count = 0;
 	vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
