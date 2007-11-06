Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id 4B3A2DDF46
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 07:39:43 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1636192rvf
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Nov 2007 12:39:42 -0800 (PST)
Message-ID: <9e4733910711061239g22b06863rbec37fcef138c869@mail.gmail.com>
Date: Tue, 6 Nov 2007 15:39:42 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	Tjernlund <tjernlund@tjernlund.se>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
Subject: [RFC] Modifying i2c-core to support alias driver names compatible
	with device trees
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It was requested to split this code out into a separate thread....

This code modifies the i2c-core to support lists of alias names in the
chip drivers.
For example: .aliases	= (char const
*[]){"ricoh,rs5c372a","ricoh,rs5c372b","ricoh,rv5c386","ricoh,rv5c387a",
0},

Support like this is needed to get the table out of the PowerPC code
that is converting from device tree name into Linux kernel versions.

Once you add the concept of aliases you don't need the separate fields
for base driver name and chip specific type. This patch eliminates the
extra field.

Of course these changes to fsl_soc.c are removed in the other patch
that updates i2c-mpc.c.


Extend i2c-core to support lists of device tree compatible names when
matching drivers

From: Jon Smirl <jonsmirl@gmail.com>


---

 arch/powerpc/sysdev/fsl_soc.c |   33 +++++++++------------------------
 drivers/i2c/i2c-core.c        |   35 ++++++++++++++++++-----------------
 drivers/rtc/rtc-pcf8563.c     |    1 +
 drivers/rtc/rtc-rs5c372.c     |    3 ++-
 include/linux/i2c.h           |   13 +++++++++----
 5 files changed, 39 insertions(+), 46 deletions(-)


diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 1cf29c9..e2aafd6 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -314,27 +314,6 @@ struct i2c_driver_device {
 	char	*i2c_type;
 };

-static struct i2c_driver_device i2c_devices[] __initdata = {
-	{"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
-	{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
-	{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
-	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
-};
-
-static int __init of_find_i2c_driver(struct device_node *node, struct
i2c_board_info *info)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
-		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
-			continue;
-		strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
-		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
-		return 0;
-	}
-	return -ENODEV;
-}
-
 static void __init of_register_i2c_devices(struct device_node
*adap_node, int bus_num)
 {
 	struct device_node *node = NULL;
@@ -342,11 +321,12 @@ static void __init
of_register_i2c_devices(struct device_node *adap_node, int bu
 	while ((node = of_get_next_child(adap_node, node))) {
 		struct i2c_board_info info;
 		const u32 *addr;
+		const char *compatible;
 		int len;

 		addr = of_get_property(node, "reg", &len);
 		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
-			printk(KERN_WARNING "fsl_ioc.c: invalid i2c device entry\n");
+			printk(KERN_WARNING "i2c-mpc.c: invalid entry, missing reg attribute\n");
 			continue;
 		}

@@ -354,16 +334,21 @@ static void __init
of_register_i2c_devices(struct device_node *adap_node, int bu
 		if (info.irq == NO_IRQ)
 			info.irq = -1;

-		if (of_find_i2c_driver(node, &info) < 0)
+		compatible = of_get_property(node, "compatible", &len);
+		if (!compatible) {
+			printk(KERN_WARNING "i2c-mpc.c: invalid entry, missing compatible
attribute\n");
 			continue;
+		}
+		strncpy(info.name, compatible, sizeof(info.name));

 		info.platform_data = NULL;
 		info.addr = *addr;
-
+		
 		i2c_register_board_info(bus_num, &info, 1);
 	}
 }

+
 static int __init fsl_i2c_of_init(void)
 {
 	struct device_node *np;
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d663e69..d9a70c2 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -51,6 +51,7 @@ static int i2c_device_match(struct device *dev,
struct device_driver *drv)
 {
 	struct i2c_client	*client = to_i2c_client(dev);
 	struct i2c_driver	*driver = to_i2c_driver(drv);
+	char const **alias;

 	/* make legacy i2c drivers bypass driver model probing entirely;
 	 * such drivers scan each i2c adapter/bus themselves.
@@ -60,8 +61,18 @@ static int i2c_device_match(struct device *dev,
struct device_driver *drv)

 	/* new style drivers use the same kind of driver matching policy
 	 * as platform devices or SPI:  compare device and driver IDs.
+	 * Match against arrary of alias device tree names. When a match
+	 * is found change the reference to point at the copy inside the
+	 * chip driver allowing the caller's string to be freed.
 	 */
-	return strcmp(client->driver_name, drv->name) == 0;
+	alias = driver->aliases;
+	while (*alias) {
+		if (strcmp(client->name, *alias) == 0) {
+			return true;
+		}
+		alias++;
+	}
+	return 0;
 }

 #ifdef	CONFIG_HOTPLUG
@@ -74,11 +85,11 @@ static int i2c_device_uevent(struct device *dev,
char **envp, int num_envp,
 	int			i = 0, length = 0;

 	/* by definition, legacy drivers can't hotplug */
-	if (dev->driver || !client->driver_name)
+	if (dev->driver || !client->name)
 		return 0;

 	if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
-			"MODALIAS=%s", client->driver_name))
+			"MODALIAS=%s", client->name))
 		return -ENOMEM;
 	envp[i] = NULL;
 	dev_dbg(dev, "uevent\n");
@@ -169,22 +180,15 @@ static void i2c_client_dev_release(struct device *dev)
 	kfree(to_i2c_client(dev));
 }

-static ssize_t show_client_name(struct device *dev, struct
device_attribute *attr, char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	return sprintf(buf, "%s\n", client->name);
-}
-
 static ssize_t show_modalias(struct device *dev, struct
device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	return client->driver_name
-		? sprintf(buf, "%s\n", client->driver_name)
+	return client->name
+		? sprintf(buf, "%s\n", client->name)
 		: 0;
 }

 static struct device_attribute i2c_dev_attrs[] = {
-	__ATTR(name, S_IRUGO, show_client_name, NULL),
 	/* modalias helps coldplug:  modprobe $(cat .../modalias) */
 	__ATTR(modalias, S_IRUGO, show_modalias, NULL),
 	{ },
@@ -233,10 +237,7 @@ i2c_new_device(struct i2c_adapter *adap, struct
i2c_board_info const *info)
 	client->flags = info->flags;
 	client->addr = info->addr;
 	client->irq = info->irq;
-
-	strlcpy(client->driver_name, info->driver_name,
-		sizeof(client->driver_name));
-	strlcpy(client->name, info->type, sizeof(client->name));
+	strlcpy(client->name, info->name, sizeof(info->name));

 	/* a new style driver may be bound to this device when we
 	 * return from this function, or any later moment (e.g. maybe
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 0242d80..43fedba 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -266,6 +266,7 @@ static struct i2c_driver pcf8563_driver = {
 	.driver		= {
 		.name	= "pcf8563",
 	},
+	.aliases = (char const *[]){"philips,pcf8563", "epson,rtc8564", 0},
 	.id		= I2C_DRIVERID_PCF8563,
 	.attach_adapter = &pcf8563_attach,
 	.detach_client	= &pcf8563_detach,
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 6b67b50..b2da981 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -62,11 +62,11 @@


 enum rtc_type {
-	rtc_undef = 0,
 	rtc_rs5c372a,
 	rtc_rs5c372b,
 	rtc_rv5c386,
 	rtc_rv5c387a,
+	rtc_undef,
 };

 /* REVISIT:  this assumes that:
@@ -649,6 +649,7 @@ static struct i2c_driver rs5c372_driver = {
 	.driver		= {
 		.name	= "rtc-rs5c372",
 	},
+	.aliases	= (char const
*[]){"ricoh,rs5c372a","ricoh,rs5c372b","ricoh,rv5c386","ricoh,rv5c387a",	0},
 	.probe		= rs5c372_probe,
 	.remove		= rs5c372_remove,
 };
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 2a32f2f..4384cc1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -107,6 +107,13 @@ extern s32 i2c_smbus_write_i2c_block_data(struct
i2c_client * client,
 struct i2c_driver {
 	int id;
 	unsigned int class;
+	
+	/* Alias names for the driver. Used to support device trees on
+	 * the PowerPC architecture. Device tree names take the form of
+	 * vendor,chip. For example "epson,rtc8564". Alias is a list of
+	 * strings terminated by a zero entry.
+	 */
+	char const **aliases;

 	/* Notifies the driver that a new bus has appeared. This routine
 	 * can be used by the driver to test if the bus meets its conditions
@@ -146,7 +153,7 @@ struct i2c_driver {
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)

-#define I2C_NAME_SIZE	20
+#define I2C_NAME_SIZE	40

 /**
  * struct i2c_client - represent an I2C slave device
@@ -181,7 +188,6 @@ struct i2c_client {
 					/* to the client		*/
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device (or -1) */
-	char driver_name[KOBJ_NAME_LEN];
 	struct list_head list;
 	struct completion released;
 };
@@ -225,8 +231,7 @@ static inline void i2c_set_clientdata (struct
i2c_client *dev, void *data)
  * with the adapter already known.
  */
 struct i2c_board_info {
-	char		driver_name[KOBJ_NAME_LEN];
-	char		type[I2C_NAME_SIZE];
+	char 		name[I2C_NAME_SIZE];
 	unsigned short	flags;
 	unsigned short	addr;
 	void		*platform_data;


-- 
Jon Smirl
jonsmirl@gmail.com
