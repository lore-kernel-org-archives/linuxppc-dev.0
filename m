Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 03 Mar 2008 17:27:46 +1100
Subject: [PATCH] [POWERPC] (testers ?) Fix sleep on some powerbooks
Message-Id: <20080303062831.6BD8EDDED8@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PMU backlight code would kick in during sleep/resume even on
machines that use a different backlight method. This appears to
break sleep on my PowerBook, though I can't test that patch at
the moment as the machine died while I was bisecting.

So if anybody around has one of those latest revision PowerPC
PowerBooks, the one just before they went to Intel, and have a
problem with suspend/resume, please test this and let me know
if it helps.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/macintosh/via-pmu-backlight.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-work.orig/drivers/macintosh/via-pmu-backlight.c	2008-03-03 17:24:44.000000000 +1100
+++ linux-work/drivers/macintosh/via-pmu-backlight.c	2008-03-03 17:25:12.000000000 +1100
@@ -17,7 +17,7 @@
 
 static struct backlight_ops pmu_backlight_data;
 static DEFINE_SPINLOCK(pmu_backlight_lock);
-static int sleeping;
+static int sleeping, uses_pmu_bl;
 static u8 bl_curve[FB_BACKLIGHT_LEVELS];
 
 static void pmu_backlight_init_curve(u8 off, u8 min, u8 max)
@@ -128,7 +128,7 @@ void pmu_backlight_set_sleep(int sleep)
 
 	spin_lock_irqsave(&pmu_backlight_lock, flags);
 	sleeping = sleep;
-	if (pmac_backlight) {
+	if (pmac_backlight && uses_pmu_bl) {
 		if (sleep) {
 			struct adb_request req;
 
@@ -166,6 +166,7 @@ void __init pmu_backlight_init()
 		printk(KERN_ERR "PMU Backlight registration failed\n");
 		return;
 	}
+	uses_pmu_bl = 1;
 	bd->props.max_brightness = FB_BACKLIGHT_LEVELS - 1;
 	pmu_backlight_init_curve(0x7F, 0x46, 0x0E);
 
