Return-Path: <clg@kaod.org>
Received: from 4.mo2.mail-out.ovh.net (4.mo2.mail-out.ovh.net [87.98.172.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsHY73lvnzDqhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:11:39 +1000 (AEST)
Received: from player692.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1632A9401B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 08:06:21 +0200 (CEST)
Subject: Re: [PATCH V2 1/2] hwmon: (ibmpowernv) introduce a legacy_compatibles
 array
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux@roeck-us.net,
 stewart@linux.vnet.ibm.com
References: <1497935293-31618-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1497935293-31618-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Cc: jdelvare@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, linux-hwmon@vger.kernel.org
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3b82267d-c647-d523-12d8-496378ab240b@kaod.org>
Date: Tue, 20 Jun 2017 08:06:09 +0200
MIME-Version: 1.0
In-Reply-To: <1497935293-31618-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/20/2017 07:08 AM, Shilpasri G Bhat wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> Today, the type of a PowerNV sensor system is determined with the
> "compatible" property for legacy Firmwares and with the "sensor-type"
> for newer ones. The same array of strings is used for both to do the
> matching and this raises some issue to introduce new sensor types.
> 
> Let's introduce two different arrays (legacy and current) to make
> things easier for new sensor types.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Did you test on a Tuleta (IBM Power) system ? 

Thanks,

C. 

> ---
>  drivers/hwmon/ibmpowernv.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 862b832..6d8909c 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -55,17 +55,27 @@ enum sensors {
>  
>  #define INVALID_INDEX (-1U)
>  
> +/*
> + * 'compatible' string properties for sensor types as defined in old
> + * PowerNV firmware (skiboot). These are ordered as 'enum sensors'.
> + */
> +static const char * const legacy_compatibles[] = {
> +	"ibm,opal-sensor-cooling-fan",
> +	"ibm,opal-sensor-amb-temp",
> +	"ibm,opal-sensor-power-supply",
> +	"ibm,opal-sensor-power"
> +};
> +
>  static struct sensor_group {
> -	const char *name;
> -	const char *compatible;
> +	const char *name; /* matches property 'sensor-type' */
>  	struct attribute_group group;
>  	u32 attr_count;
>  	u32 hwmon_index;
>  } sensor_groups[] = {
> -	{"fan", "ibm,opal-sensor-cooling-fan"},
> -	{"temp", "ibm,opal-sensor-amb-temp"},
> -	{"in", "ibm,opal-sensor-power-supply"},
> -	{"power", "ibm,opal-sensor-power"}
> +	{ "fan"   },
> +	{ "temp"  },
> +	{ "in"    },
> +	{ "power" }
>  };
>  
>  struct sensor_data {
> @@ -239,8 +249,8 @@ static int get_sensor_type(struct device_node *np)
>  	enum sensors type;
>  	const char *str;
>  
> -	for (type = 0; type < MAX_SENSOR_TYPE; type++) {
> -		if (of_device_is_compatible(np, sensor_groups[type].compatible))
> +	for (type = 0; type < ARRAY_SIZE(legacy_compatibles); type++) {
> +		if (of_device_is_compatible(np, legacy_compatibles[type]))
>  			return type;
>  	}
>  
> 
