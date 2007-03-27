Return-Path: <robbat2@gentoo.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by ozlabs.org (Postfix) with ESMTP id E2408DE0FB
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 02:37:54 +1000 (EST)
Date: Tue, 27 Mar 2007 09:31:23 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linuxppc-dev@ozlabs.org
Subject: [ALPHA PATCH] Windfarm prototype work for new sensors,
	missed sensor outputs, and PM72 support
Message-ID: <20070327163123.GA22984@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The patch is also available at
http://dev.gentoo.org/~robbat2/windfarm-2.6.18-prototyping.diff

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

The following patch is the work on the windfarm infrastructure that I did
between April 2006 and December 2006. I haven't had the time to get back to=
 it
since then, so I'm releasing this prototype version so that others can buil=
d on
the work.

This is based on 2.6.18, and I haven't found time to update it either.

It works fine on my PowerMac11,2, but I make absolutely no claims that it w=
ill
work on other machines. I did start on the PM72 windfarm support, but some
parts of it below may not even compile, or might eat your hardware etc.

The basic premise of it is:
1. Identify all chips from the device-tree of the various machines.
2. If a windfarm driver for the chip already exists, check it for multiple
   outputs (eg MAX6690, which only had one output available before)
3. Otherwise write a new windfarm-style driver for it (see DS1631, AD7417).
4. Hook up the drivers into the windfarm controller, explicitly ignoring the
   others that are present, but not yet used for speed control.
5. Notice the new style of Makefile, that allows easier selection of multip=
le
   drivers.
6. Try to come up with a consistent naming scheme based on actual sensor
   location, rather than any claims the hardware makes as to where the sens=
or
   is located.

Here's the full output of my sensors for my PM11,2. There are new sensor
readings present: DS1631 for Inlet, MAX6690 extra outputs for the heatsink =
vs.
die on the northbridge and tunnel chip.

windfarm.0/backside-fan:1109
windfarm.0/cpu-current-0:15.746
windfarm.0/cpu-current-1:17.332
windfarm.0/cpu-current-2:17.453
windfarm.0/cpu-current-3:16.722
windfarm.0/cpu-front-fan-0:845
windfarm.0/cpu-front-fan-1:845
windfarm.0/cpu-power-0:18.798
windfarm.0/cpu-power-1:21.241
windfarm.0/cpu-power-2:21.347
windfarm.0/cpu-power-3:21.638
windfarm.0/cpu-pump-0:1250
windfarm.0/cpu-rear-fan-0:871
windfarm.0/cpu-rear-fan-1:872
windfarm.0/cpu-temp-0:48.000
windfarm.0/cpu-temp-1:51.062
windfarm.0/cpu-temp-2:50.062
windfarm.0/cpu-temp-3:50.593
windfarm.0/cpu-voltage-0:1.193
windfarm.0/cpu-voltage-1:1.225
windfarm.0/cpu-voltage-2:1.223
windfarm.0/cpu-voltage-3:1.293
windfarm.0/drive-bay-fan:1000
windfarm.0/hd-temp:38.000
windfarm.0/ht2000-die-temp:43.000
windfarm.0/ht2000-heatsink-temp:37.000
windfarm.0/inlet-ambient-temp:29.625
windfarm.0/northbridge-die-temp:64.000
windfarm.0/northbridge-heatsink-temp:48.000
windfarm.0/slots-fan:1560
windfarm.0/slots-power:30.429

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index a9e747c..3b737ba 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -199,10 +199,30 @@ config WINDFARM
 	tristate "New PowerMac thermal control infrastructure"
 	depends on PPC
=20
+config WINDFARM_PM72
+	tristate "Support for thermal management on early PowerMac G5 and Xserve =
G5 models"
+	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && ADB_PMU
+	select I2C_POWERMAC
+	select WINDFARM_LM75
+	select WINDFARM_DS1631
+	select WINDFARM_MAX6690
+	select WINDFARM_AD7417
+	select WINDFARM_PCA9556
+	select WINDFARM_PIC16C72A
+	help
+	  This driver provides thermal control for early PowerMac G5 and Xserve
+	  G5 models - PowerMac7,2; PowerMac7,3; RackMac3,1
+
 config WINDFARM_PM81
 	tristate "Support for thermal management on iMac G5"
 	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && PMAC_SMU
 	select I2C_POWERMAC
+	select WINDFARM_SMU
+	select WINDFARM_CPUFREQ
+	select WINDFARM_LM75
+# Need to confirm these chips are present
+#	select WINDFARM_DS1631
+#	select WINDFARM_MAX6690
 	help
 	  This driver provides thermal control for the iMacG5
=20
@@ -210,6 +230,12 @@ config WINDFARM_PM91
 	tristate "Support for thermal management on PowerMac9,1"
 	depends on WINDFARM && I2C && CPU_FREQ_PMAC64 && PMAC_SMU
 	select I2C_POWERMAC
+	select WINDFARM_SMU
+	select WINDFARM_CPUFREQ
+	select WINDFARM_LM75
+# Need to confirm these chips are present
+#	select WINDFARM_DS1631
+#	select WINDFARM_MAX6690
 	help
 	  This driver provides thermal control for the PowerMac9,1
           which is the recent (SMU based) single CPU desktop G5
@@ -218,10 +244,51 @@ config WINDFARM_PM112
 	tristate "Support for thermal management on PowerMac11,2"
 	depends on WINDFARM && I2C && PMAC_SMU
 	select I2C_POWERMAC
+	select WINDFARM_SMU
+	select WINDFARM_SMU_SAT
+	select WINDFARM_LM75
+	select WINDFARM_DS1631
+	select WINDFARM_MAX6690
 	help
 	  This driver provides thermal control for the PowerMac11,2
 	  which are the recent dual and quad G5 machines using the
 	  970MP dual-core processor.
+=09
+config WINDFARM_LM75
+	tristate "Support for sensor chip - LM75/DS1775"
+	depends on WINDFARM && I2C
+
+config WINDFARM_DS1631
+	tristate "Support for sensor chip - DS1631"
+	depends on WINDFARM && I2C
+
+config WINDFARM_PIC16C72A
+	tristate "Support for sensor chip - PIC16C72A"
+	depends on WINDFARM && I2C
+
+config WINDFARM_MAX6690
+	tristate "Support for sensor chip - MAX6690"
+	depends on WINDFARM && I2C
+
+config WINDFARM_AD7417
+	tristate "Support for sensor chip - AD7417"
+	depends on WINDFARM && I2C
+
+config WINDFARM_PCA9556
+	tristate "Support for sensor chip - PCA9556"
+	depends on WINDFARM && I2C
+
+config WINDFARM_SMU_SAT
+	tristate "Support for SMU based 'satellite' controller sensors found in t=
he last PowerMacs."
+	depends on WINDFARM && PMAC_SMU
+
+config WINDFARM_SMU
+	tristate "Support for SMU based sensors and controls"
+	depends on WINDFARM && PMAC_SMU
+
+config WINDFARM_CPUFREQ
+	tristate "CPU frequency clamp for PowerMacs thermal control using Windfar=
m"
+	depends on WINDFARM && PMAC_SMU
=20
 config ANSLCD
 	tristate "Support for ANS LCD display"
diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
index 2dfc3f4..a8f914b 100644
--- a/drivers/macintosh/Makefile
+++ b/drivers/macintosh/Makefile
@@ -28,18 +28,21 @@ obj-$(CONFIG_ADB_MACIO)		+=3D macio-adb.o
 obj-$(CONFIG_THERM_PM72)	+=3D therm_pm72.o
 obj-$(CONFIG_THERM_WINDTUNNEL)	+=3D therm_windtunnel.o
 obj-$(CONFIG_THERM_ADT746X)	+=3D therm_adt746x.o
-obj-$(CONFIG_WINDFARM)	        +=3D windfarm_core.o
-obj-$(CONFIG_WINDFARM_PM81)     +=3D windfarm_smu_controls.o \
-				   windfarm_smu_sensors.o \
-				   windfarm_lm75_sensor.o windfarm_pid.o \
-				   windfarm_cpufreq_clamp.o windfarm_pm81.o
-obj-$(CONFIG_WINDFARM_PM91)     +=3D windfarm_smu_controls.o \
-				   windfarm_smu_sensors.o \
-				   windfarm_lm75_sensor.o windfarm_pid.o \
-				   windfarm_cpufreq_clamp.o windfarm_pm91.o
-obj-$(CONFIG_WINDFARM_PM112)	+=3D windfarm_pm112.o windfarm_smu_sat.o \
-				   windfarm_smu_controls.o \
-				   windfarm_smu_sensors.o \
-				   windfarm_max6690_sensor.o \
-				   windfarm_lm75_sensor.o windfarm_pid.o
+
+obj-$(CONFIG_WINDFARM)	        +=3D windfarm_core.o windfarm_pid.o=20
+
+obj-$(CONFIG_WINDFARM_LM75)	+=3D windfarm_lm75_sensor.o
+obj-$(CONFIG_WINDFARM_DS1631)	+=3D windfarm_ds1631_sensor.o
+obj-$(CONFIG_WINDFARM_MAX6690)	+=3D windfarm_max6690_sensor.o
+obj-$(CONFIG_WINDFARM_PIC16C72A)	+=3D windfarm_pic16c72a_sensor.o
+obj-$(CONFIG_WINDFARM_AD7417)	+=3D windfarm_ad7417_sensor.o
+obj-$(CONFIG_WINDFARM_PCA9556)	+=3D windfarm_pca9556_sensor.o
+obj-$(CONFIG_WINDFARM_SMU) +=3D windfarm_smu_controls.o windfarm_smu_senso=
rs.o
+obj-$(CONFIG_WINDFARM_SMU_SAT) +=3D windfarm_smu_sat.o
+obj-$(CONFIG_WINDFARM_CPUFREQ) +=3D windfarm_cpufreq_clamp.o
 obj-$(CONFIG_PMAC_RACKMETER)	+=3D rack-meter.o
+
+obj-$(CONFIG_WINDFARM_PM72)     +=3D windfarm_pm72.o
+obj-$(CONFIG_WINDFARM_PM81)     +=3D windfarm_pm81.o
+obj-$(CONFIG_WINDFARM_PM91)     +=3D windfarm_pm91.o
+obj-$(CONFIG_WINDFARM_PM112)	+=3D windfarm_pm112.o
diff --git a/drivers/macintosh/windfarm_ad7417_sensor.c b/drivers/macintosh=
/windfarm_ad7417_sensor.c
new file mode 100644
index 0000000..c850747
--- /dev/null
+++ b/drivers/macintosh/windfarm_ad7417_sensor.c
@@ -0,0 +1,503 @@
+/*
+ * Windfarm PowerMac thermal control.  AD7417 sensor.
+ *
+ * Copyright (C) 2006 Robin H. Johnson <robbat2@gentoo.org>
+ *
+ * Use and redistribute under the terms of the GNU GPL v2.
+ */
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <asm/prom.h>
+#include <asm/pmac_low_i2c.h>
+
+#include "windfarm.h"
+
+#define VERSION "0.2"
+
+#define DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+// This is how many channels the AD7417 hardware has
+#define AD7417_MAX_CHANNELS 5
+#define AD7417_CHANNEL_AMBIENT 0
+#define AD7417_CHANNEL_CPU_TEMP_DIODE 1
+#define AD7417_CHANNEL_12V_VOLTAGE 2
+#define AD7417_CHANNEL_CPU_VOLTAGE 3
+#define AD7417_CHANNEL_CPU_CURRENT 4
+
+/*
+ * Scaling factors for the AD7417 ADC converters (except
+ * for the CPU diode which is obtained from the EEPROM).
+ * Those values are obtained from the property list of
+ * the Darwin driver.
+ * AppleMacRISC4PE-185.0.0/AppleMacRISC4PE.pbproj/project.pbxproj
+ * Look for the 'scaling-factor' keys.
+ */
+#define ADC_12V_CURRENT_SCALE	0x0320	/* _AD2 */
+#define ADC_CPU_VOLTAGE_SCALE	0x00a0	/* _AD3 */
+#define ADC_CPU_CURRENT_SCALE	0x1f40	/* _AD4 */
+
+struct wf_ad7417_sensor {
+	struct i2c_client	*i2c;
+	struct wf_sensor	sens;
+	u8 	chan; /* channel number */
+	u8 adc_config; /* configuration of the ADC. Duplicate data in some cases,=
 but not easily avoidable. */
+};
+
+#define wf_to_ad7417(x)	container_of((x), struct wf_ad7417_sensor, sens)
+#define i2c_to_ad7417(x)	container_of((x), struct wf_ad7417_sensor, i2c)
+
+// {{{ AD7417 Fake Power Sensor
+struct ad7417_cpu_power_sensor {
+	struct wf_sensor	*volts;
+	struct wf_sensor	*amps;
+	struct wf_sensor	sens;
+};
+#define wf_to_ad7417_cpu_power(c) container_of((c), struct ad7417_cpu_powe=
r_sensor, sens)
+#define MAX_POWER_SENSORS 2
+static struct ad7417_cpu_power_sensor *ad7417_cpu_power[MAX_POWER_SENSORS];
+
+static void ad7417_cpu_power_release(struct wf_sensor *sr)
+{
+	struct ad7417_cpu_power_sensor *pow =3D wf_to_ad7417_cpu_power(sr);
+
+	if (pow->volts)
+		wf_put_sensor(pow->volts);
+	if (pow->amps)
+		wf_put_sensor(pow->amps);
+	kfree(pow);
+}
+
+static int ad7417_cpu_power_get(struct wf_sensor *sr, s32 *value)
+{
+	struct ad7417_cpu_power_sensor *pow =3D wf_to_ad7417_cpu_power(sr);
+	s32 volts, amps, power;
+	int rc;
+
+	rc =3D pow->amps->ops->get_value(pow->amps, &amps);
+	if (rc)
+		return rc;
+
+	rc =3D pow->volts->ops->get_value(pow->volts, &volts);
+	if (rc)
+		return rc;
+
+	power =3D (s32)((((u64)volts) * ((u64)amps)) >> 16);
+	*value =3D power;
+	return 0;
+}
+
+static struct wf_sensor_ops ad7417_cpu_power_ops =3D {
+	.get_value	=3D ad7417_cpu_power_get,
+	.release	=3D ad7417_cpu_power_release,
+	.owner		=3D THIS_MODULE,
+};
+
+	static struct ad7417_cpu_power_sensor *
+ad7417_cpu_power_create(struct wf_sensor *volts, struct wf_sensor *amps, c=
har* name)
+{
+	struct ad7417_cpu_power_sensor *pow;
+
+	pow =3D kmalloc(sizeof(struct ad7417_cpu_power_sensor), GFP_KERNEL);
+	if (pow =3D=3D NULL)
+		return NULL;
+	pow->sens.ops =3D &ad7417_cpu_power_ops;
+	pow->sens.name =3D name;
+
+	wf_get_sensor(volts);
+	pow->volts =3D volts;
+	wf_get_sensor(amps);
+	pow->amps =3D amps;
+
+	if (wf_register_sensor(&pow->sens))
+		goto fail;
+	return pow;
+ fail:
+	kfree(pow);
+	return NULL;
+}
+
+//}}}
+
+static int wf_ad7417_attach(struct i2c_adapter *adapter);
+static int wf_ad7417_detach(struct i2c_client *client);
+
+static struct i2c_driver wf_ad7417_driver =3D {
+	.driver =3D {
+		.name		=3D "wf_ad7417",
+	},
+	.attach_adapter	=3D wf_ad7417_attach,
+	.detach_client	=3D wf_ad7417_detach,
+};
+
+static int ad7417_init(struct i2c_client *i2c, u8 *adc_config) {
+	int rc =3D 0;
+	u8 buf[2];
+
+	/* Clear Config2 */
+	buf[0] =3D 5;
+	buf[1] =3D 0;
+	i2c_master_send(i2c, buf, 2);
+
+	/* Read & cache Config1 */
+	buf[0] =3D 1;
+	rc =3D i2c_master_send(i2c, buf, 1);
+	if (rc > 0) {
+		rc =3D i2c_master_recv(i2c, buf, 1);
+		if (rc > 0) {
+			*adc_config =3D buf[0];
+			DBG("ADC config reg: %02x\n", *adc_config);
+
+			/* Disable shutdown mode */
+			*adc_config &=3D 0xfe;
+			buf[0] =3D 1;
+			buf[1] =3D *adc_config;
+			rc =3D i2c_master_send(i2c, buf, 2);
+		}
+	}
+	if (rc <=3D 0)
+		printk(KERN_ERR "windfarm_ad7417: Error reading ADC config register !\n"=
);
+	return rc;
+}
+
+static int ad7417_channel_read(struct wf_ad7417_sensor *ad7417) {
+	int rc, data, tries =3D 0;
+	u8 buf[2];
+	for (;;) {
+		/* Set channel */
+		buf[0] =3D 1;
+		buf[1] =3D (ad7417->adc_config & 0x1f) | (ad7417->chan << 5);
+		rc =3D i2c_master_send(ad7417->i2c, buf, 2);
+		if (rc <=3D 0)
+			goto error;
+		/* Wait for convertion */
+		msleep(1);
+		/* Switch to data register */
+		buf[0] =3D 4;
+		rc =3D i2c_master_send(ad7417->i2c, buf, 1);
+		if (rc <=3D 0)
+			goto error;
+		/* Read result */
+		rc =3D i2c_master_recv(ad7417->i2c, buf, 2);
+		if (rc < 0)
+			goto error;
+		data =3D ((u16)buf[0]) << 8 | (u16)buf[1];
+		return data >> 6;
+error:
+		DBG("Error reading ADC, retrying...\n");
+		if (++tries > 10) {
+			printk(KERN_ERR "windfarm_ad7417: Error reading ADC !\n");
+			return -1;
+		}
+		msleep(10);
+	}
+}
+
+static int wf_ad7417_get(struct wf_sensor *sr, s32 *value)
+{
+	struct wf_ad7417_sensor *ad7417 =3D wf_to_ad7417(sr);
+	s32 data;
+
+	if (ad7417->i2c->adapter =3D=3D NULL)
+		return -ENODEV;
+
+	data =3D ad7417_channel_read(ad7417);
+
+	if(ad7417->chan =3D=3D AD7417_CHANNEL_AMBIENT) {
+		// ... TODO
+	} else if(ad7417->chan =3D=3D AD7417_CHANNEL_CPU_TEMP_DIODE) {
+		// ... TODO
+	} else if(ad7417->chan =3D=3D AD7417_CHANNEL_12V_VOLTAGE) {
+		data *=3D ADC_12V_CURRENT_SCALE;
+	} else if(ad7417->chan =3D=3D AD7417_CHANNEL_CPU_VOLTAGE) {
+		data *=3D ADC_CPU_VOLTAGE_SCALE;
+	} else if(ad7417->chan =3D=3D AD7417_CHANNEL_CPU_CURRENT) {
+		data *=3D ADC_CPU_CURRENT_SCALE;
+	}
+
+	// TODO: rewrite this
+
+	/* chip gets initialized by firmware */
+	/*
+	   data =3D i2c_smbus_read_byte_data(ad7417->i2c, ad7417->reg);
+	   if (data < 0)
+	   return data;
+	 *value =3D data << 16;
+	 */
+	return 0;
+}
+
+static void wf_ad7417_release(struct wf_sensor *sr)
+{
+	struct wf_ad7417_sensor *ad7417 =3D wf_to_ad7417(sr);
+
+	wf_unregister_sensor(&ad7417->sens);
+
+	if (ad7417->i2c->adapter) {
+		i2c_detach_client(ad7417->i2c);
+		ad7417->i2c->adapter =3D NULL;
+	}
+	kfree(ad7417);
+}
+
+static struct wf_sensor_ops wf_ad7417_ops =3D {
+	.get_value	=3D wf_ad7417_get,
+	.release	=3D wf_ad7417_release,
+	.owner		=3D THIS_MODULE,
+};
+
+static struct i2c_client * wf_ad7417_create_i2c_client(struct i2c_adapter =
*adapter, u8 addr) {
+	struct i2c_client *i2c;
+	const char* ad7417str =3D "ad7417";
+	i2c =3D kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (i2c =3D=3D NULL) {
+		printk(KERN_ERR "windfarm: Couldn't create i2c client no memory\n");
+		return NULL;
+	}
+	DBG(KERN_DEBUG "wf_ad7417: i2c client created %p\n",i2c);
+	i2c->addr =3D addr >> 1;
+	i2c->adapter =3D adapter;
+	i2c->driver =3D &wf_ad7417_driver;
+	/* neither name is correct
+	 * strncpy(i2c->name, name, I2C_NAME_SIZE-1);
+	 */
+	strncpy(i2c->name, ad7417str, I2C_NAME_SIZE-1);
+	return i2c;
+}
+
+static struct wf_ad7417_sensor* wf_ad7417_create_wf_sensor(struct i2c_clie=
nt *client, char* name, u8 chan, u8 adc_config) { =20
+	struct wf_ad7417_sensor *ad7417;
+	ad7417 =3D kzalloc(sizeof(struct wf_ad7417_sensor), GFP_KERNEL);
+	if (ad7417 =3D=3D NULL) {
+		printk(KERN_ERR "windfarm: Couldn't create ad7417 sensor %s: "
+				"no memory\n", name);
+		return NULL;
+	}
+
+	ad7417->chan =3D chan;
+	ad7417->sens.ops =3D &wf_ad7417_ops;
+	ad7417->sens.name =3D name;
+	ad7417->i2c =3D client;
+	ad7417->adc_config =3D adc_config;
+
+	return ad7417;
+}
+
+static void wf_ad7417_create(struct i2c_adapter *adapter, u8 addr, char* n=
ames[AD7417_MAX_CHANNELS], u8 chip, char* power_sensor_name)
+{
+	struct wf_ad7417_sensor *ad7417[AD7417_MAX_CHANNELS] =3D {NULL,NULL,NULL,=
NULL,NULL};
+	struct i2c_client* i2c;
+	u8 chan=3D0, adc_config=3D0;
+	DBG(KERN_DEBUG "wf_ad7417: create i2c client\n");
+	// --- block 1
+	i2c =3D wf_ad7417_create_i2c_client(adapter,addr);
+	if(!i2c) {
+		goto fail_i2c;
+	}
+	// --- block 2
+	/* Configure AD7417 chip */
+	if(!ad7417_init(i2c,&adc_config))
+		goto fail_create_wf_sensor;
+	/* Build sensors */
+	DBG(KERN_DEBUG "wf_ad7417: i2c client is %p\n",i2c);
+	for(chan =3D 0; chan < AD7417_MAX_CHANNELS; chan++) {
+		DBG(KERN_DEBUG "wf_ad7417: create sensor chan=3D%d\n",chan);
+		if(names[chan])  {
+			ad7417[chan] =3D wf_ad7417_create_wf_sensor(i2c, names[chan], chan, adc=
_config);
+			if(!ad7417[chan])
+				goto fail_create_wf_sensor;
+		}
+	}
+	// --- block 3
+	DBG(KERN_DEBUG "wf_ad7417: i2c attach client\n");
+	if (i2c_attach_client(i2c)) {
+		printk(KERN_ERR "windfarm: failed to attach ad7417 sensor\n");
+		goto fail_i2c_attach_client;
+	}
+	// --- block 4
+	for(chan =3D 0; chan < AD7417_MAX_CHANNELS; chan++) {
+		DBG(KERN_DEBUG "wf_ad7417: wf register chan=3D%d\n");
+		if (names[chan] && wf_register_sensor(&ad7417[chan]->sens)) {
+			goto fail_wf_register_sensor;
+		}
+	}
+	// -- block 5
+	DBG(KERN_DEBUG "wf_ad7417: creating power sensor name=3D%s\n",power_senso=
r_name);
+	if(ad7417[AD7417_CHANNEL_CPU_VOLTAGE] && ad7417[AD7417_CHANNEL_CPU_CURREN=
T])
+		ad7417_cpu_power[chip] =3D ad7417_cpu_power_create(
+				&ad7417[AD7417_CHANNEL_CPU_VOLTAGE]->sens,
+				&ad7417[AD7417_CHANNEL_CPU_CURRENT]->sens,
+				power_sensor_name);
+	// --- blocks completed
+	DBG(KERN_DEBUG "wf_ad7417: completed creating all sensors for addr=3D%x\n=
",addr);
+	return;
+
+	// undo block 4
+fail_wf_register_sensor:
+	for(chan =3D 0; chan < AD7417_MAX_CHANNELS; chan++) {
+		if (names[chan])
+			wf_unregister_sensor(&ad7417[chan]->sens);
+	}
+	// undo block 3
+	i2c_detach_client(i2c);
+	// undo block 2
+fail_i2c_attach_client:
+fail_create_wf_sensor:
+	for(chan =3D 0; chan < AD7417_MAX_CHANNELS; chan++) {
+		if(ad7417[chan])
+			kfree(ad7417[chan]);
+	}
+	// undo block 1
+	kfree(i2c);
+	// completed undo
+fail_i2c:
+	return;
+}
+
+static int wf_ad7417_attach(struct i2c_adapter *adapter)
+{
+	struct device_node *busnode, *dev =3D NULL;
+	struct pmac_i2c_bus *bus;
+	const char *loc; // the entire string
+	const char *loc_middle; // the middle constant portion (after the CPU let=
ter)
+	const char *loc_tail; // the end portion
+	char *names[AD7417_MAX_CHANNELS];
+	char *power_sensor_name =3D "power-sensor-x";
+
+	bus =3D pmac_i2c_adapter_to_bus(adapter);
+	if (bus =3D=3D NULL)
+		return -ENODEV;
+	busnode =3D pmac_i2c_get_bus_node(bus);
+
+	while ((dev =3D of_get_next_child(busnode, dev)) !=3D NULL) {
+		u8 addr;
+		u8 chan =3D 0;
+		u8 chip =3D -1;
+		int namelen;
+		int lenp;
+		for(chan =3D 0; chan < AD7417_MAX_CHANNELS; chan++) {
+			names[chan] =3D NULL;
+		}
+		chan =3D 0;
+
+		/* We must re-match the adapter in order to properly check
+		 * the channel on multibus setups
+		 */
+		if (!pmac_i2c_match_adapter(dev, adapter))
+			continue;
+		if (!device_is_compatible(dev, "ad7417"))
+			continue;
+		addr =3D pmac_i2c_get_dev_addr(dev);
+		if(addr =3D=3D 0)=20
+			continue;
+		/* At this point we diverge from template code, as ad7417
+		 * provides one temperature value and 4 analog inputs (via adc).
+		 * Channel 0 =3D temp
+		 * Channel 1-4 =3D ADC inputs 1-4
+		 */
+		DBG(KERN_DEBUG "wf_ad7417: looking for registers on chip\n");
+		loc =3D get_property(dev, "hwsensor-location", &lenp);
+		if (loc =3D=3D NULL)
+			continue;
+
+		while (lenp > 0) {
+			int l;
+			DBG(KERN_DEBUG "wf_ad7417: found loc=3D%s addr=3D0x%02x chan=3D0x%02x\n=
", loc, addr, chan);
+			/* Add more entries here */
+			// Strings:
+			// "CPU x AD7417 yyy"
+			//  0123456789012345
+			//  0+4
+			//      4
+			//       5+8
+			//               13+3
+			loc_middle =3D loc+5;
+			loc_tail =3D loc+13;
+			if(!strncmp(loc,"CPU ", 4) && !strncmp(loc_middle," AD7417 ",8)) {
+				// check CPU A/B
+				chip =3D loc[4] - 'A';
+				// check last 3 chars
+				names[chan] =3D NULL;
+				if(strcmp(loc_tail,"AMB")) {
+					names[chan] =3D "cpu-ambient-temp-x";
+				} else if(strcmp(loc_tail,"AD1")) {
+					names[chan] =3D "cpu-diode-temp-x";
+				} else if(strcmp(loc_tail,"AD2")) {
+					names[chan] =3D "12v-current-x";
+				} else if(strcmp(loc_tail,"AD3")) {
+					names[chan] =3D "cpu-voltage-x";
+				} else if(strcmp(loc_tail,"AD4")) {
+					names[chan] =3D "cpu-current-x";
+				}
+				// always append to the end
+				if(names[chan]) {
+					namelen=3Dstrlen(names[chan]);
+					names[chan][namelen-1] =3D chip+'0';
+				} else {
+					printk(KERN_WARNING "wf_ad7417: unknown sensor addr=3D0x%02x loc=3D%s=
 chan=3D0x%01x ",addr,loc,chan);
+				}
+			}
+			chan++;
+			/* Push to the next location string */
+			l =3D strlen(loc) + 1;
+			loc +=3D l;
+			lenp -=3D l;
+		}
+		DBG(KERN_DEBUG "wf_ad7417 calling create\n");
+		namelen=3Dstrlen(power_sensor_name);
+		power_sensor_name[namelen-1] =3D chip+'0';
+		wf_ad7417_create(adapter, addr, names, chip, power_sensor_name);
+		DBG(KERN_DEBUG "wf_ad7417 done create\n");
+	}
+
+	return 0;
+}
+
+static int wf_ad7417_detach(struct i2c_client *client)
+{
+	struct wf_ad7417_sensor *ad7417 =3D i2c_to_ad7417(&client);
+
+	// ad7417->i2c->adapter =3D NULL;
+	wf_unregister_sensor(&ad7417->sens);
+
+	if (ad7417->i2c->adapter) {
+		i2c_detach_client(ad7417->i2c);
+		ad7417->i2c->adapter =3D NULL;
+	}
+	kfree(ad7417);
+
+	return 0;
+}
+
+static int __init wf_ad7417_sensor_init(void) {
+	ad7417_cpu_power[0] =3D ad7417_cpu_power[1] =3D NULL;
+	return i2c_add_driver(&wf_ad7417_driver);
+}
+
+static void __exit wf_ad7417_sensor_exit(void) {
+	int i;
+	for(i =3D 0; i < MAX_POWER_SENSORS; i++) {
+		if(ad7417_cpu_power[i])
+			wf_unregister_sensor(&ad7417_cpu_power[i]->sens);
+	}
+	i2c_del_driver(&wf_ad7417_driver);
+}
+
+module_init(wf_ad7417_sensor_init);
+module_exit(wf_ad7417_sensor_exit);
+
+MODULE_AUTHOR("Robin H. Johnson <robbat2@gentoo.org>");
+MODULE_DESCRIPTION("AD7417 sensor objects for PowerMac thermal control");
+MODULE_LICENSE("GPL");
+
+// vim: fdm=3Dmarker:
diff --git a/drivers/macintosh/windfarm_ds1631_sensor.c b/drivers/macintosh=
/windfarm_ds1631_sensor.c
new file mode 100644
index 0000000..f2733a2
--- /dev/null
+++ b/drivers/macintosh/windfarm_ds1631_sensor.c
@@ -0,0 +1,298 @@
+/*
+ * Windfarm PowerMac thermal control. DS1631 sensor.
+ *
+ * The internal workings of this are based solely on the datasheet availab=
le
+ * from Maxim. We do a more complete job than the Apple driver, just in ca=
se
+ * OSX changes it's behavior in the future (it doesn't init the chip fully,
+ * just makes a few assumptions).
+ *
+ * (c) Copyright 2006 Robin H. Johnson <robbat2@gentoo.org>
+ *
+ * Released under the term of the GNU GPL v2.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+#include <linux/i2c.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <asm/sections.h>
+#include <asm/pmac_low_i2c.h>
+
+#include "windfarm.h"
+
+#define VERSION "0.1"
+
+//#undef DEBUG
+#define DEBUG
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
+
+struct wf_ds1631_sensor {
+	int			inited : 1;
+	struct 	i2c_client	i2c;
+	struct 	wf_sensor	sens;
+};
+#define wf_to_ds1631(c) container_of(c, struct wf_ds1631_sensor, sens)
+#define i2c_to_ds1631(c) container_of(c, struct wf_ds1631_sensor, i2c)
+
+static int wf_ds1631_attach(struct i2c_adapter *adapter);
+static int wf_ds1631_detach(struct i2c_client *client);
+
+static struct i2c_driver wf_ds1631_driver =3D {
+	.driver =3D {
+		.name	=3D "wf_ds1631",
+	},
+	.attach_adapter	=3D wf_ds1631_attach,
+	.detach_client	=3D wf_ds1631_detach,
+};
+
+// registers for DS1631
+#define DS1631_REG_R_TEMP 		0xAA
+#define DS1631_REG_R_LOCAL_HIGH_LIMIT 	0xA1
+#define DS1631_REG_R_LOCAL_LOW_LIMIT 	0xA2
+#define DS1631_REG_RW_CONFIG 		0xAC
+#define DS1631_REG_W_START_CONVERT_T 	0x51
+#define DS1631_REG_W_STOP_CONVERT_T	0x22
+#define DS1631_REG_W_SOFTWARE_RESET	0x54
+
+
+/* Config Register layout (MSB to LSB)
+ * DONE 	- R 	- conversion completed
+ * THF 		- RW 	- Temp high exceeded
+ * TLF 		- RW 	- Temp low exceeded
+ * NVB 		- R 	- EEPROM busy
+ * R1		- RW	- Resolution bit 1
+ * R0		- RW	- Resolution bit 0
+ * POL		- RW	- Tout polarity - don't mess with this!
+ * 1SHOT	- RW	- single-shot / continous mode toggle=20
+ *
+ * Power on state is 100011xx
+ * x bits are stored in EEPROM
+ *
+ * Resolution mapping
+ * Resolution is in bits.
+ * Time is in milliseconds (ms), max.
+ * R1 R0 - Res. - Time
+ * 0  0	 - 9	-  93.75
+ * 0  1	 - 10	- 187.5 (this is similar to the 150ms of LM75/DS1775)
+ * 1  0	 - 11	- 375
+ * 1  1	 - 12	- 750
+ *
+ * Notice that the poweron state is the maximum resolution.
+ * As this takes a worst case of 750ms, we change the resolution to
+ * 10-bit mode (one quarter of a degree C), thus allowing 5 updates a
+ * second.
+ */
+static int wf_ds1631_get(struct wf_sensor *sr, s32 *value)
+{
+	struct wf_ds1631_sensor *sensor =3D wf_to_ds1631(sr);
+	s32 data;
+
+	if (sensor->i2c.adapter =3D=3D NULL)
+		return -ENODEV;
+
+	/* Init chip if necessary */
+	if (!sensor->inited) {
+		u8 cfg =3D (u8)i2c_smbus_read_byte_data(&sensor->i2c, DS1631_REG_RW_CONF=
IG);
+
+		DBG(KERN_DEBUG "wf_ds1631: Initializing %s, cfg was: %02x\n",
+				sr->name, cfg);
+
+		/*              7654 3210
+		 * target bits: x00x 01x0b
+		 * x bits must be left alone!
+		 * This:
+		 * - clears the high/low warnings,=20
+		 * - sets resolution to 10-bit=20
+		 * - disables one-shot mode
+		 */
+		cfg &=3D 0x96; // 1001 0110b
+		cfg |=3D 0x04; // 0000 0100b
+
+		i2c_smbus_write_byte_data(&sensor->i2c, 1, cfg);
+		sensor->inited =3D 1;
+
+		/* If we just powered it up, let's wait 200 ms */
+		msleep(200);
+	}
+
+	/* Read temperature register */
+	data =3D (s32)le16_to_cpu(i2c_smbus_read_word_data(&sensor->i2c, DS1631_R=
EG_R_TEMP));
+	data <<=3D 8;
+	*value =3D data;
+
+	return 0;
+}
+
+static void wf_ds1631_release(struct wf_sensor *sr)
+{
+	struct wf_ds1631_sensor *sensor =3D wf_to_ds1631(sr);
+
+	/* check if client is registered and detach from i2c */
+	if (sensor->i2c.adapter) {
+		i2c_detach_client(&sensor->i2c);
+		sensor->i2c.adapter =3D NULL;
+	}
+
+	kfree(sensor);
+}
+
+static struct wf_sensor_ops wf_ds1631_ops =3D {
+	.get_value	=3D wf_ds1631_get,
+	.release	=3D wf_ds1631_release,
+	.owner		=3D THIS_MODULE,
+};
+
+static struct wf_ds1631_sensor *wf_ds1631_create(struct i2c_adapter *adapt=
er,
+		u8 addr, const char *loc)
+{
+	struct wf_ds1631_sensor *sensor;
+	int rc;
+
+	DBG(KERN_DEBUG "wf_ds1631: creating ds1631 device at address 0x%02x\n", a=
ddr);
+
+	sensor =3D kmalloc(sizeof(struct wf_ds1631_sensor), GFP_KERNEL);
+	if (sensor =3D=3D NULL)
+		return NULL;
+	memset(sensor, 0, sizeof(struct wf_ds1631_sensor));
+
+	/* Usual rant about sensor names not beeing very consistent in
+	 * the device-tree, oh well ...
+	 * Add more entries below as you deal with more setups
+	 * PowerMac 7,3
+	 * MLB INLET AMB =3D @96-@0
+	 * PowerMac 11,2
+	 * MLB INLET AMB =3D @96-@aa
+	 */
+	if (!strcmp(loc, "MLB INLET AMB")) {
+		sensor->sens.name =3D "inlet-ambient-temp";
+	} else {
+		printk(KERN_WARNING "wf_ds1631: unknown sensor loc=3D%s\n",loc);
+		goto fail;
+	}
+
+	sensor->inited =3D 0;
+	sensor->sens.ops =3D &wf_ds1631_ops;
+	sensor->i2c.addr =3D (addr >> 1) & 0x7f;
+	sensor->i2c.adapter =3D adapter;
+	sensor->i2c.driver =3D &wf_ds1631_driver;
+	strncpy(sensor->i2c.name, sensor->sens.name, I2C_NAME_SIZE-1);
+
+	rc =3D i2c_attach_client(&sensor->i2c);
+	if (rc) {
+		printk(KERN_ERR "windfarm: failed to attach ds1631 %s to i2c,"
+				" err %d\n", sensor->i2c.name, rc);
+		goto fail;
+	}
+
+	if (wf_register_sensor(&sensor->sens)) {
+		i2c_detach_client(&sensor->i2c);
+		goto fail;
+	}
+
+	return sensor;
+fail:
+	kfree(sensor);
+	return NULL;
+}
+
+static int wf_ds1631_attach(struct i2c_adapter *adapter)
+{
+	struct device_node *busnode, *dev;
+	struct pmac_i2c_bus *bus;
+
+	DBG(KERN_DEBUG "wf_ds1631: adapter %s detected\n", adapter->name);
+
+	bus =3D pmac_i2c_adapter_to_bus(adapter);
+	if (bus =3D=3D NULL)
+		return -ENODEV;
+	busnode =3D pmac_i2c_get_bus_node(bus);
+
+	DBG("wf_ds1631: bus found, looking for device...\n");
+
+	/* Now look for ds1631(s) in there */
+	for (dev =3D NULL;
+			(dev =3D of_get_next_child(busnode, dev)) !=3D NULL;) {
+		/* ds1631 has an odd layout. It does NOT have a
+		 * hwsensor-location property, and instead you must decend
+		 * another level and look at the location property.
+		 */
+		u8 addr;
+		/* We must re-match the adapter in order to properly check
+		 * the channel on multibus setups
+		 */
+		if (!pmac_i2c_match_adapter(dev, adapter))
+			continue;
+		addr =3D pmac_i2c_get_dev_addr(dev);
+		if(addr =3D=3D 0)
+			continue;
+
+		if (device_is_compatible(dev, "ds1631")=20
+			|| device_is_compatible(dev, "ds1631a")=20
+			|| device_is_compatible(dev, "ds1731")) {
+			struct device_node *temperature;
+			/* This loop should fire only once */
+			for(temperature =3D NULL;=20
+				(temperature =3D of_get_next_child(dev,temperature)) !=3D NULL;) {
+				const char *loc =3D get_property(temperature, "location", NULL);
+				if (loc =3D=3D NULL)
+					continue;
+				wf_ds1631_create(adapter, addr, loc);
+			}
+		}
+
+
+	}
+	return 0;
+}
+
+static int wf_ds1631_detach(struct i2c_client *client)
+{
+	struct wf_ds1631_sensor *sensor =3D i2c_to_ds1631(client);
+
+	DBG(KERN_DEBUG "wf_ds1631: i2c detatch called for %s\n", sensor->sens.nam=
e);
+
+	/* Mark client detached */
+	sensor->i2c.adapter =3D NULL;
+
+	/* release sensor */
+	wf_unregister_sensor(&sensor->sens);
+
+	return 0;
+}
+
+static int __init wf_ds1631_sensor_init(void)
+{
+	/* Don't register on old machines that use therm_pm72 for now */
+	if (machine_is_compatible("PowerMac7,2") ||
+			machine_is_compatible("PowerMac7,3") ||
+			machine_is_compatible("RackMac3,1"))
+		return -ENODEV;
+	return i2c_add_driver(&wf_ds1631_driver);
+}
+
+static void __exit wf_ds1631_sensor_exit(void)
+{
+	i2c_del_driver(&wf_ds1631_driver);
+}
+
+
+module_init(wf_ds1631_sensor_init);
+module_exit(wf_ds1631_sensor_exit);
+
+MODULE_AUTHOR("Robin H. Johnson <robbat2@gentoo.org>");
+MODULE_DESCRIPTION("DS1631 sensor objects for PowerMacs thermal control");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/w=
indfarm_lm75_sensor.c
index 3f7967f..5fa49c4 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -1,8 +1,9 @@
 /*
- * Windfarm PowerMac thermal control. LM75 sensor
+ * Windfarm PowerMac thermal control. LM75/DS1775 sensor
  *
  * (c) Copyright 2005 Benjamin Herrenschmidt, IBM Corp.
  *                    <benh@kernel.crashing.org>
+ * (c) Copyright 2006 Robin H. Johnson <robbat2@gentoo.org>
  *
  * Released under the term of the GNU GPL v2.
  */
@@ -54,6 +55,10 @@ static struct i2c_driver wf_lm75_driver =3D {
 	.detach_client	=3D wf_lm75_detach,
 };
=20
+// registers for LM75
+#define LM75_REG_R_TEMP 	0
+#define LM75_REG_RW_CONFIG 	1
+
 static int wf_lm75_get(struct wf_sensor *sr, s32 *value)
 {
 	struct wf_lm75_sensor *lm =3D wf_to_lm75(sr);
@@ -64,16 +69,18 @@ static int wf_lm75_get(struct wf_sensor *sr, s32 *value)
=20
 	/* Init chip if necessary */
 	if (!lm->inited) {
-		u8 cfg_new, cfg =3D (u8)i2c_smbus_read_byte_data(&lm->i2c, 1);
+		u8 cfg =3D (u8)i2c_smbus_read_byte_data(&lm->i2c, LM75_REG_RW_CONFIG);
=20
-		DBG("wf_lm75: Initializing %s, cfg was: %02x\n",
+		DBG(KERN_DEBUG "wf_lm75: Initializing %s, cfg was: %02x\n",
 		    sr->name, cfg);
=20
-		/* clear shutdown bit, keep other settings as left by
-		 * the firmware for now
+		/* clear shutdown bit (bit 0), keep other settings as left by the
+		 * firmware for now. Chip powers up with 9-bit resolution, no fault
+		 * tolerance, polarity active low. 9-bit conversions take 150ms worst
+		 * case.
 		 */
-		cfg_new =3D cfg & ~0x01;
-		i2c_smbus_write_byte_data(&lm->i2c, 1, cfg_new);
+		cfg &=3D !0x1;
+		i2c_smbus_write_byte_data(&lm->i2c, LM75_REG_RW_CONFIG, cfg);
 		lm->inited =3D 1;
=20
 		/* If we just powered it up, let's wait 200 ms */
@@ -81,7 +88,7 @@ static int wf_lm75_get(struct wf_sensor *sr, s32 *value)
 	}
=20
 	/* Read temperature register */
-	data =3D (s32)le16_to_cpu(i2c_smbus_read_word_data(&lm->i2c, 0));
+	data =3D (s32)le16_to_cpu(i2c_smbus_read_word_data(&lm->i2c, LM75_REG_R_T=
EMP));
 	data <<=3D 8;
 	*value =3D data;
=20
@@ -114,7 +121,7 @@ static struct wf_lm75_sensor *wf_lm75_create(struct i2c=
_adapter *adapter,
 	struct wf_lm75_sensor *lm;
 	int rc;
=20
-	DBG("wf_lm75: creating  %s device at address 0x%02x\n",
+	DBG(KERN_DEBUG "wf_lm75: creating  %s device at address 0x%02x\n",
 	    ds1775 ? "ds1775" : "lm75", addr);
=20
 	lm =3D kmalloc(sizeof(struct wf_lm75_sensor), GFP_KERNEL);
@@ -125,11 +132,26 @@ static struct wf_lm75_sensor *wf_lm75_create(struct i=
2c_adapter *adapter,
 	/* Usual rant about sensor names not beeing very consistent in
 	 * the device-tree, oh well ...
 	 * Add more entries below as you deal with more setups
+	 * PowerMac12,1 - ODD Temp@90, HD Temp@92, Incoming Air Temp@94
+	 * PowerMac11,2 - DRIVE BAY@94
+	 * PowerMac7,2 - DRIVE BAY@94
+	 * PowerMac7,3 - DRIVE BAY@94
+	 * Guesses (need to validate the names):
+	 * RackMac3,1 - PCI SLOTS@90
 	 */
-	if (!strcmp(loc, "Hard drive") || !strcmp(loc, "DRIVE BAY"))
+	if (!strcmp(loc, "Hard drive") || !strcmp(loc, "DRIVE BAY")
+		|| !strcmp(loc,"HD Temp")) {
 		lm->sens.name =3D "hd-temp";
-	else
+	} else if (!strcmp(loc, "ODD Temp")) {
+		lm->sens.name =3D "odd-temp";
+	} else if (!strcmp(loc, "Incoming Air Temp")) {
+		lm->sens.name =3D "inlet-ambient-temp";
+	} else if (!strcmp(loc, "PCI SLOTS")) {
+		lm->sens.name =3D "slots-temp";
+	} else {
+		printk(KERN_WARNING "wf_lm75: unknown sensor loc=3D%s\n",loc);
 		goto fail;
+	}
=20
 	lm->inited =3D 0;
 	lm->sens.ops =3D &wf_lm75_ops;
@@ -163,7 +185,7 @@ static int wf_lm75_attach(struct i2c_adapter *adapter)
 	struct device_node *busnode, *dev;
 	struct pmac_i2c_bus *bus;
=20
-	DBG("wf_lm75: adapter %s detected\n", adapter->name);
+	DBG(KERN_DEBUG "wf_lm75: adapter %s detected\n", adapter->name);
=20
 	bus =3D pmac_i2c_adapter_to_bus(adapter);
 	if (bus =3D=3D NULL)
@@ -201,7 +223,7 @@ static int wf_lm75_detach(struct i2c_client *client)
 {
 	struct wf_lm75_sensor *lm =3D i2c_to_lm75(client);
=20
-	DBG("wf_lm75: i2c detatch called for %s\n", lm->sens.name);
+	DBG(KERN_DEBUG "wf_lm75: i2c detatch called for %s\n", lm->sens.name);
=20
 	/* Mark client detached */
 	lm->i2c.adapter =3D NULL;
@@ -214,11 +236,6 @@ static int wf_lm75_detach(struct i2c_client *client)
=20
 static int __init wf_lm75_sensor_init(void)
 {
-	/* Don't register on old machines that use therm_pm72 for now */
-	if (machine_is_compatible("PowerMac7,2") ||
-	    machine_is_compatible("PowerMac7,3") ||
-	    machine_is_compatible("RackMac3,1"))
-		return -ENODEV;
 	return i2c_add_driver(&wf_lm75_driver);
 }
=20
@@ -232,6 +249,7 @@ module_init(wf_lm75_sensor_init);
 module_exit(wf_lm75_sensor_exit);
=20
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
-MODULE_DESCRIPTION("LM75 sensor objects for PowerMacs thermal control");
+MODULE_AUTHOR("Robin H. Johnson <robbat2@gentoo.org>");
+MODULE_DESCRIPTION("LM75/DS1775 sensor objects for PowerMacs thermal contr=
ol");
 MODULE_LICENSE("GPL");
=20
diff --git a/drivers/macintosh/windfarm_max6690_sensor.c b/drivers/macintos=
h/windfarm_max6690_sensor.c
index eae1189..d6850af 100644
--- a/drivers/macintosh/windfarm_max6690_sensor.c
+++ b/drivers/macintosh/windfarm_max6690_sensor.c
@@ -2,8 +2,17 @@
  * Windfarm PowerMac thermal control.  MAX6690 sensor.
  *
  * Copyright (C) 2005 Paul Mackerras, IBM Corp. <paulus@samba.org>
+ * Copyright (C) 2006 Robin H. Johnson <robbat2@gentoo.org>
  *
  * Use and redistribute under the terms of the GNU GPL v2.
+ *
+ * This driver supports BOTH the internal and external readings available =
=66rom
+ * the MAX6690 chip, if both readings are registered in OpenFirmware. In s=
ome
+ * systems, only a single reading may be registered in OpenFirmware, and t=
hat
+ * case is handled here as well.
+ *
+ * TODO:
+ * - Get RackMac3,1 data and incorporate here
  */
 #include <linux/types.h>
 #include <linux/errno.h>
@@ -16,22 +25,29 @@
=20
 #include "windfarm.h"
=20
-#define VERSION "0.2"
+//#undef DEBUG
+#define DEBUG 1
+
+#ifdef DEBUG
+#define DBG(args...)	printk(args)
+#else
+#define DBG(args...)	do { } while(0)
+#endif
=20
-/* This currently only exports the external temperature sensor,
-   since that's all the control loops need. */
+#define VERSION "0.4"
=20
 /* Some MAX6690 register numbers */
 #define MAX6690_INTERNAL_TEMP	0
 #define MAX6690_EXTERNAL_TEMP	1
=20
-struct wf_6690_sensor {
-	struct i2c_client	i2c;
+struct wf_max6690_sensor {
+	struct i2c_client	*i2c;
 	struct wf_sensor	sens;
+	u8 			reg; /* register number */
 };
=20
-#define wf_to_6690(x)	container_of((x), struct wf_6690_sensor, sens)
-#define i2c_to_6690(x)	container_of((x), struct wf_6690_sensor, i2c)
+#define wf_to_max6690(x)	container_of((x), struct wf_max6690_sensor, sens)
+#define i2c_to_max6690(x)	container_of((x), struct wf_max6690_sensor, i2c)
=20
 static int wf_max6690_attach(struct i2c_adapter *adapter);
 static int wf_max6690_detach(struct i2c_client *client);
@@ -46,14 +62,14 @@ static struct i2c_driver wf_max6690_driver =3D {
=20
 static int wf_max6690_get(struct wf_sensor *sr, s32 *value)
 {
-	struct wf_6690_sensor *max =3D wf_to_6690(sr);
+	struct wf_max6690_sensor *max =3D wf_to_max6690(sr);
 	s32 data;
=20
-	if (max->i2c.adapter =3D=3D NULL)
+	if (max->i2c->adapter =3D=3D NULL)
 		return -ENODEV;
=20
 	/* chip gets initialized by firmware */
-	data =3D i2c_smbus_read_byte_data(&max->i2c, MAX6690_EXTERNAL_TEMP);
+	data =3D i2c_smbus_read_byte_data(max->i2c, max->reg);
 	if (data < 0)
 		return data;
 	*value =3D data << 16;
@@ -62,11 +78,13 @@ static int wf_max6690_get(struct wf_sensor *sr, s32 *va=
lue)
=20
 static void wf_max6690_release(struct wf_sensor *sr)
 {
-	struct wf_6690_sensor *max =3D wf_to_6690(sr);
+	struct wf_max6690_sensor *max =3D wf_to_max6690(sr);
+=09
+	wf_unregister_sensor(&max->sens);
=20
-	if (max->i2c.adapter) {
-		i2c_detach_client(&max->i2c);
-		max->i2c.adapter =3D NULL;
+	if (max->i2c->adapter) {
+		i2c_detach_client(max->i2c);
+		max->i2c->adapter =3D NULL;
 	}
 	kfree(max);
 }
@@ -77,39 +95,101 @@ static struct wf_sensor_ops wf_max6690_ops =3D {
 	.owner		=3D THIS_MODULE,
 };
=20
-static void wf_max6690_create(struct i2c_adapter *adapter, u8 addr)
-{
-	struct wf_6690_sensor *max;
-	char *name =3D "backside-temp";
+static struct i2c_client * wf_max6690_create_i2c_client(struct i2c_adapter=
 *adapter, u8 addr) {
+	struct i2c_client *i2c;
+	const char* max6690str =3D "max6690";
+	i2c =3D kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	if (i2c =3D=3D NULL) {
+		printk(KERN_ERR "windfarm: Couldn't create i2c client no memory\n");
+		return NULL;
+	}
+	DBG(KERN_DEBUG "wf_max6690: i2c client created %p\n",i2c);
+	i2c->addr =3D addr >> 1;
+	i2c->adapter =3D adapter;
+	i2c->driver =3D &wf_max6690_driver;
+	/* neither name is correct
+	 * strncpy(i2c->name, name, I2C_NAME_SIZE-1);
+	 */
+	strncpy(i2c->name, max6690str, I2C_NAME_SIZE-1);
+	return i2c;
+}
=20
-	max =3D kzalloc(sizeof(struct wf_6690_sensor), GFP_KERNEL);
+static struct wf_max6690_sensor* wf_max6690_create_wf_sensor(struct i2c_cl=
ient *client, char* name, u8 reg) { =20
+	struct wf_max6690_sensor *max;
+	max =3D kzalloc(sizeof(struct wf_max6690_sensor), GFP_KERNEL);
 	if (max =3D=3D NULL) {
 		printk(KERN_ERR "windfarm: Couldn't create MAX6690 sensor %s: "
-		       "no memory\n", name);
-		return;
+				"no memory\n", name);
+		return NULL;
 	}
=20
+	max->reg =3D reg;
 	max->sens.ops =3D &wf_max6690_ops;
 	max->sens.name =3D name;
-	max->i2c.addr =3D addr >> 1;
-	max->i2c.adapter =3D adapter;
-	max->i2c.driver =3D &wf_max6690_driver;
-	strncpy(max->i2c.name, name, I2C_NAME_SIZE-1);
+	max->i2c =3D client;
+
+	return max;
+}
=20
-	if (i2c_attach_client(&max->i2c)) {
+static void wf_max6690_create(struct i2c_adapter *adapter, u8 addr, char* =
names[2])
+{
+	struct wf_max6690_sensor *max[2] =3D {NULL,NULL};
+	struct i2c_client* i2c;
+	DBG(KERN_DEBUG "wf_max6690: create i2c client\n");
+	i2c =3D wf_max6690_create_i2c_client(adapter,addr);
+	if(!i2c) {
+		goto fail_i2c;
+	}
+	DBG(KERN_DEBUG "wf_max6690: i2c client is %p\n",i2c);
+	DBG(KERN_DEBUG "wf_max6690: create internal sensor\n");
+	if(names[MAX6690_INTERNAL_TEMP])  {
+		max[MAX6690_INTERNAL_TEMP] =3D wf_max6690_create_wf_sensor(i2c,
+				names[MAX6690_INTERNAL_TEMP],
+				MAX6690_INTERNAL_TEMP);
+		if(!max[MAX6690_INTERNAL_TEMP])
+			goto fail_internal_temp;
+	}
+	DBG(KERN_DEBUG "wf_max6690: create external sensor\n");
+	if(names[MAX6690_EXTERNAL_TEMP]) {
+		max[MAX6690_EXTERNAL_TEMP] =3D wf_max6690_create_wf_sensor(i2c,
+				names[MAX6690_EXTERNAL_TEMP],
+				MAX6690_EXTERNAL_TEMP);
+		if(!max[MAX6690_EXTERNAL_TEMP])
+			goto fail_external_temp;
+	}
+	DBG(KERN_DEBUG "wf_max6690: i2c attach client\n");
+	if (i2c_attach_client(i2c)) {
 		printk(KERN_ERR "windfarm: failed to attach MAX6690 sensor\n");
-		goto fail;
+		goto fail_attach_client;
 	}
=20
-	if (wf_register_sensor(&max->sens)) {
-		i2c_detach_client(&max->i2c);
-		goto fail;
+	DBG(KERN_DEBUG "wf_max6690: wf register internal\n");
+	if (names[MAX6690_INTERNAL_TEMP] &&=20
+			wf_register_sensor(&max[MAX6690_INTERNAL_TEMP]->sens)) {
+		goto fail_wf_register_internal_temp;
+	}
+	DBG(KERN_DEBUG "wf_max6690: wf register external\n");
+	if (names[MAX6690_EXTERNAL_TEMP] &&=20
+			wf_register_sensor(&max[MAX6690_EXTERNAL_TEMP]->sens)) {
+		goto fail_wf_register_external_temp;
 	}
-
 	return;
=20
- fail:
-	kfree(max);
+fail_wf_register_external_temp:
+	if(names[MAX6690_INTERNAL_TEMP])=20
+		wf_unregister_sensor(&max[MAX6690_INTERNAL_TEMP]->sens);
+fail_wf_register_internal_temp:
+	i2c_detach_client(i2c);
+fail_attach_client:
+	if(names[MAX6690_EXTERNAL_TEMP])=20
+		kfree(max[MAX6690_EXTERNAL_TEMP]);
+fail_external_temp:
+	if(names[MAX6690_INTERNAL_TEMP])=20
+		kfree(max[MAX6690_INTERNAL_TEMP]);
+fail_internal_temp:
+	kfree(i2c);
+fail_i2c:
+	return;
 }
=20
 static int wf_max6690_attach(struct i2c_adapter *adapter)
@@ -117,6 +197,7 @@ static int wf_max6690_attach(struct i2c_adapter *adapte=
r)
 	struct device_node *busnode, *dev =3D NULL;
 	struct pmac_i2c_bus *bus;
 	const char *loc;
+	char *names[2];
=20
 	bus =3D pmac_i2c_adapter_to_bus(adapter);
 	if (bus =3D=3D NULL)
@@ -125,6 +206,11 @@ static int wf_max6690_attach(struct i2c_adapter *adapt=
er)
=20
 	while ((dev =3D of_get_next_child(busnode, dev)) !=3D NULL) {
 		u8 addr;
+		int count =3D 0;
+		u8 reg =3D 0;
+		int lenp;
+		names[0] =3D NULL;
+		names[1] =3D NULL;
=20
 		/* We must re-match the adapter in order to properly check
 		 * the channel on multibus setups
@@ -134,13 +220,110 @@ static int wf_max6690_attach(struct i2c_adapter *ada=
pter)
 		if (!device_is_compatible(dev, "max6690"))
 			continue;
 		addr =3D pmac_i2c_get_dev_addr(dev);
-		loc =3D get_property(dev, "hwsensor-location", NULL);
-		if (loc =3D=3D NULL || addr =3D=3D 0)
+		if(addr =3D=3D 0)=20
 			continue;
-		printk("found max6690, loc=3D%s addr=3D0x%02x\n", loc, addr);
-		if (strcmp(loc, "BACKSIDE"))
+		/* At this point we diverge from template code, as max6690
+		 * provides two temperature values, under the
+		 * internal-temperature and external-temperature nodes.
+		 * on the PM112 and PM73 boxes, there are seperate nodes for
+		 * internal/external readings from the chip.
+		 * However, on the PM72, the nodes do NOT exist, and they have
+		 * to be inferred from the master hwsensor-location property,
+		 * which has two null-terminated strings.
+		 * In the PM121, the sub-nodes changed name as well :-(.
+		 *
+		 * Chip mapping data:
+		 *
+		 * PowerMac 12,1 (iMac G5)
+		 * NB Ambient =3D @98, temp-sensor@0
+		 * NB Temp =3D @98, temp-sensor@1
+		 * GPU Ambient =3D @9c, temp-sensor@0
+		 * GPU Temp =3D @9c, temp-sensor@1
+		 *
+		 * PowerMac 11,2 - note the reversal on @98
+		 * BACKSIDE =3D @98, internal@0 - this is attached to the heatsink
+		 * KODIAK DIODE =3D @98, external@1 - this is actually the die temp
+		 * TUNNEL =3D @9c, internal@0
+		 * TUNNEL HEATSINK =3D  @9c, external@1
+		 *
+		 * PowerMac 7,3
+		 * BACKSIDE =3D @98, internal@0
+		 * U3 HEATSINK =3D @98, external@1
+		 *
+		 * PowerMac 7,2 (the subnodes of internal/external do NOT exist)
+		 * BACKSIDE =3D @98, internal@0=20
+		 * U3 HEATSINK =3D @98, external@1
+		 * MLB MAX6690 AMB =3D @9c, internal@0=20
+		 * MLB INLET AMB =3D @9c, external@1
+		 *
+		 * RackMac3,1
+		 * TODO: Unknown!
+		 * Guesses - note the possible reversal
+		 * - SYS CTRLR AMBIENT@98, internal@0
+		 * - SYS CTRLR INTERNAL@98, external@1
+		 */
+		DBG(KERN_DEBUG "wf_max6690: looking for registers on chip\n");
+		loc =3D get_property(dev, "hwsensor-location", &lenp);
+		if (loc =3D=3D NULL)
 			continue;
-		wf_max6690_create(adapter, addr);
+
+		while (lenp > 0) {
+			int l;
+			DBG(KERN_DEBUG "wf_max6690: found loc=3D%s addr=3D0x%02x reg=3D0x%02x\n=
", loc, addr, reg);
+			/* Add more entries here */
+			if(!strcmp(loc,"KODIAK DIODE") ||=20
+					!strcmp(loc,"NB Temp")) {
+				names[reg] =3D"northbridge-die-temp";
+				count++;
+			} else if(!strcmp(loc,"BACKSIDE") ||=20
+					!strcmp(loc,"U3 HEATSINK") ||=20
+					!strcmp(loc,"NB Ambient")) {
+				names[reg] =3D"northbridge-heatsink-temp";
+				count++;
+			} else if(!strcmp(loc,"TUNNEL")) {
+				/* Tunnel is the code name for the HT-2000 chip=20
+				 * http://www.hypertransport.org/products/productdetail.cfm?RecordID=
=3D71
+				 */
+				names[reg] =3D"ht2000-die-temp";
+				count++;
+			} else if(!strcmp(loc,"TUNNEL HEATSINK")) {
+				names[reg] =3D"ht2000-heatsink-temp";
+				count++;
+			} else if(!strcmp(loc,"GPU Temp")) {
+				names[reg] =3D"gpu-die-temp";
+				count++;
+			} else if(!strcmp(loc,"GPU Ambient")) {
+				names[reg] =3D"gpu-heatsink-temp";
+				count++;
+			} else if(!strcmp(loc,"MLB MAX6690 AMB") ||
+					!strcmp(loc,"SYS CTRLR AMBIENT")) {
+				/* (TODO: validate) This is the internal channel of a MAX6690
+				 * just sitting on a board.  It's not hugely useful in itself.
+				 */
+				names[reg] =3D"onboard-ambient-temp";
+				count++;
+			} else if(!strcmp(loc,"MLB INLET AMB") ||
+					!strcmp(loc,"SYS CTRLR INTERNAL")) {
+				/* (TODO: validate) This is a the external channel of a
+				 * MAX6690, connected to a temp sensor located immediately
+				 * behind the intake fan.
+				 */
+				names[reg] =3D"inlet-ambient-temp";
+				count++;
+			} else {
+				printk(KERN_WARNING "wf_max6690: unknown sensor addr=3D0x%02x loc=3D%s=
 reg=3D0x%01x ",addr,loc,reg);
+			}
+			reg++;
+			/* Push to the next location string */
+			l =3D strlen(loc) + 1;
+			loc +=3D l;
+			lenp -=3D l;
+		}
+		if(count > 0) {
+			DBG(KERN_DEBUG "wf_max6690 calling create\n");
+			wf_max6690_create(adapter, addr, names);
+			DBG(KERN_DEBUG "wf_max6690 done create\n");
+		}
 	}
=20
 	return 0;
@@ -148,21 +331,22 @@ static int wf_max6690_attach(struct i2c_adapter *adap=
ter)
=20
 static int wf_max6690_detach(struct i2c_client *client)
 {
-	struct wf_6690_sensor *max =3D i2c_to_6690(client);
+	struct wf_max6690_sensor *max =3D i2c_to_max6690(&client);
=20
-	max->i2c.adapter =3D NULL;
+	// max->i2c->adapter =3D NULL;
 	wf_unregister_sensor(&max->sens);
=20
+	if (max->i2c->adapter) {
+		i2c_detach_client(max->i2c);
+		max->i2c->adapter =3D NULL;
+	}
+	kfree(max);
+
 	return 0;
 }
=20
 static int __init wf_max6690_sensor_init(void)
 {
-	/* Don't register on old machines that use therm_pm72 for now */
-	if (machine_is_compatible("PowerMac7,2") ||
-	    machine_is_compatible("PowerMac7,3") ||
-	    machine_is_compatible("RackMac3,1"))
-		return -ENODEV;
 	return i2c_add_driver(&wf_max6690_driver);
 }
=20
@@ -175,5 +359,6 @@ module_init(wf_max6690_sensor_init);
 module_exit(wf_max6690_sensor_exit);
=20
 MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
+MODULE_AUTHOR("Robin H. Johnson <robbat2@gentoo.org>");
 MODULE_DESCRIPTION("MAX6690 sensor objects for PowerMac thermal control");
 MODULE_LICENSE("GPL");
diff --git a/drivers/macintosh/windfarm_pid.c b/drivers/macintosh/windfarm_=
pid.c
index f10efb2..66a6821 100644
--- a/drivers/macintosh/windfarm_pid.c
+++ b/drivers/macintosh/windfarm_pid.c
@@ -86,6 +86,15 @@ void wf_cpu_pid_init(struct wf_cpu_pid_state *st,
 }
 EXPORT_SYMBOL_GPL(wf_cpu_pid_init);
=20
+/*
+ *                history_len
+ * Tintegral =3D ( SUMMATION(Power error) ) * interval * Gr
+ *			      i=3D0
+ * Tproportional =3D (Tnew - MIN(Tfixedtarget, Tmax-Tintegral)) * Gp
+ * Tderivative =3D (Tnew - Tlast) * Gd / interval
+ * Ttarget  =3D MIN(MAX(Ttarget + (Tderivative+Tproportional),Tmin),Tmax)
+ *
+ */
 s32 wf_cpu_pid_run(struct wf_cpu_pid_state *st, s32 new_power, s32 new_tem=
p)
 {
 	s64	integ, deriv, prop;
diff --git a/drivers/macintosh/windfarm_pm112.c b/drivers/macintosh/windfar=
m_pm112.c
index b3fbb45..69d334f 100644
--- a/drivers/macintosh/windfarm_pm112.c
+++ b/drivers/macintosh/windfarm_pm112.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2005 Paul Mackerras, IBM Corp. <paulus@samba.org>
  * Copyright (C) 2006 Benjamin Herrenschmidt, IBM Corp.
+ * Copyright (C) 2006 Robin H. Johnson
  *
  * Use and redistribute under the terms of the GNU GPL v2.
  */
@@ -19,7 +20,7 @@
 #include "windfarm.h"
 #include "windfarm_pid.h"
=20
-#define VERSION "0.2"
+#define VERSION "0.3"
=20
 #define DEBUG
 #undef LOTSA_DEBUG
@@ -604,6 +605,10 @@ static void pm112_new_sensor(struct wf_sensor *sr)
 		    sens_cpu_temp[i] =3D=3D NULL && wf_get_sensor(sr) =3D=3D 0)
 			sens_cpu_temp[i] =3D sr;
=20
+	} else if (!strncmp(sr->name, "cpu-current-", 12)) {
+		/* ignore, not used by PID directly */
+	} else if (!strncmp(sr->name, "cpu-voltage-", 12)) {
+		/* ignore, not used by PID directly */
 	} else if (!strncmp(sr->name, "cpu-power-", 10)) {
 		i =3D sr->name[10] - '0';
 		if (sr->name[11] =3D=3D 0 && i < NR_CORES &&
@@ -615,11 +620,23 @@ static void pm112_new_sensor(struct wf_sensor *sr)
 	} else if (!strcmp(sr->name, "slots-power")) {
 		if (slots_power =3D=3D NULL && wf_get_sensor(sr) =3D=3D 0)
 			slots_power =3D sr;
-	} else if (!strcmp(sr->name, "backside-temp")) {
+	} else if (!strcmp(sr->name, "northbridge-die-temp")) {
 		if (u4_temp =3D=3D NULL && wf_get_sensor(sr) =3D=3D 0)
 			u4_temp =3D sr;
-	} else
+	} else if (!strcmp(sr->name, "northbridge-heatsink-temp")) {
+		/* ignore, not used presently */
+	} else if (!strcmp(sr->name, "ht2000-heatsink-temp")) {
+		/* ignore, not used presently */
+	} else if (!strcmp(sr->name, "ht2000-die-temp")) {
+		/* ignore, not used presently */
+	} else if (!strcmp(sr->name, "onboard-ambient-temp")) {
+		/* ignore, not used presently */
+	} else if (!strcmp(sr->name, "inlet-ambient-temp")) {
+		/* ignore, not used presently */
+	} else {
+		printk(KERN_WARNING "wf_pm112: unknown sensor name=3D%s\n",sr->name);
 		return;
+	}
=20
 	/* check if we have all the sensors we need */
 	for (i =3D 0; i < nr_cores; ++i)
@@ -691,6 +708,7 @@ static int __init wf_pm112_init(void)
 	request_module("windfarm_smu_sensors");
 	request_module("windfarm_smu_sat");
 	request_module("windfarm_lm75_sensor");
+	request_module("windfarm_ds1631_sensor");
 	request_module("windfarm_max6690_sensor");
 	request_module("windfarm_cpufreq_clamp");
=20
@@ -709,5 +727,6 @@ module_init(wf_pm112_init);
 module_exit(wf_pm112_exit);
=20
 MODULE_AUTHOR("Paul Mackerras <paulus@samba.org>");
+MODULE_AUTHOR("Robin H. Johnson <robbat2@gentoo.org>");
 MODULE_DESCRIPTION("Thermal control for PowerMac11,2");
 MODULE_LICENSE("GPL");
diff --git a/drivers/macintosh/windfarm_pm72.c b/drivers/macintosh/windfarm=
_pm72.c
new file mode 100644
index 0000000..e8b80d8
--- /dev/null
+++ b/drivers/macintosh/windfarm_pm72.c
@@ -0,0 +1,70 @@
+static int pm72_wf_notify(struct notifier_block *self,
+			   unsigned long event, void *data)
+{
+	switch (event) {
+	case WF_EVENT_NEW_SENSOR:
+		pm72_new_sensor(data);
+		break;
+	case WF_EVENT_NEW_CONTROL:
+		pm72_new_control(data);
+		break;
+	case WF_EVENT_TICK:
+		if (have_all_controls && have_all_sensors)
+			pm72_tick();
+	}
+	return 0;
+}
+
+static struct notifier_block pm72_events =3D {
+	.notifier_call =3D pm72_wf_notify,
+};
+
+static int wf_pm72_probe(struct device *dev)
+{
+	wf_register_client(&pm72_events);
+	return 0;
+}
+
+static int wf_pm72_remove(struct device *dev)
+{
+	wf_unregister_client(&pm72_events);
+	/* should release all sensors and controls */
+	return 0;
+}
+
+static struct device_driver wf_pm72_driver =3D {
+	.name =3D "windfarm",
+	.bus =3D &platform_bus_type,
+	.probe =3D wf_pm72_probe,
+	.remove =3D wf_pm72_remove,
+};
+
+static int __init wf_pm72_init(void) {
+	struct device_node *cpu;
+
+	rackmac =3D machine_is_compatible("RackMac3,1");
+
+	if (!machine_is_compatible("PowerMac7,2") &&
+	    !machine_is_compatible("PowerMac7,3") &&
+	    !rackmac)
+	    	return -ENODEV;
+
+	/* Count the number of CPU cores */
+	nr_cores =3D 0;
+	for (cpu =3D NULL; (cpu =3D of_find_node_by_type(cpu, "cpu")) !=3D NULL; )
+		++nr_cores;
+
+	printk(KERN_INFO "windfarm: initializing for dual-core desktop G5\n");
+	driver_register(&wf_pm72_driver);
+	return 0;
+}
+static void __exit wf_pm72_exit(void) {
+	driver_unregister(&wf_pm72_driver);
+}
+
+module_init(wf_pm72_init);
+module_exit(wf_pm72_exit);
+
+MODULE_AUTHOR("Robin H. Johnson <robbat2@gentoo.org>");
+MODULE_DESCRIPTION("Thermal control for PowerMac7,2/7,3 and RackMac3,1");
+MODULE_LICENSE("GPL");
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/=
windfarm_smu_controls.c
index 31b750d..43a3e9c 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -179,49 +179,46 @@ static struct smu_fan_control *smu_fan_create(struct =
device_node *node,
 	 * less consistent here between the iMac and the desktop models, but
 	 * that is good enough for our needs for now at least.
 	 *
-	 * One problem though is that Apple seem to be inconsistent with case
-	 * and the kernel doesn't have strcasecmp =3DP
+	 * We use strcasecmp as Apple is not consistant with names :-(.
 	 */
=20
 	fct->ctrl.name =3D NULL;
=20
 	/* Names used on desktop models */
-	if (!strcmp(l, "Rear Fan 0") || !strcmp(l, "Rear Fan") ||
-	    !strcmp(l, "Rear fan 0") || !strcmp(l, "Rear fan") ||
-	    !strcmp(l, "CPU A EXHAUST"))
+	if (!strcasecmp(l, "Rear Fan 0") || !strcasecmp(l, "Rear Fan") ||
+	    !strcasecmp(l, "CPU A EXHAUST"))
 		fct->ctrl.name =3D "cpu-rear-fan-0";
-	else if (!strcmp(l, "Rear Fan 1") || !strcmp(l, "Rear fan 1") ||
-		 !strcmp(l, "CPU B EXHAUST"))
+	else if (!strcasecmp(l, "Rear Fan 1") || !strcasecmp(l, "CPU B EXHAUST"))
 		fct->ctrl.name =3D "cpu-rear-fan-1";
-	else if (!strcmp(l, "Front Fan 0") || !strcmp(l, "Front Fan") ||
-		 !strcmp(l, "Front fan 0") || !strcmp(l, "Front fan") ||
-		 !strcmp(l, "CPU A INTAKE"))
+	else if (!strcasecmp(l, "Front Fan 0") || !strcasecmp(l, "Front Fan") ||
+		 !strcasecmp(l, "CPU A INTAKE"))
 		fct->ctrl.name =3D "cpu-front-fan-0";
-	else if (!strcmp(l, "Front Fan 1") || !strcmp(l, "Front fan 1") ||
-		 !strcmp(l, "CPU B INTAKE"))
+	else if (!strcasecmp(l, "Front Fan 1") || !strcasecmp(l, "CPU B INTAKE"))
 		fct->ctrl.name =3D "cpu-front-fan-1";
-	else if (!strcmp(l, "CPU A PUMP"))
+	else if (!strcasecmp(l, "CPU A PUMP"))
 		fct->ctrl.name =3D "cpu-pump-0";
-	else if (!strcmp(l, "Slots Fan") || !strcmp(l, "Slots fan") ||
-		 !strcmp(l, "EXPANSION SLOTS INTAKE"))
+	else if (!strcasecmp(l, "CPU B PUMP"))
+		fct->ctrl.name =3D "cpu-pump-1";
+	else if (!strcasecmp(l, "Slots Fan") || !strcasecmp(l, "EXPANSION SLOTS I=
NTAKE"))
 		fct->ctrl.name =3D "slots-fan";
-	else if (!strcmp(l, "Drive Bay") || !strcmp(l, "Drive bay") ||
-		 !strcmp(l, "DRIVE BAY A INTAKE"))
+	else if (!strcasecmp(l, "Drive Bay") || !strcasecmp(l, "DRIVE BAY A INTAK=
E"))
 		fct->ctrl.name =3D "drive-bay-fan";
-	else if (!strcmp(l, "BACKSIDE"))
+	else if (!strcasecmp(l, "BACKSIDE"))
 		fct->ctrl.name =3D "backside-fan";
=20
 	/* Names used on iMac models */
-	if (!strcmp(l, "System Fan") || !strcmp(l, "System fan"))
+	if (!strcasecmp(l, "System Fan"))
 		fct->ctrl.name =3D "system-fan";
-	else if (!strcmp(l, "CPU Fan") || !strcmp(l, "CPU fan"))
+	else if (!strcasecmp(l, "CPU Fan"))
 		fct->ctrl.name =3D "cpu-fan";
-	else if (!strcmp(l, "Hard Drive") || !strcmp(l, "Hard drive"))
+	else if (!strcasecmp(l, "Hard Drive"))
 		fct->ctrl.name =3D "drive-bay-fan";
=20
 	/* Unrecognized fan, bail out */
-	if (fct->ctrl.name =3D=3D NULL)
+	if (fct->ctrl.name =3D=3D NULL) {
+		printk(KERN_WARNING "windfarm: unknown control loc=3D%s\n",l);
 		goto fail;
+	}
=20
 	/* Get min & max values*/
 	v =3D get_property(node, "min-value", NULL);
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windf=
arm_smu_sat.c
index 83f79de..b99d36d 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -22,7 +22,7 @@
=20
 #define VERSION "0.2"
=20
-#define DEBUG
+#undef DEBUG
=20
 #ifdef DEBUG
 #define DBG(args...)	printk(args)
diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/w=
indfarm_smu_sensors.c
index 01b4c50..3be1e64 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -221,7 +221,7 @@ static struct smu_ad_sensor *smu_ads_create(struct devi=
ce_node *node)
 		ads->sens.ops =3D &smu_cputemp_ops;
 		ads->sens.name =3D "cpu-temp";
 		if (cpudiode =3D=3D NULL) {
-			DBG("wf: cpudiode partition (%02x) not found\n",
+			DBG(KERN_DEBUG "wf: cpudiode partition (%02x) not found\n",
 			    SMU_SDB_CPUDIODE_ID);
 			goto fail;
 		}
@@ -230,7 +230,7 @@ static struct smu_ad_sensor *smu_ads_create(struct devi=
ce_node *node)
 		ads->sens.ops =3D &smu_cpuamp_ops;
 		ads->sens.name =3D "cpu-current";
 		if (cpuvcp =3D=3D NULL) {
-			DBG("wf: cpuvcp partition (%02x) not found\n",
+			DBG(KERN_DEBUG "wf: cpuvcp partition (%02x) not found\n",
 			    SMU_SDB_CPUVCP_ID);
 			goto fail;
 		}
@@ -239,7 +239,7 @@ static struct smu_ad_sensor *smu_ads_create(struct devi=
ce_node *node)
 		ads->sens.ops =3D &smu_cpuvolt_ops;
 		ads->sens.name =3D "cpu-voltage";
 		if (cpuvcp =3D=3D NULL) {
-			DBG("wf: cpuvcp partition (%02x) not found\n",
+			DBG(KERN_DEBUG "wf: cpuvcp partition (%02x) not found\n",
 			    SMU_SDB_CPUVCP_ID);
 			goto fail;
 		}
@@ -248,12 +248,14 @@ static struct smu_ad_sensor *smu_ads_create(struct de=
vice_node *node)
 		ads->sens.ops =3D &smu_slotspow_ops;
 		ads->sens.name =3D "slots-power";
 		if (slotspow =3D=3D NULL) {
-			DBG("wf: slotspow partition (%02x) not found\n",
+			DBG(KERN_DEBUG "wf: slotspow partition (%02x) not found\n",
 			    SMU_SDB_SLOTSPOW_ID);
 			goto fail;
 		}
-	} else
+	} else {
+		printk(KERN_WARNING "wf: unknown sensor type=3D%s loc=3D%s\n",c,l);
 		goto fail;
+	}
=20
 	v =3D get_property(node, "reg", NULL);
 	if (v =3D=3D NULL)
@@ -368,7 +370,7 @@ smu_cpu_power_create(struct wf_sensor *volts, struct wf=
_sensor *amps)
 	     machine_is_compatible("PowerMac9,1")) &&
 	    cpuvcp_version >=3D 2) {
 		pow->quadratic =3D 1;
-		DBG("windfarm: CPU Power using quadratic transform\n");
+		DBG(KERN_DEBUG "windfarm: CPU Power using quadratic transform\n");
 	} else
 		pow->quadratic =3D 0;
=20

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGCUbbPpIsIjIzwiwRAmjRAJ9KcQCKEikb+05uhx1pt1puJryTiACg32oT
mMsLDlb48eFHaNiakcCXlsM=
=OfzG
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
