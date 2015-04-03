Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 155C41A0AA1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 02:49:55 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1Ye3qy-0006yi-Oy
 for linuxppc-dev@lists.ozlabs.org; Fri, 03 Apr 2015 15:49:52 +0000
Message-ID: <551EB692.3010309@roeck-us.net>
Date: Fri, 03 Apr 2015 08:49:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@fr.ibm.com>,
 lm-sensors@lm-sensors.org
Subject: Re: [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
References: <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
 <1427883306-32528-5-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1427883306-32528-5-git-send-email-clg@fr.ibm.com>
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

On 04/01/2015 03:15 AM, Cédric Le Goater wrote:
> The new OPAL device tree adds a few properties which can be used to add
> extra information on the sensor label.
>
> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
> ---
>   drivers/hwmon/ibmpowernv.c |   22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index be6fe559b52a..3e753c215b40 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -113,9 +113,31 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
>   static void __init make_sensor_label(struct device_node *np,
>   		    struct sensor_data *sdata, const char *label)
>   {
> +	u32 id;
>   	size_t n;
>
>   	n = snprintf(sdata->label, sizeof(sdata->label), "%s", label);
> +
> +	/*
> +	 * Core temp pretty print
> +	 */
> +	if (!of_property_read_u32(np, "ibm,pir", &id)) {
> +		int i;
> +
> +		for_each_possible_cpu(i)
> +			if (paca[i].hw_cpu_id == id)
> +				break;
> +
> +		n += snprintf(sdata->label + n, sizeof(sdata->label) - n,
> +			      " %d-%d", i, i+7);

If ibm,pir points to a bad/invalid CPU id you just print an invalid value.
Is that what you want ? Also, what relevance does 'i' have for the user ?
It is the index into the paca array, sure, but what is its relevance
outside this code, especially in the context of you printing both i and i+7 ?

Guenter

> +	}
> +
> +	/*
> +	 * Membuffer pretty print
> +	 */
> +	if (!of_property_read_u32(np, "ibm,chip-id", &id))
> +		n += snprintf(sdata->label + n, sizeof(sdata->label) - n,
> +			      " %d", id & 0xffff);
>   }
>
>   static int get_sensor_index_attr(const char *name, u32 *index,
>
