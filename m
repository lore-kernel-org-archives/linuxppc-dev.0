Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-101-monday.nerim.net [62.4.16.101])
	by ozlabs.org (Postfix) with ESMTP id 2CF6EDDDF3
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 21:39:33 +1100 (EST)
Date: Mon, 21 Jan 2008 11:39:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <i2c@lm-sensors.org>
Subject: [PATCH 1/3] i2c: Add support for device alias names
Message-ID: <20080121113930.05d0eedc@hyperion.delvare>
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

Based on earlier work by Jon Smirl.

This patch allows new-style i2c chip drivers to have alias names using
the official kernel aliasing system and MODULE_DEVICE_TABLE(). At this
point, the old i2c driver binding scheme (driver_name/type) is still
supported.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jon Smirl <jonsmirl@gmail.com>
---
 drivers/hwmon/f75375s.c         |    8 +++---
 drivers/i2c/chips/ds1682.c      |    3 +-
 drivers/i2c/chips/menelaus.c    |    3 +-
 drivers/i2c/chips/tps65010.c    |    3 +-
 drivers/i2c/chips/tsl2550.c     |    3 +-
 drivers/i2c/i2c-core.c          |   50 +++++++++++++++++++++++++++++++--------
 drivers/rtc/rtc-ds1307.c        |    3 +-
 drivers/rtc/rtc-ds1374.c        |    3 +-
 drivers/rtc/rtc-m41t80.c        |    3 +-
 drivers/rtc/rtc-rs5c372.c       |    3 +-
 include/linux/i2c.h             |    5 +--
 include/linux/mod_devicetable.h |   13 ++++++++++
 scripts/mod/file2alias.c        |   13 ++++++++++
 13 files changed, 90 insertions(+), 23 deletions(-)


--- linux-2.6.24-rc8.orig/drivers/hwmon/f75375s.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/hwmon/f75375s.c	2008-01-21 09:12:25.000000000 +0100
@@ -117,7 +117,8 @@ struct f75375_data {
 static int f75375_attach_adapter(struct i2c_adapter *adapter);
 static int f75375_detect(struct i2c_adapter *adapter, int address, int kind);
 static int f75375_detach_client(struct i2c_client *client);
-static int f75375_probe(struct i2c_client *client);
+static int f75375_probe(struct i2c_client *client,
+			const struct i2c_device_id* id);
 static int f75375_remove(struct i2c_client *client);
 
 static struct i2c_driver f75375_legacy_driver = {
@@ -628,7 +629,8 @@ static void f75375_init(struct i2c_clien
 
 }
 
-static int f75375_probe(struct i2c_client *client)
+static int f75375_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
 {
 	struct f75375_data *data = i2c_get_clientdata(client);
 	struct f75375s_platform_data *f75375s_pdata = client->dev.platform_data;
@@ -748,7 +750,7 @@ static int f75375_detect(struct i2c_adap
 	if ((err = i2c_attach_client(client)))
 		goto exit_free;
 
-	if ((err = f75375_probe(client)) < 0)
+	if ((err = f75375_probe(client, NULL)) < 0)
 		goto exit_detach;
 
 	return 0;
--- linux-2.6.24-rc8.orig/drivers/i2c/chips/ds1682.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/chips/ds1682.c	2008-01-21 09:12:25.000000000 +0100
@@ -200,7 +200,8 @@ static struct bin_attribute ds1682_eepro
 /*
  * Called when a ds1682 device is matched with this driver
  */
-static int ds1682_probe(struct i2c_client *client)
+static int ds1682_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	int rc;
 
--- linux-2.6.24-rc8.orig/drivers/i2c/chips/menelaus.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/chips/menelaus.c	2008-01-21 09:12:25.000000000 +0100
@@ -1149,7 +1149,8 @@ static inline void menelaus_rtc_init(str
 
 static struct i2c_driver menelaus_i2c_driver;
 
-static int menelaus_probe(struct i2c_client *client)
+static int menelaus_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
 {
 	struct menelaus_chip	*menelaus;
 	int			rev = 0, val;
--- linux-2.6.24-rc8.orig/drivers/i2c/chips/tps65010.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/chips/tps65010.c	2008-01-21 09:12:25.000000000 +0100
@@ -465,7 +465,8 @@ static int __exit tps65010_remove(struct
 	return 0;
 }
 
-static int tps65010_probe(struct i2c_client *client)
+static int tps65010_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
 {
 	struct tps65010		*tps;
 	int			status;
--- linux-2.6.24-rc8.orig/drivers/i2c/chips/tsl2550.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/chips/tsl2550.c	2008-01-21 09:12:25.000000000 +0100
@@ -364,7 +364,8 @@ static int tsl2550_init_client(struct i2
  */
 
 static struct i2c_driver tsl2550_driver;
-static int __devinit tsl2550_probe(struct i2c_client *client)
+static int __devinit tsl2550_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct tsl2550_data *data;
--- linux-2.6.24-rc8.orig/drivers/i2c/i2c-core.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/i2c-core.c	2008-01-21 09:12:25.000000000 +0100
@@ -48,6 +48,17 @@ static DEFINE_IDR(i2c_adapter_idr);
 
 /* ------------------------------------------------------------------------- */
 
+static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
+						const struct i2c_client *client)
+{
+	while (id->name[0]) {
+		if (strcmp(client->name, id->name) == 0)
+			return id;
+		id++;
+	}
+	return NULL;
+}
+
 static int i2c_device_match(struct device *dev, struct device_driver *drv)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
@@ -59,6 +70,10 @@ static int i2c_device_match(struct devic
 	if (!is_newstyle_driver(driver))
 		return 0;
 
+	/* match on an id table if there is one */
+	if (driver->id_table)
+		return i2c_match_id(driver->id_table, client) != NULL;
+
 	/* new style drivers use the same kind of driver matching policy
 	 * as platform devices or SPI:  compare device and driver IDs.
 	 */
@@ -73,11 +88,17 @@ static int i2c_device_uevent(struct devi
 	struct i2c_client	*client = to_i2c_client(dev);
 
 	/* by definition, legacy drivers can't hotplug */
-	if (dev->driver || !client->driver_name)
+	if (dev->driver)
 		return 0;
 
-	if (add_uevent_var(env, "MODALIAS=%s", client->driver_name))
-		return -ENOMEM;
+	if (client->driver_name[0]) {
+		if (add_uevent_var(env, "MODALIAS=%s", client->driver_name))
+			return -ENOMEM;
+	} else {
+		if (add_uevent_var(env, "MODALIAS=%s%s",
+				   I2C_MODULE_PREFIX, client->name))
+			return -ENOMEM;
+	}
 	dev_dbg(dev, "uevent\n");
 	return 0;
 }
@@ -90,12 +111,18 @@ static int i2c_device_probe(struct devic
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
+	if (driver->id_table)
+		id = i2c_match_id(driver->id_table, client);
+	else
+		id = NULL;
+	return driver->probe(client, id);
 }
 
 static int i2c_device_remove(struct device *dev)
@@ -175,9 +202,9 @@ static ssize_t show_client_name(struct d
 static ssize_t show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	return client->driver_name
+	return client->driver_name[0]
 		? sprintf(buf, "%s\n", client->driver_name)
-		: 0;
+		: sprintf(buf, "%s%s\n", I2C_MODULE_PREFIX, client->name);
 }
 
 static struct device_attribute i2c_dev_attrs[] = {
@@ -296,15 +323,20 @@ void i2c_unregister_device(struct i2c_cl
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
 
 
-static int dummy_nop(struct i2c_client *client)
+static int dummy_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	return 0;
+}
+
+static int dummy_remove(struct i2c_client *client)
 {
 	return 0;
 }
 
 static struct i2c_driver dummy_driver = {
 	.driver.name	= "dummy",
-	.probe		= dummy_nop,
-	.remove		= dummy_nop,
+	.probe		= dummy_probe,
+	.remove		= dummy_remove,
 };
 
 /**
--- linux-2.6.24-rc8.orig/drivers/rtc/rtc-ds1307.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/rtc/rtc-ds1307.c	2008-01-21 09:12:25.000000000 +0100
@@ -326,7 +326,8 @@ static struct bin_attribute nvram = {
 
 static struct i2c_driver ds1307_driver;
 
-static int __devinit ds1307_probe(struct i2c_client *client)
+static int __devinit ds1307_probe(struct i2c_client *client,
+				  const struct i2c_device_id *id)
 {
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
--- linux-2.6.24-rc8.orig/drivers/rtc/rtc-ds1374.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/rtc/rtc-ds1374.c	2008-01-21 09:12:25.000000000 +0100
@@ -355,7 +355,8 @@ static const struct rtc_class_ops ds1374
 	.ioctl = ds1374_ioctl,
 };
 
-static int ds1374_probe(struct i2c_client *client)
+static int ds1374_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	struct ds1374 *ds1374;
 	int ret;
--- linux-2.6.24-rc8.orig/drivers/rtc/rtc-m41t80.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/rtc/rtc-m41t80.c	2008-01-21 09:12:25.000000000 +0100
@@ -756,7 +756,8 @@ static struct notifier_block wdt_notifie
  *
  *****************************************************************************
  */
-static int m41t80_probe(struct i2c_client *client)
+static int m41t80_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	int i, rc = 0;
 	struct rtc_device *rtc = NULL;
--- linux-2.6.24-rc8.orig/drivers/rtc/rtc-rs5c372.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/drivers/rtc/rtc-rs5c372.c	2008-01-21 09:12:25.000000000 +0100
@@ -494,7 +494,8 @@ static void rs5c_sysfs_unregister(struct
 
 static struct i2c_driver rs5c372_driver;
 
-static int rs5c372_probe(struct i2c_client *client)
+static int rs5c372_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
 	int err = 0;
 	struct rs5c372 *rs5c372;
--- linux-2.6.24-rc8.orig/include/linux/i2c.h	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/include/linux/i2c.h	2008-01-21 09:12:25.000000000 +0100
@@ -126,7 +126,7 @@ struct i2c_driver {
 	 * With the driver model, device enumeration is NEVER done by drivers;
 	 * it's done by infrastructure.  (NEW STYLE DRIVERS ONLY)
 	 */
-	int (*probe)(struct i2c_client *);
+	int (*probe)(struct i2c_client *, const struct i2c_device_id *id);
 	int (*remove)(struct i2c_client *);
 
 	/* driver model interfaces that don't relate to enumeration  */
@@ -140,11 +140,10 @@ struct i2c_driver {
 	int (*command)(struct i2c_client *client,unsigned int cmd, void *arg);
 
 	struct device_driver driver;
+	const struct i2c_device_id *id_table;
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-#define I2C_NAME_SIZE	20
-
 /**
  * struct i2c_client - represent an I2C slave device
  * @flags: I2C_CLIENT_TEN indicates the device uses a ten bit chip address;
--- linux-2.6.24-rc8.orig/include/linux/mod_devicetable.h	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/include/linux/mod_devicetable.h	2008-01-21 09:12:25.000000000 +0100
@@ -367,4 +367,17 @@ struct virtio_device_id {
 };
 #define VIRTIO_DEV_ANY_ID	0xffffffff
 
+/* i2c */
+
+/* These defines are used to separate PowerPC open firmware
+ * drivers into their own namespace */
+#define I2C_NAME_SIZE	20
+#define I2C_MODULE_PREFIX "i2c:"
+
+struct i2c_device_id {
+	char name[I2C_NAME_SIZE];
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
--- linux-2.6.24-rc8.orig/scripts/mod/file2alias.c	2008-01-21 08:47:05.000000000 +0100
+++ linux-2.6.24-rc8/scripts/mod/file2alias.c	2008-01-21 09:12:25.000000000 +0100
@@ -539,6 +539,15 @@ static int do_virtio_entry(const char *f
 	return 1;
 }
 
+/* Looks like: i2c:S */
+static int do_i2c_entry(const char *filename, struct i2c_device_id *id,
+			char *alias)
+{
+	sprintf(alias, I2C_MODULE_PREFIX "%s", id->name);
+
+	return 1;
+}
+
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
 {
@@ -669,6 +678,10 @@ void handle_moddevtable(struct module *m
 		do_table(symval, sym->st_size,
 			 sizeof(struct virtio_device_id), "virtio",
 			 do_virtio_entry, mod);
+	else if (sym_is(symname, "__mod_i2c_device_table"))
+		do_table(symval, sym->st_size,
+			 sizeof(struct i2c_device_id), "i2c",
+			 do_i2c_entry, mod);
 	free(zeros);
 }
 

-- 
Jean Delvare
