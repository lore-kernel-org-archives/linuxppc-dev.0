Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkbr75xbHzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 19:01:27 +1000 (AEST)
Subject: patch "macintosh: use dev_groups and not dev_attrs for bus_type"
 added to driver-core-testing
To: gregkh@linuxfoundation.org, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 Jun 2017 11:01:03 +0200
Message-ID: <1496998863121242@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    macintosh: use dev_groups and not dev_attrs for bus_type

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


>From 60bb70aa761ca4090a718926f8299364a0c61ae0 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:17:12 +0200
Subject: macintosh: use dev_groups and not dev_attrs for bus_type

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/macintosh/macio_asic.c  |  4 ++--
 drivers/macintosh/macio_sysfs.c | 29 +++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index f757cef293f8..62f541f968f6 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -133,7 +133,7 @@ static int macio_device_resume(struct device * dev)
 	return 0;
 }
 
-extern struct device_attribute macio_dev_attrs[];
+extern const struct attribute_group *macio_dev_groups[];
 
 struct bus_type macio_bus_type = {
        .name	= "macio",
@@ -144,7 +144,7 @@ struct bus_type macio_bus_type = {
        .shutdown = macio_device_shutdown,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
-       .dev_attrs = macio_dev_attrs,
+       .dev_groups = macio_dev_groups,
 };
 
 static int __init macio_bus_driver_init(void)
diff --git a/drivers/macintosh/macio_sysfs.c b/drivers/macintosh/macio_sysfs.c
index 0b1f9c76c68d..2445274f7e4b 100644
--- a/drivers/macintosh/macio_sysfs.c
+++ b/drivers/macintosh/macio_sysfs.c
@@ -10,7 +10,8 @@ field##_show (struct device *dev, struct device_attribute *attr,	\
 {									\
 	struct macio_dev *mdev = to_macio_device (dev);			\
 	return sprintf (buf, format_string, mdev->ofdev.dev.of_node->field); \
-}
+}									\
+static DEVICE_ATTR_RO(field);
 
 static ssize_t
 compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
@@ -37,6 +38,7 @@ compatible_show (struct device *dev, struct device_attribute *attr, char *buf)
 
 	return length;
 }
+static DEVICE_ATTR_RO(compatible);
 
 static ssize_t modalias_show (struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -52,15 +54,26 @@ static ssize_t devspec_show(struct device *dev,
 	ofdev = to_platform_device(dev);
 	return sprintf(buf, "%s\n", ofdev->dev.of_node->full_name);
 }
+static DEVICE_ATTR_RO(modalias);
+static DEVICE_ATTR_RO(devspec);
 
 macio_config_of_attr (name, "%s\n");
 macio_config_of_attr (type, "%s\n");
 
-struct device_attribute macio_dev_attrs[] = {
-	__ATTR_RO(name),
-	__ATTR_RO(type),
-	__ATTR_RO(compatible),
-	__ATTR_RO(modalias),
-	__ATTR_RO(devspec),
-	__ATTR_NULL
+static struct attribute *macio_dev_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_type.attr,
+	&dev_attr_compatible.attr,
+	&dev_attr_modalias.attr,
+	&dev_attr_devspec.attr,
+	NULL,
+};
+
+static const struct attribute_group macio_dev_group = {
+	.attrs = macio_dev_attrs,
+};
+
+const struct attribute_group *macio_dev_groups[] = {
+	&macio_dev_group,
+	NULL,
 };
-- 
2.13.1
