Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35698DDECC
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:08:30 +1000 (EST)
Subject: [PATCH 1/5 v3] adb: replace sleep notifier with platform driver
	suspend/resume hooks
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1175676113.3556.2.camel@johannes.berg>
References: <20070319181800.149901000@sipsolutions.net>
	<20070319183619.051498000@sipsolutions.net>
	<1174349717.3660.7.camel@johannes.berg>
	<1175676113.3556.2.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 15:37:59 +0200
Message-Id: <1175693879.3600.7.camel@johannes.berg>
Mime-Version: 1.0
Cc: David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch replaces the pmu sleep notifier that adb had with
suspend/resume hooks in a new platform driver/device.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Yes, it's more a hack. But the whole code is such a mess that I could
work for days fixing it. Don't feel like doing that. Of course you can
screw yourself by unbinding the adb platform driver from the adb.0
platform device this creates. Tough luck.

 drivers/macintosh/adb.c |   96 ++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 39 deletions(-)

--- wireless-dev.orig/drivers/macintosh/adb.c	2007-04-04 14:01:41.044706154 +0200
+++ wireless-dev/drivers/macintosh/adb.c	2007-04-04 15:34:02.998565695 +0200
@@ -89,14 +89,6 @@ static int sleepy_trackpad;
 static int autopoll_devs;
 int __adb_probe_sync;
 
-#ifdef CONFIG_PM
-static void adb_notify_sleep(struct pmu_sleep_notifier *self, int when);
-static struct pmu_sleep_notifier adb_sleep_notifier = {
-	adb_notify_sleep,
-	SLEEP_LEVEL_ADB,
-};
-#endif
-
 static int adb_scan_bus(void);
 static int do_adb_reset_bus(void);
 static void adbdev_init(void);
@@ -287,6 +279,36 @@ adb_reset_bus(void)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+/*
+ * notify clients before sleep
+ */
+static int adb_suspend(struct platform_device *dev, pm_message_t state)
+{
+	adb_got_sleep = 1;
+	/* We need to get a lock on the probe thread */
+	down(&adb_probe_mutex);
+	/* Stop autopoll */
+	if (adb_controller->autopoll)
+		adb_controller->autopoll(0);
+	blocking_notifier_call_chain(&adb_client_list, ADB_MSG_POWERDOWN, NULL);
+
+	return 0;
+}
+
+/*
+ * reset bus after sleep
+ */
+static int adb_resume(struct platform_device *dev)
+{
+	adb_got_sleep = 0;
+	up(&adb_probe_mutex);
+	adb_reset_bus();
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 int __init adb_init(void)
 {
 	struct adb_driver *driver;
@@ -319,14 +341,12 @@ int __init adb_init(void)
 		printk(KERN_WARNING "Warning: no ADB interface detected\n");
 		adb_controller = NULL;
 	} else {
-#ifdef CONFIG_PM
-		pmu_register_sleep_notifier(&adb_sleep_notifier);
-#endif /* CONFIG_PM */
 #ifdef CONFIG_PPC
 		if (machine_is_compatible("AAPL,PowerBook1998") ||
 			machine_is_compatible("PowerBook1,1"))
 			sleepy_trackpad = 1;
 #endif /* CONFIG_PPC */
+
 		init_completion(&adb_probe_task_comp);
 		adbdev_init();
 		adb_reset_bus();
@@ -336,33 +356,6 @@ int __init adb_init(void)
 
 __initcall(adb_init);
 
-#ifdef CONFIG_PM
-/*
- * notify clients before sleep and reset bus afterwards
- */
-void
-adb_notify_sleep(struct pmu_sleep_notifier *self, int when)
-{
-	switch (when) {
-	case PBOOK_SLEEP_REQUEST:
-		adb_got_sleep = 1;
-		/* We need to get a lock on the probe thread */
-		down(&adb_probe_mutex);
-		/* Stop autopoll */
-		if (adb_controller->autopoll)
-			adb_controller->autopoll(0);
-		blocking_notifier_call_chain(&adb_client_list,
-			ADB_MSG_POWERDOWN, NULL);
-		break;
-	case PBOOK_WAKE:
-		adb_got_sleep = 0;
-		up(&adb_probe_mutex);
-		adb_reset_bus();
-		break;
-	}
-}
-#endif /* CONFIG_PM */
-
 static int
 do_adb_reset_bus(void)
 {
@@ -870,7 +863,29 @@ static const struct file_operations adb_
 	.release	= adb_release,
 };
 
-static void
+static struct platform_driver adb_pfdrv = {
+	.driver = {
+		.name = "adb",
+	},
+#ifdef CONFIG_PM
+	.suspend = adb_suspend,
+	.resume = adb_resume,
+#endif
+};
+
+static struct platform_device adb_pfdev = {
+	.name = "adb",
+};
+
+static int __init
+adb_dummy_probe(struct platform_device *dev)
+{
+	if (dev == &adb_pfdev)
+		return 0;
+	return -ENODEV;
+}
+
+static void __init
 adbdev_init(void)
 {
 	if (register_chrdev(ADB_MAJOR, "adb", &adb_fops)) {
@@ -882,4 +897,7 @@ adbdev_init(void)
 	if (IS_ERR(adb_dev_class))
 		return;
 	class_device_create(adb_dev_class, NULL, MKDEV(ADB_MAJOR, 0), NULL, "adb");
+
+	platform_device_register(&adb_pfdev);
+	platform_driver_probe(&adb_pfdrv, adb_dummy_probe);
 }
