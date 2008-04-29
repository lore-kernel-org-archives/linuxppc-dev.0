Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01F69DDEF2
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 20:46:35 +1000 (EST)
Date: Tue, 29 Apr 2008 12:46:21 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <i2c@lm-sensors.org>
Subject: [PATCH 1/2 v2] i2c: Add support for device alias names
Message-ID: <20080429124621.07e6efd6@hyperion.delvare>
In-Reply-To: <20080429124241.08e18ae3@hyperion.delvare>
References: <20080429124241.08e18ae3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Laurent, Sievers <kay.sievers@vrfy.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Scott Wood <scottwood@freescale.com>, Kay
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Based on earlier work by Jon Smirl and Jochen Friedrich.

This patch allows new-style i2c chip drivers to have alias names using
the official kernel aliasing system and MODULE_DEVICE_TABLE(). At this
point, the old i2c driver binding scheme (driver_name/type) is still
supported.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jochen Friedrich <jochen@scram.de>
Cc: Jon Smirl <jonsmirl@gmail.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>
---
 Documentation/i2c/writing-clients          |    3 +
 drivers/gpio/pca953x.c                     |    3 +
 drivers/gpio/pcf857x.c                     |    3 +
 drivers/hwmon/f75375s.c                    |    8 ++--
 drivers/i2c/chips/ds1682.c                 |    3 +
 drivers/i2c/chips/menelaus.c               |    3 +
 drivers/i2c/chips/tps65010.c               |    3 +
 drivers/i2c/chips/tsl2550.c                |    3 +
 drivers/i2c/i2c-core.c                     |   51 +++++++++++++++++++++++-----
 drivers/media/video/cs5345.c               |    3 +
 drivers/media/video/cs53l32a.c             |    3 +
 drivers/media/video/cx25840/cx25840-core.c |    3 +
 drivers/media/video/m52790.c               |    3 +
 drivers/media/video/msp3400-driver.c       |    2 -
 drivers/media/video/mt9m001.c              |    3 +
 drivers/media/video/mt9v022.c              |    3 +
 drivers/media/video/saa7115.c              |    3 +
 drivers/media/video/saa7127.c              |    3 +
 drivers/media/video/saa717x.c              |    3 +
 drivers/media/video/tcm825x.c              |    3 +
 drivers/media/video/tlv320aic23b.c         |    3 +
 drivers/media/video/tuner-core.c           |    3 +
 drivers/media/video/tvaudio.c              |    2 -
 drivers/media/video/upd64031a.c            |    3 +
 drivers/media/video/upd64083.c             |    3 +
 drivers/media/video/v4l2-common.c          |    5 +-
 drivers/media/video/vp27smpx.c             |    3 +
 drivers/media/video/wm8739.c               |    3 +
 drivers/media/video/wm8775.c               |    3 +
 drivers/rtc/rtc-ds1307.c                   |    3 +
 drivers/rtc/rtc-ds1374.c                   |    3 +
 drivers/rtc/rtc-isl1208.c                  |    2 -
 drivers/rtc/rtc-m41t80.c                   |    3 +
 drivers/rtc/rtc-pcf8563.c                  |    3 +
 drivers/rtc/rtc-rs5c372.c                  |    3 +
 drivers/rtc/rtc-s35390a.c                  |    3 +
 drivers/rtc/rtc-x1205.c                    |    3 +
 include/linux/i2c.h                        |    5 +-
 include/linux/mod_devicetable.h            |   11 ++++++
 include/media/v4l2-common.h                |    4 +-
 include/media/v4l2-i2c-drv-legacy.h        |    2 -
 include/media/v4l2-i2c-drv.h               |    2 -
 scripts/mod/file2alias.c                   |   13 +++++++
 43 files changed, 146 insertions(+), 54 deletions(-)

--- linux-2.6.26-rc0.orig/Documentation/i2c/writing-clients	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/Documentation/i2c/writing-clients	2008-04-29 08:37:43.000000000 +0200
@@ -164,7 +164,8 @@ I2C device drivers using this binding mo
 kind of driver in Linux:  they provide a probe() method to bind to
 those devices, and a remove() method to unbind.
 
-	static int foo_probe(struct i2c_client *client);
+	static int foo_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id);
 	static int foo_remove(struct i2c_client *client);
 
 Remember that the i2c_driver does not create those client handles.  The
--- linux-2.6.26-rc0.orig/drivers/gpio/pca953x.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/gpio/pca953x.c	2008-04-29 08:37:43.000000000 +0200
@@ -192,7 +192,8 @@ static void pca953x_setup_gpio(struct pc
 	gc->owner = THIS_MODULE;
 }
 
-static int __devinit pca953x_probe(struct i2c_client *client)
+static int __devinit pca953x_probe(struct i2c_client *client,
+				   const struct i2c_device_id *did)
 {
 	struct pca953x_platform_data *pdata;
 	struct pca953x_chip *chip;
--- linux-2.6.26-rc0.orig/drivers/gpio/pcf857x.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/gpio/pcf857x.c	2008-04-29 08:37:43.000000000 +0200
@@ -142,7 +142,8 @@ static void pcf857x_set16(struct gpio_ch
 
 /*-------------------------------------------------------------------------*/
 
-static int pcf857x_probe(struct i2c_client *client)
+static int pcf857x_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
 	struct pcf857x_platform_data	*pdata;
 	struct pcf857x			*gpio;
--- linux-2.6.26-rc0.orig/drivers/hwmon/f75375s.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/hwmon/f75375s.c	2008-04-29 08:37:43.000000000 +0200
@@ -117,7 +117,8 @@ struct f75375_data {
 static int f75375_attach_adapter(struct i2c_adapter *adapter);
 static int f75375_detect(struct i2c_adapter *adapter, int address, int kind);
 static int f75375_detach_client(struct i2c_client *client);
-static int f75375_probe(struct i2c_client *client);
+static int f75375_probe(struct i2c_client *client,
+			const struct i2c_device_id *id);
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
--- linux-2.6.26-rc0.orig/drivers/i2c/chips/ds1682.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/chips/ds1682.c	2008-04-29 08:37:43.000000000 +0200
@@ -200,7 +200,8 @@ static struct bin_attribute ds1682_eepro
 /*
  * Called when a ds1682 device is matched with this driver
  */
-static int ds1682_probe(struct i2c_client *client)
+static int ds1682_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	int rc;
 
--- linux-2.6.26-rc0.orig/drivers/i2c/chips/menelaus.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/chips/menelaus.c	2008-04-29 08:37:43.000000000 +0200
@@ -1149,7 +1149,8 @@ static inline void menelaus_rtc_init(str
 
 static struct i2c_driver menelaus_i2c_driver;
 
-static int menelaus_probe(struct i2c_client *client)
+static int menelaus_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
 {
 	struct menelaus_chip	*menelaus;
 	int			rev = 0, val;
--- linux-2.6.26-rc0.orig/drivers/i2c/chips/tps65010.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/chips/tps65010.c	2008-04-29 08:37:43.000000000 +0200
@@ -532,7 +532,8 @@ static int __exit tps65010_remove(struct
 	return 0;
 }
 
-static int tps65010_probe(struct i2c_client *client)
+static int tps65010_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
 {
 	struct tps65010		*tps;
 	int			status;
--- linux-2.6.26-rc0.orig/drivers/i2c/chips/tsl2550.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/chips/tsl2550.c	2008-04-29 08:37:43.000000000 +0200
@@ -364,7 +364,8 @@ static int tsl2550_init_client(struct i2
  */
 
 static struct i2c_driver tsl2550_driver;
-static int __devinit tsl2550_probe(struct i2c_client *client)
+static int __devinit tsl2550_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct tsl2550_data *data;
--- linux-2.6.26-rc0.orig/drivers/i2c/i2c-core.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/i2c/i2c-core.c	2008-04-29 08:37:43.000000000 +0200
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
@@ -90,13 +111,19 @@ static int i2c_device_probe(struct devic
 {
 	struct i2c_client	*client = to_i2c_client(dev);
 	struct i2c_driver	*driver = to_i2c_driver(dev->driver);
+	const struct i2c_device_id *id;
 	int status;
 
 	if (!driver->probe)
 		return -ENODEV;
 	client->driver = driver;
 	dev_dbg(dev, "probe\n");
-	status = driver->probe(client);
+
+	if (driver->id_table)
+		id = i2c_match_id(driver->id_table, client);
+	else
+		id = NULL;
+	status = driver->probe(client, id);
 	if (status)
 		client->driver = NULL;
 	return status;
@@ -179,9 +206,9 @@ static ssize_t show_client_name(struct d
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
@@ -300,15 +327,21 @@ void i2c_unregister_device(struct i2c_cl
 EXPORT_SYMBOL_GPL(i2c_unregister_device);
 
 
-static int dummy_nop(struct i2c_client *client)
+static int dummy_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
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
--- linux-2.6.26-rc0.orig/drivers/media/video/cs5345.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/cs5345.c	2008-04-29 08:37:43.000000000 +0200
@@ -142,7 +142,8 @@ static int cs5345_command(struct i2c_cli
 
 /* ----------------------------------------------------------------------- */
 
-static int cs5345_probe(struct i2c_client *client)
+static int cs5345_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	/* Check if the adapter supports the needed features */
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
--- linux-2.6.26-rc0.orig/drivers/media/video/cs53l32a.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/cs53l32a.c	2008-04-29 08:37:43.000000000 +0200
@@ -135,7 +135,8 @@ static int cs53l32a_command(struct i2c_c
  * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
  */
 
-static int cs53l32a_probe(struct i2c_client *client)
+static int cs53l32a_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
 {
 	int i;
 
--- linux-2.6.26-rc0.orig/drivers/media/video/cx25840/cx25840-core.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/cx25840/cx25840-core.c	2008-04-29 08:37:43.000000000 +0200
@@ -1209,7 +1209,8 @@ static int cx25840_command(struct i2c_cl
 
 /* ----------------------------------------------------------------------- */
 
-static int cx25840_probe(struct i2c_client *client)
+static int cx25840_probe(struct i2c_client *client,
+			 const struct i2c_device_id *did)
 {
 	struct cx25840_state *state;
 	u32 id;
--- linux-2.6.26-rc0.orig/drivers/media/video/m52790.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/m52790.c	2008-04-29 08:37:43.000000000 +0200
@@ -126,7 +126,8 @@ static int m52790_command(struct i2c_cli
 
 /* i2c implementation */
 
-static int m52790_probe(struct i2c_client *client)
+static int m52790_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	struct m52790_state *state;
 
--- linux-2.6.26-rc0.orig/drivers/media/video/msp3400-driver.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/msp3400-driver.c	2008-04-29 08:37:43.000000000 +0200
@@ -805,7 +805,7 @@ static int msp_resume(struct i2c_client 
 
 /* ----------------------------------------------------------------------- */
 
-static int msp_probe(struct i2c_client *client)
+static int msp_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct msp_state *state;
 	int (*thread_func)(void *data) = NULL;
--- linux-2.6.26-rc0.orig/drivers/media/video/mt9m001.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/mt9m001.c	2008-04-29 08:37:43.000000000 +0200
@@ -620,7 +620,8 @@ static void mt9m001_video_remove(struct 
 	soc_camera_video_stop(&mt9m001->icd);
 }
 
-static int mt9m001_probe(struct i2c_client *client)
+static int mt9m001_probe(struct i2c_client *client,
+			 const struct i2c_device_id *did)
 {
 	struct mt9m001 *mt9m001;
 	struct soc_camera_device *icd;
--- linux-2.6.26-rc0.orig/drivers/media/video/mt9v022.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/mt9v022.c	2008-04-29 08:37:43.000000000 +0200
@@ -745,7 +745,8 @@ static void mt9v022_video_remove(struct 
 	soc_camera_video_stop(&mt9v022->icd);
 }
 
-static int mt9v022_probe(struct i2c_client *client)
+static int mt9v022_probe(struct i2c_client *client,
+			 const struct i2c_device_id *did)
 {
 	struct mt9v022 *mt9v022;
 	struct soc_camera_device *icd;
--- linux-2.6.26-rc0.orig/drivers/media/video/saa7115.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/saa7115.c	2008-04-29 08:37:43.000000000 +0200
@@ -1450,7 +1450,8 @@ static int saa7115_command(struct i2c_cl
 
 /* ----------------------------------------------------------------------- */
 
-static int saa7115_probe(struct i2c_client *client)
+static int saa7115_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
 	struct saa711x_state *state;
 	int	i;
--- linux-2.6.26-rc0.orig/drivers/media/video/saa7127.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/saa7127.c	2008-04-29 08:37:43.000000000 +0200
@@ -661,7 +661,8 @@ static int saa7127_command(struct i2c_cl
 
 /* ----------------------------------------------------------------------- */
 
-static int saa7127_probe(struct i2c_client *client)
+static int saa7127_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
 	struct saa7127_state *state;
 	struct v4l2_sliced_vbi_data vbi = { 0, 0, 0, 0 };  /* set to disabled */
--- linux-2.6.26-rc0.orig/drivers/media/video/saa717x.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/saa717x.c	2008-04-29 08:37:43.000000000 +0200
@@ -1418,7 +1418,8 @@ static int saa717x_command(struct i2c_cl
 /* i2c implementation */
 
 /* ----------------------------------------------------------------------- */
-static int saa717x_probe(struct i2c_client *client)
+static int saa717x_probe(struct i2c_client *client,
+			 const struct i2c_device_id *did)
 {
 	struct saa717x_state *decoder;
 	u8 id = 0;
--- linux-2.6.26-rc0.orig/drivers/media/video/tcm825x.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/tcm825x.c	2008-04-29 08:37:43.000000000 +0200
@@ -840,7 +840,8 @@ static struct v4l2_int_device tcm825x_in
 	},
 };
 
-static int tcm825x_probe(struct i2c_client *client)
+static int tcm825x_probe(struct i2c_client *client,
+			 const struct i2c_device_id *did)
 {
 	struct tcm825x_sensor *sensor = &tcm825x;
 	int rval;
--- linux-2.6.26-rc0.orig/drivers/media/video/tlv320aic23b.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/tlv320aic23b.c	2008-04-29 08:37:43.000000000 +0200
@@ -125,7 +125,8 @@ static int tlv320aic23b_command(struct i
  * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
  */
 
-static int tlv320aic23b_probe(struct i2c_client *client)
+static int tlv320aic23b_probe(struct i2c_client *client,
+			      const struct i2c_device_id *id)
 {
 	struct tlv320aic23b_state *state;
 
--- linux-2.6.26-rc0.orig/drivers/media/video/tuner-core.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/tuner-core.c	2008-04-29 08:37:43.000000000 +0200
@@ -1073,7 +1073,8 @@ static void tuner_lookup(struct i2c_adap
 /* During client attach, set_type is called by adapter's attach_inform callback.
    set_type must then be completed by tuner_probe.
  */
-static int tuner_probe(struct i2c_client *client)
+static int tuner_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
 {
 	struct tuner *t;
 	struct tuner *radio;
--- linux-2.6.26-rc0.orig/drivers/media/video/tvaudio.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/tvaudio.c	2008-04-29 08:37:43.000000000 +0200
@@ -1461,7 +1461,7 @@ static struct CHIPDESC chiplist[] = {
 /* ---------------------------------------------------------------------- */
 /* i2c registration                                                       */
 
-static int chip_probe(struct i2c_client *client)
+static int chip_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct CHIPSTATE *chip;
 	struct CHIPDESC  *desc;
--- linux-2.6.26-rc0.orig/drivers/media/video/upd64031a.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/upd64031a.c	2008-04-29 08:37:43.000000000 +0200
@@ -195,7 +195,8 @@ static int upd64031a_command(struct i2c_
 
 /* i2c implementation */
 
-static int upd64031a_probe(struct i2c_client *client)
+static int upd64031a_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
 {
 	struct upd64031a_state *state;
 	int i;
--- linux-2.6.26-rc0.orig/drivers/media/video/upd64083.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/upd64083.c	2008-04-29 08:37:43.000000000 +0200
@@ -172,7 +172,8 @@ static int upd64083_command(struct i2c_c
 
 /* i2c implementation */
 
-static int upd64083_probe(struct i2c_client *client)
+static int upd64083_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
 {
 	struct upd64083_state *state;
 	int i;
--- linux-2.6.26-rc0.orig/drivers/media/video/v4l2-common.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/v4l2-common.c	2008-04-29 08:37:43.000000000 +0200
@@ -710,7 +710,8 @@ EXPORT_SYMBOL(v4l2_chip_ident_i2c_client
 /* Helper function for I2C legacy drivers */
 
 int v4l2_i2c_attach(struct i2c_adapter *adapter, int address, struct i2c_driver *driver,
-		const char *name, int (*probe)(struct i2c_client *))
+		const char *name,
+		int (*probe)(struct i2c_client *, const struct i2c_device_id *))
 {
 	struct i2c_client *client;
 	int err;
@@ -724,7 +725,7 @@ int v4l2_i2c_attach(struct i2c_adapter *
 	client->driver = driver;
 	strlcpy(client->name, name, sizeof(client->name));
 
-	err = probe(client);
+	err = probe(client, NULL);
 	if (err == 0) {
 		i2c_attach_client(client);
 	} else {
--- linux-2.6.26-rc0.orig/drivers/media/video/vp27smpx.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/vp27smpx.c	2008-04-29 08:37:43.000000000 +0200
@@ -121,7 +121,8 @@ static int vp27smpx_command(struct i2c_c
  * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
  */
 
-static int vp27smpx_probe(struct i2c_client *client)
+static int vp27smpx_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
 {
 	struct vp27smpx_state *state;
 
--- linux-2.6.26-rc0.orig/drivers/media/video/wm8739.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/wm8739.c	2008-04-29 08:37:43.000000000 +0200
@@ -261,7 +261,8 @@ static int wm8739_command(struct i2c_cli
 
 /* i2c implementation */
 
-static int wm8739_probe(struct i2c_client *client)
+static int wm8739_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	struct wm8739_state *state;
 
--- linux-2.6.26-rc0.orig/drivers/media/video/wm8775.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/media/video/wm8775.c	2008-04-29 08:37:43.000000000 +0200
@@ -159,7 +159,8 @@ static int wm8775_command(struct i2c_cli
  * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
  */
 
-static int wm8775_probe(struct i2c_client *client)
+static int wm8775_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	struct wm8775_state *state;
 
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-ds1307.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-ds1307.c	2008-04-29 08:37:43.000000000 +0200
@@ -326,7 +326,8 @@ static struct bin_attribute nvram = {
 
 static struct i2c_driver ds1307_driver;
 
-static int __devinit ds1307_probe(struct i2c_client *client)
+static int __devinit ds1307_probe(struct i2c_client *client,
+				  const struct i2c_device_id *id)
 {
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-ds1374.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-ds1374.c	2008-04-29 08:37:43.000000000 +0200
@@ -355,7 +355,8 @@ static const struct rtc_class_ops ds1374
 	.ioctl = ds1374_ioctl,
 };
 
-static int ds1374_probe(struct i2c_client *client)
+static int ds1374_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	struct ds1374 *ds1374;
 	int ret;
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-isl1208.c	2008-04-29 07:41:16.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-isl1208.c	2008-04-29 08:50:01.000000000 +0200
@@ -490,7 +490,7 @@ isl1208_sysfs_unregister(struct device *
 }
 
 static int
-isl1208_probe(struct i2c_client *client)
+isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	int rc = 0;
 	struct rtc_device *rtc;
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-m41t80.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-m41t80.c	2008-04-29 08:37:43.000000000 +0200
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
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-pcf8563.c	2008-04-29 07:41:16.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-pcf8563.c	2008-04-29 08:49:41.000000000 +0200
@@ -246,7 +246,8 @@ static const struct rtc_class_ops pcf856
 	.set_time	= pcf8563_rtc_set_time,
 };
 
-static int pcf8563_probe(struct i2c_client *client)
+static int pcf8563_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
 {
 	struct pcf8563 *pcf8563;
 
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-rs5c372.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-rs5c372.c	2008-04-29 08:37:43.000000000 +0200
@@ -494,7 +494,8 @@ static void rs5c_sysfs_unregister(struct
 
 static struct i2c_driver rs5c372_driver;
 
-static int rs5c372_probe(struct i2c_client *client)
+static int rs5c372_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
 	int err = 0;
 	struct rs5c372 *rs5c372;
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-s35390a.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-s35390a.c	2008-04-29 08:37:43.000000000 +0200
@@ -195,7 +195,8 @@ static const struct rtc_class_ops s35390
 
 static struct i2c_driver s35390a_driver;
 
-static int s35390a_probe(struct i2c_client *client)
+static int s35390a_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
 {
 	int err;
 	unsigned int i;
--- linux-2.6.26-rc0.orig/drivers/rtc/rtc-x1205.c	2008-04-29 07:41:16.000000000 +0200
+++ linux-2.6.26-rc0/drivers/rtc/rtc-x1205.c	2008-04-29 08:48:52.000000000 +0200
@@ -494,7 +494,8 @@ static void x1205_sysfs_unregister(struc
 }
 
 
-static int x1205_probe(struct i2c_client *client)
+static int x1205_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
 {
 	int err = 0;
 	unsigned char sr;
--- linux-2.6.26-rc0.orig/include/linux/i2c.h	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/include/linux/i2c.h	2008-04-29 08:37:43.000000000 +0200
@@ -126,7 +126,7 @@ struct i2c_driver {
 	 * With the driver model, device enumeration is NEVER done by drivers;
 	 * it's done by infrastructure.  (NEW STYLE DRIVERS ONLY)
 	 */
-	int (*probe)(struct i2c_client *);
+	int (*probe)(struct i2c_client *, const struct i2c_device_id *);
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
--- linux-2.6.26-rc0.orig/include/linux/mod_devicetable.h	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/include/linux/mod_devicetable.h	2008-04-29 08:37:43.000000000 +0200
@@ -368,4 +368,15 @@ struct virtio_device_id {
 };
 #define VIRTIO_DEV_ANY_ID	0xffffffff
 
+/* i2c */
+
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
--- linux-2.6.26-rc0.orig/include/media/v4l2-common.h	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/include/media/v4l2-common.h	2008-04-29 08:37:43.000000000 +0200
@@ -107,9 +107,11 @@ int v4l2_chip_match_host(u32 id_type, u3
 struct i2c_driver;
 struct i2c_adapter;
 struct i2c_client;
+struct i2c_device_id;
 
 int v4l2_i2c_attach(struct i2c_adapter *adapter, int address, struct i2c_driver *driver,
-		const char *name, int (*probe)(struct i2c_client *));
+		const char *name,
+		int (*probe)(struct i2c_client *, const struct i2c_device_id *));
 
 /* ------------------------------------------------------------------------- */
 
--- linux-2.6.26-rc0.orig/include/media/v4l2-i2c-drv-legacy.h	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/include/media/v4l2-i2c-drv-legacy.h	2008-04-29 08:37:43.000000000 +0200
@@ -25,7 +25,7 @@ struct v4l2_i2c_driver_data {
 	const char * const name;
 	int driverid;
 	int (*command)(struct i2c_client *client, unsigned int cmd, void *arg);
-	int (*probe)(struct i2c_client *client);
+	int (*probe)(struct i2c_client *client, const struct i2c_device_id *id);
 	int (*remove)(struct i2c_client *client);
 	int (*suspend)(struct i2c_client *client, pm_message_t state);
 	int (*resume)(struct i2c_client *client);
--- linux-2.6.26-rc0.orig/include/media/v4l2-i2c-drv.h	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/include/media/v4l2-i2c-drv.h	2008-04-29 08:37:43.000000000 +0200
@@ -30,7 +30,7 @@ struct v4l2_i2c_driver_data {
 	const char * const name;
 	int driverid;
 	int (*command)(struct i2c_client *client, unsigned int cmd, void *arg);
-	int (*probe)(struct i2c_client *client);
+	int (*probe)(struct i2c_client *client, const struct i2c_device_id *id);
 	int (*remove)(struct i2c_client *client);
 	int (*suspend)(struct i2c_client *client, pm_message_t state);
 	int (*resume)(struct i2c_client *client);
--- linux-2.6.26-rc0.orig/scripts/mod/file2alias.c	2008-04-29 08:13:00.000000000 +0200
+++ linux-2.6.26-rc0/scripts/mod/file2alias.c	2008-04-29 08:37:43.000000000 +0200
@@ -576,6 +576,15 @@ static int do_virtio_entry(const char *f
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
@@ -704,6 +713,10 @@ void handle_moddevtable(struct module *m
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
