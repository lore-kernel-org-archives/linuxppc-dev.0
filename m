Return-Path: <jonsmirl@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id B14A7DE5BB
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 04:21:40 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so6383pyg.27
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jul 2008 11:21:38 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by terra with esmtp (Exim 4.69) (envelope-from <jonsmirl@gmail.com>)
	id 1KDkTv-0003qi-Cf
	for linuxppc-dev@ozlabs.org; Tue, 01 Jul 2008 14:21:35 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH] Add the of_find_i2c_device_by_node function, standalone V1
To: linuxppc-dev@ozlabs.org
Date: Tue, 01 Jul 2008 14:21:35 -0400
Message-ID: <20080701182135.14767.15895.stgit@terra>
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

Add the of_find_i2c_device_by_node function. This allows you to follow a reference in the device tree to an i2c device node and then locate the linux device instantiated by the device tree. Example use, an i2s codec controlled by i2c. Depends on patch exporting i2c root bus symbol.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 drivers/of/of_i2c.c    |   37 ++++++++++++++++++++++++++-----------
 include/linux/of_i2c.h |    2 ++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index 715a444..ca69a16 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -75,7 +75,7 @@ static int of_find_i2c_driver(struct device_node *node,
 void of_register_i2c_devices(struct i2c_adapter *adap,
 			     struct device_node *adap_node)
 {
-	void *result;
+	struct i2c_client *i2c_dev;
 	struct device_node *node;
 
 	for_each_child_of_node(adap_node, node) {
@@ -90,29 +90,44 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 			continue;
 		}
 
-		info.irq = irq_of_parse_and_map(node, 0);
-		if (info.irq == NO_IRQ)
-			info.irq = -1;
-
-		if (of_find_i2c_driver(node, &info) < 0) {
-			irq_dispose_mapping(info.irq);
+		if (of_find_i2c_driver(node, &info) < 0)
 			continue;
-		}
 
+		info.irq = irq_of_parse_and_map(node, 0);
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
