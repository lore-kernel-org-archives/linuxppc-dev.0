Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7262F1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jun 2014 18:15:22 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Mon, 9 Jun 2014 18:15:21 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7272E357804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jun 2014 18:15:18 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s597xEeY13631564
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jun 2014 17:59:15 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s598FGDV028331
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jun 2014 18:15:16 +1000
Message-ID: <53956D06.40800@linux.vnet.ibm.com>
Date: Mon, 09 Jun 2014 13:45:02 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linuxppc-dev@lists.ozlabs.org,
 jdelvare@suse.de, lm-sensors@lm-sensors.org
Subject: Re: [PATCH v2] powerpc/powernv: hwmon driver for power values, fan
 rpm and temperature
References: <20140519141931.9248.11356.stgit@neelegup-tp-t420.in.ibm.com>
 <53858F02.2020808@roeck-us.net>
In-Reply-To: <53858F02.2020808@roeck-us.net>
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


On 05/28/2014 12:53 PM, Guenter Roeck wrote:
> On 05/19/2014 07:26 AM, Neelesh Gupta wrote:
>> This patch adds basic kernel enablement for reading power values, fan
>> speed rpm and temperature values on powernv platforms which will
>> be exported to user space through sysfs interface.
>>
>> Test results:
>> -------------
>> [root@tul163p1 ~]# sensors
>> ibmpowernv-isa-0000
>> Adapter: ISA adapter
>> fan1:        5487 RPM  (min =    0 RPM)
>> fan2:        5152 RPM  (min =    0 RPM)
>> fan3:        5590 RPM  (min =    0 RPM)
>> fan4:        4963 RPM  (min =    0 RPM)
>> fan5:           0 RPM  (min =    0 RPM)
>> fan6:           0 RPM  (min =    0 RPM)
>> fan7:        7488 RPM  (min =    0 RPM)
>> fan8:        7944 RPM  (min =    0 RPM)
>> temp1:        +39.0°C  (high =  +0.0°C)
>> power1:      192.00 W
>>
>> [root@tul163p1 ~]# ls /sys/devices/platform/
>> alarmtimer  ibmpowernv.0  rtc-generic  serial8250  uevent
>> [root@tul163p1 ~]# ls /sys/devices/platform/ibmpowernv.0/
>> driver/    hwmon/     modalias   subsystem/ uevent
>> [root@tul163p1 ~]# ls /sys/devices/platform/ibmpowernv.0/hwmon/hwmon0/
>> device        fan2_min    fan4_min    fan6_min    fan8_min power1_input
>> fan1_fault  fan3_fault    fan5_fault  fan7_fault    in1_fault subsystem
>> fan1_input  fan3_input    fan5_input  fan7_input    in2_fault 
>> temp1_input
>> fan1_min    fan3_min    fan5_min    fan7_min    in3_fault temp1_max
>> fan2_fault  fan4_fault    fan6_fault  fan8_fault    in4_fault uevent
>> fan2_input  fan4_input    fan6_input  fan8_input    name
>> [root@tul163p1 ~]#
>> [root@tul163p1 ~]# ls /sys/class/hwmon/hwmon0/
>> device        fan2_min    fan4_min    fan6_min    fan8_min power1_input
>> fan1_fault  fan3_fault    fan5_fault  fan7_fault    in1_fault subsystem
>> fan1_input  fan3_input    fan5_input  fan7_input    in2_fault 
>> temp1_input
>> fan1_min    fan3_min    fan5_min    fan7_min    in3_fault temp1_max
>> fan2_fault  fan4_fault    fan6_fault  fan8_fault    in4_fault uevent
>> fan2_input  fan4_input    fan6_input  fan8_input    name
>> [root@tul163p1 ~]#
>>
>
>
> The inX_fault attributes don't really make much sense. _fault 
> attributes without
> _input attributes don't have any value and are, as you noticed, not 
> displayed
> with the sensors command. Is this a problem in teh devicetree data or 
> do you
> really have voltage faults without voltages ?

There is no issue with the device data, somehow I'm getting only the 
_fault attribute
for the inX_ (power-supply) attributes.

>
>> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
>> ---
>>
> Checkpatch says:
>
> total: 8 errors, 11 warnings, 389 lines checked
>
> NOTE: whitespace errors detected, you may wish to use 
> scripts/cleanpatch or
>       scripts/cleanfile
>
> which should really not happen at this point.
>
> Please make sure you follow CodingStyle. checkpatch --strict points to 
> a number
> of additional violations.
>
> More comments inline.

Fixed all of these issues related to coding style.

>
>> Changes in v2
>> =============
>> - Generic use of devm_* functions in hwmon like using devm_kzalloc() 
>> for dynamic
>>    memory request, avoiding the need to explicit free of memory.
>>    Adding 'struct attribute_group' as member of platform data 
>> structure to be
>>    populated and then passed to 
>> devm_hwmon_device_register_with_groups().
>>
>>    Note: Having an array of pointers of 'attribute_group' and each group
>>    corresponds to 'enum sensors' type. Not completely sure, if it's 
>> ideal or
>>    could have just one group populated with attributes of sensor types?
>>
> Your call, really; whatever is easier for you. I won't dictate one or 
> the other.
>
> Question though is what happens if one group is not populated. If I 
> understand
> the code correctly this will result in the remaining groups to be 
> 'dropped',
> ie not displayed at all.

Yes, should be fixed.

>
>> - 'ibmpowernv' is not hot-pluggable device so moving 
>> 'platform_driver' callback
>>    function (probe) as part of __init code.
>> - Fixed issues related to coding style.
>> - Other general comments in v1.
>>
>>   drivers/hwmon/Kconfig      |    8 +
>>   drivers/hwmon/Makefile     |    1
>>   drivers/hwmon/ibmpowernv.c |  368 
>> ++++++++++++++++++++++++++++++++++++++++++++
>
> You'll also need Documentation/hwmon/ibmpowernv and
> Documentation/devicetree/bindings/hwmon/ibmpowernv.
>
> The latter will need to get an Ack from the devicetree maintainers.

I'll do as required.

>>   3 files changed, 377 insertions(+)
>>   create mode 100644 drivers/hwmon/ibmpowernv.c
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index bc196f4..3e308fa 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -554,6 +554,14 @@ config SENSORS_IBMPEX
>>         This driver can also be built as a module.  If so, the module
>>         will be called ibmpex.
>>
>> +config SENSORS_IBMPOWERNV
>> +    tristate "IBM POWERNV platform sensors"
>> +    depends on PPC_POWERNV
>> +    default y
>> +    help
>> +      If you say yes here you get support for the temperature/fan/power
>> +      sensors on your platform.
>> +
>>   config SENSORS_IIO_HWMON
>>       tristate "Hwmon driver that uses channels specified via iio maps"
>>       depends on IIO
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>> index c48f987..199c401 100644
>> --- a/drivers/hwmon/Makefile
>> +++ b/drivers/hwmon/Makefile
>> @@ -71,6 +71,7 @@ obj-$(CONFIG_SENSORS_ULTRA45)    += ultra45_env.o
>>   obj-$(CONFIG_SENSORS_I5K_AMB)    += i5k_amb.o
>>   obj-$(CONFIG_SENSORS_IBMAEM)    += ibmaem.o
>>   obj-$(CONFIG_SENSORS_IBMPEX)    += ibmpex.o
>> +obj-$(CONFIG_SENSORS_IBMPOWERNV)+= ibmpowernv.o
>>   obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
>>   obj-$(CONFIG_SENSORS_INA209)    += ina209.o
>>   obj-$(CONFIG_SENSORS_INA2XX)    += ina2xx.o
>> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
>> new file mode 100644
>> index 0000000..afce620
>> --- /dev/null
>> +++ b/drivers/hwmon/ibmpowernv.c
>> @@ -0,0 +1,368 @@
>> +/*
>> + * IBM PowerNV platform sensors for temperature/fan/power
>> + * Copyright (C) 2014 IBM
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
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/of.h>
>> +#include <linux/slab.h>
>> +
>> +#include <linux/platform_device.h>
>> +#include <asm/opal.h>
>> +#include <linux/err.h>
>> +
>> +#define DRVNAME        "ibmpowernv"
>> +#define MAX_ATTR_LEN    32
>> +
>> +/* Sensor suffix name from DT */
>> +#define DT_FAULT_ATTR_SUFFIX        "faulted"
>> +#define DT_DATA_ATTR_SUFFIX        "data"
>> +#define DT_THRESHOLD_ATTR_SUFFIX    "thrs"
>> +
>> +/*
>> + * Enumerates all the types of sensors in the POWERNV platform and 
>> does index
>> + * into 'struct sensor_group'
>> + */
>> +enum sensors {
>> +    FAN,
>> +    AMBIENT_TEMP,
>> +    POWER_SUPPLY,
>> +    POWER_INPUT,
>> +    MAX_SENSOR_TYPE,
>> +};
>> +
>> +static struct sensor_group {
>> +    const char *name;
>> +    const char *compatible;
>> +    struct attribute_group group;
>> +    u32 attr_count;
>> +} sensor_groups[] = {
>> +    {"fan", "ibm,opal-sensor-cooling-fan", {0}, 0},
>> +    {"temp", "ibm,opal-sensor-amb-temp", {0}, 0},
>> +    {"in", "ibm,opal-sensor-power-supply", {0}, 0},
>> +    {"power", "ibm,opal-sensor-power", {0}, 0}
>> +};
>> +
> The '0' initializations should not be necessary.
>
>
>> +struct sensor_data {
>> +    u32 id; /* An opaque id of the firmware for each sensor */
>> +    enum sensors type;
>> +    char name[MAX_ATTR_LEN];
>> +    struct device_attribute dev_attr;
>> +};
>> +
>> +struct platform_data {
>> +    const struct attribute_group *attr_groups[MAX_SENSOR_TYPE + 1];
>> +    u32 sensors_count; /* Total count of sensors from each group */
>> +};
>> +
>> +/* Platform device representing all the ibmpowernv sensors */
>> +static struct platform_device *pdevice;
>> +
>> +static ssize_t show_sensor(struct device *dev, struct 
>> device_attribute *devattr,
>> +               char *buf)
>> +{
>> +    struct sensor_data *sdata = container_of(devattr, struct 
>> sensor_data,
>> +                         dev_attr);
>> +    ssize_t ret;
>> +    u32 x;
>> +
>> +    ret = opal_get_sensor_data(sdata->id, &x);
>> +    if (ret) {
>> +        pr_err("%s: Failed to get opal sensor data\n", __func__);
>> +        return ret;
>> +    }
>> +
>> +    /* Convert temperature to milli-degrees */
>> +    if (sdata->type == AMBIENT_TEMP)
>> +        x *= 1000;
>> +    /* Convert power to micro-watts */
>> +    else if (sdata->type == POWER_INPUT)
>> +        x *= 1000000;
>> +
>> +    return sprintf(buf, "%d\n", x);
>
> x is unsigned, so %u.

Done.

>
>> +}
>> +
>> +static void __init get_sensor_index_attr(const char *name, u32 
>> *index, char *attr)
>> +{
>> +    char *hash_pos = strchr(name, '#');
>> +    char *dash_pos;
>> +    u32 copy_len;
>> +    char buf[8];
>> +
>> +    memset(buf, 0, sizeof(buf));
>> +    *index = 0;
>> +    *attr = '\0';
>> +
>> +    if (hash_pos) {
>> +        dash_pos = strchr(hash_pos, '-');
>> +        if (dash_pos) {
>> +            copy_len = dash_pos - hash_pos - 1;
>> +            if (copy_len < sizeof(buf)) {
>> +                strncpy(buf, hash_pos + 1, copy_len);
>> +                sscanf(buf, "%d", index);
>
> What if sscanf fails ? Might be an interesting exercise to try and create
> multiple sensors with index 0 (or, for that matter, with the same 
> index value).
> Do you have any protection against bad input data ? Guess not; did you 
> test
> what happens if you pass bad data to the driver (such as duplicate sensor
> entries) ?

Well, rewriting this function to return the error code if fails.
Next version will cover these test cases covered. Thanks.

>
>> +            }
>> +
>> +            strncpy(attr, dash_pos + 1, MAX_ATTR_LEN);
>> +        }
>> +    }
>> +}
>> +
>> +/*
>> + * This function translates the DT node name into the 'hwmon' 
>> attribute name.
>> + * IBMPOWERNV device node appear like cooling-fan#2-data, 
>> amb-temp#1-thrs etc.
>> + * which need to be mapped as fan2_input, temp1_max respectively before
>> + * populating them inside hwmon device class..
>> + */
>> +static int __init create_hwmon_attr_name(enum sensors type, const 
>> char *node_name,
>> +                  char *hwmon_attr_name)
>> +{
>> +    char attr_suffix[MAX_ATTR_LEN];
>> +    char *attr_name;
>> +    u32 index;
>> +
>> +    get_sensor_index_attr(node_name, &index, attr_suffix);
>> +    if (!index || !strlen(attr_suffix)) {
>> +        pr_info("%s: Sensor device node name is invalid, name: %s\n",
>> +                __func__, node_name);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!strcmp(attr_suffix, DT_FAULT_ATTR_SUFFIX))
>> +        attr_name = "fault";
>> +    else if(!strcmp(attr_suffix, DT_DATA_ATTR_SUFFIX))
>> +        attr_name = "input";
>> +    else if (!strcmp(attr_suffix, DT_THRESHOLD_ATTR_SUFFIX)) {
>> +        if (type == AMBIENT_TEMP)
>> +            attr_name = "max";
>> +        else if (type == FAN)
>> +            attr_name = "min";
>> +        else
>> +            return -ENOENT;
>> +    } else
>> +        return -ENOENT;
>> +
>> +    snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
>> +            sensor_groups[type].name, index, attr_name);
>> +    return 0;
>> +}
>> +
>> +static int __init populate_attr_groups(struct platform_device *pdev)
>> +{
>> +    struct platform_data *pdata = platform_get_drvdata(pdev);
>> +    const struct attribute_group **pgroups = pdata->attr_groups;
>> +    struct device_node *opal, *np;
>> +    enum sensors type;
>> +    int err = 0;
>> +
>> +    opal = of_find_node_by_path("/ibm,opal/sensors");
>> +        if (!opal) {
>
> An obvious whitespace error here.
>
>> +        pr_err("%s: Opal 'sensors' node not found\n", __func__);
>> +        return -ENODEV;
>> +        }
>> +
>> +    for_each_child_of_node(opal, np) {
>> +        if (np->name == NULL)
>> +            continue;
>> +
>> +        for (type = 0; type < MAX_SENSOR_TYPE; type++)
>> +            if (of_device_is_compatible(np,
>> +                sensor_groups[type].compatible)) {
>> +                sensor_groups[type].attr_count++;
>> +                break;
>> +            }
>> +    }
>
> You should be able to do
>     of_node_put(opal);
>
> here. Then you can return immediately on error below.

Done.

>
>> +
>> +    for (type = 0; type < MAX_SENSOR_TYPE; type++) {
>> +        if (!sensor_groups[type].attr_count)
>> +            continue;
>> +
>> +        sensor_groups[type].group.attrs = devm_kzalloc(&pdev->dev,
>> +                    sizeof(struct attribute*) *
>> +                    (sensor_groups[type].attr_count + 1),
>> +                    GFP_KERNEL);
>> +        if (!sensor_groups[type].group.attrs) {
>> +            pr_err("%s: Failed to allocate memory for attribute"
>> +                    "array\n", __func__);
>
> devm_kzalloc() already dumps an error message. Same for all other 
> memory error messages.
>
>> +            err = -ENOMEM;
>> +            goto exit_put_node;
>> +        }
>> +
>> +        pgroups[type] = &sensor_groups[type].group;
>> +        pdata->sensors_count += sensor_groups[type].attr_count;
>> +        sensor_groups[type].attr_count = 0;
>> +    }
>> +
>> +exit_put_node:
>> +    of_node_put(opal);
>> +    return err;
>> +}
>> +
>> +/*
>> + * Iterate through the device tree for each child of sensor node, 
>> create
>> + * a sysfs attribute file, the file is named by translating the DT 
>> node name
>> + * to the name required by the higher 'hwmon' driver like 
>> fan1_input, temp1_max
>> + * etc..
>> + */
>> +static int __init create_device_attrs(struct platform_device *pdev)
>> +{
>> +    struct platform_data *pdata = platform_get_drvdata(pdev);
>> +    const struct attribute_group **pgroups = pdata->attr_groups;
>> +    struct device_node *opal, *np;
>> +    struct sensor_data *sdata;
>> +    const u32 *sensor_id;
>> +    enum sensors type;
>> +    u32 count = 0;
>> +    int err = 0;
>> +
>> +    opal = of_find_node_by_path("/ibm,opal/sensors");
>> +        if (!opal) {
>> +        pr_err("%s: Opal 'sensors' node not found\n", __func__);
>> +        return -ENODEV;
>> +        }
>> +
>> +    sdata = devm_kzalloc(&pdev->dev, (pdata->sensors_count) *
>> +                 sizeof(*sdata), GFP_KERNEL);
>> +    if (!sdata) {
>> +        pr_err("%s: Failed to allocate memory for the sensor_data",
>> +                __func__);
>> +        err = -ENOMEM;
>> +        goto exit_put_node;
>> +    }
>> +
>> +    for_each_child_of_node(opal, np) {
>> +                if (np->name == NULL)
>> +                        continue;
>> +
>> +        for (type = 0; type < MAX_SENSOR_TYPE; type++)
>> +            if (of_device_is_compatible(np,
>> +                    sensor_groups[type].compatible))
>> +                break;
>> +
>> +        if (type == MAX_SENSOR_TYPE)
>> +            continue;
>> +
>> +        sensor_id = of_get_property(np, "sensor-id", NULL);
>> +        if (!sensor_id) {
>> +            pr_info("%s: %s doesn't have sensor-id\n", __func__,
>> +                np->name);
>> +            continue;
>> +        }
>> +
> Consider using of_property_read_u32().

Okay.

>
>> +        sdata[count].id = *sensor_id;
>> +        sdata[count].type = type;
>> +        err = create_hwmon_attr_name(type, np->name, 
>> sdata[count].name);
>> +        if (err)
>> +            goto exit_put_node;
>> +
>> +        sysfs_attr_init(&sdata[count].dev_attr.attr);
>> +        sdata[count].dev_attr.attr.name = sdata[count].name;
>> +        sdata[count].dev_attr.attr.mode = S_IRUGO;
>> +        sdata[count].dev_attr.show = show_sensor;
>> +
>> + pgroups[type]->attrs[sensor_groups[type].attr_count++] =
>> +                &sdata[count++].dev_attr.attr;
>> +    }
>> +
>> +exit_put_node:
>> +    of_node_put(opal);
>> +    return err;
>> +}
>> +
>> +static int __init ibmpowernv_probe(struct platform_device *pdev)
>> +{
>> +    struct platform_data *pdata;
>> +    struct device *hwmon_dev;
>> +    int err;
>> +
>> +    pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> +    if (!pdata)
>> +        return -ENOMEM;
>> +
>> +    platform_set_drvdata(pdev, pdata);
>> +    pdata->sensors_count = 0;
>> +    err = populate_attr_groups(pdev);
>> +    if (err)
>> +        return err;
>> +
>> +    /* Create sysfs attribute file for each sensor found in the DT */
>
> Attribute data, not file
>
>> +    err = create_device_attrs(pdev);
>> +    if (err)
>> +        return err;
>> +
>> +    /* Finally, register with hwmon */
>> +    hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev, 
>> DRVNAME,
>> +                               pdata,
>> +                               pdata->attr_groups);
>> +
>> +    return PTR_ERR_OR_ZERO(hwmon_dev);
>> +}
>> +
>> +static struct platform_driver ibmpowernv_driver = {
>> +    .driver = {
>> +        .owner = THIS_MODULE,
>> +        .name = DRVNAME,
>> +    },
>> +};
>> +
>> +static int __init ibmpowernv_init(void)
>> +{
>> +    int err;
>> +
>> +    pdevice = platform_device_alloc(DRVNAME, 0);
>> +    if (!pdevice) {
>> +        pr_err("%s: Device allocation failed\n", __func__);
>> +        err = -ENOMEM;
>> +        goto exit;
>> +    }
>> +
>> +    err = platform_device_add(pdevice);
>> +    if (err) {
>> +        pr_err("%s: Device addition failed (%d)\n", __func__, err);
>> +        goto exit_device_put;
>> +    }
>> +
>> +    err = platform_driver_probe(&ibmpowernv_driver, ibmpowernv_probe);
>> +    if (err) {
>> +        pr_err("%s: Platfrom driver probe failed\n", __func__);
>> +        goto exit_device_del;
>> +    }
>> +
>> +    return 0;
>> +
>> +exit_device_del:
>> +    platform_device_del(pdevice);
>> +exit_device_put:
>> +    platform_device_put(pdevice);
>> +exit:
>> +    return err;
>> +}
>> +
>> +static void __exit ibmpowernv_exit(void)
>> +{
>> +    platform_driver_unregister(&ibmpowernv_driver);
>> +    platform_device_unregister(pdevice);
>> +}
>> +
>> +MODULE_AUTHOR("Neelesh Gupta <neelegup@linux.vnet.ibm.com>");
>> +MODULE_DESCRIPTION("IBM POWERNV platform sensors");
>> +MODULE_LICENSE("GPL");
>> +
>> +module_init(ibmpowernv_init);
>> +module_exit(ibmpowernv_exit);
>>
>>
>>
>
