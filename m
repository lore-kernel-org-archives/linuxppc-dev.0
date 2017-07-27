Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJCM85CBXzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 23:22:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Possible circular locking dependency detected between
 cpu_hotplug_lock.rw_sem and wfc.work
In-Reply-To: <alpine.DEB.2.20.1707261437510.2186@nanos>
References: <87mv7r5s1y.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1707261437510.2186@nanos>
Date: Thu, 27 Jul 2017 23:22:27 +1000
Message-ID: <871sp2f20c.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, 26 Jul 2017, Michael Ellerman wrote:
>
>> Hi Thomas,
>> 
>> I'm seeing the lockdep barf below on some bare metal Power8 machines.
>> 
>> This seems to be caused by our smp_cpus_done(), which does:
>> 
>>   void __init smp_cpus_done(unsigned int max_cpus)
>>   {
>>   	/*
>>   	 * We want the setup_cpu() here to be called on the boot CPU, but
>>   	 * init might run on any CPU, so make sure it's invoked on the boot
>>   	 * CPU.
>>   	 */
>>   	if (smp_ops && smp_ops->setup_cpu)
>>   		work_on_cpu_safe(boot_cpuid, smp_setup_cpu_workfn, NULL);
>> 
>> 
>> I don't think CPU hotplug can happen at this point, so I don't think
>> there's really a bug.
>> 
>> But it looks like the work_on_cpu_safe() call could just go away, since
>> you pinned init to the boot CPU in 8fb12156b8db ("init: Pin init task to
>> the boot CPU, initially"). Though I can't see where init is unpinned, so
>> maybe we do still need to do it?
>
> It's undone in sched_init_smp(). So it looks safe. The call order is:
>
>      smp_init()
> 	...
> 	smp_cpus_done()
>
>      sched_init_smp()

Great thanks.

Patch on the way.

cheers
