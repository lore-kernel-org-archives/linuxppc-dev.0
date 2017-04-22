Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w92Lk0Z1SzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 16:11:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, =?utf-8?Q?C=C3=A9dr?=
 =?utf-8?Q?ic?= Le Goater <clg@kaod.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Paul Mackerras <paulus@samba.org>
Cc: linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, andrew@aj.id.au
Subject: Re: [PATCH] hwmon: (ibmpowernv) Add min/max attributes and current
 sensors
In-Reply-To: <66e927c1-ceec-679d-8eaf-c6686b24b3a7@linux.vnet.ibm.com>
References: <1492749112-32465-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <d4e170f4-b8a0-480a-3095-779cf27650f3@kaod.org>
 <66e927c1-ceec-679d-8eaf-c6686b24b3a7@linux.vnet.ibm.com>
Date: Sat, 22 Apr 2017 16:11:56 +1000
Message-ID: <87a879ynrn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> On 04/21/2017 05:17 PM, C=C3=A9dric Le Goater wrote:
>> On 04/21/2017 06:31 AM, Shilpasri G Bhat wrote:
>>> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
>>> index 6d2e660..1f329fa8 100644
>>> --- a/drivers/hwmon/ibmpowernv.c
>>> +++ b/drivers/hwmon/ibmpowernv.c
>>> @@ -65,7 +66,8 @@ enum sensors {
>>>  	{"fan", "ibm,opal-sensor-cooling-fan"},
>>>  	{"temp", "ibm,opal-sensor-amb-temp"},
>>>  	{"in", "ibm,opal-sensor-power-supply"},
>>> -	{"power", "ibm,opal-sensor-power"}
>>> +	{"power", "ibm,opal-sensor-power"},
>>> +	{"curr"}, /* Follows newer device tree compatible ibm,opal-sensor */
>>=20
>> why isn't there a compatible string ?=20
>
> Skiboot exports "ibm,opal-sensor" as compatible string for all the inband
> sensors. Now if I define that as the compatible string here, then all the
> sensors would get identified as "curr" type of sensor by the driver.

So fix it in skiboot?

cheers
