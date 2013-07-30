Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFAA72C0100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 13:52:35 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 30 Jul 2013 13:45:49 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 152793578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 13:52:32 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6U3b0TG2490838
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 13:37:01 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6U3qUk0022562
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 13:52:31 +1000
Message-ID: <51F73847.6090002@linux.vnet.ibm.com>
Date: Tue, 30 Jul 2013 09:21:35 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [linux-pm] [PATCH 1/3] cpuidle/powernv: cpuidle backend driver
 for powernv
References: <20130723090111.7291.99479.stgit@deepthi.in.ibm.com>
 <20130723090137.7291.36657.stgit@deepthi.in.ibm.com>
 <51F35A2A.1080408@linaro.org> <51F67E96.6040008@linux.vnet.ibm.com>
 <51F681E7.1060609@linaro.org>
In-Reply-To: <51F681E7.1060609@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: linux-pm@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2013 08:23 PM, Daniel Lezcano wrote:
> On 07/29/2013 04:39 PM, Deepthi Dharwar wrote:
>> Hi Daniel,
>>
>> On 07/27/2013 10:57 AM, Daniel Lezcano wrote:
>>> On 07/23/2013 11:01 AM, Deepthi Dharwar wrote:
>>>> This patch implements a back-end cpuidle driver for
>>>> powernv calling power7_nap and snooze idle states.
>>>> This can be extended by adding more idle states
>>>> in the future to the existing framework.
>>>>
>>>> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> 
> [ ... ]
> 
>>>> +static int snooze_loop(struct cpuidle_device *dev,
>>>> +			struct cpuidle_driver *drv,
>>>> +			int index)
>>>> +{
>>>> +	int cpu = dev->cpu;
>>>> +
>>>> +	local_irq_enable();
>>>> +	set_thread_flag(TIF_POLLING_NRFLAG);
>>>> +
>>>> +	while ((!need_resched()) && cpu_online(cpu)) {
>>>> +		ppc64_runlatch_off();
>>>> +		HMT_very_low();
>>>> +	}
>>>
>>> Why are you using the cpu_online test here ?
>>
>> Snooze state is an idle state where cpu executes an infinite loop by
>> reducing the priority of the thread and the idle cpu can come out of it
>> only if need_resched is set or in case the cpu is offlined. In order to
>> continue executing this loop to remain in this idle state, we need the
>> check just to be safe.
> 
> Yes, but if the cpu is offline you are no longer executing this code, no ?
> 

Yes, not needed.

Thanks !
Deepthi
