Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by ozlabs.org (Postfix) with ESMTP id 7A051DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 16:27:54 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so39573rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Nov 2007 21:27:52 -0800 (PST)
Message-ID: <9e4733910711072127r5f5d007rda76bfd86deaeefb@mail.gmail.com>
Date: Thu, 8 Nov 2007 00:27:52 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	Tjernlund <tjernlund@tjernlund.se>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Modifying i2c-core to support alias driver names compatible
	with device trees
In-Reply-To: <9e4733910711061239g22b06863rbec37fcef138c869@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711061239g22b06863rbec37fcef138c869@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

After contemplating the vast amounts of feedback I received on the
first version of this patch I reworked it to reduce it's impact. This
version can go in without changing any existing drivers in the kernel.

Currently i2c uses a driver_name/type pair to handle drivers which
support more than one device. This version leaves driver_name/type
alone and create a parallel, alternative naming scheme - aliases. When
the grand merge to remove legacy style i2c drivers happens, the
driver_name/type scheme can be removed and converted to use the alias
strings.

If we can get agreement on this patch, I'll post a new version of the
i2c-mpc.c rewrite patch.

Extend i2c-core to support lists of device tree compatible names when
matching drivers

From: Jon Smirl <jonsmirl@gmail.com>


---

 arch/powerpc/sysdev/fsl_soc.c |   46 ++++++-----------------------------------
 drivers/i2c/i2c-core.c        |   16 +++++++++++++-
 drivers/rtc/rtc-ds1307.c      |   14 ++++++++++++
 drivers/rtc/rtc-ds1374.c      |    1 +
 drivers/rtc/rtc-pcf8563.c     |    1 +
 drivers/rtc/rtc-rs5c372.c     |   18 +++++++++++++---
 include/linux/i2c.h           |   13 +++++++++---
 7 files changed, 63 insertions(+), 46 deletions(-)


diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ace747..cb95a72 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -320,48 +320,12 @@ arch_initcall(gfar_of_init);

 #ifdef CONFIG_I2C_BOARDINFO
 #include <linux/i2c.h>
-struct i2c_driver_device {
-	char	*of_device;
-	char	*i2c_driver;
-	char	*i2c_type;
-};
-
-static struct i2c_driver_device i2c_devices[] __initdata = {
-	{"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
-	{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
-	{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
-	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
-	{"dallas,ds1307",  "rtc-ds1307",  "ds1307",},
-	{"dallas,ds1337",  "rtc-ds1307",  "ds1337",},
-	{"dallas,ds1338",  "rtc-ds1307",  "ds1338",},
-	{"dallas,ds1339",  "rtc-ds1307",  "ds1339",},
-	{"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
-	{"stm,m41t00",     "rtc-ds1307",  "m41t00"},
-	{"dallas,ds1374",  "rtc-ds1374",  "rtc-ds1374",},
-};
-
-static int __init of_find_i2c_driver(struct device_node *node,
-				     struct i2c_board_info *info)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
-		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
-			continue;
-		if (strlcpy(info->driver_name, i2c_devices[i].i2c_driver,
-			    KOBJ_NAME_LEN) >= KOBJ_NAME_LEN ||
-		    strlcpy(info->type, i2c_devices[i].i2c_type,
-			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
-			return -ENOMEM;
-		return 0;
-	}
-	return -ENODEV;
-}

 static void __init of_register_i2c_devices(struct device_node *adap_node,
 					   int bus_num)
 {
 	struct device_node *node = NULL;
+	const char *compatible;

 	while ((node = of_get_next_child(adap_node, node))) {
 		struct i2c_board_info info = {};
@@ -378,9 +342,13 @@ static void __init of_register_i2c_devices(struct
device_node *adap_node,
 		if (info.irq == NO_IRQ)
 			info.irq = -1;

-		if (of_find_i2c_driver(node, &info) < 0)
+		compatible = of_get_property(node, "compatible", &len);
+		if (!compatible) {
+			printk(KERN_WARNING "i2c-mpc.c: invalid entry, missing compatible
attribute\n");
 			continue;
-
+		}
+		strncpy(info.name, compatible, sizeof(info.name));
+		
 		info.addr = *addr;

 		i2c_register_board_info(bus_num, &info, 1);
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 1a4e8dc..8b49860 100644
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
@@ -61,7 +62,20 @@ static int i2c_device_match(struct device *dev,
struct device_driver *drv)
 	/* new style drivers use the same kind of driver matching policy
 	 * as platform devices or SPI:  compare device and driver IDs.
 	 */
-	return strcmp(client->driver_name, drv->name) == 0;
+	if (strcmp(client->driver_name, drv->name) == 0)
+		return true;
+	
+	/* Match against arrary of alias device tree names. When a match
+	 * is found change the reference to point at the copy inside the
+	 * chip driver allowing the caller's string to be freed.
+ 	 */
+	alias = driver->aliases;
+	while (alias && *alias) {
+		if (strnicmp(client->driver_name, *alias, sizeof client->driver_name) == 0)
+			return true;
+		alias++;
+	}
+	return 0;	
 }

 #ifdef	CONFIG_HOTPLUG
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index db6f3f0..456b7ca 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -135,6 +135,11 @@ static inline const struct chip_desc
*find_chip(const char *s)
 	for (i = 0; i < ARRAY_SIZE(chips); i++)
 		if (strnicmp(s, chips[i].name, sizeof chips[i].name) == 0)
 			return &chips[i];
+	/* check the alias names */
+	for (i = ds_1307; i <= m41t00; i++)
+		if (strnicmp(client->driver_name, ds1307_driver.aliases[i], sizeof
client->driver_name) == 0)
+			return &chips[i];
+	
 	return NULL;
 }

@@ -442,6 +447,15 @@ static struct i2c_driver ds1307_driver = {
 		.name	= "rtc-ds1307",
 		.owner	= THIS_MODULE,
 	},
+	.aliases = (char const *[]){
+		[ds_1307] = "dallas,ds1307",
+		[ds_1337] = "dallas,ds1337",
+		[ds_1338] = "dallas,ds1338",
+		[ds_1339] = "dallas,ds1339",
+		[ds_1340] = "dallas,ds1340",
+		[m41t00] = "stm,m41t00",
+		0
+	},
 	.probe		= ds1307_probe,
 	.remove		= __devexit_p(ds1307_remove),
 };
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 45bda18..df8eca4 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -427,6 +427,7 @@ static struct i2c_driver ds1374_driver = {
 		.name = "rtc-ds1374",
 		.owner = THIS_MODULE,
 	},
+	.aliases = (char const *[]){"dallas,ds1374", 0},
 	.probe = ds1374_probe,
 	.remove = __devexit_p(ds1374_remove),
 };
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 0242d80..fa04dc5 100644
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
index 6b67b50..b458f5f 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -62,7 +62,6 @@


 enum rtc_type {
-	rtc_undef = 0,
 	rtc_rs5c372a,
 	rtc_rs5c372b,
 	rtc_rv5c386,
@@ -531,8 +530,14 @@ static int rs5c372_probe(struct i2c_client *client)
 	else if (strcmp(client->name, "rv5c387a") == 0)
 		rs5c372->type = rtc_rv5c387a;
 	else {
-		rs5c372->type = rtc_rs5c372b;
-		dev_warn(&client->dev, "assuming rs5c372b\n");
+		/* check the alias names */
+		for (rs5c372->type = rtc_rs5c372a; rs5c372->type <= rtc_rv5c387a;
rs5c372->type++)
+			if (strnicmp(client->driver_name,
rs5c372_driver.aliases[rs5c372->type], sizeof client->driver_name) ==
0)
+				break;
+		if (rs5c372->type > rtc_rv5c387a) {
+			rs5c372->type = rtc_rs5c372b;
+			dev_warn(&client->dev, "assuming rs5c372b\n");
+		}
 	}

 	/* clock may be set for am/pm or 24 hr time */
@@ -649,6 +654,13 @@ static struct i2c_driver rs5c372_driver = {
 	.driver		= {
 		.name	= "rtc-rs5c372",
 	},
+	.aliases	= (char const *[]){
+		[rtc_rs5c372a] = "ricoh,rs5c372a",
+		[rtc_rs5c372b] = "ricoh,rs5c372b",
+		[rtc_rv5c386] = "ricoh,rv5c386",
+		[rtc_rv5c387a] = "ricoh,rv5c387a",
+		0
+	},
 	.probe		= rs5c372_probe,
 	.remove		= rs5c372_remove,
 };
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 8033e6b..b952c8a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -105,6 +105,13 @@ extern s32 i2c_smbus_write_i2c_block_data(struct
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
@@ -144,7 +151,7 @@ struct i2c_driver {
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)

-#define I2C_NAME_SIZE	20
+#define I2C_NAME_SIZE	40

 /**
  * struct i2c_client - represent an I2C slave device
@@ -179,7 +186,7 @@ struct i2c_client {
 					/* to the client		*/
 	struct device dev;		/* the device structure		*/
 	int irq;			/* irq issued by device (or -1) */
-	char driver_name[KOBJ_NAME_LEN];
+	char driver_name[I2C_NAME_SIZE];
 	struct list_head list;
 	struct completion released;
 };
@@ -223,7 +230,7 @@ static inline void i2c_set_clientdata (struct
i2c_client *dev, void *data)
  * with the adapter already known.
  */
 struct i2c_board_info {
-	char		driver_name[KOBJ_NAME_LEN];
+	char		driver_name[I2C_NAME_SIZE];
 	char		type[I2C_NAME_SIZE];
 	unsigned short	flags;
 	unsigned short	addr;


-- 
Jon Smirl
jonsmirl@gmail.com
