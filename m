Return-Path: <clg@kaod.org>
Received: from 14.mo6.mail-out.ovh.net (14.mo6.mail-out.ovh.net
 [46.105.56.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC5jp07c5zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 00:50:37 +1000 (AEST)
Received: from player696.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id A4A49CEAA9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 16:32:27 +0200 (CEST)
Subject: Re: [PATCH] hwmon: (ibmpowernv) Add min/max attributes and current
 sensors
To: Michael Ellerman <mpe@ellerman.id.au>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Paul Mackerras <paulus@samba.org>
References: <1492749112-32465-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <d4e170f4-b8a0-480a-3095-779cf27650f3@kaod.org>
 <66e927c1-ceec-679d-8eaf-c6686b24b3a7@linux.vnet.ibm.com>
 <87a879ynrn.fsf@concordia.ellerman.id.au>
 <79e166e2-ed4b-7386-c07f-b02d68f133b5@kaod.org>
Cc: linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, andrew@aj.id.au
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6d12f317-73bd-7152-d43d-23a49f3dcde5@kaod.org>
Date: Tue, 25 Apr 2017 16:32:14 +0200
MIME-Version: 1.0
In-Reply-To: <79e166e2-ed4b-7386-c07f-b02d68f133b5@kaod.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/25/2017 04:28 PM, Cédric Le Goater wrote:
> On 04/22/2017 08:11 AM, Michael Ellerman wrote:
>> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>>> On 04/21/2017 05:17 PM, Cédric Le Goater wrote:
>>>> On 04/21/2017 06:31 AM, Shilpasri G Bhat wrote:
>>>>> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
>>>>> index 6d2e660..1f329fa8 100644
>>>>> --- a/drivers/hwmon/ibmpowernv.c
>>>>> +++ b/drivers/hwmon/ibmpowernv.c
>>>>> @@ -65,7 +66,8 @@ enum sensors {
>>>>>  	{"fan", "ibm,opal-sensor-cooling-fan"},
>>>>>  	{"temp", "ibm,opal-sensor-amb-temp"},
>>>>>  	{"in", "ibm,opal-sensor-power-supply"},
>>>>> -	{"power", "ibm,opal-sensor-power"}
>>>>> +	{"power", "ibm,opal-sensor-power"},
>>>>> +	{"curr"}, /* Follows newer device tree compatible ibm,opal-sensor */
>>>>
>>>> why isn't there a compatible string ? 
>>>
>>> Skiboot exports "ibm,opal-sensor" as compatible string for all the inband
>>> sensors. Now if I define that as the compatible string here, then all the
>>> sensors would get identified as "curr" type of sensor by the driver.
>>
>> So fix it in skiboot?
> 
> 
> After a memory refresh, this table is to maintain compatibility with 
> the support of the FSP sensors in old firmware. These have peculiar
> device node names and properties.  
> 
> So What the code is doing looks correct. But, you should also modify 
> the 'enum sensors' to include a CURRENT value.

But the patch does that already. I was missing context. This is fine
then.

Thanks,

C.
