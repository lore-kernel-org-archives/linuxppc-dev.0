Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36A931A0EE2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 07:18:42 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 20 Feb 2015 20:18:39 -0000
Message-ID: <54E79683.2080605@fr.ibm.com>
Date: Fri, 20 Feb 2015 21:18:11 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 1/3] powerpc/powernv: Check OPAL sensor calls exist
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1424444857-13805-2-git-send-email-clg@fr.ibm.com>
 <20150220165306.GF22752@roeck-us.net>
In-Reply-To: <20150220165306.GF22752@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
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

On 02/20/2015 05:53 PM, Guenter Roeck wrote:
> On Fri, Feb 20, 2015 at 04:07:35PM +0100, Cédric Le Goater wrote:
> 
> You should explain here why this patch is needed.

Yes. What it does is to check that the firmware exposes the service
this driver is using (OPAL_SENSOR_READ). I will fix it.

Thanks,

C. 


> 
>> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/opal-sensor.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
>> index 4ab67ef7abc9..544292f2020f 100644
>> --- a/arch/powerpc/platforms/powernv/opal-sensor.c
>> +++ b/arch/powerpc/platforms/powernv/opal-sensor.c
>> @@ -72,6 +72,9 @@ static __init int opal_sensor_init(void)
>>  	struct platform_device *pdev;
>>  	struct device_node *sensor;
>>  
>> +	if (!opal_check_token(OPAL_SENSOR_READ))
>> +		return -ENODEV;
>> +
>>  	sensor = of_find_node_by_path("/ibm,opal/sensors");
>>  	if (!sensor) {
>>  		pr_err("Opal node 'sensors' not found\n");
>> -- 
>> 1.7.10.4
>>
> 
