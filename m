Return-Path: <jonsmirl@gmail.com>
Received: from ro-out-1112.google.com (ro-out-1112.google.com [72.14.202.177])
	by ozlabs.org (Postfix) with ESMTP id 98EB6DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 15:25:38 +1100 (EST)
Received: by ro-out-1112.google.com with SMTP id p7so2347303roc
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 20:25:37 -0800 (PST)
Message-ID: <9e4733910711052025m7905efb6ja3e4b6a022e6aa81@mail.gmail.com>
Date: Mon, 5 Nov 2007 23:25:35 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <472F8267.8070106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> >>> Or push these strings into the chip drivers and modify
> >>> i2c-core to also match on the device tree style names.
> >> That would be ideal; it just hasn't been done yet.
> >
> > This is not hard to do but the i2c people will have to agree. I need
> > to change the i2c_driver structure to include the additional names.
>
> I got a fair bit of resistance from them on the topic of multiple match
> names for i2c clients.

Here's a first pass at pushing the strings back into the i2c drivers.
If this looks reasonable it can be optimized a lot more.  A more
advanced version of this code would combine the alias, name, and
driver_name fields. The existing pairing of driver_name/name could be
merged into the concept of alias names for the driver.

Extend i2c-core to support lists of device tree compatible names when
matching drivers

From: Jon Smirl <jonsmirl@gmail.com>


---

 drivers/i2c/busses/i2c-mpc.c |   35 ++++-------------------------------
 drivers/i2c/i2c-core.c       |   17 +++++++++++++++--
 drivers/rtc/rtc-pcf8563.c    |    1 +
 drivers/rtc/rtc-rs5c372.c    |    1 +
 include/linux/i2c.h          |   11 +++++++++--
 5 files changed, 30 insertions(+), 35 deletions(-)


diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 4ddebe4..6313631 100644
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
@@ -347,6 +319,7 @@ static void of_register_i2c_devices(struct
i2c_adapter *adap, struct device_node
 =09while ((node =3D of_get_next_child(adap_node, node))) {
 =09=09struct i2c_board_info info;
 =09=09const u32 *addr;
+=09=09const char *compatible;
 =09=09int len;

 =09=09addr =3D of_get_property(node, "reg", &len);
@@ -359,9 +332,9 @@ static void of_register_i2c_devices(struct
i2c_adapter *adap, struct device_node
 =09=09if (info.irq =3D=3D NO_IRQ)
 =09=09=09info.irq =3D -1;

-=09=09if (of_find_i2c_driver(node, &info) < 0)
-=09=09=09continue;
-
+=09=09compatible =3D of_get_property(node, "compatible", &len);
+=09=09strlcpy(info.driver_name, compatible, len);
+=09=09info.type[0] =3D '\0';
 =09=09info.platform_data =3D NULL;
 =09=09info.addr =3D *addr;

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d663e69..4128cd1 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -17,7 +17,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.=09=09     */
 /* -----------------------------------------------------------------------=
-- */

-/* With some changes from Ky=F6sti M=E4lkki <kmalkki@cc.hut.fi>.
+/* With some changes from Ky=EF=BF=9Csti M=EF=BF=9Clkki <kmalkki@cc.hut.fi=
>.
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
    SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com> and
    Jean Delvare <khali@linux-fr.org> */
@@ -51,6 +51,7 @@ static int i2c_device_match(struct device *dev,
struct device_driver *drv)
 {
 =09struct i2c_client=09*client =3D to_i2c_client(dev);
 =09struct i2c_driver=09*driver =3D to_i2c_driver(drv);
+=09char **alias;

 =09/* make legacy i2c drivers bypass driver model probing entirely;
 =09 * such drivers scan each i2c adapter/bus themselves.
@@ -61,7 +62,19 @@ static int i2c_device_match(struct device *dev,
struct device_driver *drv)
 =09/* new style drivers use the same kind of driver matching policy
 =09 * as platform devices or SPI:  compare device and driver IDs.
 =09 */
-=09return strcmp(client->driver_name, drv->name) =3D=3D 0;
+=09if (strcmp(client->driver_name, drv->name) =3D=3D 0)
+=09=09return true;
+
+=09/* Match against alias device tree names */
+=09if (!driver->alias)
+=09=09return 0;
+=09alias =3D driver->alias;
+=09while (*alias) {
+=09=09if (strcmp(client->driver_name, *alias) =3D=3D 0)
+=09=09=09return true;
+=09=09alias++;
+=09}
+=09return 0;
 }

 #ifdef=09CONFIG_HOTPLUG
diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index b778d35..7c8caf5 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -266,6 +266,7 @@ static struct i2c_driver pcf8563_driver =3D {
 =09.driver=09=09=3D {
 =09=09.name=09=3D "rtc-pcf8563",
 =09},
+=09.alias=09=3D (char *[]){"epson,pcf8564", 0},
 =09.id=09=09=3D I2C_DRIVERID_PCF8563,
 =09.probe =3D &pcf8563_probe,
 =09.remove =3D &pcf8563_remove,
diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index 6b67b50..0f37d04 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -649,6 +649,7 @@ static struct i2c_driver rs5c372_driver =3D {
 =09.driver=09=09=3D {
 =09=09.name=09=3D "rtc-rs5c372",
 =09},
+=09.alias=09=3D (char
*[]){"ricoh,rs5c372a","ricoh,rs5c372b","ricoh,rv5c386","ricoh,rv5c387a",0},
 =09.probe=09=09=3D rs5c372_probe,
 =09.remove=09=09=3D rs5c372_remove,
 };
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 2a32f2f..d55748c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -107,6 +107,13 @@ extern s32 i2c_smbus_write_i2c_block_data(struct
i2c_client * client,
 struct i2c_driver {
 =09int id;
 =09unsigned int class;
+=09
+=09/* Alias name for the driver. Used to support device trees on
+=09 * the PowerPC architecture. Device tree names take the form of
+=09 * vendor,chip. For example "epson,pcf8564". Alias is a list of
+=09 * strings terminated by a zero entry.
+=09 */
+=09char **alias;

 =09/* Notifies the driver that a new bus has appeared. This routine
 =09 * can be used by the driver to test if the bus meets its conditions
@@ -146,7 +153,7 @@ struct i2c_driver {
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)

-#define I2C_NAME_SIZE=0920
+#define I2C_NAME_SIZE=0940

 /**
  * struct i2c_client - represent an I2C slave device
@@ -225,7 +232,7 @@ static inline void i2c_set_clientdata (struct
i2c_client *dev, void *data)
  * with the adapter already known.
  */
 struct i2c_board_info {
-=09char=09=09driver_name[KOBJ_NAME_LEN];
+=09char=09=09driver_name[I2C_NAME_SIZE];
 =09char=09=09type[I2C_NAME_SIZE];
 =09unsigned short=09flags;
 =09unsigned short=09addr;


--=20
Jon Smirl
jonsmirl@gmail.com
