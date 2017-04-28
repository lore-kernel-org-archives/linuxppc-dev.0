Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDvnB53HPzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 23:29:50 +1000 (AEST)
Subject: Re: [PATCH V2] hwmon: (ibmpowernv) Add min/max attributes and current
 sensors
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, jdelvare@suse.com,
 paulus@samba.org, mpe@ellerman.id.au
References: <1493359145-6143-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, andrew@aj.id.au,
 clg@kaod.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <8f9e7f79-e9ab-e0a6-d5c6-b805b42da2e5@roeck-us.net>
Date: Fri, 28 Apr 2017 06:29:42 -0700
MIME-Version: 1.0
In-Reply-To: <1493359145-6143-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2017 10:59 PM, Shilpasri G Bhat wrote:
> Add support for adding min/max values for the inband sensors copied by
> OCC to main memory. And also add current(mA) sensors to the list.
>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from V1:
> - Add functions to get min and max attribute strings
> - Add function 'populate_sensor' to fill in the 'struct sensor_data'
>   for each sensor.
>
>  drivers/hwmon/ibmpowernv.c | 96 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 77 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 6d2e660..d59262c 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -50,6 +50,7 @@ enum sensors {
>  	TEMP,
>  	POWER_SUPPLY,
>  	POWER_INPUT,
> +	CURRENT,
>  	MAX_SENSOR_TYPE,
>  };
>
> @@ -65,7 +66,8 @@ enum sensors {
>  	{"fan", "ibm,opal-sensor-cooling-fan"},
>  	{"temp", "ibm,opal-sensor-amb-temp"},
>  	{"in", "ibm,opal-sensor-power-supply"},
> -	{"power", "ibm,opal-sensor-power"}
> +	{"power", "ibm,opal-sensor-power"},
> +	{"curr"}, /* Follows newer device tree compatible ibm,opal-sensor */

Following up on a previous e-mail, this really _is_ odd. Any chance to fix it
in the firmware and have current sensors return "ibm,opal-sensor-current" ?

>  };
>
>  struct sensor_data {
> @@ -287,6 +289,7 @@ static int populate_attr_groups(struct platform_device *pdev)
>  	opal = of_find_node_by_path("/ibm,opal/sensors");
>  	for_each_child_of_node(opal, np) {
>  		const char *label;
> +		int len;
>
>  		if (np->name == NULL)
>  			continue;
> @@ -298,10 +301,14 @@ static int populate_attr_groups(struct platform_device *pdev)
>  		sensor_groups[type].attr_count++;
>
>  		/*
> -		 * add a new attribute for labels
> +		 * add attributes for labels, min and max
>  		 */
>  		if (!of_property_read_string(np, "label", &label))
>  			sensor_groups[type].attr_count++;
> +		if (of_find_property(np, "sensor-data-min", &len))
> +			sensor_groups[type].attr_count++;
> +		if (of_find_property(np, "sensor-data-max", &len))
> +			sensor_groups[type].attr_count++;
>  	}
>
>  	of_node_put(opal);
> @@ -337,6 +344,49 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
>  	sdata->dev_attr.show = show;
>  }
>
> +static void populate_sensor(struct sensor_data *sdata, int od, int hd, int sid,
> +			    const char *attr_name, enum sensors type,
> +			    const struct attribute_group *pgroup,
> +			    ssize_t (*show)(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf))
> +{
> +	sdata->id = sid;
> +	sdata->type = type;
> +	sdata->opal_index = od;
> +	sdata->hwmon_index = hd;
> +	create_hwmon_attr(sdata, attr_name, show);
> +	pgroup->attrs[sensor_groups[type].attr_count++] = &sdata->dev_attr.attr;
> +}
> +
> +static char *get_max_attr(enum sensors type)
> +{
> +	switch (type) {
> +	case POWER_INPUT:
> +		return "input_highest";
> +	case TEMP:
> +		return "max";
> +	default:
> +		break;
> +	}
> +
> +	return "highest";

This is a bit confusing. Why not 'return "highest";' in the default case above ?

Also, is this correct for type == POWER_SUPPLY, ie is it "highest" vs. "max" ?

Kind of odd that the firmware reports "highest/lowest" in some cases
and "max/min" in others. Guess there is nothing we can do about that,
just a note.

> +}
> +
> +static char *get_min_attr(enum sensors type)
> +{
> +	switch (type) {
> +	case POWER_INPUT:
> +		return "input_lowest";
> +	case TEMP:
> +		return "min";
> +	default:
> +		break;
> +	}
> +
> +	return "lowest";

Same here.

> +}
> +
>  /*
>   * Iterate through the device tree for each child of 'sensors' node, create
>   * a sysfs attribute file, the file is named by translating the DT node name
> @@ -365,6 +415,7 @@ static int create_device_attrs(struct platform_device *pdev)
>  	for_each_child_of_node(opal, np) {
>  		const char *attr_name;
>  		u32 opal_index;
> +		u32 hwmon_index;
>  		const char *label;
>
>  		if (np->name == NULL)
> @@ -386,9 +437,6 @@ static int create_device_attrs(struct platform_device *pdev)
>  			continue;
>  		}
>
> -		sdata[count].id = sensor_id;
> -		sdata[count].type = type;
> -
>  		/*
>  		 * If we can not parse the node name, it means we are
>  		 * running on a newer device tree. We can just forget
> @@ -401,14 +449,12 @@ static int create_device_attrs(struct platform_device *pdev)
>  			opal_index = INVALID_INDEX;
>  		}
>
> -		sdata[count].opal_index = opal_index;
> -		sdata[count].hwmon_index =
> -			get_sensor_hwmon_index(&sdata[count], sdata, count);
> -
> -		create_hwmon_attr(&sdata[count], attr_name, show_sensor);
> -
> -		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> -				&sdata[count++].dev_attr.attr;
> +		hwmon_index = get_sensor_hwmon_index(&sdata[count], sdata,
> +						     count);
> +		populate_sensor(&sdata[count], opal_index, hwmon_index,
> +				sensor_id, attr_name, type, pgroups[type],
> +				show_sensor);
> +		count++;
>
>  		if (!of_property_read_string(np, "label", &label)) {
>  			/*
> @@ -417,16 +463,28 @@ static int create_device_attrs(struct platform_device *pdev)
>  			 * attribute. They are related to the same
>  			 * sensor.
>  			 */
> -			sdata[count].type = type;
> -			sdata[count].opal_index = sdata[count - 1].opal_index;
> -			sdata[count].hwmon_index = sdata[count - 1].hwmon_index;
>
>  			make_sensor_label(np, &sdata[count], label);
> +			populate_sensor(&sdata[count], opal_index, hwmon_index,
> +					sensor_id, "label", type, pgroups[type],
> +					show_label);
> +			count++;
> +		}
>
> -			create_hwmon_attr(&sdata[count], "label", show_label);
> +		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
> +			attr_name = get_max_attr(type);
> +			populate_sensor(&sdata[count], opal_index, hwmon_index,
> +					sensor_id, attr_name, type,
> +					pgroups[type], show_sensor);
> +			count++;
> +		}
>
> -			pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> -				&sdata[count++].dev_attr.attr;
> +		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
> +			attr_name = get_min_attr(type);
> +			populate_sensor(&sdata[count], opal_index, hwmon_index,
> +					sensor_id, attr_name, type,
> +					pgroups[type], show_sensor);
> +			count++;
>  		}
>  	}
>
>
