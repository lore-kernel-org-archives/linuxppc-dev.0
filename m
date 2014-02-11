Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4A4A52C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 09:01:25 +1100 (EST)
Received: by mail-wi0-f180.google.com with SMTP id hm4so5471426wib.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 14:01:20 -0800 (PST)
Message-ID: <52FA9DAE.1040603@linaro.org>
Date: Tue, 11 Feb 2014 23:01:18 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V4 2/3] tick/cpuidle: Initialize hrtimer mode of broadcast
References: <20140207075618.17187.20149.stgit@preeti.in.ibm.com>
 <20140207080632.17187.80532.stgit@preeti.in.ibm.com>
 <52F9F896.4020402@linaro.org>
 <alpine.DEB.2.02.1402111654190.21991@ionos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.02.1402111654190.21991@ionos.tec.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: deepthi@linux.vnet.ibm.com, linux-pm@vger.kernel.org, peterz@infradead.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, fweisbec@gmail.com,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2014 04:58 PM, Thomas Gleixner wrote:
> On Tue, 11 Feb 2014, Daniel Lezcano wrote:
>> On 02/07/2014 09:06 AM, Preeti U Murthy wrote:
>> Setting the smp affinity on the earliest timer should be handled automatically
>> with the CLOCK_EVT_FEAT_DYNIRQ flag. Did you look at using this flag ?
>
> How should this flag help? Not at all, because the hrtimer based
> broadcast device cannot assign affinities.
>
>> Another comment is the overall approach. We enter the cpuidle idle framework
>> with a specific state to go to and it is the tick framework telling us we
>> mustn't go to this state. IMO the logic is wrong, the decision to not enter
>> this state should be moved somewhere else.
>>
>> Why don't you create a cpuidle driver with the shallow idle states assigned to
>> a cpu (let's say cpu0) and another one with all the deeper idle states for the
>> rest of the cpus ? Using the multiple cpuidle driver support makes it
>> possible. The timer won't be moving around and a cpu will be dedicated to act
>> as the broadcast timer.
>>
>> Wouldn't make sense and be less intrusive than the patchset you proposed ?
>
> How do you arm the broadcast timer on CPU0 from CPU1? You can't!
>
> You cannot access the cpu local timer on a different cpu. So you would
> have to send an IPI over to CPU0 so that it can reevaluate and
> schedule the broadcast. That's even more backwards than telling the
> cpuidle code that the CPU is not in a state to go deep.

Indeed :)

Thanks for the clarification.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
