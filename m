Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com
 [IPv6:2a00:1450:400c:c09::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZxp135pyzDqlK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 20:02:01 +1000 (AEST)
Received: by mail-wm0-x22a.google.com with SMTP id r190so2708958wmr.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 03:02:01 -0700 (PDT)
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
To: Balbir Singh <bsingharora@gmail.com>,
 Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <576B23EB.7080903@gmail.com> <576B6C64.6060206@linux.vnet.ibm.com>
 <576BABC5.7020600@gmail.com>
Cc: linux-pm@vger.kernel.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <576BB395.5050502@linaro.org>
Date: Thu, 23 Jun 2016 12:01:57 +0200
MIME-Version: 1.0
In-Reply-To: <576BABC5.7020600@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2016 11:28 AM, Balbir Singh wrote:

[ ... ]

>> cpuidle_enter_state()
>> {
>> 	[...]
>> 	time_start = local_clock();
>> 	[enter idle state]
>> 	time_end = local_clock();
>> 	/*
>>           * local_clock() returns the time in nanosecond, let's shift
>>           * by 10 (divide by 1024) to have microsecond based time.
>>           */
>>          diff = (time_end - time_start) >> 10;
>> 	[...]
>> 	dev->last_residency = (int) diff;
>> }
>>
>> Because of >>10 as opposed to /1000, last_residency is lesser by 2.3%

I am surprised the last_residency is 2.3% exactly less. The difference 
between >>10 and /1000 is 2.34%.

What is the next target residency value ?

Does it solve the issue if you replace >>10 by /1000 ?



-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
