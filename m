Return-Path: <abounine@tundra.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8281AB770E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Aug 2010 01:20:38 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 6/9] RapidIO: Add switch-specific sysfs initialization callback
Date: Fri, 13 Aug 2010 11:18:03 -0400
Message-Id: <1281712686-31308-7-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add callback that allows to create/remove switch-specific sysfs attributes.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Reviewed-by: Thomas Moll <thomas.moll@sysgo.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/rapidio/rio-sysfs.c |   26 +++++++++++++++++++-------
 include/linux/rio.h         |    2 ++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/rapidio/rio-sysfs.c b/drivers/rapidio/rio-sysfs.c
index 00b4756..bfc483b 100644
--- a/drivers/rapidio/rio-sysfs.c
+++ b/drivers/rapidio/rio-sysfs.c
@@ -40,9 +40,6 @@ static ssize_t routes_show(struct device *dev, struct device_attribute *attr, ch
 	char *str = buf;
 	int i;
 
-	if (!rdev->rswitch)
-		goto out;
-
 	for (i = 0; i < RIO_MAX_ROUTE_ENTRIES(rdev->net->hport->sys_size);
 			i++) {
 		if (rdev->rswitch->route_table[i] == RIO_INVALID_ROUTE)
@@ -52,7 +49,6 @@ static ssize_t routes_show(struct device *dev, struct device_attribute *attr, ch
 			    rdev->rswitch->route_table[i]);
 	}
 
-      out:
 	return (str - buf);
 }
 
@@ -63,10 +59,11 @@ struct device_attribute rio_dev_attrs[] = {
 	__ATTR_RO(asm_did),
 	__ATTR_RO(asm_vid),
 	__ATTR_RO(asm_rev),
-	__ATTR_RO(routes),
 	__ATTR_NULL,
 };
 
+static DEVICE_ATTR(routes, S_IRUGO, routes_show, NULL);
+
 static ssize_t
 rio_read_config(struct file *filp, struct kobject *kobj,
 		struct bin_attribute *bin_attr,
@@ -218,7 +215,17 @@ int rio_create_sysfs_dev_files(struct rio_dev *rdev)
 {
 	int err = 0;
 
-	err = sysfs_create_bin_file(&rdev->dev.kobj, &rio_config_attr);
+	err = device_create_bin_file(&rdev->dev, &rio_config_attr);
+
+	if (!err && rdev->rswitch) {
+		err = device_create_file(&rdev->dev, &dev_attr_routes);
+		if (!err && rdev->rswitch->sw_sysfs)
+			err = rdev->rswitch->sw_sysfs(rdev, 1);
+	}
+
+	if (err)
+		pr_warning("RIO: Failed to create attribute file(s) for %s\n",
+			   rio_name(rdev));
 
 	return err;
 }
@@ -231,5 +238,10 @@ int rio_create_sysfs_dev_files(struct rio_dev *rdev)
  */
 void rio_remove_sysfs_dev_files(struct rio_dev *rdev)
 {
-	sysfs_remove_bin_file(&rdev->dev.kobj, &rio_config_attr);
+	device_remove_bin_file(&rdev->dev, &rio_config_attr);
+	if (rdev->rswitch) {
+		device_remove_file(&rdev->dev, &dev_attr_routes);
+		if (rdev->rswitch->sw_sysfs)
+			rdev->rswitch->sw_sysfs(rdev, 0);
+	}
 }
diff --git a/include/linux/rio.h b/include/linux/rio.h
index 754895c..8f19fb2 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -233,6 +233,7 @@ struct rio_net {
  * @get_domain: Callback for switch-specific domain get function
  * @em_init: Callback for switch-specific error management initialization function
  * @em_handle: Callback for switch-specific error management handler function
+ * @sw_sysfs: Callback that initializes switch-specific sysfs attributes
  * @nextdev: Array of per-port pointers to the next attached device
  */
 struct rio_switch {
@@ -256,6 +257,7 @@ struct rio_switch {
 			   u8 *sw_domain);
 	int (*em_init) (struct rio_dev *dev);
 	int (*em_handle) (struct rio_dev *dev, u8 swport);
+	int (*sw_sysfs) (struct rio_dev *dev, int create);
 	struct rio_dev *nextdev[0];
 };
 
-- 
1.7.0.5
