Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 15:00:21 +1100
Subject: [PATCH] [POWERPC] Fix for via-pmu based backlight control
Message-Id: <20071220040025.0951BDE14A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a few issues with via-pmu based backlight control.

First, it fixes a sign problem with the setup of the backlight
curve since the values there -can- (and will) go negative.

Then, it reworks the interaction between this and the via-pmu sleep
code to properly restore backlight on wakeup from sleep.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/macintosh/via-pmu-backlight.c |   48 ++++++++++++++++++++--------------
 drivers/macintosh/via-pmu.c           |   26 +++++++-----------
 include/linux/pmu.h                   |    2 +
 3 files changed, 42 insertions(+), 34 deletions(-)

--- linux-merge.orig/drivers/macintosh/via-pmu-backlight.c	2007-12-20 11:54:57.000000000 +1100
+++ linux-merge/drivers/macintosh/via-pmu-backlight.c	2007-12-20 12:49:04.000000000 +1100
@@ -22,7 +22,7 @@ static u8 bl_curve[FB_BACKLIGHT_LEVELS];
 
 static void pmu_backlight_init_curve(u8 off, u8 min, u8 max)
 {
-	unsigned int i, flat, count, range = (max - min);
+	int i, flat, count, range = (max - min);
 
 	bl_curve[0] = off;
 
@@ -68,17 +68,11 @@ static int pmu_backlight_get_level_brigh
 	return pmulevel;
 }
 
-static int pmu_backlight_update_status(struct backlight_device *bd)
+static int __pmu_backlight_update_status(struct backlight_device *bd)
 {
 	struct adb_request req;
-	unsigned long flags;
 	int level = bd->props.brightness;
 
-	spin_lock_irqsave(&pmu_backlight_lock, flags);
-
-	/* Don't update brightness when sleeping */
-	if (sleeping)
-		goto out;
 
 	if (bd->props.power != FB_BLANK_UNBLANK ||
 	    bd->props.fb_blank != FB_BLANK_UNBLANK)
@@ -99,12 +93,23 @@ static int pmu_backlight_update_status(s
 		pmu_wait_complete(&req);
 	}
 
-out:
-	spin_unlock_irqrestore(&pmu_backlight_lock, flags);
-
 	return 0;
 }
 
+static int pmu_backlight_update_status(struct backlight_device *bd)
+{
+	unsigned long flags;
+	int rc = 0;
+
+	spin_lock_irqsave(&pmu_backlight_lock, flags);
+	/* Don't update brightness when sleeping */
+	if (!sleeping)
+		rc = __pmu_backlight_update_status(bd);
+	spin_unlock_irqrestore(&pmu_backlight_lock, flags);
+	return rc;
+}
+
+
 static int pmu_backlight_get_brightness(struct backlight_device *bd)
 {
 	return bd->props.brightness;
@@ -123,6 +128,16 @@ void pmu_backlight_set_sleep(int sleep)
 
 	spin_lock_irqsave(&pmu_backlight_lock, flags);
 	sleeping = sleep;
+	if (pmac_backlight) {
+		if (sleep) {
+			struct adb_request req;
+
+			pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
+				    PMU_POW_BACKLIGHT | PMU_POW_OFF);
+			pmu_wait_complete(&req);
+		} else
+			__pmu_backlight_update_status(pmac_backlight);
+	}
 	spin_unlock_irqrestore(&pmu_backlight_lock, flags);
 }
 #endif /* CONFIG_PM */
@@ -148,8 +163,8 @@ void __init pmu_backlight_init()
 
 	bd = backlight_device_register(name, NULL, NULL, &pmu_backlight_data);
 	if (IS_ERR(bd)) {
-		printk("pmubl: Backlight registration failed\n");
-		goto error;
+		printk(KERN_ERR "PMU Backlight registration failed\n");
+		return;
 	}
 	bd->props.max_brightness = FB_BACKLIGHT_LEVELS - 1;
 	pmu_backlight_init_curve(0x7F, 0x46, 0x0E);
@@ -171,10 +186,5 @@ void __init pmu_backlight_init()
 	bd->props.power = FB_BLANK_UNBLANK;
 	backlight_update_status(bd);
 
-	printk("pmubl: Backlight initialized (%s)\n", name);
-
-	return;
-
-error:
-	return;
+	printk(KERN_INFO "PMU Backlight initialized (%s)\n", name);
 }
Index: linux-merge/drivers/macintosh/via-pmu.c
===================================================================
--- linux-merge.orig/drivers/macintosh/via-pmu.c	2007-12-20 12:11:12.000000000 +1100
+++ linux-merge/drivers/macintosh/via-pmu.c	2007-12-20 12:12:46.000000000 +1100
@@ -1758,8 +1758,6 @@ restore_via_state(void)
 	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
 }
 
-extern void pmu_backlight_set_sleep(int sleep);
-
 #define	GRACKLE_PM	(1<<7)
 #define GRACKLE_DOZE	(1<<5)
 #define	GRACKLE_NAP	(1<<4)
@@ -2176,11 +2174,6 @@ pmu_release(struct inode *inode, struct 
  */
 void arch_suspend_disable_irqs(void)
 {
-#ifdef CONFIG_PMAC_BACKLIGHT
-	/* Tell backlight code not to muck around with the chip anymore */
-	pmu_backlight_set_sleep(1);
-#endif
-
 	/* Call platform functions marked "on sleep" */
 	pmac_pfunc_i2c_suspend();
 	pmac_pfunc_base_suspend();
@@ -2236,11 +2229,6 @@ static int powerbook_sleep(suspend_state
 
 	mdelay(100);
 
-#ifdef CONFIG_PMAC_BACKLIGHT
-	/* Tell backlight code it can use the chip again */
-	pmu_backlight_set_sleep(0);
-#endif
-
 	return 0;
 }
 
@@ -2493,10 +2481,15 @@ static int pmu_sys_suspend(struct sys_de
 	if (state.event != PM_EVENT_SUSPEND || pmu_sys_suspended)
 		return 0;
 
-	/* Suspend PMU event interrupts */
+	/* Suspend PMU event interrupts */\
 	pmu_suspend();
-
 	pmu_sys_suspended = 1;
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	/* Tell backlight code not to muck around with the chip anymore */
+	pmu_backlight_set_sleep(1);
+#endif
+
 	return 0;
 }
 
@@ -2511,9 +2504,12 @@ static int pmu_sys_resume(struct sys_dev
 	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
 	pmu_wait_complete(&req);
 
+#ifdef CONFIG_PMAC_BACKLIGHT
+	/* Tell backlight code it can use the chip again */
+	pmu_backlight_set_sleep(0);
+#endif
 	/* Resume PMU event interrupts */
 	pmu_resume();
-
 	pmu_sys_suspended = 0;
 
 	return 0;
Index: linux-merge/include/linux/pmu.h
===================================================================
--- linux-merge.orig/include/linux/pmu.h	2007-12-20 12:11:33.000000000 +1100
+++ linux-merge/include/linux/pmu.h	2007-12-20 12:11:36.000000000 +1100
@@ -159,6 +159,8 @@ extern void pmu_unlock(void);
 extern int pmu_present(void);
 extern int pmu_get_model(void);
 
+extern void pmu_backlight_set_sleep(int sleep);
+
 #define PMU_MAX_BATTERIES	2
 
 /* values for pmu_power_flags */
