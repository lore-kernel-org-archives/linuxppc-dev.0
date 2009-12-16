Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0D378B7B69
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 19:25:00 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBGJOxkK011613
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 06:24:59 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBG8L6W11659034
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 19:21:06 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBG8Owvg015285
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 19:24:59 +1100
Message-ID: <4B289955.2010705@in.ibm.com>
Date: Wed, 16 Dec 2009 13:54:53 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Xiaotian Feng <xtfeng@gmail.com>
Subject: Re: [Next] CPU Hotplug test failures on powerpc
References: <4B2224C7.1020908@in.ibm.com>
	<7b6bb4a50912152225p4f5dde13re83c439407c16eaf@mail.gmail.com>
	<4B288131.2050306@in.ibm.com>
	<7b6bb4a50912152245v61a7f1ebgb41f4857134f3476@mail.gmail.com>
	<4B288413.2070704@in.ibm.com> <1260947890.8023.1281.camel@laptop>
	<7b6bb4a50912152357m75aea5dfl6fe063d716517baf@mail.gmail.com>
In-Reply-To: <7b6bb4a50912152357m75aea5dfl6fe063d716517baf@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Xiaotian Feng wrote:
> Could follow be possible?  We know there's cpu 0 and cpu 1,
>
> offline cpu1 > done
> offline cpu0 > false
>
> consider this in cpu_down code,
>
>
> int __ref cpu_down(unsigned int cpu)
> {
> <snip>
>         set_cpu_active(cpu, false); // here, we set cpu 0 to inactive
>
>         synchronize_sched();
>
>         err = _cpu_down(cpu, 0);
> out:
> <snip>
> }
>
> Then in _cpu_down code:
>
> static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
> {
> <snip>
>         if (num_online_cpus() == 1)        // if we're trying to
> offline cpu0, num_online_cpus will be 1
>                 return -EBUSY;                    // after return back
> to cpu_down, we didn't change cpu 0 back to active
>
>         if (!cpu_online(cpu))
>                 return -EINVAL;
>
>         if (!alloc_cpumask_var(&old_allowed, GFP_KERNEL))
>                 return -ENOMEM;
> <snip>
> }
>
> Then cpu 0 is not active, but online, then we try to offline cpu1, .......
> This can not be exposed because x86 does not have
> /sys/devices/system/cpu0/online.
> I guess following patch fixes this bug.
>   
Just tested this one on the POWER box and the test passed.
I did not observe the hang.

Thanks
-Sachin

> ---
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 291ac58..21ddace 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -199,14 +199,18 @@ static int __ref _cpu_down(unsigned int cpu, int
> tasks_frozen)
>                 .hcpu = hcpu,
>         };
>
> -       if (num_online_cpus() == 1)
> +       if (num_online_cpus() == 1) {
> +               set_cpu_active(cpu, true);
>                 return -EBUSY;
> +       }
>
>         if (!cpu_online(cpu))
>                 return -EINVAL;
>
> -       if (!alloc_cpumask_var(&old_allowed, GFP_KERNEL))
> +       if (!alloc_cpumask_var(&old_allowed, GFP_KERNEL)) {
> +               set_cpu_active(cpu, true);
>                 return -ENOMEM;
> +       }
>
>         cpu_hotplug_begin();
>         err = __raw_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE | mod,
>
>
>   
>> Unless of course, I messed up, which appears to be rather likely given
>> these problems ;-)
>>
>>
>>     
>
>   


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
