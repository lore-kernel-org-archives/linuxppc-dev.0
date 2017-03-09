Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfBBd3mgLzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 00:31:53 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v29DSoE6071910
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 08:31:40 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2937kkscmp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Mar 2017 08:31:39 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 9 Mar 2017 19:01:03 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v29DTpv09502856
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 18:59:51 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v29DUvvV021509
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 19:01:00 +0530
Subject: Re: [RFC 2/2] hwmon: powernv: Hwmon driver for OCC inband power and
 temperature sensors
To: Guenter Roeck <linux@roeck-us.net>
References: <1489060155-22086-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1489060155-22086-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20170309121009.GA23732@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, andrew@aj.id.au, clg@kaod.org,
 maddy@linux.vnet.ibm.com, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 Eddie James <eajames@linux.vnet.ibm.com>
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Thu, 9 Mar 2017 19:00:57 +0530
MIME-Version: 1.0
In-Reply-To: <20170309121009.GA23732@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <b2d4558f-fb9d-a0dc-137c-1d0461ff643c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Guenter,

On 03/09/2017 05:40 PM, Guenter Roeck wrote:
> On Thu, Mar 09, 2017 at 05:19:15PM +0530, Shilpasri G Bhat wrote:
>> Add support to read power and temperature sensors from OCC inband
>> sensors which are copied to main memory by OCC.
>>
> 
> Is this supposed to be an alternative to the submission from 
> Eddie James ? If so, is there a reason to consider such an
> alternative ?
> 

This is not an alternative submission. Eddie James' hwmon OCC driver is to
export the sensors in BMC which is a service processor for POWER{8,9} servers.
This patch adds a hwmon driver in the POWER9 server.

Thanks and Regards,
Shilpa

> Thanks,
> Guenter
> 
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Jean Delvare <jdelvare@suse.com>
>> CC: Guenter Roeck <linux@roeck-us.net>
>> CC: Jonathan Corbet <corbet@lwn.net>
>> CC: devicetree@vger.kernel.org
>> CC: linux-hwmon@vger.kernel.org
>> CC: linux-doc@vger.kernel.org
>> ---
>>  .../devicetree/bindings/hwmon/ibmpowernv-occ.txt   |   4 +
>>  Documentation/hwmon/ibmpowernv-occ                 |  24 ++
>>  drivers/hwmon/Kconfig                              |  11 +
>>  drivers/hwmon/Makefile                             |   1 +
>>  drivers/hwmon/ibmpowernv-occ.c                     | 302 +++++++++++++++++++++
>>  5 files changed, 342 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/ibmpowernv-occ.txt
>>  create mode 100644 Documentation/hwmon/ibmpowernv-occ
>>  create mode 100644 drivers/hwmon/ibmpowernv-occ.c
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/ibmpowernv-occ.txt b/Documentation/devicetree/bindings/hwmon/ibmpowernv-occ.txt
>> new file mode 100644
>> index 0000000..d03f744
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/ibmpowernv-occ.txt
>> @@ -0,0 +1,4 @@
>> +IBM POWERNV OCC inband platform sensors
>> +
>> +Required device-tree property:
>> +- compatible: "ibm,p9-occ-inband-sensor"
>> diff --git a/Documentation/hwmon/ibmpowernv-occ b/Documentation/hwmon/ibmpowernv-occ
>> new file mode 100644
>> index 0000000..151028b
>> --- /dev/null
>> +++ b/Documentation/hwmon/ibmpowernv-occ
>> @@ -0,0 +1,24 @@
>> +Kernel driver ibmpowernv-occ
>> +=============================
>> +
>> +Supported systems:
>> + * P9 server based on POWERNV platform
>> +
>> +Description
>> +------------
>> +
>> +This driver exports the power and temperature sensors from OCC inband
>> +sensors on P9 POWERNV platforms.
>> +
>> +Sysfs attributes
>> +----------------
>> +
>> +powerX_input		Latest power reading
>> +powerX_input_highest	Minimum power
>> +powerX_input_lowest	Maximum power
>> +powerX_label		Sensor name
>> +
>> +tempX_input		Latest temperature reading
>> +tempX_max		Minimum temperature
>> +tempX_min		Maximum temperature
>> +tempX_label		Sensor name
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 0649d53f3..3b1dbb9 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -598,6 +598,17 @@ config SENSORS_IBMPOWERNV
>>  	  This driver can also be built as a module. If so, the module
>>  	  will be called ibmpowernv.
>>  
>> +config SENSORS_IBMPOWERNV_OCC
>> +	tristate "IBM POWERNV OCC Inband platform sensors"
>> +	depends on PPC_POWERNV
>> +	default y
>> +	help
>> +	  If you say yes here you get support for the temperature/power
>> +	  OCC inband sensors on your PowerNV platform.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called ibmpowernv-occ.
>> +
>>  config SENSORS_IIO_HWMON
>>  	tristate "Hwmon driver that uses channels specified via iio maps"
>>  	depends on IIO
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index 5509edf..0da2207 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -75,6 +75,7 @@ obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
>>  obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
>>  obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
>>  obj-$(CONFIG_SENSORS_IBMPOWERNV)+= ibmpowernv.o
>> +obj-$(CONFIG_SENSORS_IBMPOWERNV_OCC)+= ibmpowernv-occ.o
>>  obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
>>  obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
>>  obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
>> diff --git a/drivers/hwmon/ibmpowernv-occ.c b/drivers/hwmon/ibmpowernv-occ.c
>> new file mode 100644
>> index 0000000..97b1bbe
>> --- /dev/null
>> +++ b/drivers/hwmon/ibmpowernv-occ.c
>> @@ -0,0 +1,302 @@
>> +/*
>> + * IBM PowerNV platform OCC inband sensors for temperature/power
>> + * Copyright (C) 2017 IBM
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.
>> + */
>> +
>> +#define DRVNAME		"ibmpowernv_occ"
>> +#define pr_fmt(fmt)	DRVNAME ": " fmt
>> +
>> +#include <linux/module.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <asm/opal.h>
>> +
>> +#define MAX_HWMON_ATTR_LEN	32
>> +#define MAX_HWMON_LABEL_LEN	(MAX_OCC_SENSOR_NAME_LEN * 2)
>> +#define HWMON_ATTRS_PER_SENSOR	16
>> +#define TO_MILLI_UNITS(x)	((x) * 1000)
>> +#define TO_MICRO_UNITS(x)	((x) * 1000000)
>> +
>> +enum sensors {
>> +	TEMP,
>> +	POWER,
>> +	MAX_SENSOR_TYPE,
>> +};
>> +
>> +static struct sensor_type {
>> +	const char *name;
>> +	int hwmon_id;
>> +} sensor_types[] = {
>> +	{ "temp"},
>> +	{ "power"},
>> +};
>> +
>> +static struct sensor_data {
>> +	u32 occ_id;
>> +	u64 offset;  /* Offset to ping/pong reading buffer */
>> +	enum sensors type;
>> +	char label[MAX_HWMON_LABEL_LEN];
>> +	char name[MAX_HWMON_ATTR_LEN];
>> +	struct device_attribute attr;
>> +} *sdata;
>> +
>> +static struct attribute_group sensor_attrs_group;
>> +__ATTRIBUTE_GROUPS(sensor_attrs);
>> +
>> +#define show(file_name)							\
>> +static ssize_t ibmpowernv_occ_show_##file_name				\
>> +(struct device *dev, struct device_attribute *dattr, char *buf)		\
>> +{									\
>> +	struct sensor_data *sdata = container_of(dattr,			\
>> +						 struct sensor_data,	\
>> +						 attr);			\
>> +	u64 val;							\
>> +	int ret;							\
>> +	ret = opal_occ_sensor_get_##file_name(sdata->occ_id,		\
>> +					      sdata->offset,		\
>> +					      &val);			\
>> +	if (ret)							\
>> +		return ret;						\
>> +	if (sdata->type == TEMP)					\
>> +		val = TO_MILLI_UNITS(val);				\
>> +	else if (sdata->type == POWER)					\
>> +		val = TO_MICRO_UNITS(val);				\
>> +	return sprintf(buf, "%llu\n", val);				\
>> +}
>> +
>> +show(sample);
>> +show(max);
>> +show(min);
>> +show(js_min);
>> +show(js_max);
>> +show(csm_min);
>> +show(csm_max);
>> +show(prof_min);
>> +show(prof_max);
>> +
>> +static struct sensor_view_groups {
>> +	const char *name;
>> +	ssize_t (*show_sample)(struct device *dev,
>> +			       struct device_attribute *attr,
>> +			       char *buf);
>> +	ssize_t (*show_min)(struct device *dev,
>> +			    struct device_attribute *attr,
>> +			    char *buf);
>> +	ssize_t (*show_max)(struct device *dev,
>> +			    struct device_attribute *attr,
>> +			    char *buf);
>> +} sensor_views[] = {
>> +	{
>> +		.name		= "",
>> +		.show_sample	= ibmpowernv_occ_show_sample,
>> +		.show_min	= ibmpowernv_occ_show_min,
>> +		.show_max	= ibmpowernv_occ_show_max
>> +	},
>> +	{
>> +		.name		= "_JS",
>> +		.show_sample	= ibmpowernv_occ_show_sample,
>> +		.show_min	= ibmpowernv_occ_show_js_min,
>> +		.show_max	= ibmpowernv_occ_show_js_max
>> +	},
>> +	{	.name		= "_CSM",
>> +		.show_sample	= ibmpowernv_occ_show_sample,
>> +		.show_min	= ibmpowernv_occ_show_csm_min,
>> +		.show_max	= ibmpowernv_occ_show_csm_max
>> +	},
>> +	{	.name		= "_Prof",
>> +		.show_sample	= ibmpowernv_occ_show_sample,
>> +		.show_min	= ibmpowernv_occ_show_prof_min,
>> +		.show_max	= ibmpowernv_occ_show_prof_max
>> +	},
>> +};
>> +
>> +static ssize_t ibmpowernv_occ_show_label(struct device *dev,
>> +					 struct device_attribute *dattr,
>> +					 char *buf)
>> +{
>> +	struct sensor_data *sdata = container_of(dattr, struct sensor_data,
>> +						 attr);
>> +
>> +	return sprintf(buf, "%s\n", sdata->label);
>> +}
>> +
>> +static int ibmpowernv_occ_get_sensor_type(enum occ_sensor_type type)
>> +{
>> +	switch (type) {
>> +	case OCC_SENSOR_TYPE_POWER:
>> +		return POWER;
>> +	case OCC_SENSOR_TYPE_TEMPERATURE:
>> +		return TEMP;
>> +	default:
>> +		return MAX_SENSOR_TYPE;
>> +	}
>> +
>> +	return MAX_SENSOR_TYPE;
>> +}
>> +
>> +static void ibmpowernv_occ_add_sdata(struct occ_hwmon_sensor sensor,
>> +				     struct sensor_data *sdata, char *name,
>> +				     int hwmon_id, enum sensors type,
>> +				     ssize_t (*show)(struct device *dev,
>> +						struct device_attribute *attr,
>> +						char *buf))
>> +{
>> +	sdata->type = type;
>> +	sdata->occ_id = sensor.occ_id;
>> +	sdata->offset = sensor.offset;
>> +	snprintf(sdata->name, MAX_HWMON_ATTR_LEN, "%s%d_%s",
>> +		 sensor_types[type].name, hwmon_id, name);
>> +	sysfs_attr_init(&sdata->attr.attr);
>> +	sdata->attr.attr.name = sdata->name;
>> +	sdata->attr.attr.mode = 0444;
>> +	sdata->attr.show = show;
>> +}
>> +
>> +static void ibmpowernv_occ_add_sensor_attrs(struct occ_hwmon_sensor sensor,
>> +					    int index)
>> +{
>> +	struct attribute **attrs = sensor_attrs_group.attrs;
>> +	char attr_str[MAX_HWMON_ATTR_LEN];
>> +	enum sensors type = ibmpowernv_occ_get_sensor_type(sensor.type);
>> +	int i;
>> +
>> +	index *= HWMON_ATTRS_PER_SENSOR;
>> +	for (i = 0; i < ARRAY_SIZE(sensor_views); i++) {
>> +		int hid = ++sensor_types[type].hwmon_id;
>> +
>> +		/* input */
>> +		ibmpowernv_occ_add_sdata(sensor, &sdata[index], "input", hid,
>> +					 type, sensor_views[i].show_sample);
>> +		attrs[index] = &sdata[index].attr.attr;
>> +		index++;
>> +
>> +		/* min */
>> +		if (type == POWER)
>> +			snprintf(attr_str, MAX_HWMON_ATTR_LEN, "%s",
>> +				 "input_lowest");
>> +		else
>> +			snprintf(attr_str, MAX_HWMON_ATTR_LEN, "%s", "min");
>> +
>> +		ibmpowernv_occ_add_sdata(sensor, &sdata[index], attr_str, hid,
>> +					 type, sensor_views[i].show_min);
>> +		attrs[index] = &sdata[index].attr.attr;
>> +		index++;
>> +
>> +		/* max */
>> +		if (type == POWER)
>> +			snprintf(attr_str, MAX_HWMON_ATTR_LEN, "%s",
>> +				 "input_highest");
>> +		else
>> +			snprintf(attr_str, MAX_HWMON_ATTR_LEN, "%s", "max");
>> +
>> +		ibmpowernv_occ_add_sdata(sensor, &sdata[index], attr_str, hid,
>> +					 type, sensor_views[i].show_max);
>> +		attrs[index] = &sdata[index].attr.attr;
>> +		index++;
>> +
>> +		/* label */
>> +		snprintf(sdata[index].label, MAX_HWMON_LABEL_LEN, "%s%s",
>> +			 sensor.name, sensor_views[i].name);
>> +		ibmpowernv_occ_add_sdata(sensor, &sdata[index], "label", hid,
>> +					 type, ibmpowernv_occ_show_label);
>> +		attrs[index] = &sdata[index].attr.attr;
>> +		index++;
>> +	}
>> +}
>> +
>> +static int ibmpowernv_occ_add_device_attrs(struct platform_device *pdev)
>> +{
>> +	struct attribute **attrs;
>> +	struct occ_hwmon_sensor *slist = NULL;
>> +	int nr_sensors = 0, i;
>> +	int ret = -ENOMEM;
>> +
>> +	slist = opal_occ_sensor_get_hwmon_list(&nr_sensors);
>> +	if (!nr_sensors)
>> +		return -ENODEV;
>> +
>> +	if (!slist)
>> +		return ret;
>> +
>> +	sdata = devm_kzalloc(&pdev->dev, nr_sensors * sizeof(*sdata) *
>> +			     HWMON_ATTRS_PER_SENSOR, GFP_KERNEL);
>> +	if (!sdata)
>> +		goto out;
>> +
>> +	attrs = devm_kzalloc(&pdev->dev, nr_sensors * sizeof(*attrs) *
>> +			     HWMON_ATTRS_PER_SENSOR, GFP_KERNEL);
>> +	if (!attrs)
>> +		goto out;
>> +
>> +	sensor_attrs_group.attrs = attrs;
>> +	for (i = 0; i < nr_sensors; i++)
>> +		ibmpowernv_occ_add_sensor_attrs(slist[i], i);
>> +
>> +	ret = 0;
>> +out:
>> +	kfree(slist);
>> +	return ret;
>> +}
>> +
>> +static int ibmpowernv_occ_probe(struct platform_device *pdev)
>> +{
>> +	struct device *hwmon_dev;
>> +	int err;
>> +
>> +	err = ibmpowernv_occ_add_device_attrs(pdev);
>> +	if (err)
>> +		goto out;
>> +
>> +	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev, DRVNAME,
>> +							   NULL,
>> +							   sensor_attrs_groups);
>> +
>> +	err = PTR_ERR_OR_ZERO(hwmon_dev);
>> +out:
>> +	if (err)
>> +		pr_warn("Failed to initialize Hwmon OCC inband sensors\n");
>> +
>> +	return err;
>> +}
>> +
>> +static const struct platform_device_id occ_sensor_ids[] = {
>> +	{ .name = "occ-inband-sensor" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, occ_sensor_ids);
>> +
>> +static const struct of_device_id occ_sensor_of_ids[] = {
>> +	{ .compatible	= "ibm,p9-occ-inband-sensor" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, occ_sensor_of_ids);
>> +
>> +static struct platform_driver ibmpowernv_occ_driver = {
>> +	.probe		= ibmpowernv_occ_probe,
>> +	.id_table	= occ_sensor_ids,
>> +	.driver		= {
>> +		.name	= DRVNAME,
>> +		.of_match_table	= occ_sensor_of_ids,
>> +	},
>> +};
>> +
>> +module_platform_driver(ibmpowernv_occ_driver);
>> +
>> +MODULE_AUTHOR("Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>");
>> +MODULE_DESCRIPTION("IBM POWERNV platform OCC inband sensors");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 1.8.3.1
>>
> 
