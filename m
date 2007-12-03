Return-Path: <jonsmirl@gmail.com>
Received: from vms040pub.verizon.net (vms040pub.verizon.net [206.46.252.40])
	by ozlabs.org (Postfix) with ESMTP id C4581DDE2F
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 09:22:27 +1100 (EST)
Received: from terra.home ([96.233.72.204])
	by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0JSH00ARSSNK2565@vms040.mailsrvcs.net> for
	linuxppc-dev@ozlabs.org; Mon, 03 Dec 2007 15:21:21 -0600 (CST)
Date: Mon, 03 Dec 2007 16:20:34 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 1/4] Implement module aliasing for i2c to translate from	device
	tree names
In-reply-to: <20071203212032.23543.3453.stgit@terra.home>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
Message-id: <20071203212034.23543.21977.stgit@terra.home>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071203212032.23543.3453.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch allows new style i2c chip drivers to have alias names using
the official kernel aliasing system and MODULE_DEVICE_TABLE(). I've
tested it on PowerPC and x86. This change is required for PowerPC
device tree support.
---

 drivers/i2c/i2c-core.c          |   34 +++++++++++++++++++++++++++-------
 include/linux/i2c.h             |    5 ++---
 include/linux/mod_devicetable.h |    9 +++++++++
 3 files changed, 38 insertions(+), 10 deletions(-)


diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b5e13e4..76f48be 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -47,10 +47,26 @@ static DEFINE_IDR(i2c_adapter_idr);
 
 /* ------------------------------------------------------------------------- */
 
-static int i2c_device_match(struct device *dev, struct device_driver *drv)
+static const struct i2c_device_id * i2c_device_match(const struct i2c_device_id *id, struct i2c_client *client)
+{
+	/* new style drivers use the same kind of driver matching policy
+	 * as platform devices or SPI:  compare device and driver IDs.
+	 */
+	if (id) {
+    	while (id->name[0]) {
+        	if (strcmp(client->driver_name, id->name) == 0)
+            	return id;
+            id++;
+        }
+    }
+    return NULL;
+}
+
+static int i2c_bus_match(struct device *dev, struct device_driver *drv)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
 	struct i2c_driver	*driver = to_i2c_driver(drv);
+	const struct i2c_device_id *found_id;
 
 	/* make legacy i2c drivers bypass driver model probing entirely;
 	 * such drivers scan each i2c adapter/bus themselves.
@@ -58,10 +74,11 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 	if (!is_newstyle_driver(driver))
 		return 0;
 
-	/* new style drivers use the same kind of driver matching policy
-	 * as platform devices or SPI:  compare device and driver IDs.
-	 */
-	return strcmp(client->driver_name, drv->name) == 0;
+    found_id = i2c_device_match(driver->id_table, client);
+    if (found_id)
+            return 1;
+
+    return 0;
 }
 
 #ifdef	CONFIG_HOTPLUG
@@ -89,12 +106,15 @@ static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
 	struct i2c_driver	*driver = to_i2c_driver(dev->driver);
+	const struct i2c_device_id *id;
 
 	if (!driver->probe)
 		return -ENODEV;
 	client->driver = driver;
 	dev_dbg(dev, "probe\n");
-	return driver->probe(client);
+	
+    id = i2c_device_match(driver->id_table, client);
+	return driver->probe(client, id);
 }
 
 static int i2c_device_remove(struct device *dev)
@@ -189,7 +209,7 @@ static struct device_attribute i2c_dev_attrs[] = {
 static struct bus_type i2c_bus_type = {
 	.name		= "i2c",
 	.dev_attrs	= i2c_dev_attrs,
-	.match		= i2c_device_match,
+	.match		= i2c_bus_match,
 	.uevent		= i2c_device_uevent,
 	.probe		= i2c_device_probe,
 	.remove		= i2c_device_remove,
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index a100c9f..56d2dca 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -126,7 +126,7 @@ struct i2c_driver {
 	 * With the driver model, device enumeration is NEVER done by drivers;
 	 * it's done by infrastructure.  (NEW STYLE DRIVERS ONLY)
 	 */
-	int (*probe)(struct i2c_client *);
+	int (*probe)(struct i2c_client *, const struct i2c_device_id *id);
 	int (*remove)(struct i2c_client *);
 
 	/* driver model interfaces that don't relate to enumeration  */
@@ -141,11 +141,10 @@ struct i2c_driver {
 
 	struct device_driver driver;
 	struct list_head list;
+	struct i2c_device_id *id_table; 
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-#define I2C_NAME_SIZE	20
-
 /**
  * struct i2c_client - represent an I2C slave device
  * @flags: I2C_CLIENT_TEN indicates the device uses a ten bit chip address;
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index e9fddb4..688fad6 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -367,4 +367,13 @@ struct virtio_device_id {
 };
 #define VIRTIO_DEV_ANY_ID	0xffffffff
 
+/* i2c */
+
+#define I2C_NAME_SIZE	40
+struct i2c_device_id {
+	char name[I2C_NAME_SIZE];
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
