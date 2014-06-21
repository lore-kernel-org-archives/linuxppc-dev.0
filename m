Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id A0A331A0084
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jun 2014 03:15:45 +1000 (EST)
Message-ID: <53A5BDB4.5020008@roeck-us.net>
Date: Sat, 21 Jun 2014 10:15:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, jdelvare@suse.de, lm-sensors@lm-sensors.org
Subject: Re: [PATCH v3] powerpc/powernv: hwmon driver for power, fan rpm,
 voltage and temperature
References: <20140618083250.20069.73848.stgit@localhost.localdomain>
In-Reply-To: <20140618083250.20069.73848.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sbhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/18/2014 01:35 AM, Neelesh Gupta wrote:
> This patch adds basic kernel enablement for reading power values, fan

how about support instead of enablement ?

> speed rpm, voltage and temperature data on powernv platforms which will
> be exported to user space through sysfs interface.
>
> Test results:
> -------------
> [root@ltctul57a-p1 ~]# sensors
> ibmpowernv-isa-0000
> Adapter: ISA adapter
> fan1:        5660 RPM  (min =    0 RPM)
> fan2:        5273 RPM  (min =    0 RPM)
> fan3:        5625 RPM  (min =    0 RPM)
> fan4:        5283 RPM  (min =    0 RPM)
> fan5:        5625 RPM  (min =    0 RPM)
> fan6:        5242 RPM  (min =    0 RPM)
> fan7:        5636 RPM  (min =    0 RPM)
> fan8:        5273 RPM  (min =    0 RPM)
> fan9:        4984 RPM  (min =    0 RPM)
> fan10:       4984 RPM  (min =    0 RPM)
> fan11:       4984 RPM  (min =    0 RPM)
> fan12:       4984 RPM  (min =    0 RPM)
> temp1:        +24.0 C  (high =  +0.0 C)
> power1:      573.00 W
>
> [root@ltctul57a-p1 ~]#
> [root@ltctul57a-p1 ~]# ls /sys/devices/platform/
> alarmtimer  ibmpowernv.0  rtc-generic  serial8250  uevent
> [root@ltctul57a-p1 ~]# ls /sys/devices/platform/ibmpowernv.0/hwmon/hwmon0/
> device	     fan12_input  fan3_fault  fan5_min	  fan8_input  in4_fault
> fan10_fault  fan12_min	  fan3_input  fan6_fault  fan8_min    name
> fan10_input  fan1_fault   fan3_min    fan6_input  fan9_fault  power1_input
> fan10_min    fan1_input   fan4_fault  fan6_min	  fan9_input  subsystem
> fan11_fault  fan1_min	  fan4_input  fan7_fault  fan9_min    temp1_input
> fan11_input  fan2_fault   fan4_min    fan7_input  in1_fault   temp1_max
> fan11_min    fan2_input   fan5_fault  fan7_min	  in2_fault   uevent
> fan12_fault  fan2_min	  fan5_input  fan8_fault  in3_fault
> [root@ltctul57a-p1 ~]#
> [root@ltctul57a-p1 ~]# ls /sys/class/hwmon/hwmon0/
> device	     fan12_input  fan3_fault  fan5_min	  fan8_input  in4_fault
> fan10_fault  fan12_min	  fan3_input  fan6_fault  fan8_min    name
> fan10_input  fan1_fault   fan3_min    fan6_input  fan9_fault  power1_input
> fan10_min    fan1_input   fan4_fault  fan6_min	  fan9_input  subsystem
> fan11_fault  fan1_min	  fan4_input  fan7_fault  fan9_min    temp1_input
> fan11_input  fan2_fault   fan4_min    fan7_input  in1_fault   temp1_max
> fan11_min    fan2_input   fan5_fault  fan7_min	  in2_fault   uevent
> fan12_fault  fan2_min	  fan5_input  fan8_fault  in3_fault
> [root@ltctul57a-p1 ~]#
>
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> ---
>
> Changes in V3
> =========
> - Fixed an endianness bug leading the driver to break on LE.
> - Fixed a bug that when one of the 'attribute_group' not populated, following
>    groups attributes were dropped.
> - Rewrite the get_sensor_index_attr() function to handle all the error scenarios
>    like 'sscanf' etc.
> - Fixed all the errors/warnings related to coding style/whitespace.
> - Added 'Documentation' files.
> - Addressed remaining review comments on V2.
>
> Changes in v2
> =============
> - Generic use of devm_* functions in hwmon like using devm_kzalloc() for dynamic
>    memory request, avoiding the need to explicit free of memory.
>    Adding 'struct attribute_group' as member of platform data structure to be
>    populated and then passed to devm_hwmon_device_register_with_groups().
>
>    Note: Having an array of pointers of 'attribute_group' and each group
>    corresponds to 'enum sensors' type. Not completely sure, if it's ideal or
>    could have just one group populated with attributes of sensor types?
>
> - 'ibmpowernv' is not hot-pluggable device so moving 'platform_driver' callback
>    function (probe) as part of __init code.
> - Fixed issues related to coding style.
> - Other general comments in v1.
>
>   .../devicetree/bindings/hwmon/ibmpowernv.txt       |   27 +
>   Documentation/hwmon/ibmpowernv                     |   41 ++
>   drivers/hwmon/Kconfig                              |   11 +
>   drivers/hwmon/Makefile                             |    1
>   drivers/hwmon/ibmpowernv.c                         |  366 ++++++++++++++++++++
>   5 files changed, 446 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/ibmpowernv.txt
>   create mode 100644 Documentation/hwmon/ibmpowernv
>   create mode 100644 drivers/hwmon/ibmpowernv.c
>
> diff --git a/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt b/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt
> new file mode 100644
> index 0000000..e3bd1eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ibmpowernv.txt
> @@ -0,0 +1,27 @@
> +IBM POWERNV platform sensors
> +----------------------------
> +
> +Required node properties:
> +- compatible: must be one of
> +		"ibm,opal-sensor-cooling-fan"
> +		"ibm,opal-sensor-amb-temp"
> +		"ibm,opal-sensor-power-supply"
> +		"ibm,opal-sensor-power"
> +- sensor-id: an opaque id provided by the firmware to the kernel, identifies a
> +	     given sensor and its attribute data
> +
> +Example sensors node:
> +
> +cooling-fan#8-data {
> +	sensor-id = <0x7052107>;
> +	phandle = <0x10000028>;
> +	linux,phandle = <0x10000028>;
> +	compatible = "ibm,opal-sensor-cooling-fan";
> +};
> +
> +amb-temp#1-thrs {
> +	sensor-id = <0x5096000>;
> +	phandle = <0x10000017>;
> +	linux,phandle = <0x10000017>;
> +	compatible = "ibm,opal-sensor-amb-temp";
> +};
> diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
> new file mode 100644
> index 0000000..d9ce50e
> --- /dev/null
> +++ b/Documentation/hwmon/ibmpowernv
> @@ -0,0 +1,41 @@
> +Kernel Driver IBMPOWENV
> +=======================
> +
> +Supported systems:
> +  * Any recent IBM P servers based on POWERNV platform
> +
> +Author: Neelesh Gupta
> +
> +Description
> +-----------
> +
> +This driver implements reading the platform sensors data like temperature/fan/
> +voltage/power for 'POWERNV' platform.
> +
> +The driver uses the platform device infrastructure. It probes the device tree
> +for sensor devices during the __init phase and registers them with the 'hwmon'.
> +'hwmon' populates the 'sysfs' tree having attribute files, each for a given
> +sensor type and its attribute data.
> +
> +All the nodes in the DT appear under "/ibm,opal/sensors" and each valid node in
> +the DT maps to an attribute file in 'sysfs'. The node exports unique 'sensor-id'
> +which the driver uses to make an OPAL call to the firmware.
> +
> +Usage notes
> +-----------
> +The driver is built statically with the kernel by enabling the config
> +CONFIG_SENSORS_IBMPOWERNV. It can also be built as module 'ibmpowernv'.
> +
> +Sysfs attributes
> +----------------
> +
> +fanX_input		Measured RPM value.
> +fanX_min		Threshold RPM for alert generation.
> +fanX_fault		0: No fail condition
> +			1: Failing fan
> +tempX_input		Measured ambient temperature.
> +tempX_max		Threshold ambient temperature for alert generation.
> +inX_input		Measured power supply voltage
> +inX_fault		0: No fail condition.
> +			1: Failing power supply.
> +power1_input		System power consumption (milliWatts)

ABI says micro-watts. Code below agrees.

> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index bc196f4..fc69112 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -554,6 +554,17 @@ config SENSORS_IBMPEX
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called ibmpex.
>
> +config SENSORS_IBMPOWERNV
> +	tristate "IBM POWERNV platform sensors"
> +	depends on PPC_POWERNV
> +	default y
> +	help
> +	  If you say yes here you get support for the temperature/fan/power
> +	  sensors on your platform.

on your PowerNV platform

> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called ibmpowernv.
> +
>   config SENSORS_IIO_HWMON
>   	tristate "Hwmon driver that uses channels specified via iio maps"
>   	depends on IIO
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index c48f987..199c401 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
>   obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
>   obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
>   obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
> +obj-$(CONFIG_SENSORS_IBMPOWERNV)+= ibmpowernv.o
>   obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
>   obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
>   obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> new file mode 100644
> index 0000000..45c7f4b
> --- /dev/null
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -0,0 +1,366 @@
> +/*
> + * IBM PowerNV platform sensors for temperature/fan/voltage/power
> + * Copyright (C) 2014 IBM
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include <linux/platform_device.h>
> +#include <asm/opal.h>
> +#include <linux/err.h>
> +
> +#define DRVNAME		"ibmpowernv"
> +#define MAX_ATTR_LEN	32
> +
> +/* Sensor suffix name from DT */
> +#define DT_FAULT_ATTR_SUFFIX		"faulted"
> +#define DT_DATA_ATTR_SUFFIX		"data"
> +#define DT_THRESHOLD_ATTR_SUFFIX	"thrs"
> +
> +/*
> + * Enumerates all the types of sensors in the POWERNV platform and does index
> + * into 'struct sensor_group'
> + */
> +enum sensors {
> +	FAN,
> +	AMBIENT_TEMP,
> +	POWER_SUPPLY,
> +	POWER_INPUT,
> +	MAX_SENSOR_TYPE,
> +};
> +
> +static struct sensor_group {
> +	const char *name;
> +	const char *compatible;
> +	struct attribute_group group;
> +	u32 attr_count;
> +} sensor_groups[] = {
> +	{"fan", "ibm,opal-sensor-cooling-fan"},
> +	{"temp", "ibm,opal-sensor-amb-temp"},
> +	{"in", "ibm,opal-sensor-power-supply"},
> +	{"power", "ibm,opal-sensor-power"}
> +};
> +
> +struct sensor_data {
> +	u32 id; /* An opaque id of the firmware for each sensor */
> +	enum sensors type;
> +	char name[MAX_ATTR_LEN];
> +	struct device_attribute dev_attr;
> +};
> +
> +struct platform_data {
> +	const struct attribute_group *attr_groups[MAX_SENSOR_TYPE + 1];
> +	u32 sensors_count; /* Total count of sensors from each group */
> +};
> +
> +/* Platform device representing all the ibmpowernv sensors */
> +static struct platform_device *pdevice;
> +
> +static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
> +			   char *buf)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +	ssize_t ret;
> +	u32 x;
> +
> +	ret = opal_get_sensor_data(sdata->id, &x);
> +	if (ret) {
> +		pr_err("%s: Failed to get opal sensor data\n", __func__);

Please use dev_err, and drop __func__. Also, do really need that error message ?
The caller already gets notified, so polluting the log with it isn't really
that helpful (if every driver in the kernel would do that, the log would be all
but useless).

> +		return ret;
> +	}
> +
> +	/* Convert temperature to milli-degrees */
> +	if (sdata->type == AMBIENT_TEMP)
> +		x *= 1000;
> +	/* Convert power to micro-watts */
> +	else if (sdata->type == POWER_INPUT)
> +		x *= 1000000;
> +
> +	return sprintf(buf, "%u\n", x);
> +}
> +
> +static int __init get_sensor_index_attr(const char *name, u32 *index,
> +					char *attr)
> +{
> +	char *hash_pos = strchr(name, '#');
> +	char *dash_pos;
> +	u32 copy_len;
> +	char buf[8];
> +
> +	memset(buf, 0, sizeof(buf));
> +
Consider using
	char buf[8] = { 0 };
to leave it up to the compiler how to initialize the field.

> +	if (!hash_pos)
> +		return -EINVAL;
> +
> +	dash_pos = strchr(hash_pos, '-');
> +	if (!dash_pos)
> +		return -EINVAL;
> +
> +	copy_len = dash_pos - hash_pos - 1;
> +	if (copy_len >= sizeof(buf))
> +		return -EINVAL;
> +
> +	strncpy(buf, hash_pos + 1, copy_len);
> +	if (sscanf(buf, "%d", index) != 1)
> +		return -EINVAL;
> +
checkpatch says:

WARNING: Prefer kstrto<type> to single variable sscanf
#347: FILE: drivers/hwmon/ibmpowernv.c:124:
+	if (sscanf(buf, "%d", index) != 1)
+		return -EINVAL;

> +	strncpy(attr, dash_pos + 1, MAX_ATTR_LEN);
> +
> +	return 0;
> +}
> +
> +/*
> + * This function translates the DT node name into the 'hwmon' attribute name.
> + * IBMPOWERNV device node appear like cooling-fan#2-data, amb-temp#1-thrs etc.
> + * which need to be mapped as fan2_input, temp1_max respectively before
> + * populating them inside hwmon device class..
> + */
> +static int __init create_hwmon_attr_name(enum sensors type,
> +					 const char *node_name,
> +					 char *hwmon_attr_name)
> +{
> +	char attr_suffix[MAX_ATTR_LEN];
> +	char *attr_name;
> +	u32 index;
> +	int err;
> +
> +	err = get_sensor_index_attr(node_name, &index, attr_suffix);
> +	if (err) {
> +		pr_info("%s: Sensor device node name is invalid, name: %s\n",
> +			__func__, node_name);

dev_info please, and drop __func__. Pass dev as parameter to the function.
Why _info anyway ? Isn't this an error ?

> +		return err;
> +	}
> +
> +	if (!strcmp(attr_suffix, DT_FAULT_ATTR_SUFFIX)) {
> +		attr_name = "fault";
> +	} else if (!strcmp(attr_suffix, DT_DATA_ATTR_SUFFIX)) {
> +		attr_name = "input";
> +	} else if (!strcmp(attr_suffix, DT_THRESHOLD_ATTR_SUFFIX)) {
> +		if (type == AMBIENT_TEMP)
> +			attr_name = "max";
> +		else if (type == FAN)
> +			attr_name = "min";
> +		else
> +			return -ENOENT;
> +	} else {
> +		return -ENOENT;
> +	}
> +
> +	snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
> +		 sensor_groups[type].name, index, attr_name);
> +	return 0;
> +}
> +
> +static int __init populate_attr_groups(struct platform_device *pdev)
> +{
> +	struct platform_data *pdata = platform_get_drvdata(pdev);
> +	const struct attribute_group **pgroups = pdata->attr_groups;
> +	struct device_node *opal, *np;
> +	enum sensors type;
> +
> +	opal = of_find_node_by_path("/ibm,opal/sensors");
> +	if (!opal) {
> +		pr_err("%s: Opal 'sensors' node not found\n", __func__);

dev_err please, and drop __func__.

> +		return -ENODEV;
> +	}
> +
> +	for_each_child_of_node(opal, np) {
> +		if (np->name == NULL)
> +			continue;
> +
> +		for (type = 0; type < MAX_SENSOR_TYPE; type++)
> +			if (of_device_is_compatible(np,
> +					sensor_groups[type].compatible)) {
> +				sensor_groups[type].attr_count++;
> +				break;
> +			}
> +	}
> +
> +	of_node_put(opal);
> +
> +	for (type = 0; type < MAX_SENSOR_TYPE; type++) {
> +		sensor_groups[type].group.attrs = devm_kzalloc(&pdev->dev,
> +					sizeof(struct attribute *) *
> +					(sensor_groups[type].attr_count + 1),
> +					GFP_KERNEL);
> +		if (!sensor_groups[type].group.attrs)
> +			return -ENOMEM;
> +
> +		pgroups[type] = &sensor_groups[type].group;
> +		pdata->sensors_count += sensor_groups[type].attr_count;
> +		sensor_groups[type].attr_count = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Iterate through the device tree for each child of 'sensors' node, create
> + * a sysfs attribute file, the file is named by translating the DT node name
> + * to the name required by the higher 'hwmon' driver like fan1_input, temp1_max
> + * etc..
> + */
> +static int __init create_device_attrs(struct platform_device *pdev)
> +{
> +	struct platform_data *pdata = platform_get_drvdata(pdev);
> +	const struct attribute_group **pgroups = pdata->attr_groups;
> +	struct device_node *opal, *np;
> +	struct sensor_data *sdata;
> +	const __be32 *sensor_id;
> +	enum sensors type;
> +	u32 count = 0;
> +	int err = 0;
> +
> +	opal = of_find_node_by_path("/ibm,opal/sensors");
> +	if (!opal) {
> +		pr_err("%s: Opal 'sensors' node not found\n", __func__);

dev_err. Why are you checking this twice, anyway ?

> +		return -ENODEV;
> +	}
> +
> +	sdata = devm_kzalloc(&pdev->dev, (pdata->sensors_count) *
> +			     sizeof(*sdata), GFP_KERNEL);

( ) around pdata->sensors_count is unnecessary.

> +	if (!sdata) {
> +		err = -ENOMEM;
> +		goto exit_put_node;
> +	}
> +
> +	for_each_child_of_node(opal, np) {
> +		if (np->name == NULL)
> +			continue;
> +
> +		for (type = 0; type < MAX_SENSOR_TYPE; type++)
> +			if (of_device_is_compatible(np,
> +					sensor_groups[type].compatible))
> +				break;
> +
> +		if (type == MAX_SENSOR_TYPE)
> +			continue;
> +
> +		sensor_id = of_get_property(np, "sensor-id", NULL);
> +		if (!sensor_id) {
> +			pr_info("%s: 'sensor-id' property not present in %s\n",
> +				__func__, np->name);

dev_info

> +			continue;
> +		}
> +
> +		sdata[count].id = be32_to_cpup(sensor_id);
> +		sdata[count].type = type;
> +		err = create_hwmon_attr_name(type, np->name, sdata[count].name);
> +		if (err)
> +			goto exit_put_node;
> +
> +		sysfs_attr_init(&sdata[count].dev_attr.attr);
> +		sdata[count].dev_attr.attr.name = sdata[count].name;
> +		sdata[count].dev_attr.attr.mode = S_IRUGO;
> +		sdata[count].dev_attr.show = show_sensor;
> +
> +		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> +				&sdata[count++].dev_attr.attr;
> +	}
> +
> +exit_put_node:
> +	of_node_put(opal);
> +	return err;
> +}
> +
> +static int __init ibmpowernv_probe(struct platform_device *pdev)
> +{
> +	struct platform_data *pdata;
> +	struct device *hwmon_dev;
> +	int err;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pdata);
> +	pdata->sensors_count = 0;
> +	err = populate_attr_groups(pdev);
> +	if (err)
> +		return err;
> +
> +	/* Create sysfs attribute data for each sensor found in the DT */
> +	err = create_device_attrs(pdev);
> +	if (err)
> +		return err;
> +
> +	/* Finally, register with hwmon */
> +	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev, DRVNAME,
> +							   pdata,
> +							   pdata->attr_groups);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static struct platform_driver ibmpowernv_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = DRVNAME,
> +	},
> +};
> +
> +static int __init ibmpowernv_init(void)
> +{
> +	int err;
> +
> +	pdevice = platform_device_alloc(DRVNAME, 0);
> +	if (!pdevice) {
> +		pr_err("%s: Device allocation failed\n", __func__);

Please define something like

#define pr_fmt(fmt) DRVNAME ": " fmt

at the beginning of the driver (before the include files)
to get an automatic driver name prefix.
Then you can drop __func__ as it is redundant and doesn't provide
as much value as the name of the driver.

> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	err = platform_device_add(pdevice);
> +	if (err) {
> +		pr_err("%s: Device addition failed (%d)\n", __func__, err);
> +		goto exit_device_put;
> +	}
> +
> +	err = platform_driver_probe(&ibmpowernv_driver, ibmpowernv_probe);
> +	if (err) {
> +		pr_err("%s: Platfrom driver probe failed\n", __func__);
> +		goto exit_device_del;
> +	}
> +
> +	return 0;
> +
> +exit_device_del:
> +	platform_device_del(pdevice);
> +exit_device_put:
> +	platform_device_put(pdevice);
> +exit:
> +	return err;
> +}
> +
> +static void __exit ibmpowernv_exit(void)
> +{
> +	platform_driver_unregister(&ibmpowernv_driver);
> +	platform_device_unregister(pdevice);
> +}
> +
> +MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
> +MODULE_DESCRIPTION("IBM POWERNV platform sensors");
> +MODULE_LICENSE("GPL");
> +
> +module_init(ibmpowernv_init);
> +module_exit(ibmpowernv_exit);
>
>
>
