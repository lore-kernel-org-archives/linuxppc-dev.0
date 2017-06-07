Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjS3g1VHbzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 22:07:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
In-Reply-To: <20170601213310.uzal6zihfbxazysx@arbab-laptop.localdomain>
References: <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
 <87zie08ekt.fsf@concordia.ellerman.id.au>
 <20170526143147.z4lmtrs7vowucbkf@arbab-laptop.localdomain>
 <87lgpg6xe2.fsf@concordia.ellerman.id.au>
 <54877b2b-8446-20f6-e316-25af809ae11f@linux.vnet.ibm.com>
 <87tw402go0.fsf@concordia.ellerman.id.au>
 <20170601213310.uzal6zihfbxazysx@arbab-laptop.localdomain>
Date: Wed, 07 Jun 2017 22:07:26 +1000
Message-ID: <87wp8odmrl.fsf@concordia.ellerman.id.au>
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

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> On Thu, Jun 01, 2017 at 07:36:31PM +1000, Michael Ellerman wrote:
>>I don't think that's what the patch does. It just marks 32 (!?) nodes 
>>as online. Or if you're talking about reverting 3af229f2071f that 
>>leaves you with 256 possible nodes. Both of which are wasteful.
>
> To be clear, with Balbir's set the latter is no longer wasteful.

AFAIK that series has been rejected.

And even so, it only fixes one known case where having a very large
possible map is wasteful, there could be others we haven't found, or
there could be more introduced in future.

So we will always prefer to keep the possible map as small as it can be.

>>The right fix is to make sure any nodes which are present at boot 
>>remain in the possible map, even if they don't have memory/CPUs 
>>assigned at boot.
>
> I'm still hoping 3af229f2071f could indeed be reverted some day, but 
> until then the following would follow your suggestion for our GPU nodes.  
> What do you think?

Yeah we can do something like that.

We might want to come up with a generic property, rather than looking
specifically for ibm,coherent-device-memory.

And we might also need a way for skiboot to tell us "in addition to
what is in the device tree at boot, up to N more nodes could be hot
plugged".

cheers

> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -895,6 +895,7 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>  void __init initmem_init(void)
>  {
>  	int nid, cpu;
> +	struct device_node *dn;
>  
>  	max_low_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
>  	max_pfn = max_low_pfn;
> @@ -911,6 +912,18 @@ void __init initmem_init(void)
>  	 */
>  	nodes_and(node_possible_map, node_possible_map, node_online_map);
>  
> +	/*
> +	 * Consider an ibm,coherent-device-memory node possible. Even though
> +	 * it is not online at boot, it may be hotplugged later.
> +	 */
> +	for_each_compatible_node(dn, NULL, "ibm,coherent-device-memory") {
> +		nid = of_node_to_nid_single(dn);
> +		if (nid < 0)
> +			continue;
> +
> +		node_set(nid, node_possible_map);
> +	}
> +
>  	for_each_online_node(nid) {
>  		unsigned long start_pfn, end_pfn;
>  
>
> -- 
> Reza Arbab
