Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F8331400BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2014 18:25:27 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 8 Apr 2014 18:25:19 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8745E2CE803F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2014 18:25:17 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s388P3SL10486156
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Apr 2014 18:25:03 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s388P9YY018639
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Apr 2014 18:25:09 +1000
Message-ID: <5343B246.1080909@linux.vnet.ibm.com>
Date: Tue, 08 Apr 2014 13:54:38 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael wang <wangyun@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] power,
 sched: stop updating inside arch_update_cpu_topology()
 when nothing to be update
References: <533B8431.8090507@linux.vnet.ibm.com>
 <53436AC8.5020705@linux.vnet.ibm.com>
In-Reply-To: <53436AC8.5020705@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, LKML <linux-kernel@vger.kernel.org>, paulus@samba.org,
 alistair@popple.id.au, nfont@linux.vnet.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/08/2014 08:49 AM, Michael wang wrote:
> Since v1:
> 	Edited the comment according to Srivatsa's suggestion.
> 
> During the testing, we encounter below WARN followed by Oops:
> 
> 	WARNING: at kernel/sched/core.c:6218
> 	...
> 	NIP [c000000000101660] .build_sched_domains+0x11d0/0x1200
> 	LR [c000000000101358] .build_sched_domains+0xec8/0x1200
> 	PACATMSCRATCH [800000000000f032]
> 	Call Trace:
> 	[c00000001b103850] [c000000000101358] .build_sched_domains+0xec8/0x1200
> 	[c00000001b1039a0] [c00000000010aad4] .partition_sched_domains+0x484/0x510
> 	[c00000001b103aa0] [c00000000016d0a8] .rebuild_sched_domains+0x68/0xa0
> 	[c00000001b103b30] [c00000000005cbf0] .topology_work_fn+0x10/0x30
> 	...
> 	Oops: Kernel access of bad area, sig: 11 [#1]
> 	...
> 	NIP [c00000000045c000] .__bitmap_weight+0x60/0xf0
> 	LR [c00000000010132c] .build_sched_domains+0xe9c/0x1200
> 	PACATMSCRATCH [8000000000029032]
> 	Call Trace:
> 	[c00000001b1037a0] [c000000000288ff4] .kmem_cache_alloc_node_trace+0x184/0x3a0
> 	[c00000001b103850] [c00000000010132c] .build_sched_domains+0xe9c/0x1200
> 	[c00000001b1039a0] [c00000000010aad4] .partition_sched_domains+0x484/0x510
> 	[c00000001b103aa0] [c00000000016d0a8] .rebuild_sched_domains+0x68/0xa0
> 	[c00000001b103b30] [c00000000005cbf0] .topology_work_fn+0x10/0x30
> 	...
> 
> This was caused by that 'sd->groups == NULL' after building groups, which
> was caused by the empty 'sd->span'.
> 
> The cpu's domain contained nothing because the cpu was assigned to a wrong
> node, due to the following unfortunate sequence of events:
> 
> 1. The hypervisor sent a topology update to the guest OS, to notify changes
>    to the cpu-node mapping. However, the update was actually redundant - i.e.,
>    the "new" mapping was exactly the same as the old one.
> 
> 2. Due to this, the 'updated_cpus' mask turned out to be empty after exiting
>    the 'for-loop' in arch_update_cpu_topology().
> 
> 3. So we ended up calling stop-machine() with an empty cpumask list, which made
>    stop-machine internally elect cpumask_first(cpu_online_mask), i.e., CPU0 as
>    the cpu to run the payload (the update_cpu_topology() function).
> 
> 4. This causes update_cpu_topology() to be run by CPU0. And since 'updates'
>    is kzalloc()'ed inside arch_update_cpu_topology(), update_cpu_topology()
>    finds update->cpu as well as update->new_nid to be 0. In other words, we
>    end up assigning CPU0 (and eventually its siblings) to node 0, incorrectly.
> 
> Along with the following wrong updating, it causes the sched-domain rebuild
> code to break and crash the system.
> 
> Fix this by skipping the topology update in cases where we find that
> the topology has not actually changed in reality (ie., spurious updates).
> 
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> CC: Stephen Rothwell <sfr@canb.auug.org.au>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Robert Jennings <rcj@linux.vnet.ibm.com>
> CC: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> CC: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> CC: Alistair Popple <alistair@popple.id.au>
> Suggested-by: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Michael Wang <wangyun@linux.vnet.ibm.com>
> ---

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

>  arch/powerpc/mm/numa.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 30a42e2..4ebbb9e 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1591,6 +1591,20 @@ int arch_update_cpu_topology(void)
>  		cpu = cpu_last_thread_sibling(cpu);
>  	}
> 
> +	/*
> +	 * In cases where we have nothing to update (because the updates list
> +	 * is too short or because the new topology is same as the old one),
> +	 * skip invoking update_cpu_topology() via stop-machine(). This is
> +	 * necessary (and not just a fast-path optimization) since stop-machine
> +	 * can end up electing a random CPU to run update_cpu_topology(), and
> +	 * thus trick us into setting up incorrect cpu-node mappings (since
> +	 * 'updates' is kzalloc()'ed).
> +	 *
> +	 * And for the similar reason, we will skip all the following updating.
> +	 */
> +	if (!cpumask_weight(&updated_cpus))
> +		goto out;
> +
>  	stop_machine(update_cpu_topology, &updates[0], &updated_cpus);
> 
>  	/*
> @@ -1612,6 +1626,7 @@ int arch_update_cpu_topology(void)
>  		changed = 1;
>  	}
> 
> +out:
>  	kfree(updates);
>  	return changed;
>  }
> 
