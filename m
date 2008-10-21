Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 78066DDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 11:23:19 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so342827ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 17:23:17 -0700 (PDT)
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Add the of_find_i2c_device_by_node function.
To: linuxppc-dev@ozlabs.org, avorontsov@ru.mvista.com
Date: Mon, 20 Oct 2008 20:23:15 -0400
Message-ID: <20081021002315.31817.7497.stgit@terra>
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

Anton - this version is based off from your patches

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
