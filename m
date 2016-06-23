Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com
 [IPv6:2a00:1450:400c:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rb3tG3SM0zDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 00:36:05 +1000 (AEST)
Received: by mail-wm0-x22f.google.com with SMTP id r201so53049426wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 07:36:05 -0700 (PDT)
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, rjw@rjwysocki.net
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com>
 <576BABC5.7020600@gmail.com> <576BB395.5050502@linaro.org>
 <576BE58F.9030303@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <576BF3D1.6030507@linaro.org>
Date: Thu, 23 Jun 2016 16:36:01 +0200
MIME-Version: 1.0
In-Reply-To: <576BE58F.9030303@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2016 03:35 PM, Shreyas B Prabhu wrote:
>
>
> On 06/23/2016 03:31 PM, Daniel Lezcano wrote:
>> On 06/23/2016 11:28 AM, Balbir Singh wrote:
>>
>> [ ... ]
>>
>>>> cpuidle_enter_state()
>>>> {
>>>>      [...]
>>>>      time_start = local_clock();
>>>>      [enter idle state]
>>>>      time_end = local_clock();
>>>>      /*
>>>>            * local_clock() returns the time in nanosecond, let's shift
>>>>            * by 10 (divide by 1024) to have microsecond based time.
>>>>            */
>>>>           diff = (time_end - time_start) >> 10;
>>>>      [...]
>>>>      dev->last_residency = (int) diff;
>>>> }
>>>>
>>>> Because of >>10 as opposed to /1000, last_residency is lesser by 2.3%
>>
>> I am surprised the last_residency is 2.3% exactly less. The difference
>> between >>10 and /1000 is 2.34%.
>>
>> What is the next target residency value ?
>>
> Target residency of the next idle state is 100 microseconds.
> When snooze times out after 100 microseconds, last_residency value
> calculated is typically 97 or 98 microseconds.

I see, the snooze exit is very fast.

>> Does it solve the issue if you replace >>10 by /1000 ?
>>
>
> Yes it does.

Ok. IMO, it would be cleaner to fix this in the core code.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
