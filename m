Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wthh0730hzDr0W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 23:07:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 John Allen <jallen@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] powerpc: Only obtain cpu_hotplug_lock if called by rtasd
In-Reply-To: <87h8z8g6wu.fsf@linux.vnet.ibm.com>
References: <1497996510-4032-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8737attzw5.fsf@concordia.ellerman.id.au> <87h8z8g6wu.fsf@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 23:07:28 +1000
Message-ID: <87r2ycqigf.fsf@concordia.ellerman.id.au>
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

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>>
>>> Calling arch_update_cpu_topology from a CPU hotplug state machine callback
>>> hits a deadlock because the function tries to get a read lock on
>>> cpu_hotplug_lock while the state machine still holds a write lock on it.
>>>
>>> Since all callers of arch_update_cpu_topology except rtasd already hold
>>> cpu_hotplug_lock, this patch changes the function to use
>>> stop_machine_cpuslocked and creates a separate function for rtasd which
>>> still tries to obtain the lock.
>>>
>>> Michael Bringmann investigated the bug and provided a detailed analysis
>>> of the deadlock on this previous RFC for an alternate solution:
>>>
>>> https://patchwork.ozlabs.org/patch/771293/
>>
>> Do we know when this broke? Or has it never worked?
>
> It's been broken since at least v4.4, I think. I don't know about
> earlier versions.

OK.

Just to be clear, this is happening on a 4.12-rcX system with no other
patches?


The code in arch_update_cpu_topology() has used stop_machine() since 
30c05350c39d ("powerpc/pseries: Use stop machine to update cpu maps")
which went into v3.10, about 4 years ago.

Prior to that it used get/put_online_cpus(), since 9eff1a38407c
("powerpc/pseries: Poll VPA for topology changes and update NUMA maps"),
which was 2.6.38 in 2010.

I wouldn't rule out the possibility it's been broken for 7 years, but I
wonder if something else has changed to cause it to break.

We really need to work it out before we backport anything.

>> Should it go to stable? (can't in its current form AFAICS)
>
> It's not hard to backport both this patch and commit fe5595c07400
> ("stop_machine: Provide stop_machine_cpuslocked()") from branch
> smp/hotplug in tip.git for stable.

Yeah but it's not really my business backporting that unfortunately.

> Since rtasd only started calling arch_update_cpu_topology since v4.11,
> for earlier versions this patch can be simplified to making that
> function call stop_machine_cpuslocked unconditionally instead of
> defining a separate function.

OK.

cheers
