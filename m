Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7LnK5MvgzDr69
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 05:26:12 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v95INXZJ085945
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Oct 2017 14:26:09 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ddrnmvpcs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 14:26:09 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 5 Oct 2017 14:26:08 -0400
References: <20171005000430.8080-1-bauerman@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710051435530.2083@nanos>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Black <daniel.black@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Drop lockdep_assert_cpus_held call from
 arch_update_cpu_topology
In-reply-to: <alpine.DEB.2.20.1710051435530.2083@nanos>
Date: Thu, 05 Oct 2017 15:26:01 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87o9pl5u4m.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello Thomas,

Thanks for your comments.

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, 4 Oct 2017, Thiago Jung Bauermann wrote:
>
>> It turns out that not all paths calling arch_update_cpu_topology hold
>> cpu_hotplug_lock, but that's ok because those paths aren't supposed to race
>> with any concurrent hotplug events.
>> 
>> Callers of arch_update_cpu_topology are expected to know what they are
>> doing when they call the function without holding the lock, so remove the
>> lockdep warning.
>
> "Expected to know what they are doing" is not really a good approach as
> it's way too simple to screw things up.

I agree.

> You might consider to have two functions where one does the check and the
> other does not, but I leave that to the PPC maintainers.

It doesn't look like powerpc uses arch_update_cpu_topology differently
than other arches. Are you saying that all callers of the function
should be holding cpu_hotplug_lock? I came to the conclusion that this
isn't the case because of two things:

1. This comment in sched_init_smp:

	/*
	 * There's no userspace yet to cause hotplug operations; hence all the
	 * CPU masks are stable and all blatant races in the below code cannot
	 * happen.
	 */
	mutex_lock(&sched_domains_mutex);
	sched_init_domains(cpu_active_mask);
	cpumask_andnot(non_isolated_cpus, cpu_possible_mask, cpu_isolated_map);
	if (cpumask_empty(non_isolated_cpus))
		cpumask_set_cpu(smp_processor_id(), non_isolated_cpus);
	mutex_unlock(&sched_domains_mutex);

   This is relevant for the following call trace:

	[c000003ff6107b50] [c00000000010ac70] lockdep_assert_cpus_held+0x50/0x70 (unreliable)
	[c000003ff6107b70] [c0000000000802c0] arch_update_cpu_topology+0x20/0x40
	[c000003ff6107b90] [c000000000182ec4] sched_init_domains+0x74/0x100
	[c000003ff6107bd0] [c000000000ed5c78] sched_init_smp+0x58/0x168
	[c000003ff6107d00] [c000000000eb460c] kernel_init_freeable+0x1fc/0x3ac
	[c000003ff6107dc0] [c00000000000dc2c] kernel_init+0x2c/0x150
	[c000003ff6107e30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70

2. Your comment on patch "lockup_detector: Cleanup hotplug locking mess"¹:

    "All watchdog thread related functions are delegated to the smpboot thread
     infrastructure, which handles serialization against CPU hotplug correctly."

   Though TBH I'm still grasping the smpboot thread infrastructure and
   I'm not sure how it handles serialization against CPU hotplug.

   This is relevant for the following call trace:

	[c000001ff257ba00] [c0000000000f8618] lockdep_assert_cpus_held+0x48/0x80 (unreliable)
	[c000001ff257ba20] [c00000000007a848] arch_update_cpu_topology+0x18/0x30
	[c000001ff257ba40] [c00000000016bd0c] partition_sched_domains+0x8c/0x4e0
	[c000001ff257baf0] [c00000000020a914] cpuset_update_active_cpus+0x24/0x60
	[c000001ff257bb10] [c0000000001449bc] sched_cpu_deactivate+0xfc/0x1a0
	[c000001ff257bc20] [c0000000000f5a8c] cpuhp_invoke_callback+0x19c/0xe00
	[c000001ff257bcb0] [c0000000000f6868] cpuhp_down_callbacks+0x78/0xf0
	[c000001ff257bd00] [c0000000000f6c1c] cpuhp_thread_fun+0x1fc/0x210
	[c000001ff257bd50] [c000000000132f4c] smpboot_thread_fn+0x2fc/0x370
	[c000001ff257bdc0] [c00000000012ca24] kthread+0x1b4/0x1c0
	[c000001ff257be30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70

>From what you said though it looks like the lockdep assertion shouldn't
have been triggered in either case. I'll keep digging.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


¹ https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-September/163477.html
