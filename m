Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdj0J6PQ2zDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 19:36:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
In-Reply-To: <54877b2b-8446-20f6-e316-25af809ae11f@linux.vnet.ibm.com>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
 <87zie08ekt.fsf@concordia.ellerman.id.au>
 <20170526143147.z4lmtrs7vowucbkf@arbab-laptop.localdomain>
 <87lgpg6xe2.fsf@concordia.ellerman.id.au>
 <54877b2b-8446-20f6-e316-25af809ae11f@linux.vnet.ibm.com>
Date: Thu, 01 Jun 2017 19:36:31 +1000
Message-ID: <87tw402go0.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> On 05/29/2017 12:32 AM, Michael Ellerman wrote:
>> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>> 
>>> On Fri, May 26, 2017 at 01:46:58PM +1000, Michael Ellerman wrote:
>>>> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>>>>
>>>>> On Thu, May 25, 2017 at 04:19:53PM +1000, Michael Ellerman wrote:
>>>>>> The commit message for 3af229f2071f says:
>>>>>>
>>>>>>    In practice, we never see a system with 256 NUMA nodes, and in fact, we
>>>>>>    do not support node hotplug on power in the first place, so the nodes
>>>>>>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>    that are online when we come up are the nodes that will be present for
>>>>>>    the lifetime of this kernel.
>>>>>>
>>>>>> Is that no longer true?
>>>>>
>>>>> I don't know what the reasoning behind that statement was at the time,
>>>>> but as far as I can tell, the only thing missing for node hotplug now is
>>>>> Balbir's patchset [1]. He fixes the resource issue which motivated
>>>>> 3af229f2071f and reverts it.
>>>>>
>>>>> With that set, I can instantiate a new numa node just by doing
>>>>> add_memory(nid, ...) where nid doesn't currently exist.
>>>>
>>>> But does that actually happen on any real system?
>>>
>>> I don't know if anything currently tries to do this. My interest in 
>>> having this working is so that in the future, our coherent gpu memory 
>>> could be added as a distinct node by the device driver.
>> 
>> Sure. If/when that happens, we would hopefully still have some way to
>> limit the size of the possible map.
>> 
>> That would ideally be a firmware property that tells us the maximum
>> number of GPUs that might be hot-added, or we punt and cap it at some
>> "sane" maximum number.
>> 
>> But until that happens it's silly to say we can have up to 256 nodes
>> when in practice most of our systems have 8 or less.
>> 
>> So I'm still waiting for an explanation from Michael B on how he's
>> seeing this bug in practice.
>
> I already answered this in an earlier message.

Which one? I must have missed it.

> I will give an example.
>
> * Let there be a configuration with nodes (0, 4-5, 8) that boots with 1 VP
>   and 10G of memory in a shared processor configuration.
> * At boot time, 4 nodes are put into the possible map by the PowerPC boot
>   code.

I'm pretty sure we never add nodes to the possible map, it starts out
with MAX_NUMNODES possible and that's it.

Do you actually see mention of nodes 0 and 8 in the dmesg?

What does it say?

> * Subsequently, the NUMA code executes and puts the 10G memory into nodes
>   4 & 5.  No memory goes into Node 0.  So we now have 2 nodes in the
>   node_online_map.
> * The VP and its threads get assigned to Node 4.
> * Then when 'initmem_init()' in 'powerpc/numa.c' executes the instruction,
>      node_and(node_possible_map, node_possible_map, node_online_map);
>   the content of the node_possible_map is reduced to nodes 4-5.
> * Later on we hot-add 90G of memory to the system.  It tries to put the
>   memory into nodes 0, 4-5, 8 based on the memory association map.  We
>   should see memory put into all 4 nodes.  However, since we have reduced
>   the 'node_possible_map' to only nodes 4 & 5, we can now only put memory
>   into 2 of the configured nodes.

Right. So it's not that you're hot adding memory into a previously
unseen node as you implied in earlier mails.

> # We want to be able to put memory into all 4 nodes via hot-add operations,
>   not only the nodes that 'survive' boot time initialization.  We could
>   make a number of changes to ensure that all of the nodes in the initial
>   configuration provided by the pHyp can be used, but this one appears to
>   be the simplest, only using resources requested by the pHyp at boot --
>   even if those resource are not used immediately.

I don't think that's what the patch does. It just marks 32 (!?) nodes as
online. Or if you're talking about reverting 3af229f2071f that leaves
you with 256 possible nodes. Both of which are wasteful.

The right fix is to make sure any nodes which are present at boot remain
in the possible map, even if they don't have memory/CPUs assigned at
boot.

What does your device tree look like? Can you send us the output of:

 $ lsprop /proc/device-tree


cheers
