Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M4lK068LzF1g6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 03:35:56 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w65HYQoj051022
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2018 13:35:54 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k1qa7sd1b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 13:35:53 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 5 Jul 2018 18:35:51 +0100
Subject: Re: [PATCH v3 2/3] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
To: Guenter Roeck <linux@roeck-us.net>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
References: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530798689-27742-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <9b55f78a-1d29-4391-c43e-124772b7aa9f@roeck-us.net>
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Thu, 5 Jul 2018 23:05:42 +0530
MIME-Version: 1.0
In-Reply-To: <9b55f78a-1d29-4391-c43e-124772b7aa9f@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Message-Id: <d1c00dde-2d1f-5748-a306-f646ae265f8f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 07/05/2018 09:07 PM, Guenter Roeck wrote:
> On 07/05/2018 06:51 AM, Shilpasri G Bhat wrote:
>> On-Chip-Controller(OCC) is an embedded micro-processor in POWER9 chip
>> which measures various system and chip level sensors. These sensors
>> comprises of environmental sensors (like power, temperature, current
>> and voltage) and performance sensors (like utilization, frequency).
>> All these sensors are copied to main memory at a regular interval of
>> 100ms. OCC provides a way to select a group of sensors that is copied
>> to the main memory to increase the update frequency of selected sensor
>> groups. When a sensor-group is disabled, OCC will not copy it to main
>> memory and those sensors read 0 values.
>>
>> This patch provides support for enabling/disabling the sensor groups
>> like power, temperature, current and voltage. This patch adds new
>> per-senor sysfs attribute to disable and enable them.
>>
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>> Changes from v2:
>> - Writes to first 'enable' attribute of the sensor group will affect all the
>>    sensors in the group
>> - Removed global mutex and made it per sensor-group
>>
>>   drivers/hwmon/ibmpowernv.c | 184 ++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 155 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
>> index f829dad..9c6adee 100644
>> --- a/drivers/hwmon/ibmpowernv.c
>> +++ b/drivers/hwmon/ibmpowernv.c
>> @@ -73,6 +73,10 @@ enum sensors {
>>       struct attribute_group group;
>>       u32 attr_count;
>>       u32 hwmon_index;
>> +    struct mutex mutex;
>> +    u32 *gid;
>> +    u32 nr_gid;
>> +    bool enable;
>>   } sensor_groups[] = {
>>       { "fan"   },
>>       { "temp"  },
>> @@ -105,6 +109,9 @@ static ssize_t show_sensor(struct device *dev, struct
>> device_attribute *devattr,
>>       ssize_t ret;
>>       u64 x;
>>   +    if (!sensor_groups[sdata->type].enable)
>> +        return -ENODATA;
>> +
>>       ret =  opal_get_sensor_data_u64(sdata->id, &x);
>>         if (ret)
>> @@ -120,6 +127,46 @@ static ssize_t show_sensor(struct device *dev, struct
>> device_attribute *devattr,
>>       return sprintf(buf, "%llu\n", x);
>>   }
>>   +static ssize_t show_enable(struct device *dev,
>> +               struct device_attribute *devattr, char *buf)
>> +{
>> +    struct sensor_data *sdata = container_of(devattr, struct sensor_data,
>> +                         dev_attr);
>> +
>> +    return sprintf(buf, "%u\n", sensor_groups[sdata->type].enable);
>> +}
>> +
>> +static ssize_t store_enable(struct device *dev,
>> +                struct device_attribute *devattr,
>> +                const char *buf, size_t count)
>> +{
>> +    struct sensor_data *sdata = container_of(devattr, struct sensor_data,
>> +                         dev_attr);
>> +    struct sensor_group *sg = &sensor_groups[sdata->type];
>> +    int ret, i;
>> +    bool data;
>> +
>> +    ret = kstrtobool(buf, &data);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = mutex_lock_interruptible(&sg->mutex);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (data != sg->enable)
>> +        for (i = 0; i < sg->nr_gid && !ret; i++)
>> +            ret =  sensor_group_enable(sg->gid[i], data);
>> +
> 
> Wouldn't it be better to have a separate attribute for each of the
> affected groups if there can be more than one ? Just wondering.
> 
> The idea was to widen the scope to a point where there is a 1:1 match
> between the hardware capabilities and attributes. Clearly having
> a separate attribute for all sensors was inappropriate, but the code
> above now suggests that a single attribute for all sensors may have
> widened the scope too much (because the hardware can do better than
> this).
> 

Yup it would be better to have 'enable' attribute for each sub-group.

Thanks and Regards,
Shilpa

> Thanks,
> Guenter
> 
>> +    if (!ret) {
>> +        sg->enable = data;
>> +        ret = count;
>> +    }
>> +
>> +    mutex_unlock(&sg->mutex);
>> +    return ret;
>> +}
>> +
>>   static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
>>                 char *buf)
>>   {
>> @@ -292,13 +339,68 @@ static u32 get_sensor_hwmon_index(struct sensor_data
>> *sdata,
>>       return ++sensor_groups[sdata->type].hwmon_index;
>>   }
>>   +static int init_sensor_group_data(struct platform_device *pdev)
>> +{
>> +    struct device_node *groups, *sg;
>> +    enum sensors type;
>> +    int ret = 0, i;
>> +
>> +    for (i = 0; i < MAX_SENSOR_TYPE; i++) {
>> +        sensor_groups[i].nr_gid = 0;
>> +        sensor_groups[i].enable = true;
>> +    }
>> +
>> +    groups = of_find_node_by_path("/ibm,opal/sensor-groups");
>> +    if (!groups)
>> +        return ret;
>> +
>> +    for (i = 0; i < MAX_SENSOR_TYPE; i++) {
>> +        u32 gid[256];
>> +        u32 id, size;
>> +
>> +        for_each_child_of_node(groups, sg) {
>> +            type = get_sensor_type(sg);
>> +            if (type != i)
>> +                continue;
>> +
>> +            if (of_property_read_u32(sg, "sensor-group-id", &id))
>> +                continue;
>> +
>> +            gid[sensor_groups[i].nr_gid++] = id;
>> +        }
>> +
>> +        if (!sensor_groups[i].nr_gid)
>> +            continue;
>> +
>> +        size = sensor_groups[i].nr_gid * sizeof(u32);
>> +        sensor_groups[i].gid = devm_kzalloc(&pdev->dev, size,
>> +                            GFP_KERNEL);
>> +        if (!sensor_groups[i].gid) {
>> +            ret = -ENOMEM;
>> +            break;
>> +        }
>> +
>> +        memcpy(sensor_groups[i].gid, gid, size);
>> +        sensor_groups[i].enable = false;
>> +        mutex_init(&sensor_groups[i].mutex);
>> +    }
>> +
>> +    of_node_put(groups);
>> +    return ret;
>> +}
>> +
>>   static int populate_attr_groups(struct platform_device *pdev)
>>   {
>>       struct platform_data *pdata = platform_get_drvdata(pdev);
>>       const struct attribute_group **pgroups = pdata->attr_groups;
>>       struct device_node *opal, *np;
>> +    int ret;
>>       enum sensors type;
>>   +    ret = init_sensor_group_data(pdev);
>> +    if (ret)
>> +        return ret;
>> +
>>       opal = of_find_node_by_path("/ibm,opal/sensors");
>>       for_each_child_of_node(opal, np) {
>>           const char *label;
>> @@ -313,7 +415,7 @@ static int populate_attr_groups(struct platform_device *pdev)
>>           sensor_groups[type].attr_count++;
>>             /*
>> -         * add attributes for labels, min and max
>> +         * add attributes for labels, min, max and enable
>>            */
>>           if (!of_property_read_string(np, "label", &label))
>>               sensor_groups[type].attr_count++;
>> @@ -321,6 +423,8 @@ static int populate_attr_groups(struct platform_device *pdev)
>>               sensor_groups[type].attr_count++;
>>           if (of_find_property(np, "sensor-data-max", NULL))
>>               sensor_groups[type].attr_count++;
>> +        if (sensor_groups[type].nr_gid)
>> +            sensor_groups[type].attr_count++;
>>       }
>>         of_node_put(opal);
>> @@ -344,7 +448,10 @@ static int populate_attr_groups(struct platform_device
>> *pdev)
>>   static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
>>                     ssize_t (*show)(struct device *dev,
>>                             struct device_attribute *attr,
>> -                          char *buf))
>> +                          char *buf),
>> +                ssize_t (*store)(struct device *dev,
>> +                         struct device_attribute *attr,
>> +                         const char *buf, size_t count))
>>   {
>>       snprintf(sdata->name, MAX_ATTR_LEN, "%s%d_%s",
>>            sensor_groups[sdata->type].name, sdata->hwmon_index,
>> @@ -352,8 +459,13 @@ static void create_hwmon_attr(struct sensor_data *sdata,
>> const char *attr_name,
>>         sysfs_attr_init(&sdata->dev_attr.attr);
>>       sdata->dev_attr.attr.name = sdata->name;
>> -    sdata->dev_attr.attr.mode = S_IRUGO;
>>       sdata->dev_attr.show = show;
>> +    if (store) {
>> +        sdata->dev_attr.store = store;
>> +        sdata->dev_attr.attr.mode = 0664;
>> +    } else {
>> +        sdata->dev_attr.attr.mode = 0444;
>> +    }
>>   }
>>     static void populate_sensor(struct sensor_data *sdata, int od, int hd, int
>> sid,
>> @@ -361,13 +473,16 @@ static void populate_sensor(struct sensor_data *sdata,
>> int od, int hd, int sid,
>>                   const struct attribute_group *pgroup,
>>                   ssize_t (*show)(struct device *dev,
>>                           struct device_attribute *attr,
>> -                        char *buf))
>> +                        char *buf),
>> +                ssize_t (*store)(struct device *dev,
>> +                         struct device_attribute *attr,
>> +                         const char *buf, size_t count))
>>   {
>>       sdata->id = sid;
>>       sdata->type = type;
>>       sdata->opal_index = od;
>>       sdata->hwmon_index = hd;
>> -    create_hwmon_attr(sdata, attr_name, show);
>> +    create_hwmon_attr(sdata, attr_name, show, store);
>>       pgroup->attrs[sensor_groups[type].attr_count++] = &sdata->dev_attr.attr;
>>   }
>>   @@ -408,18 +523,16 @@ static int create_device_attrs(struct platform_device
>> *pdev)
>>       u32 count = 0;
>>       int err = 0;
>>   -    opal = of_find_node_by_path("/ibm,opal/sensors");
>>       sdata = devm_kcalloc(&pdev->dev,
>>                    pdata->sensors_count, sizeof(*sdata),
>>                    GFP_KERNEL);
>> -    if (!sdata) {
>> -        err = -ENOMEM;
>> -        goto exit_put_node;
>> -    }
>> +    if (!sdata)
>> +        return -ENOMEM;
>>   +    opal = of_find_node_by_path("/ibm,opal/sensors");
>>       for_each_child_of_node(opal, np) {
>>           const char *attr_name;
>> -        u32 opal_index;
>> +        u32 opal_index, hw_id;
>>           const char *label;
>>             if (np->name == NULL)
>> @@ -456,14 +569,11 @@ static int create_device_attrs(struct platform_device
>> *pdev)
>>               opal_index = INVALID_INDEX;
>>           }
>>   -        sdata[count].opal_index = opal_index;
>> -        sdata[count].hwmon_index =
>> -            get_sensor_hwmon_index(&sdata[count], sdata, count);
>> -
>> -        create_hwmon_attr(&sdata[count], attr_name, show_sensor);
>> -
>> -        pgroups[type]->attrs[sensor_groups[type].attr_count++] =
>> -                &sdata[count++].dev_attr.attr;
>> +        hw_id = get_sensor_hwmon_index(&sdata[count], sdata, count);
>> +        populate_sensor(&sdata[count], opal_index, hw_id, sensor_id,
>> +                attr_name, type, pgroups[type], show_sensor,
>> +                NULL);
>> +        count++;
>>             if (!of_property_read_string(np, "label", &label)) {
>>               /*
>> @@ -474,33 +584,49 @@ static int create_device_attrs(struct platform_device
>> *pdev)
>>                */
>>                 make_sensor_label(np, &sdata[count], label);
>> -            populate_sensor(&sdata[count], opal_index,
>> -                    sdata[count - 1].hwmon_index,
>> +            populate_sensor(&sdata[count], opal_index, hw_id,
>>                       sensor_id, "label", type, pgroups[type],
>> -                    show_label);
>> +                    show_label, NULL);
>>               count++;
>>           }
>>             if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
>>               attr_name = get_max_attr(type);
>> -            populate_sensor(&sdata[count], opal_index,
>> -                    sdata[count - 1].hwmon_index,
>> +            populate_sensor(&sdata[count], opal_index, hw_id,
>>                       sensor_id, attr_name, type,
>> -                    pgroups[type], show_sensor);
>> +                    pgroups[type], show_sensor, NULL);
>>               count++;
>>           }
>>             if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
>>               attr_name = get_min_attr(type);
>> -            populate_sensor(&sdata[count], opal_index,
>> -                    sdata[count - 1].hwmon_index,
>> +            populate_sensor(&sdata[count], opal_index, hw_id,
>>                       sensor_id, attr_name, type,
>> -                    pgroups[type], show_sensor);
>> +                    pgroups[type], show_sensor, NULL);
>>               count++;
>>           }
>> +
>> +        if (sensor_groups[type].nr_gid) {
>> +            ssize_t (*store)(struct device *dev,
>> +                     struct device_attribute *attr,
>> +                     const char *buf, size_t count);
>> +
>> +            if (!sensor_groups[type].enable) {
>> +                sensor_groups[type].enable = true;
>> +                store = store_enable;
>> +            } else {
>> +                store = NULL;
>> +            }
>> +
>> +            sensor_groups[type].enable = true;
>> +            populate_sensor(&sdata[count], opal_index, hw_id,
>> +                    sensor_id, "enable", type,
>> +                    pgroups[type], show_enable, store);
>> +            count++;
>> +        }
>> +
>>       }
>>   -exit_put_node:
>>       of_node_put(opal);
>>       return err;
>>   }
>>
> 
