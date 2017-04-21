Return-Path: <clg@kaod.org>
Received: from 18.mo1.mail-out.ovh.net (18.mo1.mail-out.ovh.net [46.105.35.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8hD44PcNzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 02:34:59 +1000 (AEST)
Received: from player730.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 3E38469AF2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 13:48:08 +0200 (CEST)
Subject: Re: [PATCH] hwmon: (ibmpowernv) Add min/max attributes and current
 sensors
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1492749112-32465-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, andrew@aj.id.au
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d4e170f4-b8a0-480a-3095-779cf27650f3@kaod.org>
Date: Fri, 21 Apr 2017 13:47:50 +0200
MIME-Version: 1.0
In-Reply-To: <1492749112-32465-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Shilpasri,

On 04/21/2017 06:31 AM, Shilpasri G Bhat wrote:
> Add support for adding min/max values for the inband sensors copied by
> OCC to main memory. And also add current(mA) sensors to the list.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/hwmon/ibmpowernv.c | 55 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 6d2e660..1f329fa8 100644
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

why isn't there a compatible string ? 

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

We are negating of_property_read_string() above, but not below.
I wonder why ? 
 
> +		if (of_find_property(np, "sensor-data-min", &len))
> +			sensor_groups[type].attr_count++;
> +		if (of_find_property(np, "sensor-data-max", &len))
> +			sensor_groups[type].attr_count++;
>  	}
>  
>  	of_node_put(opal);
> @@ -428,6 +435,50 @@ static int create_device_attrs(struct platform_device *pdev)
>  			pgroups[type]->attrs[sensor_groups[type].attr_count++] =
>  				&sdata[count++].dev_attr.attr;
>  		}
> +
> +		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
> +			switch (type) {
> +			case POWER_INPUT:
> +				attr_name = "input_highest";
> +				break;
> +			case TEMP:
> +				attr_name = "max";
> +				break;
> +			default:
> +				attr_name = "highest";
> +				break;
> +			}

May be we could use a converting routine here ? create_device_attrs()
is getting big.

> +			sdata[count].id = sensor_id;
> +			sdata[count].type = type;
> +			sdata[count].hwmon_index = sdata[count - 1].hwmon_index;
> +			create_hwmon_attr(&sdata[count], attr_name,
> +					  show_sensor);
> +			pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> +				&sdata[count++].dev_attr.attr;
> +		}
> +
> +		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
> +			switch (type) {
> +			case POWER_INPUT:
> +				attr_name = "input_lowest";
> +				break;
> +			case TEMP:
> +				attr_name = "min";
> +				break;
> +			default:
> +				attr_name = "lowest";
> +				break;
> +			}

same here.

Thanks,

C.
> +			sdata[count].id = sensor_id;
> +			sdata[count].type = type;
> +			sdata[count].hwmon_index = sdata[count - 1].hwmon_index;
> +			create_hwmon_attr(&sdata[count], attr_name,
> +					  show_sensor);
> +			pgroups[type]->attrs[sensor_groups[type].attr_count++] =
> +				&sdata[count++].dev_attr.attr;
> +		}
>  	}
>  
>  exit_put_node:
> 
