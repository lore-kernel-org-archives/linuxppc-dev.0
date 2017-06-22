Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wts3k2chjzDqjf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 05:25:06 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MJNcCX022894
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:25:04 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b8kvr099b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 15:25:03 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 22 Jun 2017 16:25:01 -0300
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5MJOvd41704296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 16:24:57 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5MJOxR5006022
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 16:25:00 -0300
References: <1497996510-4032-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8737attzw5.fsf@concordia.ellerman.id.au> <87h8z8g6wu.fsf@linux.vnet.ibm.com>
 <87r2ycqigf.fsf@concordia.ellerman.id.au>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 John Allen <jallen@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] powerpc: Only obtain cpu_hotplug_lock if called by rtasd
In-reply-to: <87r2ycqigf.fsf@concordia.ellerman.id.au>
Date: Thu, 22 Jun 2017 16:24:47 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tkjn7uo.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Michael Ellerman <mpe@ellerman.id.au> writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>>>
>>>> Calling arch_update_cpu_topology from a CPU hotplug state machine callback
>>>> hits a deadlock because the function tries to get a read lock on
>>>> cpu_hotplug_lock while the state machine still holds a write lock on it.
>>>>
>>>> Since all callers of arch_update_cpu_topology except rtasd already hold
>>>> cpu_hotplug_lock, this patch changes the function to use
>>>> stop_machine_cpuslocked and creates a separate function for rtasd which
>>>> still tries to obtain the lock.
>>>>
>>>> Michael Bringmann investigated the bug and provided a detailed analysis
>>>> of the deadlock on this previous RFC for an alternate solution:
>>>>
>>>> https://patchwork.ozlabs.org/patch/771293/
>>>
>>> Do we know when this broke? Or has it never worked?
>>
>> It's been broken since at least v4.4, I think. I don't know about
>> earlier versions.
>
> OK.
>
> Just to be clear, this is happening on a 4.12-rcX system with no other
> patches?
>
> The code in arch_update_cpu_topology() has used stop_machine() since 
> 30c05350c39d ("powerpc/pseries: Use stop machine to update cpu maps")
> which went into v3.10, about 4 years ago.
>
> Prior to that it used get/put_online_cpus(), since 9eff1a38407c
> ("powerpc/pseries: Poll VPA for topology changes and update NUMA maps"),
> which was 2.6.38 in 2010.
>
> I wouldn't rule out the possibility it's been broken for 7 years, but I
> wonder if something else has changed to cause it to break.
>
> We really need to work it out before we backport anything.

Michael Bringmann provided this information:

    We need at least one patch to show the issue in the latest 4.12
    codebase:

    [PATCH V6 2/2] powerpc/numa: Update CPU topology when VPHN enabled
    https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-June/159341.html

    Reason: Prior to this patch we were not exercising the PowerPC VPHN
    hcall nor the associated path through the kernel/sched code that
    encounters the problem. All CPUs, whether present at boot or
    hot-added, are added to node 0 without this patch. This
    representation of the topology is incorrect in many/most cases.

    cpu_hotplug_begin() + get_online_cpus() have potentially been broken
    since the implementation of multithreading for _cpu_up() and
    _cpu_down().

    Reason: 'cpu_hotplug.active_writer' check in get_online_cpus() is
    dependent upon the nested routines that call get_online_cpus() to
    execute in the same thread as the one that invokes
    'cpu_hotplug_begin'.

    PowerPC's version of arch_update_cpu_topology() has used
    stop_machine() or get_online_cpus() for years, since at least 2011.

    Practically speaking, until the recent patch, in the 4.12 codebase
    PowerPC CPUs are being added only to nodes that were online at boot,
    and the topology did not change enough to trigger the paths through
    'stop_machine'.

    I can't say for certain about the earlier code bases where
    'arch_update_cpu_topology' used 'get_online_cpus'/'put_online_cpus'
    directly.

>>> Should it go to stable? (can't in its current form AFAICS)
>>
>> It's not hard to backport both this patch and commit fe5595c07400
>> ("stop_machine: Provide stop_machine_cpuslocked()") from branch
>> smp/hotplug in tip.git for stable.
>
> Yeah but it's not really my business backporting that unfortunately.

Sorry, I wasn't clear. I was offering to provide backported patches for
the relevant stable branches.

Though that will only be necessary if we also backport the topology
fixes as well.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
