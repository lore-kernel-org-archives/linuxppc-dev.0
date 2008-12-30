Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id B871DDDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 07:17:23 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1610220yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 12:17:22 -0800 (PST)
Received: from localhost ([127.0.0.1]) by terra with esmtp (Exim 4.69)
	(envelope-from <jonsmirl@gmail.com>) id 1LHkvj-0006z0-Ck
	for linuxppc-dev@ozlabs.org; Tue, 30 Dec 2008 15:11:07 -0500
Subject: [PATCH] Add the of_find_i2c_device_by_node function.
To: linuxppc-dev@ozlabs.org
From: Jon Smirl <jonsmirl@gmail.com>
Date: Tue, 30 Dec 2008 15:11:07 -0500
Message-ID: <20081230201107.26810.71390.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the of_find_i2c_device_by_node function. This allows you to follow
a reference in the device tree to an i2c device node and then locate
the linux device instantiated by the device tree. Example use, an i2s
codec controlled by i2c.

This was waiting for Anton's i2c patches that were just added.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 drivers/of/of_i2c.c    |   19 +++++++++++++++++++
 include/linux/of_i2c.h |    3 +++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index e1b0ad6..fa65a2b 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -66,4 +66,23 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 }
 EXPORT_SYMBOL(of_register_i2c_devices);
 
+static int of_dev_node_match(struct device *dev, void *data)
+{
+        return dev_archdata_get_node(&dev->archdata) == data;
+}
+
+/* must call put_device() when done with returned i2c_client device */
+struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&i2c_bus_type, NULL, node,
+					 of_dev_node_match);
+	if (!dev)
+		return NULL;
+
+	return to_i2c_client(dev);
+}
+EXPORT_SYMBOL(of_find_i2c_device_by_node);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
index bd2a870..34974b5 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -17,4 +17,7 @@
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node);
 
+/* must call put_device() when done with returned i2c_client device */
+struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
+
 #endif /* __LINUX_OF_I2C_H */
