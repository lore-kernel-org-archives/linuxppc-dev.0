Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C4D2B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 15:26:33 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p174QQPP005694
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Feb 2011 22:26:27 -0600
Subject: [PATCH] powerpc/pseries: Reduce HVCS driver insanity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 15:26:25 +1100
Message-ID: <1297052785.14982.39.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The HVCS driver, for those who don't know, is a driver for the "server" side
of the IBM virtual terminal mechanism allowing Linux partitions to act as
terminal servers under IBM PowerVM hypervisor. It's almost never used on
the field at the moment.

However, it's part of our configs, and in its current incarnation, will
allocate the tty driver & major (with 64 minors) and create a kernel thread
whether it's used or not, ie, whether the hypervisor did put a virtual
terminal server device node in the partition or not (or whether running on
a pseries machine or not even).

This in turns causes modern distro's udev's to start trying to open all
those 64 minors at boot, which, since they aren't linked to anything,
causes the driver to spew errors in the kernel log for each of them.

Not nice.

This moves all that initialization to a function which is now only called
the first time a terminal server virtual IO device is actually probed
(that is almost never).

There's still a _LOT_ of cleanup that can be done in this driver, some
simple (almost all printk's statements in there shall either just be
removed or in some case turned into better written & more informative
messages, including using the dev_* variants etc...). This is left as
an exercise for whoever actually cares about that driver.

One could also try to be smart and dispose of all the tty related
resources when the last instance of the VIO server device
is removed (Hotplug anybody ?).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index bedc6c1..7e315b7 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -309,6 +309,7 @@ struct hvcs_struct {
 
 static LIST_HEAD(hvcs_structs);
 static DEFINE_SPINLOCK(hvcs_structs_lock);
+static DEFINE_MUTEX(hvcs_init_mutex);
 
 static void hvcs_unthrottle(struct tty_struct *tty);
 static void hvcs_throttle(struct tty_struct *tty);
@@ -340,6 +341,7 @@ static int __devinit hvcs_probe(struct vio_dev *dev,
 static int __devexit hvcs_remove(struct vio_dev *dev);
 static int __init hvcs_module_init(void);
 static void __exit hvcs_module_exit(void);
+static int __devinit hvcs_initialize(void);
 
 #define HVCS_SCHED_READ	0x00000001
 #define HVCS_QUICK_READ	0x00000002
@@ -762,7 +764,7 @@ static int __devinit hvcs_probe(
 	const struct vio_device_id *id)
 {
 	struct hvcs_struct *hvcsd;
-	int index;
+	int index, rc;
 	int retval;
 
 	if (!dev || !id) {
@@ -770,6 +772,13 @@ static int __devinit hvcs_probe(
 		return -EPERM;
 	}
 
+	/* Make sure we are properly initialized */
+	rc = hvcs_initialize();
+	if (rc) {
+		pr_err("HVCS: Failed to initialize core driver.\n");
+		return rc;
+	}
+
 	/* early to avoid cleanup on failure */
 	index = hvcs_get_index();
 	if (index < 0) {
@@ -1464,12 +1473,15 @@ static void hvcs_free_index_list(void)
 	hvcs_index_count = 0;
 }
 
-static int __init hvcs_module_init(void)
+static int __devinit hvcs_initialize(void)
 {
-	int rc;
-	int num_ttys_to_alloc;
+	int rc, num_ttys_to_alloc;
 
-	printk(KERN_INFO "Initializing %s\n", hvcs_driver_string);
+	mutex_lock(&hvcs_init_mutex);
+	if (hvcs_task) {
+		mutex_unlock(&hvcs_init_mutex);
+		return 0;
+	}
 
 	/* Has the user specified an overload with an insmod param? */
 	if (hvcs_parm_num_devs <= 0 ||
@@ -1528,35 +1540,13 @@ static int __init hvcs_module_init(void)
 
 	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
-		printk(KERN_ERR "HVCS: khvcsd creation failed.  Driver not loaded.\n");
+		printk(KERN_ERR "HVCS: khvcsd creation failed.\n");
 		rc = -EIO;
 		goto kthread_fail;
 	}
-
-	rc = vio_register_driver(&hvcs_vio_driver);
-	if (rc) {
-		printk(KERN_ERR "HVCS: can't register vio driver\n");
-		goto vio_fail;
-	}
-
-	/*
-	 * This needs to be done AFTER the vio_register_driver() call or else
-	 * the kobjects won't be initialized properly.
-	 */
-	rc = driver_create_file(&(hvcs_vio_driver.driver), &driver_attr_rescan);
-	if (rc) {
-		printk(KERN_ERR "HVCS: sysfs attr create failed\n");
-		goto attr_fail;
-	}
-
-	printk(KERN_INFO "HVCS: driver module inserted.\n");
-
+	mutex_unlock(&hvcs_init_mutex);
 	return 0;
 
-attr_fail:
-	vio_unregister_driver(&hvcs_vio_driver);
-vio_fail:
-	kthread_stop(hvcs_task);
 kthread_fail:
 	kfree(hvcs_pi_buff);
 buff_alloc_fail:
@@ -1566,15 +1556,39 @@ register_fail:
 index_fail:
 	put_tty_driver(hvcs_tty_driver);
 	hvcs_tty_driver = NULL;
+	mutex_unlock(&hvcs_init_mutex);
 	return rc;
 }
 
+static int __init hvcs_module_init(void)
+{
+	int rc = vio_register_driver(&hvcs_vio_driver);
+	if (rc) {
+		printk(KERN_ERR "HVCS: can't register vio driver\n");
+		return rc;
+	}
+
+	pr_info("HVCS: Driver registered.\n");
+
+	/* This needs to be done AFTER the vio_register_driver() call or else
+	 * the kobjects won't be initialized properly.
+	 */
+	rc = driver_create_file(&(hvcs_vio_driver.driver), &driver_attr_rescan);
+	if (rc)
+		pr_warning(KERN_ERR "HVCS: Failed to create rescan file (err %d)\n", rc);
+
+	return 0;
+}
+
 static void __exit hvcs_module_exit(void)
 {
 	/*
 	 * This driver receives hvcs_remove callbacks for each device upon
 	 * module removal.
 	 */
+	vio_unregister_driver(&hvcs_vio_driver);
+	if (!hvcs_task)
+		return;
 
 	/*
 	 * This synchronous operation  will wake the khvcsd kthread if it is
@@ -1589,8 +1603,6 @@ static void __exit hvcs_module_exit(void)
 
 	driver_remove_file(&hvcs_vio_driver.driver, &driver_attr_rescan);
 
-	vio_unregister_driver(&hvcs_vio_driver);
-
 	tty_unregister_driver(hvcs_tty_driver);
 
 	hvcs_free_index_list();
