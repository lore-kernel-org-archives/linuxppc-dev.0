Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7111A0035
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 04:28:38 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 25 Feb 2015 17:28:35 -0000
Message-ID: <54EE0625.7050604@fr.ibm.com>
Date: Wed, 25 Feb 2015 18:28:05 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 1/3] powerpc/powernv: Check OPAL sensor calls exist
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
 <1424444857-13805-2-git-send-email-clg@fr.ibm.com>
 <1424753699.2318.8.camel@ellerman.id.au>
In-Reply-To: <1424753699.2318.8.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Guenter Roeck <linux@roeck-us.net>,
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

On 02/24/2015 05:54 AM, Michael Ellerman wrote:
> On Fri, 2015-02-20 at 16:07 +0100, Cédric Le Goater wrote:
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
> 
> Are you actually seeing this in practice?

No. Not this one. I have seen others though. I will send you patches.

> It's a bit annoying that we have to check for the token, and then also check
> the device tree. It would be nice if one implied the presence of the other.

Should we expose the OPAL call token in the device tree ? 

Cheers,

C. 
 
