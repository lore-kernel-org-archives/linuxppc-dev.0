Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rB6YS1FMBzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 22:23:56 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rB6YR2n1Zz9t43
 for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2016 22:23:55 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 20 May 2016 17:53:51 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CE342E0040
 for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2016 17:57:01 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4KCNlYK54395038
 for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2016 17:53:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4KCNiA5028423
 for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2016 17:53:46 +0530
Message-ID: <573F01CD.6030107@linux.vnet.ibm.com>
Date: Fri, 20 May 2016 17:53:41 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
 <20160519114029.GW3193@twins.programming.kicks-ass.net>
In-Reply-To: <20160519114029.GW3193@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 05/19/2016 05:10 PM, Peter Zijlstra wrote:
> On Wed, May 18, 2016 at 11:11:51PM +0200, Rafael J. Wysocki wrote:
>> On Wed, May 18, 2016 at 2:53 PM, Shilpasri G Bhat
>> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>>> This patch adds driver callback for fast_switch and below observations
>>> on schedutil governor are done with this patch.
>>>
>>> In POWER8 there is a regression observed with schedutil compared to
>>> ondemand. With schedutil the frequency is not ramping down and is
>>> mostly stuck at max frequency during idle . This is because of the
>>> watchdog timer, an RT task which is fired every 4 seconds which
>>> results in requesting max frequency.
>>
>> Well, yes, that would be problematic.
>>
> 
> Right; we need to come up with something for RT tasks; but what happens
> if you disable the watchdog? This should be entirely doable and might
> give a better comparison.
> 

Below are the comparisons by disabling watchdog.
Both schedutil and ondemand have a similar ramp-down trend. And in both the
cases I can see that frequency of the cpu is not reduced in deterministic
fashion. In a observation window of 30 seconds after running a workload I can
see that the frequency is not ramped down on some cpus in the system and are
idling at max frequency.

Below are the sample trace showcasing the frequency request when the cpu enters
idle with schedutil.
<...>-3528  7650.011010: cpu_frequency: state=4322000 cpu_id=120
<...>-3528  7650.027540: sched_switch: prev_comm=ppc64_cpu prev_state=x ==>
			next_comm=swapper/120
<idle>-0    7650.035017: cpu_frequency: state=4322000 cpu_id=120
<idle>-0    7729.683536: cpu_frequency: state=4322000 cpu_id=120
<idle>-0    7729.683552: sched_switch: prev_comm=swapper/120 prev_state=R ==>
			next_comm=kworker/120:1
kworker/120  7729.683565: sched_switch: prev_comm=kworker/120:1 prev_state=S ==>
			 next_comm=swapper/120

However ondemand governor(with watchdog enabled) benefits from the noise created
by watchdog timer and is able to brig down the frequency.

Thanks and Regards,
Shilpa
