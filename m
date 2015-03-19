Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B11E1A09DD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 14:58:24 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YYRbB-002tH7-Qr
 for linuxppc-dev@lists.ozlabs.org; Thu, 19 Mar 2015 03:58:21 +0000
Message-ID: <550A494E.2080103@roeck-us.net>
Date: Wed, 18 Mar 2015 20:58:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@fr.ibm.com>,
 lm-sensors@lm-sensors.org
Subject: Re: [PATCH 3/5] hwmon: (ibmpowernv) add a convert_opal_attr_name()
 routine
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1426693665-10797-4-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1426693665-10797-4-git-send-email-clg@fr.ibm.com>
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
> It simplifies the create_hwmon_attr_name() routine and it clearly isolates
> the conversion done between the OPAL node names and hwmon attributes names.
>
> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
> ---
>   drivers/hwmon/ibmpowernv.c |   39 +++++++++++++++++++++++++--------------
>   1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 07a8219b7f4e..edcc4ffa5ad0 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -127,6 +127,28 @@ static int get_sensor_index_attr(const char *name, u32 *index,
>   	return 0;
>   }
>
> +static const char *convert_opal_attr_name(enum sensors type,
> +					const char *opal_attr)

Would be great if you could align all the continuation lines with '('.

> +{
> +	const char *attr_name = NULL;
> +
> +	if (!strcmp(opal_attr, DT_FAULT_ATTR_SUFFIX)) {
> +		attr_name = "fault";
> +	} else if (!strcmp(opal_attr, DT_DATA_ATTR_SUFFIX)) {
> +		attr_name = "input";
> +	} else if (!strcmp(opal_attr, DT_THRESHOLD_ATTR_SUFFIX)) {
> +		if (type == TEMP)
> +			attr_name = "max";
> +		else if (type == FAN)
> +			attr_name = "min";
> +		else
> +			return NULL;
> +	} else {
> +		return NULL;
> +	}

Those else cases returning NULL are unnecessary; attr_name
is already initialized with NULL, so you can just return it.


> +	return attr_name;
> +}
> +
>   /*
>    * This function translates the DT node name into the 'hwmon' attribute name.
>    * IBMPOWERNV device node appear like cooling-fan#2-data, amb-temp#1-thrs etc.
> @@ -138,7 +160,7 @@ static int create_hwmon_attr_name(struct device *dev, enum sensors type,
>   					 char *hwmon_attr_name)
>   {
>   	char attr_suffix[MAX_ATTR_LEN];
> -	char *attr_name;
> +	const char *attr_name;
>   	u32 index;
>   	int err;
>
> @@ -149,20 +171,9 @@ static int create_hwmon_attr_name(struct device *dev, enum sensors type,
>   		return err;
>   	}
>
> -	if (!strcmp(attr_suffix, DT_FAULT_ATTR_SUFFIX)) {
> -		attr_name = "fault";
> -	} else if (!strcmp(attr_suffix, DT_DATA_ATTR_SUFFIX)) {
> -		attr_name = "input";
> -	} else if (!strcmp(attr_suffix, DT_THRESHOLD_ATTR_SUFFIX)) {
> -		if (type == TEMP)
> -			attr_name = "max";
> -		else if (type == FAN)
> -			attr_name = "min";
> -		else
> -			return -ENOENT;
> -	} else {
> +	attr_name = convert_opal_attr_name(type, attr_suffix);
> +	if (!attr_name)
>   		return -ENOENT;
> -	}
>
>   	snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
>   		 sensor_groups[type].name, index, attr_name);
>
