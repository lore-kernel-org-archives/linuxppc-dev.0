Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsFk46tRHzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 14:49:16 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K4nEPF047319
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 00:49:14 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b69tvmp2s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 00:48:50 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 14:48:47 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K4mavr61341756
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 14:48:44 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K4mBxG013101
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 14:48:12 +1000
Subject: Re: [PATCH] hwmon: (ibmpowernv) Add current(A) sensors
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, linux@roeck-us.net,
 stewart@linux.vnet.ibm.com
References: <1497864333-16969-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <56a39618-dc4f-385c-77c3-5c9be92e2d48@kaod.org>
Cc: jdelvare@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, linux-hwmon@vger.kernel.org
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 10:17:48 +0530
MIME-Version: 1.0
In-Reply-To: <56a39618-dc4f-385c-77c3-5c9be92e2d48@kaod.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <77775369-f1d6-3dde-6985-ec35c176cdc3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cedric,

On 06/19/2017 06:22 PM, Cédric Le Goater wrote:
> On 06/19/2017 11:25 AM, Shilpasri G Bhat wrote:
>> This patch exports current(A) sensors in inband sensors copied to
>> main memory by OCC.
>>
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>>  drivers/hwmon/ibmpowernv.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
>> index 862b832..e0557f9 100644
>> --- a/drivers/hwmon/ibmpowernv.c
>> +++ b/drivers/hwmon/ibmpowernv.c
>> @@ -50,6 +50,7 @@ enum sensors {
>>  	TEMP,
>>  	POWER_SUPPLY,
>>  	POWER_INPUT,
>> +	CURRENT,
>>  	MAX_SENSOR_TYPE,
>>  };
>>  
>> @@ -65,7 +66,8 @@ enum sensors {
>>  	{"fan", "ibm,opal-sensor-cooling-fan"},
>>  	{"temp", "ibm,opal-sensor-amb-temp"},
>>  	{"in", "ibm,opal-sensor-power-supply"},
>> -	{"power", "ibm,opal-sensor-power"}
>> +	{"power", "ibm,opal-sensor-power"},
>> +	{"curr", "ibm,opal-sensor-current"},
>>  };
>>  
>>  struct sensor_data {
>>
> 
> 
> I know why you are doing that but that is the old (cr?@#!y) way to 
> define sensor types. we should try to improve thing a little more 
> and use the "sensor-type" property only.
> 
> I think the patch below should help you adding new types without 
> too much changes to your skiboot patchset. Could you please check ? 
> 

Thanks for the patch. And yes this patch very neatly serves the purpose.
I will repost my patch on top of your patch.

Thanks and Regards,
Shilpa

> Thanks,
> 
> C. 
> 
> From: Cédric Le Goater <clg@kaod.org>
> Subject: [PATCH] hwmon: (ibmpowernv) introduce a legacy_compatibles array
> Date: Mon, 19 Jun 2017 14:29:29 +0200
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
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
> ---


>  drivers/hwmon/ibmpowernv.c |   26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> Index: linux.git/drivers/hwmon/ibmpowernv.c
> ===================================================================
> --- linux.git.orig/drivers/hwmon/ibmpowernv.c
> +++ linux.git/drivers/hwmon/ibmpowernv.c
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
> @@ -239,8 +249,8 @@ static int get_sensor_type(struct device
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
