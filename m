Return-Path: <wangyun@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D1382C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 20:08:55 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <wangyun@linux.vnet.ibm.com>;
 Tue, 2 Jul 2013 19:59:00 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 447B83578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 20:08:45 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r629rceX56426592
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jul 2013 19:53:38 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r62A8gWL027027
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jul 2013 20:08:44 +1000
Message-ID: <51D2A6A2.207@linux.vnet.ibm.com>
Date: Tue, 02 Jul 2013 18:08:34 +0800
From: Michael Wang <wangyun@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 10/45] smp: Use get/put_online_cpus_atomic() to prevent
 CPU offline
References: <20130627195136.29830.10445.stgit@srivatsabhat.in.ibm.com>
 <20130627195418.29830.34958.stgit@srivatsabhat.in.ibm.com>
 <51D2660A.8000401@linux.vnet.ibm.com> <51D28E69.9060205@linux.vnet.ibm.com>
 <51D2939C.5090205@linux.vnet.ibm.com> <51D2A289.7070805@linux.vnet.ibm.com>
In-Reply-To: <51D2A289.7070805@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: peterz@infradead.org, fweisbec@gmail.com, Shaohua Li <shli@fusionio.com>,
 linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 namhyung@kernel.org, tglx@linutronix.de, Wang YanQing <udknight@gmail.com>,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 oleg@redhat.com, sbw@mit.edu, David.Laight@aculab.com, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 liguang <lig.fnst@cn.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2013 05:51 PM, Srivatsa S. Bhat wrote:
[snip]
> 
> Well, as I said, its timing dependent. We might miss the newly onlined CPU in
> the for_each_online_cpu() loop itself, based on when exactly the CPU was added
> to the cpu_online_mask. So you can't exactly pin-point the places where you'll
> miss the CPU and where you won't. Besides, is it _that_ important? It is after
> all unpredictable..

Sure, it's nothing important ;-)

I just think this comment:

+ * We use get/put_online_cpus_atomic() to protect against CPUs going
+ * offline but not online. CPUs going online during the call will
+ * not be seen or sent an IPI

It told people that the cpu could online during the call, but won't get
IPI, while actually they have a chance to get it, folks haven't look
inside may missed some thing when use it.

But it's just self-opinion, so let's put down the discuss :)

Regards,
Michael Wang

> 
>> The comment position seems like it declaim that during the call of this
>> func, online-cpu won't be seem and send IPI...
>>
> 
> Doesn't matter, AFAICS. The key take-away from that whole comment is: nothing is
> done to prevent CPUs from coming online while the function is running, whereas
> the online CPUs are guaranteed to remain online throughout the function. In other
> words, its a weaker form of get_online_cpus()/put_online_cpus(), providing a
> one-way synchronization (CPU offline).
> 
> As long as that idea is conveyed properly, the purpose of that comment is served,
> IMHO.
> 
> Regards,
> Srivatsa S. Bhat
> 
> 
>>>>>   *
>>>>>   * You must not call this function with disabled interrupts or
>>>>>   * from a hardware interrupt handler or from a bottom half handler.
>>>>> @@ -641,26 +649,26 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
>>>>>  	might_sleep_if(gfp_flags & __GFP_WAIT);
>>>>>
>>>>>  	if (likely(zalloc_cpumask_var(&cpus, (gfp_flags|__GFP_NOWARN)))) {
>>>>> -		preempt_disable();
>>>>> +		get_online_cpus_atomic();
>>>>>  		for_each_online_cpu(cpu)
>>>>>  			if (cond_func(cpu, info))
>>>>>  				cpumask_set_cpu(cpu, cpus);
>>>>>  		on_each_cpu_mask(cpus, func, info, wait);
>>>>> -		preempt_enable();
>>>>> +		put_online_cpus_atomic();
>>>>>  		free_cpumask_var(cpus);
>>>>>  	} else {
>>>>>  		/*
>>>>>  		 * No free cpumask, bother. No matter, we'll
>>>>>  		 * just have to IPI them one by one.
>>>>>  		 */
>>>>> -		preempt_disable();
>>>>> +		get_online_cpus_atomic();
>>>>>  		for_each_online_cpu(cpu)
>>>>>  			if (cond_func(cpu, info)) {
>>>>>  				ret = smp_call_function_single(cpu, func,
>>>>>  								info, wait);
>>>>>  				WARN_ON_ONCE(!ret);
>>>>>  			}
>>>>> -		preempt_enable();
>>>>> +		put_online_cpus_atomic();
>>>>>  	}
>>>>>  }
>>>>>  EXPORT_SYMBOL(on_each_cpu_cond);
>>>>>
>>>>
>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
