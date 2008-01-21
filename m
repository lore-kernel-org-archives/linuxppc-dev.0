Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-101-monday.nerim.net [62.4.16.101])
	by ozlabs.org (Postfix) with ESMTP id 6A69CDDE2B
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 21:43:22 +1100 (EST)
Date: Mon, 21 Jan 2008 11:43:20 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <i2c@lm-sensors.org>
Subject: [PATCH 3/3] i2c: Kill the old driver matching scheme
Message-ID: <20080121114320.22ccda76@hyperion.delvare>
In-Reply-To: <20080121112517.6fe35a89@hyperion.delvare>
References: <20080121112517.6fe35a89@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the old driver_name/type scheme for i2c driver matching. Only the
standard aliasing model will be used from now on.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jon Smirl <jonsmirl@gmail.com>
---
 drivers/i2c/i2c-core.c |   36 ++++++++++++++----------------------
 include/linux/i2c.h    |    9 ++-------
 2 files changed, 16 insertions(+), 29 deletions(-)

--- linux-2.6.24-rc8.orig/drivers/i2c/i2c-core.c	2008-01-20 16:28:09.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/i2c-core.c	2008-01-20 19:36:48.000000000 +0100
@@ -74,10 +74,7 @@ static int i2c_device_match(struct devic
 	if (driver->id_table)
 		return i2c_match_id(driver->id_table, client) != NULL;
 
-	/* new style drivers use the same kind of driver matching policy
-	 * as platform devices or SPI:  compare device and driver IDs.
-	 */
-	return strcmp(client->driver_name, drv->name) == 0;
+	return 0;
 }
 
 #ifdef	CONFIG_HOTPLUG
@@ -91,14 +88,9 @@ static int i2c_device_uevent(struct devi
 	if (dev->driver)
 		return 0;
 
-	if (client->driver_name[0]) {
-		if (add_uevent_var(env, "MODALIAS=%s", client->driver_name))
-			return -ENOMEM;
-	} else {
-		if (add_uevent_var(env, "MODALIAS=%s%s",
-				   I2C_MODULE_PREFIX, client->name))
-			return -ENOMEM;
-	}
+	if (add_uevent_var(env, "MODALIAS=%s%s",
+			   I2C_MODULE_PREFIX, client->name))
+		return -ENOMEM;
 	dev_dbg(dev, "uevent\n");
 	return 0;
 }
@@ -202,9 +194,7 @@ static ssize_t show_client_name(struct d
 static ssize_t show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	return client->driver_name[0]
-		? sprintf(buf, "%s\n", client->driver_name)
-		: sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
+	return sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
 }
 
 static struct device_attribute i2c_dev_attrs[] = {
@@ -278,8 +268,6 @@ i2c_new_device(struct i2c_adapter *adap,
 	client->addr = info->addr;
 	client->irq = info->irq;
 
-	strlcpy(client->driver_name, info->driver_name,
-		sizeof(client->driver_name));
 	strlcpy(client->name, info->type, sizeof(client->name));
 
 	/* a new style driver may be bound to this device when we
@@ -323,6 +311,12 @@ void i2c_unregister_device(struct i2c_cl
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
 
 
+static const struct i2c_device_id dummy_id[] = {
+	{ "dummy", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, dummy_id);
+
 static int dummy_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	return 0;
@@ -337,13 +331,13 @@ static struct i2c_driver dummy_driver = 
 	.driver.name	= "dummy",
 	.probe		= dummy_probe,
 	.remove		= dummy_remove,
+	.id_table	= dummy_id,
 };
 
 /**
  * i2c_new_dummy - return a new i2c device bound to a dummy driver
  * @adapter: the adapter managing the device
  * @address: seven bit address to be used
- * @type: optional label used for i2c_client.name
  * Context: can sleep
  *
  * This returns an I2C client bound to the "dummy" driver, intended for use
@@ -359,15 +353,13 @@ static struct i2c_driver dummy_driver = 
  * i2c_unregister_device(); or NULL to indicate an error.
  */
 struct i2c_client *
-i2c_new_dummy(struct i2c_adapter *adapter, u16 address, const char *type)
+i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
 {
 	struct i2c_board_info info = {
-		.driver_name	= "dummy",
+		.type		= "dummy",
 		.addr		= address,
 	};
 
-	if (type)
-		strlcpy(info.type, type, sizeof info.type);
 	return i2c_new_device(adapter, &info);
 }
 EXPORT_SYMBOL_GPL(i2c_new_dummy);
--- linux-2.6.24-rc8.orig/include/linux/i2c.h	2008-01-20 17:40:37.000000000 +0100
+++ linux-2.6.24-rc8/include/linux/i2c.h	2008-01-20 19:36:35.000000000 +0100
@@ -155,8 +155,6 @@ struct i2c_driver {
  * @driver: device's driver, hence pointer to access routines
  * @dev: Driver model device node for the slave.
  * @irq: indicates the IRQ generated by this device (if any)
- * @driver_name: Identifies new-style driver used with this device; also
- *	used as the module name for hotplug/coldplug modprobe support.
  * @list: list of active/busy clients (DEPRECATED)
  * @released: used to synchronize client releases & detaches and references
  *
@@ -174,7 +172,6 @@ struct i2c_client {
 	struct i2c_driver *driver;	/* and our access routines	*/
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device (or -1) */
-	char driver_name[KOBJ_NAME_LEN];
 	struct list_head list;		/* DEPRECATED */
 	struct completion released;
 };
@@ -200,8 +197,7 @@ static inline void i2c_set_clientdata (s
 
 /**
  * struct i2c_board_info - template for device creation
- * @driver_name: identifies the driver to be bound to the device
- * @type: optional chip type information, to initialize i2c_client.name
+ * @type: chip type, to initialize i2c_client.name
  * @flags: to initialize i2c_client.flags
  * @addr: stored in i2c_client.addr
  * @platform_data: stored in i2c_client.dev.platform_data
@@ -220,7 +216,6 @@ static inline void i2c_set_clientdata (s
  * with the adapter already known.
  */
 struct i2c_board_info {
-	char		driver_name[KOBJ_NAME_LEN];
 	char		type[I2C_NAME_SIZE];
 	unsigned short	flags;
 	unsigned short	addr;
@@ -262,7 +257,7 @@ i2c_new_probed_device(struct i2c_adapter
  * client handles for the extra addresses.
  */
 extern struct i2c_client *
-i2c_new_dummy(struct i2c_adapter *adap, u16 address, const char *type);
+i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
 extern void i2c_unregister_device(struct i2c_client *);
 

-- 
Jean Delvare
