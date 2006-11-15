Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48CA867C06
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 08:26:33 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAFLQLur002406
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 16:26:21 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAFLQL4r266994
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 16:26:21 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAFLQL3O000885
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 16:26:21 -0500
Date: Wed, 15 Nov 2006 15:26:19 -0600
To: Greg KH <greg@kroah.com>, akpm@osdl.org, Alan Cox <alan@redhat.com>,
	"Ryan S. Arnold" <rsa@us.ibm.com>
Subject: [PATCH]: HVCS char driver janitoring: fix compile warnings
Message-ID: <20061115212619.GJ8395@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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



This is a non-urgent patch. 

I can't figure out who the upstream maintainer for char drivers 
is supposed to be. Can this patch be applied? 

--linas

This patch removes an pair of irritating compiler warnings:

drivers/char/hvcs.c:1605: warning: ignoring return value of
sysfs_create_group declared with attribute warn_unused_result
drivers/char/hvcs.c:1639: warning: ignoring return value of
driver_create_file declared with attribute warn_unused_result

Doing this required moving a big block of code from the bottom 
of the file to the top, so as to avoid the need for (irritating) 
forward declarations.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Ryan S. Arnold <rsa@us.ibm.com>

----
 drivers/char/hvcs.c |  426 +++++++++++++++++++++++++---------------------------
 1 file changed, 210 insertions(+), 216 deletions(-)

Index: linux-2.6.19-rc4-git3/drivers/char/hvcs.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/char/hvcs.c	2006-11-01 16:15:14.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/char/hvcs.c	2006-11-15 15:04:50.000000000 -0600
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
@@ -353,6 +348,172 @@ static void __exit hvcs_module_exit(void
 #define HVCS_TRY_WRITE	0x00000004
 #define HVCS_READ_MASK	(HVCS_SCHED_READ | HVCS_QUICK_READ)
 
+static inline struct hvcs_struct *from_vio_dev(struct vio_dev *viod)
+{
+	return viod->dev.driver_data;
+}
+/* The sysfs interface for the driver and devices */
+
+static ssize_t hvcs_partner_vtys_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%X\n", hvcsd->p_unit_address);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+static DEVICE_ATTR(partner_vtys, S_IRUGO, hvcs_partner_vtys_show, NULL);
+
+static ssize_t hvcs_partner_clcs_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+static DEVICE_ATTR(partner_clcs, S_IRUGO, hvcs_partner_clcs_show, NULL);
+
+static ssize_t hvcs_current_vty_store(struct device *dev, struct device_attribute *attr, const char * buf,
+		size_t count)
+{
+	/*
+	 * Don't need this feature at the present time because firmware doesn't
+	 * yet support multiple partners.
+	 */
+	printk(KERN_INFO "HVCS: Denied current_vty change: -EPERM.\n");
+	return -EPERM;
+}
+
+static ssize_t hvcs_current_vty_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+
+static DEVICE_ATTR(current_vty,
+	S_IRUGO | S_IWUSR, hvcs_current_vty_show, hvcs_current_vty_store);
+
+static ssize_t hvcs_vterm_state_store(struct device *dev, struct device_attribute *attr, const char *buf,
+		size_t count)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+
+	/* writing a '0' to this sysfs entry will result in the disconnect. */
+	if (simple_strtol(buf, NULL, 0) != 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+
+	if (hvcsd->open_count > 0) {
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+		printk(KERN_INFO "HVCS: vterm state unchanged.  "
+				"The hvcs device node is still in use.\n");
+		return -EPERM;
+	}
+
+	if (hvcsd->connected == 0) {
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+		printk(KERN_INFO "HVCS: vterm state unchanged. The"
+				" vty-server is not connected to a vty.\n");
+		return -EPERM;
+	}
+
+	hvcs_partner_free(hvcsd);
+	printk(KERN_INFO "HVCS: Closed vty-server@%X and"
+			" partner vty@%X:%d connection.\n",
+			hvcsd->vdev->unit_address,
+			hvcsd->p_unit_address,
+			(uint32_t)hvcsd->p_partition_ID);
+
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return count;
+}
+
+static ssize_t hvcs_vterm_state_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%d\n", hvcsd->connected);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+static DEVICE_ATTR(vterm_state, S_IRUGO | S_IWUSR,
+		hvcs_vterm_state_show, hvcs_vterm_state_store);
+
+static ssize_t hvcs_index_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%d\n", hvcsd->index);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+
+static DEVICE_ATTR(index, S_IRUGO, hvcs_index_show, NULL);
+
+static ssize_t hvcs_rescan_show(struct device_driver *ddp, char *buf)
+{
+	/* A 1 means it is updating, a 0 means it is done updating */
+	return snprintf(buf, PAGE_SIZE, "%d\n", hvcs_rescan_status);
+}
+
+static ssize_t hvcs_rescan_store(struct device_driver *ddp, const char * buf,
+		size_t count)
+{
+	if ((simple_strtol(buf, NULL, 0) != 1)
+		&& (hvcs_rescan_status != 0))
+		return -EINVAL;
+
+	hvcs_rescan_status = 1;
+	printk(KERN_INFO "HVCS: rescanning partner info for all"
+		" vty-servers.\n");
+	hvcs_rescan_devices_list();
+	hvcs_rescan_status = 0;
+	return count;
+}
+
+static DRIVER_ATTR(rescan,
+	S_IRUGO | S_IWUSR, hvcs_rescan_show, hvcs_rescan_store);
+
+static struct attribute *hvcs_attrs[] = {
+	&dev_attr_partner_vtys.attr,
+	&dev_attr_partner_clcs.attr,
+	&dev_attr_current_vty.attr,
+	&dev_attr_vterm_state.attr,
+	&dev_attr_index.attr,
+	NULL,
+};
+
+static struct attribute_group hvcs_attr_group = {
+	.attrs = hvcs_attrs,
+};
+
 static void hvcs_kick(void)
 {
 	hvcs_kicked = 1;
@@ -575,7 +736,7 @@ static void destroy_hvcs_struct(struct k
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	spin_unlock(&hvcs_structs_lock);
 
-	hvcs_remove_device_attrs(vdev);
+	sysfs_remove_group(&vdev->dev.kobj, &hvcs_attr_group);
 
 	kfree(hvcsd);
 }
@@ -608,6 +769,7 @@ static int __devinit hvcs_probe(
 {
 	struct hvcs_struct *hvcsd;
 	int index;
+	int retval;
 
 	if (!dev || !id) {
 		printk(KERN_ERR "HVCS: probed with invalid parameter.\n");
@@ -658,14 +820,16 @@ static int __devinit hvcs_probe(
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
 
@@ -1354,8 +1518,10 @@ static int __init hvcs_module_init(void)
 	if (!hvcs_tty_driver)
 		return -ENOMEM;
 
-	if (hvcs_alloc_index_list(num_ttys_to_alloc))
-		return -ENOMEM;
+	if (hvcs_alloc_index_list(num_ttys_to_alloc)) {
+		rc = -ENOMEM;
+		goto index_fail;
+	}
 
 	hvcs_tty_driver->owner = THIS_MODULE;
 
@@ -1385,41 +1551,57 @@ static int __init hvcs_module_init(void)
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
 
@@ -1441,7 +1623,7 @@ static void __exit hvcs_module_exit(void
 	hvcs_pi_buff = NULL;
 	spin_unlock(&hvcs_pi_lock);
 
-	hvcs_remove_driver_attrs();
+	driver_remove_file(&hvcs_vio_driver.driver, &driver_attr_rescan);
 
 	vio_unregister_driver(&hvcs_vio_driver);
 
@@ -1456,191 +1638,3 @@ static void __exit hvcs_module_exit(void
 
 module_init(hvcs_module_init);
 module_exit(hvcs_module_exit);
-
-static inline struct hvcs_struct *from_vio_dev(struct vio_dev *viod)
-{
-	return viod->dev.driver_data;
-}
-/* The sysfs interface for the driver and devices */
-
-static ssize_t hvcs_partner_vtys_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%X\n", hvcsd->p_unit_address);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-static DEVICE_ATTR(partner_vtys, S_IRUGO, hvcs_partner_vtys_show, NULL);
-
-static ssize_t hvcs_partner_clcs_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-static DEVICE_ATTR(partner_clcs, S_IRUGO, hvcs_partner_clcs_show, NULL);
-
-static ssize_t hvcs_current_vty_store(struct device *dev, struct device_attribute *attr, const char * buf,
-		size_t count)
-{
-	/*
-	 * Don't need this feature at the present time because firmware doesn't
-	 * yet support multiple partners.
-	 */
-	printk(KERN_INFO "HVCS: Denied current_vty change: -EPERM.\n");
-	return -EPERM;
-}
-
-static ssize_t hvcs_current_vty_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-
-static DEVICE_ATTR(current_vty,
-	S_IRUGO | S_IWUSR, hvcs_current_vty_show, hvcs_current_vty_store);
-
-static ssize_t hvcs_vterm_state_store(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-
-	/* writing a '0' to this sysfs entry will result in the disconnect. */
-	if (simple_strtol(buf, NULL, 0) != 0)
-		return -EINVAL;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-
-	if (hvcsd->open_count > 0) {
-		spin_unlock_irqrestore(&hvcsd->lock, flags);
-		printk(KERN_INFO "HVCS: vterm state unchanged.  "
-				"The hvcs device node is still in use.\n");
-		return -EPERM;
-	}
-
-	if (hvcsd->connected == 0) {
-		spin_unlock_irqrestore(&hvcsd->lock, flags);
-		printk(KERN_INFO "HVCS: vterm state unchanged. The"
-				" vty-server is not connected to a vty.\n");
-		return -EPERM;
-	}
-
-	hvcs_partner_free(hvcsd);
-	printk(KERN_INFO "HVCS: Closed vty-server@%X and"
-			" partner vty@%X:%d connection.\n",
-			hvcsd->vdev->unit_address,
-			hvcsd->p_unit_address,
-			(uint32_t)hvcsd->p_partition_ID);
-
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return count;
-}
-
-static ssize_t hvcs_vterm_state_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%d\n", hvcsd->connected);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-static DEVICE_ATTR(vterm_state, S_IRUGO | S_IWUSR,
-		hvcs_vterm_state_show, hvcs_vterm_state_store);
-
-static ssize_t hvcs_index_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%d\n", hvcsd->index);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-
-static DEVICE_ATTR(index, S_IRUGO, hvcs_index_show, NULL);
-
-static struct attribute *hvcs_attrs[] = {
-	&dev_attr_partner_vtys.attr,
-	&dev_attr_partner_clcs.attr,
-	&dev_attr_current_vty.attr,
-	&dev_attr_vterm_state.attr,
-	&dev_attr_index.attr,
-	NULL,
-};
-
-static struct attribute_group hvcs_attr_group = {
-	.attrs = hvcs_attrs,
-};
-
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
-static ssize_t hvcs_rescan_show(struct device_driver *ddp, char *buf)
-{
-	/* A 1 means it is updating, a 0 means it is done updating */
-	return snprintf(buf, PAGE_SIZE, "%d\n", hvcs_rescan_status);
-}
-
-static ssize_t hvcs_rescan_store(struct device_driver *ddp, const char * buf,
-		size_t count)
-{
-	if ((simple_strtol(buf, NULL, 0) != 1)
-		&& (hvcs_rescan_status != 0))
-		return -EINVAL;
-
-	hvcs_rescan_status = 1;
-	printk(KERN_INFO "HVCS: rescanning partner info for all"
-		" vty-servers.\n");
-	hvcs_rescan_devices_list();
-	hvcs_rescan_status = 0;
-	return count;
-}
-static DRIVER_ATTR(rescan,
-	S_IRUGO | S_IWUSR, hvcs_rescan_show, hvcs_rescan_store);
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
