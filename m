Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 40BDC67BDD
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 08:15:19 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAGLFGn9015883
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:15:16 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAGLF5Yg244716
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:15:06 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAGLF4Gq030360
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:15:05 -0500
Date: Thu, 16 Nov 2006 15:15:04 -0600
To: Greg KH <greg@kroah.com>, akpm@osdl.org, Alan Cox <alan@redhat.com>,
	"Ryan S. Arnold" <rsa@us.ibm.com>,
	Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/2]: HVCS char driver janitoring: rm compiler warnings
Message-ID: <20061116211504.GA22797@austin.ibm.com>
References: <20061116205210.GB23600@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061116205210.GB23600@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Please apply.

--linas 

This patch removes an pair of irritating compiler warnings:

drivers/char/hvcs.c:1605: warning: ignoring return value of
sysfs_create_group declared with attribute warn_unused_result
drivers/char/hvcs.c:1639: warning: ignoring return value of
driver_create_file declared with attribute warn_unused_result

This is done primarily by restructuring the module_init error
handling code.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Ryan S. Arnold <rsa@us.ibm.com>

----
 drivers/char/hvcs.c |   95 ++++++++++++++++++++++++----------------------------
 1 file changed, 44 insertions(+), 51 deletions(-)

Index: linux-2.6.19-rc4-git3/drivers/char/hvcs.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/char/hvcs.c	2006-11-16 14:32:38.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/char/hvcs.c	2006-11-16 14:36:27.000000000 -0600
@@ -337,11 +337,6 @@ static int hvcs_open(struct tty_struct *
 static void hvcs_close(struct tty_struct *tty, struct file *filp);
 static void hvcs_hangup(struct tty_struct * tty);
 
-static void hvcs_create_device_attrs(struct hvcs_struct *hvcsd);
-static void hvcs_remove_device_attrs(struct vio_dev *vdev);
-static void hvcs_create_driver_attrs(void);
-static void hvcs_remove_driver_attrs(void);
-
 static int __devinit hvcs_probe(struct vio_dev *dev,
 		const struct vio_device_id *id);
 static int __devexit hvcs_remove(struct vio_dev *dev);
@@ -495,17 +490,6 @@ static struct attribute_group hvcs_attr_
 	.attrs = hvcs_attrs,
 };
 
-static void hvcs_create_device_attrs(struct hvcs_struct *hvcsd)
-{
-	struct vio_dev *vdev = hvcsd->vdev;
-	sysfs_create_group(&vdev->dev.kobj, &hvcs_attr_group);
-}
-
-static void hvcs_remove_device_attrs(struct vio_dev *vdev)
-{
-	sysfs_remove_group(&vdev->dev.kobj, &hvcs_attr_group);
-}
-
 static ssize_t hvcs_rescan_show(struct device_driver *ddp, char *buf)
 {
 	/* A 1 means it is updating, a 0 means it is done updating */
@@ -752,7 +736,7 @@ static void destroy_hvcs_struct(struct k
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	spin_unlock(&hvcs_structs_lock);
 
-	hvcs_remove_device_attrs(vdev);
+	sysfs_remove_group(&vdev->dev.kobj, &hvcs_attr_group);
 
 	kfree(hvcsd);
 }
@@ -785,6 +769,7 @@ static int __devinit hvcs_probe(
 {
 	struct hvcs_struct *hvcsd;
 	int index;
+	int retval;
 
 	if (!dev || !id) {
 		printk(KERN_ERR "HVCS: probed with invalid parameter.\n");
@@ -835,14 +820,16 @@ static int __devinit hvcs_probe(
 	 * the hvcs_struct has been added to the devices list then the user app
 	 * will get -ENODEV.
 	 */
-
 	spin_lock(&hvcs_structs_lock);
-
 	list_add_tail(&(hvcsd->next), &hvcs_structs);
-
 	spin_unlock(&hvcs_structs_lock);
 
-	hvcs_create_device_attrs(hvcsd);
+	retval = sysfs_create_group(&dev->dev.kobj, &hvcs_attr_group);
+	if (retval) {
+		printk(KERN_ERR "HVCS: Can't create sysfs attrs for vty-server@%X\n",
+		       hvcsd->vdev->unit_address);
+		return retval;
+	}
 
 	printk(KERN_INFO "HVCS: vty-server@%X added to the vio bus.\n", dev->unit_address);
 
@@ -1531,8 +1518,10 @@ static int __init hvcs_module_init(void)
 	if (!hvcs_tty_driver)
 		return -ENOMEM;
 
-	if (hvcs_alloc_index_list(num_ttys_to_alloc))
-		return -ENOMEM;
+	if (hvcs_alloc_index_list(num_ttys_to_alloc)) {
+		rc = -ENOMEM;
+		goto index_fail;
+	}
 
 	hvcs_tty_driver->owner = THIS_MODULE;
 
@@ -1562,41 +1551,57 @@ static int __init hvcs_module_init(void)
 	 * dynamically assigned major and minor numbers for our devices.
 	 */
 	if (tty_register_driver(hvcs_tty_driver)) {
-		printk(KERN_ERR "HVCS: registration "
-			" as a tty driver failed.\n");
-		hvcs_free_index_list();
-		put_tty_driver(hvcs_tty_driver);
-		return -EIO;
+		printk(KERN_ERR "HVCS: registration as a tty driver failed.\n");
+		rc = -EIO;
+		goto register_fail;
 	}
 
 	hvcs_pi_buff = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!hvcs_pi_buff) {
-		tty_unregister_driver(hvcs_tty_driver);
-		hvcs_free_index_list();
-		put_tty_driver(hvcs_tty_driver);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto buff_alloc_fail;
 	}
 
 	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
 		printk(KERN_ERR "HVCS: khvcsd creation failed.  Driver not loaded.\n");
-		kfree(hvcs_pi_buff);
-		tty_unregister_driver(hvcs_tty_driver);
-		hvcs_free_index_list();
-		put_tty_driver(hvcs_tty_driver);
-		return -EIO;
+		rc = -EIO;
+		goto kthread_fail;
 	}
 
 	rc = vio_register_driver(&hvcs_vio_driver);
+	if (rc) {
+		printk(KERN_ERR "HVCS: can't register vio driver\n");
+		goto vio_fail;
+	}
 
 	/*
 	 * This needs to be done AFTER the vio_register_driver() call or else
 	 * the kobjects won't be initialized properly.
 	 */
-	hvcs_create_driver_attrs();
+	rc = driver_create_file(&(hvcs_vio_driver.driver), &driver_attr_rescan);
+	if (rc) {
+		printk(KERN_ERR "HVCS: sysfs attr create failed\n");
+		goto attr_fail;
+	}
 
 	printk(KERN_INFO "HVCS: driver module inserted.\n");
 
+	return 0;
+
+attr_fail:
+	vio_unregister_driver(&hvcs_vio_driver);
+vio_fail:
+	kthread_stop(hvcs_task);
+kthread_fail:
+	kfree(hvcs_pi_buff);
+buff_alloc_fail:
+	tty_unregister_driver(hvcs_tty_driver);
+register_fail:
+	hvcs_free_index_list();
+index_fail:
+	put_tty_driver(hvcs_tty_driver);
+	hvcs_tty_driver = NULL;
 	return rc;
 }
 
@@ -1618,7 +1623,7 @@ static void __exit hvcs_module_exit(void
 	hvcs_pi_buff = NULL;
 	spin_unlock(&hvcs_pi_lock);
 
-	hvcs_remove_driver_attrs();
+	driver_remove_file(&hvcs_vio_driver.driver, &driver_attr_rescan);
 
 	vio_unregister_driver(&hvcs_vio_driver);
 
@@ -1633,15 +1638,3 @@ static void __exit hvcs_module_exit(void
 
 module_init(hvcs_module_init);
 module_exit(hvcs_module_exit);
-
-static void hvcs_create_driver_attrs(void)
-{
-	struct device_driver *driverfs = &(hvcs_vio_driver.driver);
-	driver_create_file(driverfs, &driver_attr_rescan);
-}
-
-static void hvcs_remove_driver_attrs(void)
-{
-	struct device_driver *driverfs = &(hvcs_vio_driver.driver);
-	driver_remove_file(driverfs, &driver_attr_rescan);
-}
