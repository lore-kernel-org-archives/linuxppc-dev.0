Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40E1C2C00B1
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2014 07:49:14 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Thu, 13 Mar 2014 02:19:08 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6851A1258055
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2014 02:21:20 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2CKn0Hf50659420
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2014 02:19:00 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2CKn3mO006644
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2014 02:19:05 +0530
Message-ID: <5320C839.5010206@linux.vnet.ibm.com>
Date: Thu, 13 Mar 2014 02:18:57 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 00/52] CPU hotplug: Fix issues with callback
 registration
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
 <20140311150733.efcc594dd7fe59c9c5fe9325@linux-foundation.org>
In-Reply-To: <20140311150733.efcc594dd7fe59c9c5fe9325@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, ego@linux.vnet.ibm.com, walken@google.com,
 linux@arm.linux.org.uk, linux-pm@vger.kernel.org, peterz@infradead.org,
 rusty@rustcorp.com.au, rjw@rjwysocki.net, oleg@redhat.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
 tj@kernel.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/12/2014 03:37 AM, Andrew Morton wrote:
> On Tue, 11 Mar 2014 02:03:52 +0530 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> 
>> Hi,
>>
>> Many subsystems and drivers have the need to register CPU hotplug callbacks
>> from their init routines and also perform initialization for the CPUs that are
>> already online. But unfortunately there is no race-free way to achieve this
>> today.
>>
>> For example, consider this piece of code:
>>
>> 	get_online_cpus();
>>
>> 	for_each_online_cpu(cpu)
>> 		init_cpu(cpu);
>>
>> 	register_cpu_notifier(&foobar_cpu_notifier);
>>
>> 	put_online_cpus();
>>
>> This is not safe because there is a possibility of an ABBA deadlock involving
>> the cpu_add_remove_lock and the cpu_hotplug.lock.
>>
>>           CPU 0                                         CPU 1
>>           -----                                         -----
>>
>>    Acquire cpu_hotplug.lock
>>    [via get_online_cpus()]
>>
>>                                               CPU online/offline operation
>>                                               takes cpu_add_remove_lock
>>                                               [via cpu_maps_update_begin()]
>>
>>    Try to acquire
>>    cpu_add_remove_lock
>>    [via register_cpu_notifier()]
>>
>>                                               CPU online/offline operation
>>                                               tries to acquire cpu_hotplug.lock
>>                                               [via cpu_hotplug_begin()]
> 
> Can't we fix this by using a different (ie: new) lock to protect
> cpu_chain?
> 

No, that won't be a better solution than this one :-( The reason is that
CPU_POST_DEAD notifiers are invoked with the cpu_hotplug.lock dropped (by
design). So if we introduce the new lock, the locking would look as shown
below at the CPU hotplug side:

[ Note that it is unsafe to acquire and release the cpu-chain lock separately
for each invocation of the notifiers, because that would allow manipulations
of the cpu-chain in between two sets of notifications (such as CPU_DOWN_PREPARE
and CPU_DEAD, corresponding to the same CPU hotplug operation), which is
clearly wrong. So we need to acquire the new lock at the very beginning of
the hotplug operation and release it at the very end, after all notifiers
have been invoked.]


cpu_maps_update_begin(); //acquire cpu_add_remove_lock
    cpu_hotplug_begin(); //acquire cpu_hotplug.lock

        cpu_chain_lock(); //acquire a new lock that protects the cpu_chain

		Invoke CPU_DOWN_PREPARE notifiers
		//take cpu offline using stop-machine
		Invoke CPU_DEAD notifiers

    cpu_hotplug_done(); //release cpu_hotplug.lock

		Invoke CPU_POST_DEAD notifiers

        cpu_chain_unlock(); //release a new lock that protects the cpu_chain

cpu_maps_update_done(); //release cpu_add_remove_lock


So, if you observe the nesting of locks, it looks weird, because
cpu_hotplug.lock is acquired first, followed by cpu_chain_lock,
but they are released in the same order! IOW, they don't nest "properly".

To avoid this, if we reorder the locks in such a way that cpu_chain_lock
is the outer lock compared to cpu_hotplug.lock, then it becomes exactly
same as cpu_add_remove_lock. In other words, we can reuse the
cpu_add_remove_lock for this very purpose of protecting the cpu-chains
without adding any new lock to the CPU hotplug core code. And this is
what the existing code already does. I just utilize this fact and make
sure that we don't deadlock in the scenarios mentioned in the cover-letter
of this patchset.

Regards,
Srivatsa S. Bhat
