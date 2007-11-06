Return-Path: <jonsmirl@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.181])
	by ozlabs.org (Postfix) with ESMTP id 0A701DDE39
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 06:02:15 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id r27so562100ele
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Nov 2007 11:02:13 -0800 (PST)
Message-ID: <9e4733910711061102w710f670ey48a0cca72883084@mail.gmail.com>
Date: Tue, 6 Nov 2007 14:02:12 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <20071106154004.4f01a536.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
	<9e4733910711052025m7905efb6ja3e4b6a022e6aa81@mail.gmail.com>
	<20071106154004.4f01a536.sfr@canb.auug.org.au>
Cc: Tjernlund <tjernlund@tjernlund.se>, Jean Delvare <khali@linux-fr.org>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Second pass at extending i2c core to accept strings of aliases for the
module. This version eliminate the need for separate name and type
fields when selecting a driver. PowerPC has to have a mapping from
device tree names to the i2c drivers, it makes sense to keep this
mapping inside the i2c driver.

Extend i2c-core to support lists of device tree compatible names when
matching drivers

From: Jon Smirl <jonsmirl@gmail.com>


---

 drivers/i2c/busses/i2c-mpc.c |   37 +++++++------------------------------
 drivers/i2c/i2c-core.c       |   35 ++++++++++++++++++-----------------
 drivers/rtc/rtc-pcf8563.c    |    1 +
 drivers/rtc/rtc-rs5c372.c    |    3 ++-
 include/linux/i2c.h          |   13 +++++++++----
 5 files changed, 37 insertions(+), 52 deletions(-)


diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 4ddebe4..30420ad 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -312,34 +312,6 @@ static struct i2c_adapter mpc_ops =3D {
 =09.retries =3D 1
 };

-struct i2c_driver_device {
-=09char=09*of_device;
-=09char=09*i2c_driver;
-=09char=09*i2c_type;
-};
-
-static struct i2c_driver_device i2c_devices[] =3D {
-=09{"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
-=09{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
-=09{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
-=09{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
-=09{"epson,pcf8564", "rtc-pcf8563", "pcf8564",},
-};
-
-static int of_find_i2c_driver(struct device_node *node, struct
i2c_board_info *info)
-{
-=09int i;
-
-=09for (i =3D 0; i < ARRAY_SIZE(i2c_devices); i++) {
-=09=09if (!of_device_is_compatible(node, i2c_devices[i].of_device))
-=09=09=09continue;
-=09=09strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN)=
;
-=09=09strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
-=09=09return 0;
-=09}
-=09return -ENODEV;
-}
-
 static void of_register_i2c_devices(struct i2c_adapter *adap, struct
device_node *adap_node)
 {
 =09struct device_node *node =3D NULL;
@@ -347,11 +319,12 @@ static void of_register_i2c_devices(struct
i2c_adapter *adap, struct device_node
 =09while ((node =3D of_get_next_child(adap_node, node))) {
 =09=09struct i2c_board_info info;
 =09=09const u32 *addr;
+=09=09const char *compatible;
 =09=09int len;

 =09=09addr =3D of_get_property(node, "reg", &len);
 =09=09if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
-=09=09=09printk(KERN_WARNING "i2c-mpc.c: invalid i2c device entry\n");
+=09=09=09printk(KERN_WARNING "i2c-mpc.c: invalid entry, missing reg attrib=
ute\n");
 =09=09=09continue;
 =09=09}

@@ -359,8 +332,12 @@ static void of_register_i2c_devices(struct
i2c_adapter *adap, struct device_node
 =09=09if (info.irq =3D=3D NO_IRQ)
 =09=09=09info.irq =3D -1;

-=09=09if (of_find_i2c_driver(node, &info) < 0)
+=09=09compatible =3D of_get_property(node, "compatible", &len);
+=09=09if (!compatible) {
+=09=09=09printk(KERN_WARNING "i2c-mpc.c: invalid entry, missing compatible
attribute\n");
 =09=09=09continue;
+=09=09}
+=09=09strncpy(info.name, compatible, sizeof(info.name));

 =09=09info.platform_data =3D NULL;
 =09=09info.addr =3D *addr;
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d663e69..d9a70c2 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -17,7 +17,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.=09=09     */
 /* -----------------------------------------------------------------------=
-- */

-/* With some changes from Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>.
+/* With some changes from Ky=C3=B6sti M=C3=80lkki <kmalkki@cc.hut.fi>.
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
    SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com> and
    Jean Delvare <khali@linux-fr.org> */
@@ -51,6 +51,7 @@ static int i2c_device_match(struct device *dev,
struct device_driver *drv)
 {
 =09struct i2c_client=09*client =3D to_i2c_client(dev);
 =09struct i2c_driver=09*driver =3D to_i2c_driver(drv);
+=09char const **alias;

 =09/* make legacy i2c drivers bypass driver model probing entirely;
 =09 * such drivers scan each i2c adapter/bus themselves.
@@ -60,8 +61,18 @@ static int i2c_device_match(struct device *dev,
struct device_driver *drv)

 =09/* new style drivers use the same kind of driver matching policy
 =09 * as platform devices or SPI:  compare device and driver IDs.
+=09 * Match against arrary of alias device tree names. When a match
+=09 * is found change the reference to point at the copy inside the
+=09 * chip driver allowing the caller's string to be freed.
 =09 */
-=09return strcmp(client->driver_name, drv->name) =3D=3D 0;
+=09alias =3D driver->aliases;
+=09while (*alias) {
+=09=09if (strcmp(client->name, *alias) =3D=3D 0) {
+=09=09=09return true;
+=09=09}
+=09=09alias++;
+=09}
+=09return 0;
 }

 #ifdef=09CONFIG_HOTPLUG
@@ -74,11 +85,11 @@ static int i2c_device_uevent(struct device *dev,
char **envp, int num_envp,
 =09int=09=09=09i =3D 0, length =3D 0;

 =09/* by definition, legacy drivers can't hotplug */
-=09if (dev->driver || !client->driver_name)
+=09if (dev->driver || !client->name)
 =09=09return 0;

 =09if (add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
-=09=09=09"MODALIAS=3D%s", client->driver_name))
+=09=09=09"MODALIAS=3D%s", client->name))
 =09=09return -ENOMEM;
 =09envp[i] =3D NULL;
 =09dev_dbg(dev, "uevent\n");
@@ -169,22 +180,15 @@ static void i2c_client_dev_release(struct device *dev=
)
 =09kfree(to_i2c_client(dev));
 }

-static ssize_t show_client_name(struct device *dev, struct
device_attribute *attr, char *buf)
-{
-=09struct i2c_client *client =3D to_i2c_client(dev);
-=09return sprintf(buf, "%s\n", client->name);
-}
-
 static ssize_t show_modalias(struct device *dev, struct
device_attribute *attr, char *buf)
 {
 =09struct i2c_client *client =3D to_i2c_client(dev);
-=09return client->driver_name
-=09=09? sprintf(buf, "%s\n", client->driver_name)
+=09return client->name
+=09=09? sprintf(buf, "%s\n", client->name)
 =09=09: 0;
 }

 static struct device_attribute i2c_dev_attrs[] =3D {
-=09__ATTR(name, S_IRUGO, show_client_name, NULL),
 =09/* modalias helps coldplug:  modprobe $(cat .../modalias) */
 =09__ATTR(modalias, S_IRUGO, show_modalias, NULL),
 =09{ },
@@ -233,10 +237,7 @@ i2c_new_device(struct i2c_adapter *adap, struct
i2c_board_info const *info)
 =09client->flags =3D info->flags;
 =09client->addr =3D info->addr;
 =09client->irq =3D info->irq;
-
-=09strlcpy(client->driver_name, info->driver_name,
-=09=09sizeof(client->driver_name));
-=09strlcpy(client->name, info->type, sizeof(client->name));
+=09strlcpy(client->name, info->name, sizeof(info->name));

 =09/* a new style driver may be bound to this device when we
 =09 * return from this function, or any later moment (e.g. maybe
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index b778d35..8162f77 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -266,6 +266,7 @@ static struct i2c_driver pcf8563_driver =3D {
 =09.driver=09=09=3D {
 =09=09.name=09=3D "rtc-pcf8563",
 =09},
+=09.aliases =3D (char const *[]){"philips,pcf8563", "epson,rtc8564", 0},
 =09.id=09=09=3D I2C_DRIVERID_PCF8563,
 =09.probe =3D &pcf8563_probe,
 =09.remove =3D &pcf8563_remove,
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 6b67b50..b2da981 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -62,11 +62,11 @@


 enum rtc_type {
-=09rtc_undef =3D 0,
 =09rtc_rs5c372a,
 =09rtc_rs5c372b,
 =09rtc_rv5c386,
 =09rtc_rv5c387a,
+=09rtc_undef,
 };

 /* REVISIT:  this assumes that:
@@ -649,6 +649,7 @@ static struct i2c_driver rs5c372_driver =3D {
 =09.driver=09=09=3D {
 =09=09.name=09=3D "rtc-rs5c372",
 =09},
+=09.aliases=09=3D (char const
*[]){"ricoh,rs5c372a","ricoh,rs5c372b","ricoh,rv5c386","ricoh,rv5c387a",=09=
0},
 =09.probe=09=09=3D rs5c372_probe,
 =09.remove=09=09=3D rs5c372_remove,
 };
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 2a32f2f..4384cc1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -107,6 +107,13 @@ extern s32 i2c_smbus_write_i2c_block_data(struct
i2c_client * client,
 struct i2c_driver {
 =09int id;
 =09unsigned int class;
+=09
+=09/* Alias names for the driver. Used to support device trees on
+=09 * the PowerPC architecture. Device tree names take the form of
+=09 * vendor,chip. For example "epson,rtc8564". Alias is a list of
+=09 * strings terminated by a zero entry.
+=09 */
+=09char const **aliases;

 =09/* Notifies the driver that a new bus has appeared. This routine
 =09 * can be used by the driver to test if the bus meets its conditions
@@ -146,7 +153,7 @@ struct i2c_driver {
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)

-#define I2C_NAME_SIZE=0920
+#define I2C_NAME_SIZE=0940

 /**
  * struct i2c_client - represent an I2C slave device
@@ -181,7 +188,6 @@ struct i2c_client {
 =09=09=09=09=09/* to the client=09=09*/
 =09struct device dev;=09=09/* the device structure=09=09*/
 =09int irq;=09=09=09/* irq issued by device (or -1) */
-=09char driver_name[KOBJ_NAME_LEN];
 =09struct list_head list;
 =09struct completion released;
 };
@@ -225,8 +231,7 @@ static inline void i2c_set_clientdata (struct
i2c_client *dev, void *data)
  * with the adapter already known.
  */
 struct i2c_board_info {
-=09char=09=09driver_name[KOBJ_NAME_LEN];
-=09char=09=09type[I2C_NAME_SIZE];
+=09char =09=09name[I2C_NAME_SIZE];
 =09unsigned short=09flags;
 =09unsigned short=09addr;
 =09void=09=09*platform_data;

--=20
Jon Smirl
jonsmirl@gmail.com
