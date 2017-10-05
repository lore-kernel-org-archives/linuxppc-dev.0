Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7MDn2bJ6zDrF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 05:46:32 +1100 (AEDT)
Date: Thu, 5 Oct 2017 20:46:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
cc: Daniel Black <daniel.black@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Drop lockdep_assert_cpus_held call from
 arch_update_cpu_topology
In-Reply-To: <87o9pl5u4m.fsf@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1710052031590.2398@nanos>
References: <20171005000430.8080-1-bauerman@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710051435530.2083@nanos>
 <87o9pl5u4m.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1223104522-1507229187=:2398"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1223104522-1507229187=:2398
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Thiago,

On Thu, 5 Oct 2017, Thiago Jung Bauermann wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> It doesn't look like powerpc uses arch_update_cpu_topology differently
> than other arches. Are you saying that all callers of the function
> should be holding cpu_hotplug_lock?

No. I didn't check as I was lazy and wanted you to do it. Which obviously
worked :)

> I came to the conclusion that this isn't the case because of two things:

> 1. This comment in sched_init_smp:
> 
> 	/*
> 	 * There's no userspace yet to cause hotplug operations; hence all the
> 	 * CPU masks are stable and all blatant races in the below code cannot
> 	 * happen.
> 	 */
> 	mutex_lock(&sched_domains_mutex);
> 	sched_init_domains(cpu_active_mask);
> 	cpumask_andnot(non_isolated_cpus, cpu_possible_mask, cpu_isolated_map);
> 	if (cpumask_empty(non_isolated_cpus))
> 		cpumask_set_cpu(smp_processor_id(), non_isolated_cpus);
> 	mutex_unlock(&sched_domains_mutex);
> 
>    This is relevant for the following call trace:
> 
> 	[c000003ff6107b50] [c00000000010ac70] lockdep_assert_cpus_held+0x50/0x70 (unreliable)
> 	[c000003ff6107b70] [c0000000000802c0] arch_update_cpu_topology+0x20/0x40
> 	[c000003ff6107b90] [c000000000182ec4] sched_init_domains+0x74/0x100
> 	[c000003ff6107bd0] [c000000000ed5c78] sched_init_smp+0x58/0x168
> 	[c000003ff6107d00] [c000000000eb460c] kernel_init_freeable+0x1fc/0x3ac
> 	[c000003ff6107dc0] [c00000000000dc2c] kernel_init+0x2c/0x150
> 	[c000003ff6107e30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70

Ok. That's safe.

> 2. Your comment on patch "lockup_detector: Cleanup hotplug locking mess"¹:
> 
>     "All watchdog thread related functions are delegated to the smpboot thread
>      infrastructure, which handles serialization against CPU hotplug correctly."
> 
>    Though TBH I'm still grasping the smpboot thread infrastructure and
>    I'm not sure how it handles serialization against CPU hotplug.

The thread infrastructur is simple:

registration/unregistration is serialized internally against
hotplug. Park/unpark happens from CPU hotplug context so that's serialized
obviously as well.

>    This is relevant for the following call trace:

Not really. The smpboot thread is just the context in which this
happens. That thread is the hotplug thread of a CPU which goes down and it
invokes one of the callbacks, which ends up in that assertion. These
invocations are triggered from a different thread which holds cpu hotplug
lock. But because its not the hotplug thread which holds the lock, lockdep
cant know that there is an indirect protection. Would be cool to have that,
but that's a different story.

> 	[c000001ff257ba00] [c0000000000f8618] lockdep_assert_cpus_held+0x48/0x80 (unreliable)
> 	[c000001ff257ba20] [c00000000007a848] arch_update_cpu_topology+0x18/0x30
> 	[c000001ff257ba40] [c00000000016bd0c] partition_sched_domains+0x8c/0x4e0
> 	[c000001ff257baf0] [c00000000020a914] cpuset_update_active_cpus+0x24/0x60
> 	[c000001ff257bb10] [c0000000001449bc] sched_cpu_deactivate+0xfc/0x1a0
> 	[c000001ff257bc20] [c0000000000f5a8c] cpuhp_invoke_callback+0x19c/0xe00
> 	[c000001ff257bcb0] [c0000000000f6868] cpuhp_down_callbacks+0x78/0xf0
> 	[c000001ff257bd00] [c0000000000f6c1c] cpuhp_thread_fun+0x1fc/0x210
> 	[c000001ff257bd50] [c000000000132f4c] smpboot_thread_fn+0x2fc/0x370
> 	[c000001ff257bdc0] [c00000000012ca24] kthread+0x1b4/0x1c0
> 	[c000001ff257be30] [c00000000000bcec] ret_from_kernel_thread+0x5c/0x70

So no, the lockdep assertion triggers in #1 and #2 because

   #1 does definitely not hold it

   #2 is indirectily protected, but we have no way to express that to lockdep

So yes, it's safe for both cases to remove that assertion.

If there are other call sites, then they need to be checked. If not, you're
good.

Thanks,

	tglx

--8323329-1223104522-1507229187=:2398--
