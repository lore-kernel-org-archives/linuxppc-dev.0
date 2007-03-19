Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41480DDF1C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 05:40:16 +1100 (EST)
Message-Id: <20070319183620.171327000@sipsolutions.net>
References: <20070319181800.149901000@sipsolutions.net>
Date: Mon, 19 Mar 2007 19:18:03 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] via-pmu: remove LED sleep notifier
Mime-Version: 1.0
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
 drivers/macintosh/via-pmu-led.c |   37 +++++--------------------------------
 drivers/macintosh/via-pmu.c     |    2 +-
 2 files changed, 6 insertions(+), 33 deletions(-)

--- linux-2.6.orig/drivers/macintosh/via-pmu-led.c	2007-03-19 19:15:06.563321419 +0100
+++ linux-2.6/drivers/macintosh/via-pmu-led.c	2007-03-19 19:32:30.813321419 +0100
@@ -31,7 +31,8 @@ static spinlock_t pmu_blink_lock;
 static struct adb_request pmu_blink_req;
 /* -1: no change, 0: request off, 1: request on */
 static int requested_change;
-static int sleeping;
+
+extern int pmu_sys_suspended;
 
 static void pmu_req_done(struct adb_request * req)
 {
@@ -41,7 +42,7 @@ static void pmu_req_done(struct adb_requ
 	/* if someone requested a change in the meantime
 	 * (we only see the last one which is fine)
 	 * then apply it now */
-	if (requested_change != -1 && !sleeping)
+	if (requested_change != -1 && !pmu_sys_suspended)
 		pmu_request(&pmu_blink_req, NULL, 4, 0xee, 4, 0, requested_change);
 	/* reset requested change */
 	requested_change = -1;
@@ -66,7 +67,7 @@ static void pmu_led_set(struct led_class
 		break;
 	}
 	/* if request isn't done, then don't do anything */
-	if (pmu_blink_req.complete && !sleeping)
+	if (pmu_blink_req.complete && !pmu_sys_suspended)
 		pmu_request(&pmu_blink_req, NULL, 4, 0xee, 4, 0, requested_change);
  out:
  	spin_unlock_irqrestore(&pmu_blink_lock, flags);
@@ -80,32 +81,6 @@ static struct led_classdev pmu_led = {
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
@@ -133,9 +108,7 @@ static int __init via_pmu_led_init(void)
 	/* no outstanding req */
 	pmu_blink_req.complete = 1;
 	pmu_blink_req.done = pmu_req_done;
-#ifdef CONFIG_PM
-	pmu_register_sleep_notifier(&via_pmu_led_sleep_notif);
-#endif
+
 	return led_classdev_register(NULL, &pmu_led);
 }
 
--- linux-2.6.orig/drivers/macintosh/via-pmu.c	2007-03-19 19:27:38.293321419 +0100
+++ linux-2.6/drivers/macintosh/via-pmu.c	2007-03-19 19:32:04.053321419 +0100
@@ -2699,7 +2699,7 @@ pmu_polled_request(struct adb_request *r
 
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 
-static int pmu_sys_suspended;
+int pmu_sys_suspended;
 
 static int pmu_sys_suspend(struct sys_device *sysdev, pm_message_t state)
 {

--
