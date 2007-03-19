Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33A57DDEBB
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 05:40:14 +1100 (EST)
Message-Id: <20070319183619.051498000@sipsolutions.net>
References: <20070319181800.149901000@sipsolutions.net>
Date: Mon, 19 Mar 2007 19:18:01 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] adb: replace sleep notifier with sysdev
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch replaces the pmu sleep notifier that adb had with a proper
sysdevice.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 drivers/macintosh/adb.c |   89 ++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 39 deletions(-)

--- linux-2.6.orig/drivers/macintosh/adb.c	2007-03-19 19:15:06.553321419 +0100
+++ linux-2.6/drivers/macintosh/adb.c	2007-03-19 19:15:08.613321419 +0100
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
@@ -287,10 +279,51 @@ adb_reset_bus(void)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+/*
+ * notify clients before sleep
+ */
+int adb_suspend(struct sys_device *dev, pm_message_t state)
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
+int adb_resume(struct sys_device *dev)
+{
+	adb_got_sleep = 0;
+	up(&adb_probe_mutex);
+	adb_reset_bus();
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static struct sysdev_class adb_sysclass = {
+#ifdef CONFIG_PM
+	.resume = adb_resume,
+	.suspend = adb_suspend,
+#endif
+	set_kset_name("adb"),
+};
+
+static struct sys_device adb_sysdev = {
+	.cls = &adb_sysclass,
+};
+
 int __init adb_init(void)
 {
 	struct adb_driver *driver;
-	int i;
+	int i, err;
 
 #ifdef CONFIG_PPC32
 	if (!machine_is(chrp) && !machine_is(powermac))
@@ -319,14 +352,19 @@ int __init adb_init(void)
 		printk(KERN_WARNING "Warning: no ADB interface detected\n");
 		adb_controller = NULL;
 	} else {
-#ifdef CONFIG_PM
-		pmu_register_sleep_notifier(&adb_sleep_notifier);
-#endif /* CONFIG_PM */
+		err = sysdev_class_register(&adb_sysclass);
+		if (err)
+			return err;
+		err = sysdev_register(&adb_sysdev);
+		if (err)
+			return err;
+
 #ifdef CONFIG_PPC
 		if (machine_is_compatible("AAPL,PowerBook1998") ||
 			machine_is_compatible("PowerBook1,1"))
 			sleepy_trackpad = 1;
 #endif /* CONFIG_PPC */
+
 		init_completion(&adb_probe_task_comp);
 		adbdev_init();
 		adb_reset_bus();
@@ -336,33 +374,6 @@ int __init adb_init(void)
 
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

--
