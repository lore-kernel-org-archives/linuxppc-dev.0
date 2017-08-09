Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRzgQ16G8zDqvG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 15:03:29 +1000 (AEST)
Subject: Re: [RFC] hwmon: (ibmpowernv) Add support for reset-history sensors
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, clg@kaod.org
Cc: jdelvare@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-hwmon@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, stewart@linux.vnet.ibm.com
References: <1501048538-23160-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7783ed56-74fb-cd6c-f971-6b7922d11a35@roeck-us.net>
Date: Tue, 8 Aug 2017 21:32:51 -0700
MIME-Version: 1.0
In-Reply-To: <1501048538-23160-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2017 10:55 PM, Shilpasri G Bhat wrote:
> In P9, OCC allows for clearing the sensor min-max history. This patch
> exports attribute to reset history when set will clear the history of
> all the sensors owned by CSM and belonging to the chip.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> This patch is on top of this patchset:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1453891.html
> 
> This patch creates a non-standard attribute called as reset_historyX
> which clears the lowest and highest of all the sensors like power,
> temperature, voltage belonging to the chip.
> 
>   drivers/hwmon/ibmpowernv.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 5ccdd0b..611e472 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -51,6 +51,7 @@ enum sensors {
>   	POWER_SUPPLY,
>   	POWER_INPUT,
>   	CURRENT,
> +	RESET_HISTORY,
>   	MAX_SENSOR_TYPE,
>   };
>   
> @@ -78,6 +79,7 @@ enum sensors {
>   	{ "in"    },
>   	{ "power" },
>   	{ "curr"  },
> +	{ "reset_history" },
>   };
>   
>   struct sensor_data {
> @@ -126,6 +128,25 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
>   	return sprintf(buf, "%s\n", sdata->label);
>   }
>   
> +static ssize_t store_reset_history(struct device *dev,
> +				   struct device_attribute *devattr,
> +				   const char *buf, size_t count)
> +{
> +	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
> +						 dev_attr);
> +	int rc;
> +	int reset;
> +
> +	rc = kstrtoint(buf, 0, &reset);
> +	if (rc)
> +		return rc;
> +
> +	if (reset == 1)
> +		rc = opal_sensor_groups_clear_history(sdata->id);
> +

Which of course doesn't exist, so it is hard to determine if this is
all that is offered.

I'd rather stick with the existing ABI, which resets the history either
per sensor(inX_reset_history) or per group (in_reset_history).

Guenter

> +	return rc ? rc : count;
> +}
> +
>   static int __init get_logical_cpu(int hwcpu)
>   {
>   	int cpu;
> @@ -458,6 +479,16 @@ static int create_device_attrs(struct platform_device *pdev)
>   
>   		create_hwmon_attr(&sdata[count], attr_name, show_sensor);
>   
> +		if (type == RESET_HISTORY) {
> +			snprintf(sdata[count].name, MAX_ATTR_LEN, "%s%d",
> +				 sensor_groups[type].name,
> +				 sdata[count].hwmon_index);
> +
> +			sdata[count].dev_attr.attr.mode = 0220;
> +			sdata[count].dev_attr.store = store_reset_history;
> +			sdata[count].dev_attr.show = NULL;
> +		}
> +
>   		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
>   				&sdata[count++].dev_attr.attr;
>   
> 
