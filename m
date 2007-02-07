Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90FFEDE19D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 00:01:11 +1100 (EST)
Message-Id: <20070207124615.015873000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Date: Wed, 07 Feb 2007 13:45:47 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/12] powermac: disallow pmu sleep notifiers from aborting
	sleep
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tracing through the code, no current PMU sleep notifier can abort sleep.
Since no new PMU sleep notifiers should be added, this patch simplifies the
code and removes the ability to abort sleep.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
This is just something I did before I understood how to do the next patch
in this series. If you want, I can drop this one and rework the next, it's
very well possible to abort suspend from these callbacks even with the
next patch.

--- linux-2.6-git.orig/drivers/macintosh/adb.c	2007-02-07 02:54:56.301884289 +0100
+++ linux-2.6-git/drivers/macintosh/adb.c	2007-02-07 02:55:35.961884289 +0100
@@ -90,7 +90,7 @@ static int autopoll_devs;
 int __adb_probe_sync;
 
 #ifdef CONFIG_PM
-static int adb_notify_sleep(struct pmu_sleep_notifier *self, int when);
+static void adb_notify_sleep(struct pmu_sleep_notifier *self, int when);
 static struct pmu_sleep_notifier adb_sleep_notifier = {
 	adb_notify_sleep,
 	SLEEP_LEVEL_ADB,
@@ -340,11 +340,9 @@ __initcall(adb_init);
 /*
  * notify clients before sleep and reset bus afterwards
  */
-int
+void
 adb_notify_sleep(struct pmu_sleep_notifier *self, int when)
 {
-	int ret;
-	
 	switch (when) {
 	case PBOOK_SLEEP_REQUEST:
 		adb_got_sleep = 1;
@@ -353,22 +351,8 @@ adb_notify_sleep(struct pmu_sleep_notifi
 		/* Stop autopoll */
 		if (adb_controller->autopoll)
 			adb_controller->autopoll(0);
-		ret = blocking_notifier_call_chain(&adb_client_list,
-				ADB_MSG_POWERDOWN, NULL);
-		if (ret & NOTIFY_STOP_MASK) {
-			up(&adb_probe_mutex);
-			return PBOOK_SLEEP_REFUSE;
-		}
-		break;
-	case PBOOK_SLEEP_REJECT:
-		if (adb_got_sleep) {
-			adb_got_sleep = 0;
-			up(&adb_probe_mutex);
-			adb_reset_bus();
-		}
-		break;
-		
-	case PBOOK_SLEEP_NOW:
+		blocking_notifier_call_chain(&adb_client_list,
+			ADB_MSG_POWERDOWN, NULL);
 		break;
 	case PBOOK_WAKE:
 		adb_got_sleep = 0;
@@ -376,14 +360,13 @@ adb_notify_sleep(struct pmu_sleep_notifi
 		adb_reset_bus();
 		break;
 	}
-	return PBOOK_SLEEP_OK;
 }
 #endif /* CONFIG_PM */
 
 static int
 do_adb_reset_bus(void)
 {
-	int ret, nret;
+	int ret;
 	
 	if (adb_controller == NULL)
 		return -ENXIO;
@@ -391,13 +374,8 @@ do_adb_reset_bus(void)
 	if (adb_controller->autopoll)
 		adb_controller->autopoll(0);
 
-	nret = blocking_notifier_call_chain(&adb_client_list,
-			ADB_MSG_PRE_RESET, NULL);
-	if (nret & NOTIFY_STOP_MASK) {
-		if (adb_controller->autopoll)
-			adb_controller->autopoll(autopoll_devs);
-		return -EBUSY;
-	}
+	blocking_notifier_call_chain(&adb_client_list,
+		ADB_MSG_PRE_RESET, NULL);
 
 	if (sleepy_trackpad) {
 		/* Let the trackpad settle down */
@@ -427,10 +405,8 @@ do_adb_reset_bus(void)
 	}
 	up(&adb_handler_sem);
 
-	nret = blocking_notifier_call_chain(&adb_client_list,
-			ADB_MSG_POST_RESET, NULL);
-	if (nret & NOTIFY_STOP_MASK)
-		return -EBUSY;
+	blocking_notifier_call_chain(&adb_client_list,
+		ADB_MSG_POST_RESET, NULL);
 	
 	return ret;
 }
--- linux-2.6-git.orig/drivers/macintosh/via-pmu.c	2007-02-07 02:54:56.363884289 +0100
+++ linux-2.6-git/drivers/macintosh/via-pmu.c	2007-02-07 02:55:35.966884289 +0100
@@ -1770,35 +1770,21 @@ EXPORT_SYMBOL(pmu_unregister_sleep_notif
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 
 /* Sleep is broadcast last-to-first */
-static int
-broadcast_sleep(int when, int fallback)
+static void broadcast_sleep(int when)
 {
-	int ret = PBOOK_SLEEP_OK;
 	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
 	for (list = sleep_notifiers.prev; list != &sleep_notifiers;
 	     list = list->prev) {
 		notifier = list_entry(list, struct pmu_sleep_notifier, list);
-		ret = notifier->notifier_call(notifier, when);
-		if (ret != PBOOK_SLEEP_OK) {
-			printk(KERN_DEBUG "sleep %d rejected by %p (%p)\n",
-			       when, notifier, notifier->notifier_call);
-			for (; list != &sleep_notifiers; list = list->next) {
-				notifier = list_entry(list, struct pmu_sleep_notifier, list);
-				notifier->notifier_call(notifier, fallback);
-			}
-			return ret;
-		}
+		notifier->notifier_call(notifier, when);
 	}
-	return ret;
 }
 
 /* Wake is broadcast first-to-last */
-static int
-broadcast_wake(void)
+static void broadcast_wake(void)
 {
-	int ret = PBOOK_SLEEP_OK;
 	struct list_head *list;
 	struct pmu_sleep_notifier *notifier;
 
@@ -1807,7 +1793,6 @@ broadcast_wake(void)
 		notifier = list_entry(list, struct pmu_sleep_notifier, list);
 		notifier->notifier_call(notifier, PBOOK_WAKE);
 	}
-	return ret;
 }
 
 /*
@@ -2014,12 +1999,8 @@ pmac_suspend_devices(void)
 
 	pm_prepare_console();
 	
-	/* Notify old-style device drivers & userland */
-	ret = broadcast_sleep(PBOOK_SLEEP_REQUEST, PBOOK_SLEEP_REJECT);
-	if (ret != PBOOK_SLEEP_OK) {
-		printk(KERN_ERR "Sleep rejected by drivers\n");
-		return -EBUSY;
-	}
+	/* Notify old-style device drivers */
+	broadcast_sleep(PBOOK_SLEEP_REQUEST);
 
 	/* Sync the disks. */
 	/* XXX It would be nice to have some way to ensure that
@@ -2029,12 +2010,7 @@ pmac_suspend_devices(void)
 	 */
 	sys_sync();
 
-	/* Sleep can fail now. May not be very robust but useful for debugging */
-	ret = broadcast_sleep(PBOOK_SLEEP_NOW, PBOOK_WAKE);
-	if (ret != PBOOK_SLEEP_OK) {
-		printk(KERN_ERR "Driver sleep failed\n");
-		return -EBUSY;
-	}
+	broadcast_sleep(PBOOK_SLEEP_NOW);
 
 	/* Send suspend call to devices, hold the device core's dpm_sem */
 	ret = device_suspend(PMSG_SUSPEND);
--- linux-2.6-git.orig/include/linux/pmu.h	2007-02-07 02:54:56.728884289 +0100
+++ linux-2.6-git/include/linux/pmu.h	2007-02-07 02:55:35.968884289 +0100
@@ -168,24 +168,16 @@ extern int pmu_get_model(void);
 
 struct pmu_sleep_notifier
 {
-	int (*notifier_call)(struct pmu_sleep_notifier *self, int when);
+	void (*notifier_call)(struct pmu_sleep_notifier *self, int when);
 	int priority;
 	struct list_head list;
 };
 
 /* Code values for calling sleep/wakeup handlers
- *
- * Note: If a sleep request got cancelled, all drivers will get
- * the PBOOK_SLEEP_REJECT, even those who didn't get the PBOOK_SLEEP_REQUEST.
  */
 #define PBOOK_SLEEP_REQUEST	1
 #define PBOOK_SLEEP_NOW		2
-#define PBOOK_SLEEP_REJECT	3
-#define PBOOK_WAKE		4
-
-/* Result codes returned by the notifiers */
-#define PBOOK_SLEEP_OK		0
-#define PBOOK_SLEEP_REFUSE	-1
+#define PBOOK_WAKE		3
 
 /* priority levels in notifiers */
 #define SLEEP_LEVEL_VIDEO	100	/* Video driver (first wake) */
--- linux-2.6-git.orig/drivers/macintosh/via-pmu-led.c	2007-02-07 02:54:56.425884289 +0100
+++ linux-2.6-git/drivers/macintosh/via-pmu-led.c	2007-02-07 02:55:35.969884289 +0100
@@ -81,7 +81,7 @@ static struct led_classdev pmu_led = {
 };
 
 #ifdef CONFIG_PM
-static int pmu_led_sleep_call(struct pmu_sleep_notifier *self, int when)
+static void pmu_led_sleep_call(struct pmu_sleep_notifier *self, int when)
 {
 	unsigned long flags;
 
@@ -99,8 +99,6 @@ static int pmu_led_sleep_call(struct pmu
 		break;
 	}
 	spin_unlock_irqrestore(&pmu_blink_lock, flags);
-
-	return PBOOK_SLEEP_OK;
 }
 
 static struct pmu_sleep_notifier via_pmu_led_sleep_notif = {
--- linux-2.6-git.orig/drivers/macintosh/apm_emu.c	2007-02-07 02:54:56.542884289 +0100
+++ linux-2.6-git/drivers/macintosh/apm_emu.c	2007-02-07 02:55:35.972884289 +0100
@@ -96,7 +96,7 @@ static DECLARE_WAIT_QUEUE_HEAD(apm_waitq
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;
 
-static int apm_notify_sleep(struct pmu_sleep_notifier *self, int when);
+static void apm_notify_sleep(struct pmu_sleep_notifier *self, int when);
 static struct pmu_sleep_notifier apm_sleep_notifier = {
 	apm_notify_sleep,
 	SLEEP_LEVEL_USERLAND,
@@ -352,7 +352,7 @@ static int do_open(struct inode * inode,
  * doesn't provide a way to NAK, but this could be added
  * here.
  */
-static int wait_all_suspend(void)
+static void wait_all_suspend(void)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
@@ -366,24 +366,19 @@ static int wait_all_suspend(void)
 	remove_wait_queue(&apm_suspend_waitqueue, &wait);
 
 	DBG("apm_emu: wait_all_suspend() - complete !\n");
-	
-	return 1;
 }
 
-static int apm_notify_sleep(struct pmu_sleep_notifier *self, int when)
+static void apm_notify_sleep(struct pmu_sleep_notifier *self, int when)
 {
 	switch(when) {
 		case PBOOK_SLEEP_REQUEST:
 			queue_event(APM_SYS_SUSPEND, NULL);
-			if (!wait_all_suspend())
-				return PBOOK_SLEEP_REFUSE;
+			wait_all_suspend();
 			break;
-		case PBOOK_SLEEP_REJECT:
 		case PBOOK_WAKE:
 			queue_event(APM_NORMAL_RESUME, NULL);
 			break;
 	}
-	return PBOOK_SLEEP_OK;
 }
 
 #define APM_CRITICAL		10

--
