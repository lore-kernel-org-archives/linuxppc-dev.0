Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C8442140079
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 16:04:11 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 14 May 2014 11:34:08 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C94F01258062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 11:33:07 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E64KMH6619568
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 11:34:20 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E643T4025720
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 11:34:04 +0530
Subject: [PATCH] powerpc/powernv: hwmon driver for power values,
 fan rpm and temperature
To: linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net, jdelvare@suse.de,
 lm-sensors@lm-sensors.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Wed, 14 May 2014 11:31:53 +0530
Message-ID: <20140514055859.16148.35534.stgit@neelegup-tp-t420.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: sbhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds basic kernel enablement for reading power values, fan
speed rpm and temperature values on powernv platforms which will
be exported to user space through sysfs interface.

Test results:
-------------
[root@tul163p1 ~]# sensors
ibmpowernv-isa-0000
Adapter: ISA adapter
fan1:        5294 RPM  (min =    0 RPM)
fan2:        4945 RPM  (min =    0 RPM)
fan3:        5831 RPM  (min =    0 RPM)
fan4:        5212 RPM  (min =    0 RPM)
fan5:           0 RPM  (min =    0 RPM)
fan6:           0 RPM  (min =    0 RPM)
fan7:        7472 RPM  (min =    0 RPM)
fan8:        7920 RPM  (min =    0 RPM)
temp1:        +39.0°C  (high =  +0.0°C)
power1:      192.00 W  

[root@tul163p1 ~]# 
[root@tul163p1 ~]# ls /sys/devices/platform/ibmpowernv.0/
driver      fan2_min    fan4_min    fan6_min    fan8_min   modalias      uevent
fan1_fault  fan3_fault  fan5_fault  fan7_fault  hwmon      name
fan1_input  fan3_input  fan5_input  fan7_input  in1_fault  power1_input
fan1_min    fan3_min    fan5_min    fan7_min    in2_fault  subsystem
fan2_fault  fan4_fault  fan6_fault  fan8_fault  in3_fault  temp1_input
fan2_input  fan4_input  fan6_input  fan8_input  in4_fault  temp1_max
[root@tul163p1 ~]# 
[root@tul163p1 ~]# ls /sys/class/hwmon/hwmon0/device/
driver      fan2_min    fan4_min    fan6_min    fan8_min   modalias      uevent
fan1_fault  fan3_fault  fan5_fault  fan7_fault  hwmon      name
fan1_input  fan3_input  fan5_input  fan7_input  in1_fault  power1_input
fan1_min    fan3_min    fan5_min    fan7_min    in2_fault  subsystem
fan2_fault  fan4_fault  fan6_fault  fan8_fault  in3_fault  temp1_input
fan2_input  fan4_input  fan6_input  fan8_input  in4_fault  temp1_max
[root@tul163p1 ~]#

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
---
 drivers/hwmon/Kconfig      |    8 +
 drivers/hwmon/Makefile     |    1 
 drivers/hwmon/ibmpowernv.c |  386 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 395 insertions(+)
 create mode 100644 drivers/hwmon/ibmpowernv.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index bc196f4..3e308fa 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -554,6 +554,14 @@ config SENSORS_IBMPEX
 	  This driver can also be built as a module.  If so, the module
 	  will be called ibmpex.
 
+config SENSORS_IBMPOWERNV
+	tristate "IBM POWERNV platform sensors"
+	depends on PPC_POWERNV
+	default y
+	help
+	  If you say yes here you get support for the temperature/fan/power
+	  sensors on your platform.
+
 config SENSORS_IIO_HWMON
 	tristate "Hwmon driver that uses channels specified via iio maps"
 	depends on IIO
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index c48f987..199c401 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
 obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
 obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
+obj-$(CONFIG_SENSORS_IBMPOWERNV)+= ibmpowernv.o
 obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
 obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
 obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
new file mode 100644
index 0000000..e5cffce
--- /dev/null
+++ b/drivers/hwmon/ibmpowernv.c
@@ -0,0 +1,386 @@
+/*
+ * IBM PowerNV platform sensors for temperature/fan/power
+ * Copyright (C) 2014 IBM
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include <linux/platform_device.h>
+#include <asm/opal.h>
+#include <linux/err.h>
+
+#define DRVNAME		"ibmpowernv"
+#define MAX_ATTR_LEN	32
+
+/* Sensor suffix name from DT */
+#define DT_FAULT_ATTR_SUFFIX		"faulted"
+#define DT_DATA_ATTR_SUFFIX		"data"
+#define DT_THRESHOLD_ATTR_SUFFIX	"thrs"
+
+/* Enumerates all the sensors in the POWERNV platform and also index into
+ * 'struct sensor_name'
+ */
+enum sensors {
+	FAN,
+	AMBIENT_TEMP,
+	POWERSUPPLY,
+	POWER,
+	MAX_SENSOR_TYPE,
+};
+
+static struct sensor_name {
+	char *name;
+	char *compatible;
+} sensor_names[] = {
+	{"fan", "ibm,opal-sensor-cooling-fan"},
+	{"temp", "ibm,opal-sensor-amb-temp"},
+	{"in", "ibm,opal-sensor-power-supply"},
+	{"power", "ibm,opal-sensor-power"}
+};
+
+struct platform_data {
+	struct device *hwmon_dev;
+	struct device_attribute name_attr;
+	struct list_head attr_list;
+};
+
+struct sensor_data {
+	u32 id;
+	enum sensors stype;
+	char name[MAX_ATTR_LEN];
+	struct sensor_device_attribute sd_attr;
+	struct list_head list;
+};
+
+/* Platform device representing all the ibmpowernv sensors */
+static struct platform_device *pdevice;
+
+static void get_sensor_index_attr(const char *name, u32 *index, char *attr)
+{
+	char *hash_pos = strchr(name, '#');
+	char *dash_pos;
+	u32 copy_len;
+	char buf[8];
+
+	memset(buf, 0, sizeof(buf));
+	*index = 0;
+	*attr = '\0';
+
+	if (hash_pos) {
+		dash_pos = strchr(hash_pos, '-');
+		if (dash_pos) {
+			copy_len = dash_pos - hash_pos - 1;
+			if (copy_len < sizeof(buf)) {
+				strncpy(buf, hash_pos + 1, copy_len);
+				sscanf(buf, "%d", index);
+			}
+
+			strncpy(attr, dash_pos + 1, MAX_ATTR_LEN);
+		}
+	}
+}
+
+/*
+ * This function translates the DT node name into the 'hwmon' attribute name.
+ * IBMPOWERNV device node appear like cooling-fan#2-data, amb-temp#1-thrs etc.
+ * which need to be mapped as fan2_input, temp1_max respectively before
+ * populating them inside hwmon device class..
+ */
+static int create_hwmon_attr_name(enum sensors stype, const char *node_name,
+		char *hwmon_attr_name)
+{
+	char attr_suffix[MAX_ATTR_LEN];
+	char *attr_name;
+	u32 index;
+
+	get_sensor_index_attr(node_name, &index, attr_suffix);
+	if (!index || !strlen(attr_suffix)) {
+		pr_info("%s: Sensor device node name is invalid, name: %s\n",
+				__func__, node_name);
+		return -EINVAL;
+	}
+
+	if (!strcmp(attr_suffix, DT_FAULT_ATTR_SUFFIX))
+		attr_name = "fault";
+	else if(!strcmp(attr_suffix, DT_DATA_ATTR_SUFFIX))
+		attr_name = "input";
+	else if (!strcmp(attr_suffix, DT_THRESHOLD_ATTR_SUFFIX)) {
+		if (stype == AMBIENT_TEMP)
+			attr_name = "max";
+		else if (stype == FAN)
+			attr_name = "min";
+		else
+			return -ENOENT;
+	} else
+		return -ENOENT;
+
+	snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
+			sensor_names[stype].name, index, attr_name);
+	return 0;
+}
+
+static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
+		char *buf)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(devattr);
+	struct sensor_data *sdata = container_of(sd_attr, struct sensor_data,
+			sd_attr);
+	int err;
+	u32 x;
+
+	err = opal_get_sensor_data(sdata->id, &x);
+	if (err) {
+		pr_err("%s: Failed to get opal sensor data\n", __func__);
+		x = -1;
+	}
+
+	/* Convert temperature to milli-degrees */
+	if (sdata->stype == AMBIENT_TEMP && x > 0)
+		x *= 1000;
+	/* Convert power to micro-watts */
+	else if (sdata->stype == POWER && x > 0)
+		x *= 1000000;
+
+	return sprintf(buf, "%d\n", x);
+}
+
+static void remove_device_attrs(struct platform_device *pdev)
+{
+	struct platform_data *pdata = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct sensor_data *s, *next;
+
+	list_for_each_entry_safe(s, next, &pdata->attr_list, list) {
+		device_remove_file(dev, &s->sd_attr.dev_attr);
+		list_del(&s->list);
+		kfree(s);
+	}
+}
+
+/*
+ * Iterate through the device tree and for each child of sensor node, create
+ * a sysfs attribute file, the file is named by translating the DT node name
+ * to the name required by the higher 'hwmon' driver like fan1_input, temp1_max
+ * etc..
+ */
+static int create_device_attrs(struct platform_device *pdev)
+{
+	struct platform_data *pdata = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *opal, *np;
+	struct sensor_data *sdata;
+	const u32 *sensor_id;
+	enum sensors stype;
+	int err;
+
+	opal = of_find_node_by_path("/ibm,opal/sensors");
+        if (!opal) {
+		pr_err("%s: Opal 'sensors' node not found\n", __func__);
+		err = -ENXIO;
+		goto exit;
+        }
+
+	for_each_child_of_node(opal, np) {
+                if (np->name == NULL)
+                        continue;
+
+		for (stype = 0; stype < MAX_SENSOR_TYPE; stype++)
+			if (of_device_is_compatible(np,
+					sensor_names[stype].compatible))
+				break;
+
+		if (stype == MAX_SENSOR_TYPE)
+			continue;
+
+		sensor_id = of_get_property(np, "sensor-id", NULL);
+		if (!sensor_id) {
+			pr_info("%s: %s doesn't have sensor-id\n", __func__,
+					np->name);
+			continue;
+		}
+
+		sdata = kzalloc(sizeof(*sdata), GFP_KERNEL);
+		if (!sdata) {
+			pr_err("%s: Failed to allocate memory for sensor_data",
+					__func__);
+			err = -ENOMEM;
+			goto exit_put_node;
+		}
+
+		sdata->id = *sensor_id;
+		sdata->stype = stype;
+		err = create_hwmon_attr_name(stype, np->name, sdata->name);
+		if (err) {
+			pr_err("%s: Failed to create the hwmon attribute name\n",
+					__func__);
+			goto exit_free_sdata;
+		}
+
+		sysfs_attr_init(&sdata->sd_attr.dev_attr.attr);
+		sdata->sd_attr.dev_attr.attr.name = sdata->name;
+		sdata->sd_attr.dev_attr.attr.mode = S_IRUGO;
+		sdata->sd_attr.dev_attr.show = show_sensor;
+
+		/* Create sysfs attribute file */
+		err = device_create_file(dev, &sdata->sd_attr.dev_attr);
+		if (err)
+			goto exit_free_sdata;
+
+		list_add_tail(&sdata->list, &pdata->attr_list);
+	}
+
+	of_node_put(opal);
+	return 0;
+
+exit_free_sdata:
+	kfree(sdata);
+exit_put_node:
+	of_node_put(opal);
+	remove_device_attrs(pdev);
+exit:
+	return err;
+}
+
+static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
+		char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	return sprintf(buf, "%s\n", pdev->name);
+}
+
+static int ibmpowernv_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct platform_data *pdata;
+	int err;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	INIT_LIST_HEAD(&pdata->attr_list);
+	platform_set_drvdata(pdev, pdata);
+
+	/* Create platform device 'name' attribute */
+	sysfs_attr_init(&pdata->name_attr.attr);
+	pdata->name_attr.attr.name = "name";
+	pdata->name_attr.attr.mode = S_IRUGO;
+	pdata->name_attr.show = show_name;
+	err = device_create_file(dev, &pdata->name_attr);
+	if (err)
+		goto exit;
+
+	/* Create sysfs attribute file for each sensor found in the DT */
+	err = create_device_attrs(pdev);
+	if (err) {
+		pr_err("%s: Failed to create the device attributes\n",
+				__func__);
+		goto exit_remove_name;
+	}
+
+	/* Finally, register with hwmon */
+	pdata->hwmon_dev = devm_hwmon_device_register_with_groups(dev, DRVNAME,
+			pdata, NULL);
+	if (IS_ERR(pdata->hwmon_dev)) {
+		err = PTR_ERR(pdata->hwmon_dev);
+		goto exit_remove_devattrs;
+	}
+
+	return 0;
+
+exit_remove_devattrs:
+	remove_device_attrs(pdev);
+exit_remove_name:
+	device_remove_file(dev, &pdata->name_attr);
+exit:
+	return err;
+}
+
+static int ibmpowernv_remove(struct platform_device *pdev)
+{
+	struct platform_data *pdata = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	remove_device_attrs(pdev);
+	device_remove_file(dev, &pdata->name_attr);
+
+	return 0;
+}
+
+
+static struct platform_driver ibmpowernv_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = DRVNAME,
+	},
+	.probe = ibmpowernv_probe,
+	.remove = ibmpowernv_remove,
+};
+
+
+static int __init ibmpowernv_init(void)
+{
+	int err;
+
+
+	err = platform_driver_register(&ibmpowernv_driver);
+	if (err)
+		goto exit;
+
+
+	pdevice = platform_device_alloc(DRVNAME, 0);
+	if (!pdevice) {
+		pr_err("%s: Device allocation failed\n", __func__);
+		err = -ENOMEM;
+		goto exit_driver_unreg;
+	}
+
+	err = platform_device_add(pdevice);
+	if (err) {
+		pr_err("%s: Device addition failed (%d)\n", __func__, err);
+		goto exit_device_put;
+	}
+
+	return 0;
+
+exit_device_put:
+	platform_device_put(pdevice);
+exit_driver_unreg:
+	platform_driver_unregister(&ibmpowernv_driver);
+exit:
+	return err;
+}
+
+static void __exit ibmpowernv_exit(void)
+{
+	platform_device_unregister(pdevice);
+	platform_driver_unregister(&ibmpowernv_driver);
+}
+
+MODULE_DESCRIPTION("IBM POWERNV platform sensors");
+MODULE_LICENSE("GPL");
+
+module_init(ibmpowernv_init);
+module_exit(ibmpowernv_exit);
