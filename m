Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF74F2C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 09:05:29 +1100 (EST)
Received: by mail-wi0-f173.google.com with SMTP id hn9so5498297wib.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 14:05:25 -0800 (PST)
Message-ID: <52FA9EA3.6060008@linaro.org>
Date: Tue, 11 Feb 2014 23:05:23 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 2/3] tick/cpuidle: Initialize hrtimer mode of broadcast
References: <20140207075618.17187.20149.stgit@preeti.in.ibm.com>
 <20140207080632.17187.80532.stgit@preeti.in.ibm.com>
 <52F9F896.4020402@linaro.org> <52FA4B2E.4070709@linux.vnet.ibm.com>
In-Reply-To: <52FA4B2E.4070709@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: deepthi@linux.vnet.ibm.com, linux-pm@vger.kernel.org, peterz@infradead.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, fweisbec@gmail.com, tglx@linutronix.de,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2014 05:09 PM, Preeti U Murthy wrote:
> Hi Daniel,
>
> Thank you very much for the review.
>
> On 02/11/2014 03:46 PM, Daniel Lezcano wrote:
>> On 02/07/2014 09:06 AM, Preeti U Murthy wrote:
>>> From: Thomas Gleixner <tglx@linutronix.de>
>>>
>>> On some architectures, in certain CPU deep idle states the local
>>> timers stop.
>>> An external clock device is used to wakeup these CPUs. The kernel
>>> support for the
>>> wakeup of these CPUs is provided by the tick broadcast framework by
>>> using the
>>> external clock device as the wakeup source.
>>>
>>> However not all implementations of architectures provide such an external
>>> clock device. This patch includes support in the broadcast framework
>>> to handle
>>> the wakeup of the CPUs in deep idle states on such systems by queuing
>>> a hrtimer
>>> on one of the CPUs, which is meant to handle the wakeup of CPUs in
>>> deep idle states.
>>>
>>> This patchset introduces a pseudo clock device which can be registered
>>> by the
>>> archs as tick_broadcast_device in the absence of a real external clock
>>> device. Once registered, the broadcast framework will work as is for
>>> these
>>> architectures as long as the archs take care of the BROADCAST_ENTER
>>> notification failing for one of the CPUs. This CPU is made the stand
>>> by CPU to
>>> handle wakeup of the CPUs in deep idle and it *must not enter deep
>>> idle states*.
>>>
>>> The CPU with the earliest wakeup is chosen to be this CPU. Hence this
>>> way the
>>> stand by CPU dynamically moves around and so does the hrtimer which is
>>> queued
>>> to trigger at the next earliest wakeup time. This is consistent with
>>> the case where
>>> an external clock device is present. The smp affinity of this clock
>>> device is
>>> set to the CPU with the earliest wakeup.
>>
>> Hi Preeti,
>>
>> jumping a bit late in the thread...
>>
>> Setting the smp affinity on the earliest timer should be handled
>> automatically with the CLOCK_EVT_FEAT_DYNIRQ flag. Did you look at using
>> this flag ?
>
> This patch is not setting the smp affinity of the pseudo clock device at
> all. Its not required to for the reason that it does not exist.
>
> I mentioned this point because we assign a CPU with the earliest wakeup
> as standby. I compared this logic to the one used by the tick broadcast
> framework for archs which have an external clock device to set the smp
> affinity of the device.
>
> If these archs do not have the flag CLOCK_EVT_FEAT_DYNIRQ set for the
> external clock device, the tick broadcast framework sets the smp
> affinity of this device to the CPU with the earliest wakeup. We are
> using the same logic in this patchset as well to assign the stand by CPU.
>
>>
>> Another comment is the overall approach. We enter the cpuidle idle
>> framework with a specific state to go to and it is the tick framework
>> telling us we mustn't go to this state. IMO the logic is wrong, the
>> decision to not enter this state should be moved somewhere else.
>
> Its not the tick framework which tells us that we cannot enter deep idle
> state, its the *tick broadcast* framework specifically. The tick
> broadcast framework was introduced with the primary intention of
> handling wakeup of CPUs in deep idle states when the local timers become
> non-functional. Therefore there is a co-operation between this tick
> broadcast framework and cpuidle. This has always been the case.
>
> That is why just before cpus go into deep idle, they call into the
> broadcast framework. Till now it was assumed that the tick broadcast
> framework would find no problems with the cpus entering deep idle.
> Therefore cpuidle would simply assume that all is well and go ahead and
> enter deep idle state.
>    But today there is a scenario when there could be problems if all cpus
> enter deep idle states and the tick broadcast framework now notifies the
> cpuidle framework to hold back one cpu. This is just a simple extension
> of the current interaction between cpuidle and tick broadcast framework.
>
>>
>> Why don't you create a cpuidle driver with the shallow idle states
>> assigned to a cpu (let's say cpu0) and another one with all the deeper
>> idle states for the rest of the cpus ? Using the multiple cpuidle driver
>> support makes it possible. The timer won't be moving around and a cpu
>> will be dedicated to act as the broadcast timer.
>>
>
> Having a dedicated stand by cpu for broadcasting has some issues which
> were pointed to when I posted the initial versions of this patchset.
> https://lkml.org/lkml/2013/7/27/14
>
> 1. This could create power/thermal imbalance on the chip since only the
> standby cpu cannot enter deep idle state at all times.
>
> 2. If it is cpu0 it is fine, else with the logic that you suggest,
> hot-plugging out the dedicated stand by cpu would mean moving the work
> of broadcasting to another cpu and modifying the cpuidle state table for
> it. Even with cpu0, if support to hotplug it out is enabled (maybe it is
> already), we will face the same issue and this gets very messy.
>
>> Wouldn't make sense and be less intrusive than the patchset you proposed ?
>
> Actually this patchset brings in a solution that is as less intrusive as
> possible. It makes the problem nearly invisible except for a failed
> return from a call into the broadcast framework. It simply asks the
> archs which do not have an external clock device to register a pseudo
> device with the broadcast framework and from then on everything just
> falls in place to enable deep idle states for such archs.

Hi Preeti,

thanks for the detailed explanation. I understand better now why you did 
it this way. Furthermore, as Thomas pointed me, what I missed is one cpu 
can't setup a local timer for another cpu, so what I was talking about 
does not make sense.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
