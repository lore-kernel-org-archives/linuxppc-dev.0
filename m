Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5B9FDDFAD
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:32:36 +1000 (EST)
Subject: [PATCH v2] via-pmu: remove LED sleep notifier
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070502205741.72dc191b.sfr@canb.auug.org.au>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178084161.13233.16.camel@johannes.berg>
	<20070502205741.72dc191b.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 02 May 2007 16:32:57 +0200
Message-Id: <1178116377.13233.63.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The generic LED code now makes sure that suspended devices don't blink,
so we no longer need to do it ourselves. For the suspend to disk case,
however, we need to make sure that we don't blink if the PMU sysdev
was suspended before the LED device.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 drivers/macintosh/via-pmu-led.c |   35 +++--------------------------------
 drivers/macintosh/via-pmu.c     |    2 +-
 include/linux/pmu.h             |    3 +++
 3 files changed, 7 insertions(+), 33 deletions(-)

--- wireless-dev.orig/drivers/macintosh/via-pmu-led.c	2007-05-02 10:46:52.289190072 +0200
+++ wireless-dev/drivers/macintosh/via-pmu-led.c	2007-05-02 16:31:37.019177080 +0200
@@ -31,7 +31,6 @@ static spinlock_t pmu_blink_lock;
 static struct adb_request pmu_blink_req;
 /* -1: no change, 0: request off, 1: request on */
 static int requested_change;
-static int sleeping;
 
 static void pmu_req_done(struct adb_request * req)
 {
@@ -41,7 +40,7 @@ static void pmu_req_done(struct adb_requ
 	/* if someone requested a change in the meantime
 	 * (we only see the last one which is fine)
 	 * then apply it now */
-	if (requested_change != -1 && !sleeping)
+	if (requested_change != -1 && !pmu_sys_suspended)
 		pmu_request(&pmu_blink_req, NULL, 4, 0xee, 4, 0, requested_change);
 	/* reset requested change */
 	requested_change = -1;
@@ -66,7 +65,7 @@ static void pmu_led_set(struct led_class
 		break;
 	}
 	/* if request isn't done, then don't do anything */
-	if (pmu_blink_req.complete && !sleeping)
+	if (pmu_blink_req.complete && !pmu_sys_suspended)
 		pmu_request(&pmu_blink_req, NULL, 4, 0xee, 4, 0, requested_change);
  out:
  	spin_unlock_irqrestore(&pmu_blink_lock, flags);
@@ -80,32 +79,6 @@ static struct led_classdev pmu_led = {
 	.brightness_set = pmu_led_set,
 };
 
-#ifdef CONFIG_PM
-static void pmu_led_sleep_call(struct pmu_sleep_notifier *self, int when)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&pmu_blink_lock, flags);
-
-	switch (when) {
-	case PBOOK_SLEEP_REQUEST:
-		sleeping = 1;
-		break;
-	case PBOOK_WAKE:
-		sleeping = 0;
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
-	spin_unlock_irqrestore(&pmu_blink_lock, flags);
-}
-
-static struct pmu_sleep_notifier via_pmu_led_sleep_notif = {
-	.notifier_call = pmu_led_sleep_call,
-};
-#endif
-
 static int __init via_pmu_led_init(void)
 {
 	struct device_node *dt;
@@ -135,9 +108,7 @@ static int __init via_pmu_led_init(void)
 	/* no outstanding req */
 	pmu_blink_req.complete = 1;
 	pmu_blink_req.done = pmu_req_done;
-#ifdef CONFIG_PM
-	pmu_register_sleep_notifier(&via_pmu_led_sleep_notif);
-#endif
+
 	return led_classdev_register(NULL, &pmu_led);
 }
 
--- wireless-dev.orig/drivers/macintosh/via-pmu.c	2007-05-02 10:46:52.319190072 +0200
+++ wireless-dev/drivers/macintosh/via-pmu.c	2007-05-02 16:30:42.849177080 +0200
@@ -2759,7 +2759,7 @@ pmu_polled_request(struct adb_request *r
 
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 
-static int pmu_sys_suspended;
+int pmu_sys_suspended;
 
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {
--- wireless-dev.orig/include/linux/pmu.h	2007-05-02 16:30:48.519177080 +0200
+++ wireless-dev/include/linux/pmu.h	2007-05-02 16:31:29.619177080 +0200
@@ -225,4 +225,7 @@ extern unsigned int pmu_power_flags;
 /* Backlight */
 extern void pmu_backlight_init(void);
 
+/* some code needs to know if the PMU was suspended for hibernation */
+extern int pmu_sys_suspended;
+
 #endif	/* __KERNEL__ */
