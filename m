Return-Path: <groeck7@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LQbk3lWzzF1Dg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 01:57:05 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y24-v6so2947863pfe.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 08:57:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
References: <1530695793-4584-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530695793-4584-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e3a013fb-eaf0-8d45-2f23-3be8b3e5640b@roeck-us.net>
Date: Wed, 4 Jul 2018 07:46:32 -0700
MIME-Version: 1.0
In-Reply-To: <1530695793-4584-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2018 02:16 AM, Shilpasri G Bhat wrote:
> On-Chip-Controller(OCC) is an embedded micro-processor in POWER9 chip
> which measures various system and chip level sensors. These sensors
> comprises of environmental sensors (like power, temperature, current
> and voltage) and performance sensors (like utilization, frequency).
> All these sensors are copied to main memory at a regular interval of
> 100ms. OCC provides a way to select a group of sensors that is copied
> to the main memory to increase the update frequency of selected sensor
> groups. When a sensor-group is disabled, OCC will not copy it to main
> memory and those sensors read 0 values.
> 
> This patch provides support for enabling/disabling the sensor groups
> like power, temperature, current and voltage. This patch adds new
> per-senor sysfs attribute to disable and enable them.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from v1:
> - Add per-sensor 'enable' attribute
> - Return -ENODATA when sensor is disabled
> 
>   Documentation/hwmon/sysfs-interface |  22 +++
>   drivers/hwmon/ibmpowernv.c          | 281 +++++++++++++++++++++++++++++++-----
>   2 files changed, 264 insertions(+), 39 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index fc337c3..38ab05c 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface

Separate patch please.

> @@ -184,6 +184,11 @@ vrm		Voltage Regulator Module version number.
>   		Affects the way the driver calculates the CPU core reference
>   		voltage from the vid pins.
>   
> +in[0-*]_enable	Enable or disable the sensor
> +		1 : Enable
> +		0 : Disable
> +		RW
> +
>   Also see the Alarms section for status flags associated with voltages.
>   
>   
> @@ -409,6 +414,12 @@ temp_reset_history
>   		Reset temp_lowest and temp_highest for all sensors
>   		WO
>   
> +temp[1-*]_enable
> +		Enable or disable the sensor
> +		1 : Enable
> +		0 : Disable > +		RW
> +
>   Some chips measure temperature using external thermistors and an ADC, and
>   report the temperature measurement as a voltage. Converting this voltage
>   back to a temperature (or the other way around for limits) requires
> @@ -468,6 +479,12 @@ curr_reset_history
>   		Reset currX_lowest and currX_highest for all sensors
>   		WO
>   
> +curr[1-*]_enable
> +		Enable or disable the sensor
> +		1 : Enable
> +		0 : Disable
> +		RW
> +
>   Also see the Alarms section for status flags associated with currents.
>   
>   *********
> @@ -566,6 +583,11 @@ power[1-*]_crit			Critical maximum power.
>   				Unit: microWatt
>   				RW
>   
> +power[1-*]_enable		Enable or disable the sensor
> +				1 : Enable
> +				0 : Disable
> +				RW
> +
>   Also see the Alarms section for status flags associated with power readings.
>   

Any reason for excluding fan, energy, humidity ?

>   **********
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index f829dad..61e04cf 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -90,8 +90,28 @@ struct sensor_data {
>   	char label[MAX_LABEL_LEN];
>   	char name[MAX_ATTR_LEN];
>   	struct device_attribute dev_attr;
> +	struct sensor_group_data *sgdata;
> +	struct sensor_data *sdata[3];
> +	bool enable;
>   };
>   
> +static struct sensor_group_data {
> +	u32 gid;
> +	u32 nr_phandle;
> +	u32 nr_sensor;
> +	enum sensors type;
> +	const __be32 *phandles;
> +	struct sensor_data **sensors;
> +	bool enable;
> +} *sg_data;
> +
> +/*
> + * To synchronise writes to struct sensor_data.enable and
> + * struct sensor_group_data.enable
> + */
> +DEFINE_MUTEX(sensor_groups_mutex);

Not as global variable, please.

> +static int nr_sensor_groups;
> +

Do those have to be static variables ? Why not in struct platform_data ?

>   struct platform_data {
>   	const struct attribute_group *attr_groups[MAX_SENSOR_TYPE + 1];
>   	u32 sensors_count; /* Total count of sensors from each group */
> @@ -105,6 +125,9 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>   	ssize_t ret;
>   	u64 x;
>   
> +	if (sdata->sgdata && !sdata->enable)
> +		return -ENODATA;
> +

This return code should be documented in the ABI.

>   	ret =  opal_get_sensor_data_u64(sdata->id, &x);
>   
>   	if (ret)
> @@ -120,6 +143,74 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
>   	return sprintf(buf, "%llu\n", x);
>   }
>   
> +static ssize_t show_enable(struct device *dev,
> +			   struct device_attribute *devattr, char *buf)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +
> +	return sprintf(buf, "%u\n", sdata->enable);
> +}
> +
> +static ssize_t store_enable(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +	struct sensor_group_data *sg = sdata->sgdata;
> +	u32 data;
> +	int ret, i;
> +	bool send_command;
> +
> +	ret = kstrtoint(buf, 0, &data);

Use kstrtobool(), please. Then you won't need the additional range check below.

> +	if (ret)
> +		return ret;
> +
> +	if (data != 0 && data != 1)
> +		return -EIO;

This is not an IO error.

> +
> +	ret = mutex_lock_interruptible(&sensor_groups_mutex);
> +	if (ret)
> +		return ret;
> +
> +	sdata->enable = data;
> +	if ((data && sg->enable) || (!data && !sg->enable)) {
> +		send_command = false;

If data is bool you can use a simple comparison.

> +	} else if (data && !sg->enable) {

!sg->enable is unnecessary.

> +		/* Enable if first sensor in the group */
> +		send_command = true; > +	} else if (!data && sg->enable) {

This if statement is always true and thus unnecessary.

Overall, you could use

	send_command = data != sg->enable;
	if (send_command && !data) {
		for (...) {

> +		/* Disable if last sensor in the group */
> +		send_command = true;
> +		for (i = 0; i < sg->nr_sensor; i++) {
> +			struct sensor_data *sd = sg->sensors[i];
> +
> +			if (sd->enable) {
> +				send_command = false;
> +				break;
> +			}

This is weird. So there are situations where a request to disable
a sensor is accepted, but effectively ignored ? Shouldn't that
return, say, -EBUSY ?

> +		}
> +	}
> +
> +	if (send_command) {
> +		ret =  sensor_group_enable(sg->gid, data);
> +		if (!ret)
> +			sg->enable = data;
> +	}
> +
> +	if (!ret) {
> +		for (i = 0; i < ARRAY_SIZE(sdata->sdata); i++)
> +			sdata->sdata[i]->enable = data;
> +		ret = count;
> +	} else {
> +		ret = -EIO;

No overriding error codes, please.

> +	}
> +
> +	mutex_unlock(&sensor_groups_mutex);
> +	return ret;
> +}
> +
>   static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
>   			  char *buf)
>   {
> @@ -292,6 +383,90 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
>   	return ++sensor_groups[sdata->type].hwmon_index;
>   }
>   
> +static int init_sensor_group_data(struct platform_device *pdev)
> +{
> +	struct device_node *sensor_groups, *sg;
> +	enum sensors type;
> +	int count = 0, ret = 0;
> +
> +	sensor_groups = of_find_node_by_path("/ibm,opal/sensor-groups");
> +	if (!sensor_groups)
> +		return ret;
> +
> +	for_each_child_of_node(sensor_groups, sg) {
> +		type = get_sensor_type(sg);
> +		if (type != MAX_SENSOR_TYPE)
> +			nr_sensor_groups++;
> +	}
> +
> +	if (!nr_sensor_groups)
> +		goto out;
> +
> +	sg_data = devm_kzalloc(&pdev->dev, nr_sensor_groups * sizeof(*sg_data),
> +			       GFP_KERNEL);
> +	if (!sg_data) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for_each_child_of_node(sensor_groups, sg) {
> +		const __be32 *phandles;
> +		int len, gid;
> +
> +		type = get_sensor_type(sg);
> +		if (type == MAX_SENSOR_TYPE)
> +			continue;
> +
> +		if (of_property_read_u32(sg, "sensor-group-id", &gid))
> +			continue;
> +
> +		phandles = of_get_property(sg, "sensors", &len);
> +		if (!phandles)
> +			continue;
> +
> +		len /= sizeof(u32);
> +		if (!len)
> +			continue;
> +
> +		sg_data[count].sensors = devm_kzalloc(&pdev->dev,
> +					    len * sizeof(struct sensor_data *),
> +					    GFP_KERNEL);
> +		if (!sg_data[count].sensors) {
> +			ret = -ENOMEM;
> +			break;

Doesn't this result in a missing of_node_put() on sg ?

> +		}
> +
> +		sg_data[count].nr_sensor = 0;
> +		sg_data[count].gid = gid;
> +		sg_data[count].type = type;
> +		sg_data[count].nr_phandle = len;
> +		sg_data[count].phandles = phandles;
> +		sg_data[count++].enable = true;
> +	}
> +out:
> +	of_node_put(sensor_groups);
> +	return ret;
> +}
> +
> +static struct sensor_group_data *get_sensor_group(struct device_node *np,
> +						  enum sensors type)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < nr_sensor_groups; i++) {
> +		const __be32 *phandles = sg_data[i].phandles;
> +
> +		if (type != sg_data[i].type)
> +			continue;
> +
> +		for (j = 0; j < sg_data[i].nr_phandle; j++)
> +			if (be32_to_cpu(phandles[j]) == np->phandle)
> +				return &sg_data[i];
> +	}
> +
> +	return NULL;
> +}
> +
>   static int populate_attr_groups(struct platform_device *pdev)
>   {
>   	struct platform_data *pdata = platform_get_drvdata(pdev);
> @@ -299,6 +474,9 @@ static int populate_attr_groups(struct platform_device *pdev)
>   	struct device_node *opal, *np;
>   	enum sensors type;
>   
> +	if (init_sensor_group_data(pdev))
> +		return -ENOMEM;
> +

init_sensor_group_data() returns an error code which you should pass on.

>   	opal = of_find_node_by_path("/ibm,opal/sensors");
>   	for_each_child_of_node(opal, np) {
>   		const char *label;
> @@ -313,7 +491,7 @@ static int populate_attr_groups(struct platform_device *pdev)
>   		sensor_groups[type].attr_count++;
>   
>   		/*
> -		 * add attributes for labels, min and max
> +		 * add attributes for labels, min, max and enable
>   		 */
>   		if (!of_property_read_string(np, "label", &label))
>   			sensor_groups[type].attr_count++;
> @@ -321,6 +499,8 @@ static int populate_attr_groups(struct platform_device *pdev)
>   			sensor_groups[type].attr_count++;
>   		if (of_find_property(np, "sensor-data-max", NULL))
>   			sensor_groups[type].attr_count++;
> +		if (get_sensor_group(np, type))
> +			sensor_groups[type].attr_count++;
>   	}
>   
>   	of_node_put(opal);
> @@ -344,7 +524,10 @@ static int populate_attr_groups(struct platform_device *pdev)
>   static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
>   			      ssize_t (*show)(struct device *dev,
>   					      struct device_attribute *attr,
> -					      char *buf))
> +					      char *buf),
> +			    ssize_t (*store)(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t count))
>   {
>   	snprintf(sdata->name, MAX_ATTR_LEN, "%s%d_%s",
>   		 sensor_groups[sdata->type].name, sdata->hwmon_index,
> @@ -352,23 +535,34 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
>   
>   	sysfs_attr_init(&sdata->dev_attr.attr);
>   	sdata->dev_attr.attr.name = sdata->name;
> -	sdata->dev_attr.attr.mode = S_IRUGO;
>   	sdata->dev_attr.show = show;
> +	if (store) {
> +		sdata->dev_attr.store = store;
> +		sdata->dev_attr.attr.mode = 0664;
> +	} else {
> +		sdata->dev_attr.attr.mode = 0444;
> +	}
>   }
>   
>   static void populate_sensor(struct sensor_data *sdata, int od, int hd, int sid,
>   			    const char *attr_name, enum sensors type,
>   			    const struct attribute_group *pgroup,
> +			    struct sensor_group_data *sgdata,
>   			    ssize_t (*show)(struct device *dev,
>   					    struct device_attribute *attr,
> -					    char *buf))
> +					    char *buf),
> +			    ssize_t (*store)(struct device *dev,
> +					     struct device_attribute *attr,
> +					     const char *buf, size_t count))
>   {
>   	sdata->id = sid;
>   	sdata->type = type;
>   	sdata->opal_index = od;
>   	sdata->hwmon_index = hd;
> -	create_hwmon_attr(sdata, attr_name, show);
> +	create_hwmon_attr(sdata, attr_name, show, store);
>   	pgroup->attrs[sensor_groups[type].attr_count++] = &sdata->dev_attr.attr;
> +	sdata->enable = true;
> +	sdata->sgdata = sgdata;
>   }
>   
>   static char *get_max_attr(enum sensors type)
> @@ -408,18 +602,17 @@ static int create_device_attrs(struct platform_device *pdev)
>   	u32 count = 0;
>   	int err = 0;
>   
> -	opal = of_find_node_by_path("/ibm,opal/sensors");
>   	sdata = devm_kcalloc(&pdev->dev,
>   			     pdata->sensors_count, sizeof(*sdata),
>   			     GFP_KERNEL);
> -	if (!sdata) {
> -		err = -ENOMEM;
> -		goto exit_put_node;
> -	}
> +	if (!sdata)
> +		return -ENOMEM;
>   
> +	opal = of_find_node_by_path("/ibm,opal/sensors");
>   	for_each_child_of_node(opal, np) {
> +		struct sensor_group_data *sgdata;
>   		const char *attr_name;
> -		u32 opal_index;
> +		u32 opal_index, hw_id;
>   		const char *label;
>   
>   		if (np->name == NULL)
> @@ -456,14 +649,43 @@ static int create_device_attrs(struct platform_device *pdev)
>   			opal_index = INVALID_INDEX;
>   		}
>   
> -		sdata[count].opal_index = opal_index;
> -		sdata[count].hwmon_index =
> -			get_sensor_hwmon_index(&sdata[count], sdata, count);
> +		hw_id = get_sensor_hwmon_index(&sdata[count], sdata, count);
> +		sgdata = get_sensor_group(np, type);
> +		populate_sensor(&sdata[count], opal_index, hw_id, sensor_id,
> +				attr_name, type, pgroups[type], sgdata,
> +				show_sensor, NULL);
> +		count++;
> +
> +		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
> +			attr_name = get_max_attr(type);
> +			populate_sensor(&sdata[count], opal_index, hw_id,
> +					sensor_id, attr_name, type,
> +					pgroups[type], sgdata, show_sensor,
> +					NULL);
> +			count++;
> +		}
> +
> +		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
> +			attr_name = get_min_attr(type);
> +			populate_sensor(&sdata[count], opal_index, hw_id,
> +					sensor_id, attr_name, type,
> +					pgroups[type], sgdata, show_sensor,
> +					NULL);
> +			count++;
> +		}
>   
> -		create_hwmon_attr(&sdata[count], attr_name, show_sensor);
> +		if (sgdata) {
> +			int i;
>   
> -		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> -				&sdata[count++].dev_attr.attr;
> +			sgdata->sensors[sgdata->nr_sensor++] = &sdata[count];
> +			populate_sensor(&sdata[count], opal_index, hw_id,
> +					sgdata->gid, "enable", type,
> +					pgroups[type], sgdata, show_enable,
> +					store_enable);
> +			for (i = 0; i < ARRAY_SIZE(sdata[count].sdata); i++)
> +				sdata[count].sdata[i] = &sdata[count - i - 1];
> +			count++;
> +		}
>   
>   		if (!of_property_read_string(np, "label", &label)) {
>   			/*
> @@ -474,34 +696,15 @@ static int create_device_attrs(struct platform_device *pdev)
>   			 */
>   
>   			make_sensor_label(np, &sdata[count], label);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> +			populate_sensor(&sdata[count], opal_index, hw_id,
>   					sensor_id, "label", type, pgroups[type],
> -					show_label);
> -			count++;
> -		}
> -
> -		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
> -			attr_name = get_max_attr(type);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> -					sensor_id, attr_name, type,
> -					pgroups[type], show_sensor);
> -			count++;
> -		}
> -
> -		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
> -			attr_name = get_min_attr(type);
> -			populate_sensor(&sdata[count], opal_index,
> -					sdata[count - 1].hwmon_index,
> -					sensor_id, attr_name, type,
> -					pgroups[type], show_sensor);
> +					NULL, show_label, NULL);
>   			count++;
>   		}
>   	}
>   
> -exit_put_node:
>   	of_node_put(opal);
> +
>   	return err;
>   }
>   
> 
