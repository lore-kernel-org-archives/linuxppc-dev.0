Return-Path: <jonsmirl@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by ozlabs.org (Postfix) with ESMTP id 7212CDDDE3
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 01:00:43 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so984297wxc.15
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 07:00:41 -0700 (PDT)
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Add the of_find_i2c_device_by_node function
To: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
Date: Sun, 19 Oct 2008 10:00:40 -0400
Message-ID: <20081019140040.32281.65209.stgit@terra>
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
codec controlled by i2c. Depends on patch exporting i2c root bus symbol.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 drivers/of/of_i2c.c |   28 ++++++++++++++++++++++++----
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 6a98dc8..ba7b394 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -19,7 +19,7 @@
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node)
 {
-	void *result;
+	struct i2c_client *i2c_dev;
 	struct device_node *node;
 
 	for_each_child_of_node(adap_node, node) {
@@ -41,18 +41,38 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 
 		info.addr = *addr;
 
-		request_module(info.type);
+		request_module("%s", info.type);
 
-		result = i2c_new_device(adap, &info);
-		if (result == NULL) {
+		i2c_dev = i2c_new_device(adap, &info);
+		if (i2c_dev == NULL) {
 			printk(KERN_ERR
 			       "of-i2c: Failed to load driver for %s\n",
 			       info.type);
 			irq_dispose_mapping(info.irq);
 			continue;
 		}
+		
+		i2c_dev->dev.archdata.of_node = of_node_get(node);
 	}
 }
 EXPORT_SYMBOL(of_register_i2c_devices);
 
+static int of_dev_node_match(struct device *dev, void *data)
+{
+        return dev->archdata.of_node == data;
+}
+
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
index bd2a870..17d5897 100644
--- a/include/linux/of_i2c.h
+++ b/include/linux/of_i2c.h
@@ -16,5 +16,7 @@
 
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node);
+struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
+			     
 
 #endif /* __LINUX_OF_I2C_H */
