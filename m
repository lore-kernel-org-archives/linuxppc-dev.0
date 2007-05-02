Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0C85DDF82
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 18:15:55 +1000 (EST)
Subject: [PATCH] via-pmu: kill sleep notifiers completely
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 02 May 2007 08:18:30 +0200
Message-Id: <1178086710.13233.23.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch kills off the remnants of the ancient sleep notifiers.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Obviously depends on the previous patches that remove all the users.

 drivers/macintosh/via-pmu.c |   71 --------------------------------------------
 include/linux/pmu.h         |   36 ----------------------
 2 files changed, 107 deletions(-)

--- wireless-dev.orig/drivers/macintosh/via-pmu.c	2007-05-02 07:24:43.429196053 +0200
+++ wireless-dev/drivers/macintosh/via-pmu.c	2007-05-02 08:15:04.959192713 +0200
@@ -177,7 +177,6 @@ static struct proc_dir_entry *proc_pmu_b
 
 int __fake_sleep;
 int asleep;
-BLOCKING_NOTIFIER_HEAD(sleep_notifier_list);
 
 #ifdef CONFIG_ADB
 static int adb_dev_map;
@@ -1738,67 +1737,7 @@ pmu_present(void)
 	return via != 0;
 }
 
-#ifdef CONFIG_PM
-
-static LIST_HEAD(sleep_notifiers);
-
-int
-pmu_register_sleep_notifier(struct pmu_sleep_notifier *n)
-{
-	struct list_head *list;
-	struct pmu_sleep_notifier *notifier;
-
-	for (list = sleep_notifiers.next; list != &sleep_notifiers;
-	     list = list->next) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
-		if (n->priority > notifier->priority)
-			break;
-	}
-	__list_add(&n->list, list->prev, list);
-	return 0;
-}
-EXPORT_SYMBOL(pmu_register_sleep_notifier);
-
-int
-pmu_unregister_sleep_notifier(struct pmu_sleep_notifier* n)
-{
-	if (n->list.next == 0)
-		return -ENOENT;
-	list_del(&n->list);
-	n->list.next = NULL;
-	return 0;
-}
-EXPORT_SYMBOL(pmu_unregister_sleep_notifier);
-#endif /* CONFIG_PM */
-
 #if defined(CONFIG_PM) && defined(CONFIG_PPC32)
-
-/* Sleep is broadcast last-to-first */
-static void broadcast_sleep(int when)
-{
-	struct list_head *list;
-	struct pmu_sleep_notifier *notifier;
-
-	for (list = sleep_notifiers.prev; list != &sleep_notifiers;
-	     list = list->prev) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
-		notifier->notifier_call(notifier, when);
-	}
-}
-
-/* Wake is broadcast first-to-last */
-static void broadcast_wake(void)
-{
-	struct list_head *list;
-	struct pmu_sleep_notifier *notifier;
-
-	for (list = sleep_notifiers.next; list != &sleep_notifiers;
-	     list = list->next) {
-		notifier = list_entry(list, struct pmu_sleep_notifier, list);
-		notifier->notifier_call(notifier, PBOOK_WAKE);
-	}
-}
-
 /*
  * This struct is used to store config register values for
  * PCI devices which may get powered off when we sleep.
@@ -2003,9 +1942,6 @@ pmac_suspend_devices(void)
 
 	pm_prepare_console();
 	
-	/* Notify old-style device drivers */
-	broadcast_sleep(PBOOK_SLEEP_REQUEST);
-
 	/* Sync the disks. */
 	/* XXX It would be nice to have some way to ensure that
 	 * nobody is dirtying any new buffers while we wait. That
@@ -2014,12 +1950,9 @@ pmac_suspend_devices(void)
 	 */
 	sys_sync();
 
-	broadcast_sleep(PBOOK_SLEEP_NOW);
-
 	/* Send suspend call to devices, hold the device core's dpm_sem */
 	ret = device_suspend(PMSG_SUSPEND);
 	if (ret) {
-		broadcast_wake();
 		printk(KERN_ERR "Driver sleep failed\n");
 		return -EBUSY;
 	}
@@ -2060,7 +1993,6 @@ pmac_suspend_devices(void)
 		local_irq_enable();
 		preempt_enable();
 		device_resume();
-		broadcast_wake();
 		printk(KERN_ERR "Driver powerdown failed\n");
 		return -EBUSY;
 	}
@@ -2114,9 +2046,6 @@ pmac_wakeup_devices(void)
 	/* Resume devices */
 	device_resume();
 
-	/* Notify old style drivers */
-	broadcast_wake();
-
 	pm_restore_console();
 
 	return 0;
--- wireless-dev.orig/include/linux/pmu.h	2007-05-02 07:24:24.169196053 +0200
+++ wireless-dev/include/linux/pmu.h	2007-05-02 07:24:43.569196053 +0200
@@ -159,42 +159,6 @@ extern void pmu_unlock(void);
 extern int pmu_present(void);
 extern int pmu_get_model(void);
 
-#ifdef CONFIG_PM
-/*
- * Stuff for putting the powerbook to sleep and waking it again.
- *
- */
-#include <linux/list.h>
-
-struct pmu_sleep_notifier
-{
-	void (*notifier_call)(struct pmu_sleep_notifier *self, int when);
-	int priority;
-	struct list_head list;
-};
-
-/* Code values for calling sleep/wakeup handlers
- */
-#define PBOOK_SLEEP_REQUEST	1
-#define PBOOK_SLEEP_NOW		2
-#define PBOOK_WAKE		3
-
-/* priority levels in notifiers */
-#define SLEEP_LEVEL_VIDEO	100	/* Video driver (first wake) */
-#define SLEEP_LEVEL_MEDIABAY	90	/* Media bay driver */
-#define SLEEP_LEVEL_BLOCK	80	/* IDE, SCSI */
-#define SLEEP_LEVEL_NET		70	/* bmac, gmac */
-#define SLEEP_LEVEL_MISC	60	/* Anything else */
-#define SLEEP_LEVEL_USERLAND	55	/* Reserved for apm_emu */
-#define SLEEP_LEVEL_ADB		50	/* ADB (async) */
-#define SLEEP_LEVEL_SOUND	40	/* Sound driver (blocking) */
-
-/* special register notifier functions */
-int pmu_register_sleep_notifier(struct pmu_sleep_notifier* notifier);
-int pmu_unregister_sleep_notifier(struct pmu_sleep_notifier* notifier);
-
-#endif /* CONFIG_PM */
-
 #define PMU_MAX_BATTERIES	2
 
 /* values for pmu_power_flags */
