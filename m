Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA1051A09E1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:02:18 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YYRey-002ww1-9Y
 for linuxppc-dev@lists.ozlabs.org; Thu, 19 Mar 2015 04:02:16 +0000
Message-ID: <550A4A3A.3090406@roeck-us.net>
Date: Wed, 18 Mar 2015 21:02:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@fr.ibm.com>,
 lm-sensors@lm-sensors.org
Subject: Re: [PATCH 4/5] hwmon: (ibmpowernv) change create_hwmon_attr_name()
 prototype
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426693665-10797-5-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1426693665-10797-5-git-send-email-clg@fr.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/18/2015 08:47 AM, Cédric Le Goater wrote:
> It simplifies the creation of the hwmon attributes and will help when
> support for a new device tree layout is added. The patch also changes
> the name of the routine to parse_opal_node_name().
>
> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
> ---
>   drivers/hwmon/ibmpowernv.c |   32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index edcc4ffa5ad0..570d2360b698 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -155,28 +155,22 @@ static const char *convert_opal_attr_name(enum sensors type,
>    * which need to be mapped as fan2_input, temp1_max respectively before
>    * populating them inside hwmon device class.
>    */
> -static int create_hwmon_attr_name(struct device *dev, enum sensors type,
> -					 const char *node_name,
> -					 char *hwmon_attr_name)
> +static int parse_opal_node_name(const char *node_name, enum sensors type,
> +	u32 *index, const char **hwmon_attr_name)
>   {

Please have the function return const char * and merge the error code with ERR_PTR.

>   	char attr_suffix[MAX_ATTR_LEN];
>   	const char *attr_name;
> -	u32 index;
>   	int err;
>
> -	err = get_sensor_index_attr(node_name, &index, attr_suffix);
> -	if (err) {
> -		dev_err(dev, "Sensor device node name '%s' is invalid\n",
> -			node_name);
> +	err = get_sensor_index_attr(node_name, index, attr_suffix);
> +	if (err)
>   		return err;
> -	}
>
>   	attr_name = convert_opal_attr_name(type, attr_suffix);
>   	if (!attr_name)
>   		return -ENOENT;
>
> -	snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
> -		 sensor_groups[type].name, index, attr_name);
> +	*hwmon_attr_name = attr_name;
>   	return 0;
>   }
>
> @@ -252,6 +246,9 @@ static int create_device_attrs(struct platform_device *pdev)
>   	}
>
>   	for_each_child_of_node(opal, np) {
> +		const char *attr_name;
> +		u32 opal_index;
> +
>   		if (np->name == NULL)
>   			continue;
>
> @@ -268,10 +265,17 @@ static int create_device_attrs(struct platform_device *pdev)
>
>   		sdata[count].id = sensor_id;
>   		sdata[count].type = type;
> -		err = create_hwmon_attr_name(&pdev->dev, type, np->name,
> -					     sdata[count].name);
> -		if (err)
> +
> +		err = parse_opal_node_name(np->name, type, &opal_index,
> +					   &attr_name);
> +		if (err) {
> +			dev_err(&pdev->dev, "Sensor device node name '%s' is invalid\n",
> +				np->name);
>   			goto exit_put_node;
> +		}
> +
> +		snprintf(sdata[count].name, MAX_ATTR_LEN, "%s%d_%s",
> +			 sensor_groups[type].name, opal_index, attr_name);
>
>   		sysfs_attr_init(&sdata[count].dev_attr.attr);
>   		sdata[count].dev_attr.attr.name = sdata[count].name;
>
