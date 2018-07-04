Return-Path: <groeck7@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LZGy56S5zDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 07:43:06 +1000 (AEST)
Received: by mail-pf0-f195.google.com with SMTP id s21-v6so3531251pfm.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jul 2018 14:43:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
References: <1530695793-4584-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530695793-4584-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <e3a013fb-eaf0-8d45-2f23-3be8b3e5640b@roeck-us.net>
 <c7e1272a-c9c8-a120-632f-7693cef3fd22@linux.vnet.ibm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f0b3384f-02fb-f4f2-0f89-378183a1fad9@roeck-us.net>
Date: Wed, 4 Jul 2018 14:42:56 -0700
MIME-Version: 1.0
In-Reply-To: <c7e1272a-c9c8-a120-632f-7693cef3fd22@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2018 09:53 AM, Shilpasri G Bhat wrote:
> Hi Guenter,
> 
> Thanks for reviewing the patch.
> On 07/04/2018 08:16 PM, Guenter Roeck wrote:
>>> +        /* Disable if last sensor in the group */
>>> +        send_command = true;
>>> +        for (i = 0; i < sg->nr_sensor; i++) {
>>> +            struct sensor_data *sd = sg->sensors[i];
>>> +
>>> +            if (sd->enable) {
>>> +                send_command = false;
>>> +                break;
>>> +            }
>>
>> This is weird. So there are situations where a request to disable
>> a sensor is accepted, but effectively ignored ? Shouldn't that
>> return, say, -EBUSY ?
> 
> This is because we do not support per-sensor enable/disable. We can only
> enable/disable at a sensor-group level.
> 
> This patch follows the semantic to disable a sensor group iff all the sensors
> belonging to that group have been disabled. Otherwise the sensor alone is marked
> to be disabled and returns -ENODATA on reading it.
> 
> And a sensor group will be enabled if any of the sensor in that group is enabled.
> 

In similar situations, where setting one attribute affects others, a common solution
is to make only the first attribute writable and have it affect all the others.
I think that would make sense here as well, and it would be much simpler to implement.

Guenter

> I will make changes to the remaining code according to your suggestion.
> 
> Thanks and Regards,
> Shilpa
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
