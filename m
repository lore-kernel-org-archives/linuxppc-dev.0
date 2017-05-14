Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wQp4n3n7NzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 01:47:37 +1000 (AEST)
Subject: Re: [PATCH V4] hwmon: (ibmpowernv) Add highest/lowest attributes to
 sensors
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, jdelvare@suse.com,
 paulus@samba.org, mpe@ellerman.id.au
References: <1494084436-32445-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, andrew@aj.id.au,
 clg@kaod.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <64f13726-7f7b-5a4e-bb65-ef3cf3b970e3@roeck-us.net>
Date: Sun, 14 May 2017 08:47:31 -0700
MIME-Version: 1.0
In-Reply-To: <1494084436-32445-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2017 08:27 AM, Shilpasri G Bhat wrote:
> OCC provides historical minimum and maximum value for the sensor
> readings. This patch exports them as highest and lowest attributes
> for the inband sensors copied by OCC to main memory.
>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from V3:
> - Removed extra variable 'hwmon_index'
> - Retain the initialization of sensor_data for *_input attribute in
>   create_device_attrs(), otherwise all the sensors from different
>   classes will numbered continuously.
>
>  drivers/hwmon/ibmpowernv.c | 69 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 6d2e660..862b832 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -287,6 +287,7 @@ static int populate_attr_groups(struct platform_device *pdev)
>  	opal = of_find_node_by_path("/ibm,opal/sensors");
>  	for_each_child_of_node(opal, np) {
>  		const char *label;
> +		int len;
>
>  		if (np->name == NULL)
>  			continue;
> @@ -298,10 +299,14 @@ static int populate_attr_groups(struct platform_device *pdev)
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

len isn't used, so you can just pass NULL and avoid the unnecessary variable.

>  	}
>
>  	of_node_put(opal);
> @@ -337,6 +342,41 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
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
> +	default:
> +		return "highest";
> +	}
> +}
> +
> +static char *get_min_attr(enum sensors type)
> +{
> +	switch (type) {
> +	case POWER_INPUT:
> +		return "input_lowest";
> +	default:
> +		return "lowest";
> +	}
> +}
> +
>  /*
>   * Iterate through the device tree for each child of 'sensors' node, create
>   * a sysfs attribute file, the file is named by translating the DT node name
> @@ -417,16 +457,31 @@ static int create_device_attrs(struct platform_device *pdev)
>  			 * attribute. They are related to the same
>  			 * sensor.
>  			 */
> -			sdata[count].type = type;
> -			sdata[count].opal_index = sdata[count - 1].opal_index;
> -			sdata[count].hwmon_index = sdata[count - 1].hwmon_index;
>
>  			make_sensor_label(np, &sdata[count], label);
> +			populate_sensor(&sdata[count], opal_index,
> +					sdata[count - 1].hwmon_index,
> +					sensor_id, "label", type, pgroups[type],
> +					show_label);
> +			count++;
> +		}
>
> -			create_hwmon_attr(&sdata[count], "label", show_label);
> +		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
> +			attr_name = get_max_attr(type);
> +			populate_sensor(&sdata[count], opal_index,
> +					sdata[count - 1].hwmon_index,
> +					sensor_id, attr_name, type,
> +					pgroups[type], show_sensor);
> +			count++;
> +		}
>
> -			pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> -				&sdata[count++].dev_attr.attr;
> +		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
> +			attr_name = get_min_attr(type);
> +			populate_sensor(&sdata[count], opal_index,
> +					sdata[count - 1].hwmon_index,
> +					sensor_id, attr_name, type,
> +					pgroups[type], show_sensor);
> +			count++;
>  		}
>  	}
>
>
