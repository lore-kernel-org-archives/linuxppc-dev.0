Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D4C15DDF1B
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 14:41:43 +1000 (EST)
Date: Thu, 8 May 2008 00:41:40 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Re: All your drivers are belong to us [was WARNING: mutexes are
	preferredfor single holder semaphores]
Message-ID: <20080508004140.31a6b065@lappy.seanm.ca>
In-Reply-To: <20080507194957.47abb103@zod.rchland.ibm.com>
References: <20080504204104.7eea7618@lappy.seanm.ca>
	<1209958719.21644.32.camel@pasglop>
	<20080505004023.05603b93@lappy.seanm.ca>
	<m23aouuqoh.fsf_-_@ohwell.denx.de>
	<20080507174251.2af863d6@wally.pikatech.com>
	<20080507194957.47abb103@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have attached the driver in question below. This is *not*
representative of PIKA board drivers in general. This driver was
rewritten from scratch to work in 2.6.26, but still work on the 2.6.9
kernel in RedHatES 4.

Since it was rewritten, it matches the kernel coding specs rather than
PIKA's. Emacs users will recognize the comment at the bottom ;)

This is also a generally useful driver that does one specific thing. It
is also very small. The next smallest PIKA driver is close to 9,000
lines of code. Our largest is about 130,000 lines of code and lsmod
reports 1.6M in size.

The other board drivers are *very* specific to PIKA hardware, and are
not "chip" drivers as such. I suspect Greg was mainly talking about
chip drivers.

I use this driver all the time to write quick drivers. It handles all
the dirty work for you so you can quickly prototype character drivers.

And while the Linux driver project looks interesting, it doesn't really
help me. We still have to support all our customers, which includes
windows, and old Linux kernels. This means I would still have to
maintain the PIKA version of the driver separate from the driver
projects version.

Cheers,
   Sean

--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ pikacore.h	2008-05-07 23:48:47.000000000 -0400
@@ -0,0 +1,39 @@
+/*
+ * PIKA Core Driver
+ *
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ */
+
+#ifndef PIKACORE_H
+#define PIKACORE_H
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/device.h>
+
+
+/* pikacore_register* returns a negative number on error.
+ * On success, it returns the minor number.
+ */
+int pikacore_register_board(struct file_operations *fops);
+int pikacore_register(int minor, char *name, struct file_operations *fops);
+int pikacore_unregister(int minor);
+int pikacore_device_attr(int minor, struct device_attribute *attr, void *data);
+
+
+/* Some compatibility changes. */
+
+#ifndef DEFINE_MUTEX
+#define DEFINE_MUTEX DECLARE_MUTEX
+#define mutex_lock down
+#define mutex_unlock up
+#endif
+
+#include <linux/interrupt.h>
+#ifndef IRQF_SHARED
+#define IRQF_SHARED (SA_SHIRQ | SA_INTERRUPT)
+#define IRQF_DISABLED 0
+#endif
+
+#endif
--- /dev/null	2005-11-20 22:22:37.000000000 -0500
+++ pikacore.c	2008-05-08 00:18:35.000000000 -0400
@@ -0,0 +1,261 @@
+/*
+ * PIKA Core Driver
+ *
+ * Copyright (c) 2008 PIKA Technologies
+ *   Sean MacLennan <smaclennan@pikatech.com>
+ *
+ * This driver handles all the details of creating a character device
+ * driver. It also allows us to reuse one major number for all the
+ * character device drivers.
+ */
+
+#include "pikacore.h"
+
+#include <linux/cdev.h>
+#include <linux/version.h>
+
+
+static int major;
+module_param(major, int, 0444);
+
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 13)
+/* This is really for RedHatES4 */
+#define OLD_KERNEL
+
+#define class_create class_simple_create
+#define class_destroy class_simple_destroy
+
+static inline struct class_device *device_create(struct class_simple *cls,
+						 void *parent, dev_t devt,
+						 const char *fmt, ...)
+{
+	va_list ap;
+	char tmpname[20];
+
+	va_start(ap, fmt);
+	vsnprintf(tmpname, sizeof(tmpname), fmt, ap);
+	va_end(ap);
+
+	return class_simple_device_add(cls, devt, parent, tmpname);
+}
+
+#define device_destroy(a, b) class_simple_device_remove(b)
+
+#define device class_device
+static struct class_simple *pikacore_class;
+#else
+static struct class *pikacore_class;
+#endif
+
+
+struct pk_coredevice  {
+	struct list_head list;
+	int minor;
+	struct cdev cdev;
+	struct device *device;
+};
+
+static LIST_HEAD(pikacore_list);
+static DEFINE_MUTEX(pikacore_mtx);
+
+#define MAX_MINORS 64
+static unsigned long pikacore_minors[MAX_MINORS / 8 / sizeof(unsigned long)];
+
+
+int pikacore_register(int minor, char *name, struct file_operations *fops)
+{
+	struct pk_coredevice *pika;
+	dev_t dev;
+	int err;
+
+	mutex_lock(&pikacore_mtx);
+
+	if (minor == 0)
+		minor = find_first_zero_bit(pikacore_minors, MAX_MINORS);
+
+	if (minor >= MAX_MINORS ||
+	    test_and_set_bit(minor, pikacore_minors)) {
+		mutex_unlock(&pikacore_mtx);
+		return -ENOENT;
+	}
+
+	mutex_unlock(&pikacore_mtx);
+
+	pika = kzalloc(sizeof(struct pk_coredevice), GFP_KERNEL);
+	if (!pika)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&pika->list);
+	pika->minor = minor;
+	dev = MKDEV(major, minor);
+
+	if (name)
+		pika->device = device_create(pikacore_class, NULL, dev,
+					     "%s", name);
+	else
+		pika->device = device_create(pikacore_class, NULL, dev,
+					     "pika%d", minor);
+	if (IS_ERR(pika->device)) {
+		err = PTR_ERR(pika->device);
+		goto out;
+	}
+
+	cdev_init(&pika->cdev, fops);
+	err = cdev_add(&pika->cdev, dev, 1);
+	if (err)
+		goto out;
+
+	mutex_lock(&pikacore_mtx);
+	list_add(&pika->list, &pikacore_list);
+	mutex_unlock(&pikacore_mtx);
+
+	printk(KERN_INFO "pikacore: registered %d.%d\n", major, minor);
+
+	return minor;
+
+ out:
+	if (pika->device)
+		device_destroy(pikacore_class, MKDEV(major, minor));
+
+	kfree(pika);
+	return err;
+}
+EXPORT_SYMBOL(pikacore_register);
+
+int pikacore_register_board(struct file_operations *fops)
+{
+	return pikacore_register(0, NULL, fops);
+}
+EXPORT_SYMBOL(pikacore_register_board);
+
+/* You must have pikacore_mtx held */
+static inline struct pk_coredevice *find_by_minor(int minor)
+{
+	struct pk_coredevice *pika;
+
+	list_for_each_entry(pika, &pikacore_list, list)
+		if (pika->minor == minor)
+			return pika;
+
+	return NULL;
+}
+
+int pikacore_unregister(int minor)
+{
+	struct pk_coredevice *pika;
+
+	mutex_lock(&pikacore_mtx);
+
+	pika = find_by_minor(minor);
+	if (!pika) {
+		mutex_unlock(&pikacore_mtx);
+		return -EINVAL;
+	}
+
+	list_del(&pika->list);
+
+	clear_bit(minor, pikacore_minors);
+
+	mutex_unlock(&pikacore_mtx);
+
+	printk(KERN_INFO "pikacore: remove %d.%d\n", major, minor);
+
+	device_destroy(pikacore_class, MKDEV(major, minor));
+
+	cdev_del(&pika->cdev);
+
+	kfree(pika);
+
+	return 0;
+}
+EXPORT_SYMBOL(pikacore_unregister);
+
+int pikacore_device_attr(int minor, struct device_attribute *attr, void *data)
+{
+#ifdef OLD_KERNEL
+	return -ENOSYS;
+#else
+	struct pk_coredevice *pika;
+	int rc;
+
+	mutex_lock(&pikacore_mtx);
+
+	pika = find_by_minor(minor);
+	if (!pika) {
+		printk(KERN_WARNING "%s: %d is not a pika device\n",
+		       __func__, minor);
+		rc = -ENOENT;
+		goto out;
+	}
+
+	if (data) {
+		void *cur = dev_get_drvdata(pika->device);
+		if (cur == NULL)
+			dev_set_drvdata(pika->device, data);
+		else if (cur != data) {
+			printk(KERN_WARNING "%s: data already set!!!\n",
+			       __func__);
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
+	rc = device_create_file(pika->device, attr);
+
+out:
+	mutex_unlock(&pikacore_mtx);
+
+	return rc;
+#endif
+}
+EXPORT_SYMBOL(pikacore_device_attr);
+
+static int __init pikacore_init(void)
+{
+	int rc;
+	dev_t devt;
+
+	pikacore_class = class_create(THIS_MODULE, "pika");
+	if (IS_ERR(pikacore_class))
+		return PTR_ERR(pikacore_class);
+
+	if (major) {
+		/* user specified the major */
+		devt = MKDEV(major, 0);
+		rc = register_chrdev_region(devt, MAX_MINORS, "pikacore");
+	} else
+		/* dynamic */
+		rc = alloc_chrdev_region(&devt, 0, MAX_MINORS, "pikacore");
+	if (rc) {
+		printk(KERN_ERR "pikacore: Unable to register (%d).\n", rc);
+		class_destroy(pikacore_class);
+		return rc;
+	}
+
+	major = MAJOR(devt);
+
+	return 0;
+}
+module_init(pikacore_init);
+
+void __exit pikacore_exit(void)
+{
+	unregister_chrdev_region(MKDEV(major, 0), MAX_MINORS);
+
+	class_destroy(pikacore_class);
+}
+module_exit(pikacore_exit);
+
+MODULE_DESCRIPTION("pikacore - core class driver");
+MODULE_AUTHOR("Sean MacLennan");
+MODULE_LICENSE("GPL");
+
+/*
+ * Force kernel coding standard on PIKA code
+ * Local Variables:
+ * tab-width: 8
+ * c-basic-offset: 8
+ * indent-tabs-mode: t
+ * End:
+ */
