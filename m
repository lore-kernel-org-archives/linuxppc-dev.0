Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdC1N37QlzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 00:05:44 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4VE3h1W011931
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 10:05:36 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2asj431bhe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 10:05:36 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 31 May 2017 08:05:35 -0600
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
To: Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Wed, 31 May 2017 09:05:28 -0500
MIME-Version: 1.0
In-Reply-To: <87lgpg6xe2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <54877b2b-8446-20f6-e316-25af809ae11f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/29/2017 12:32 AM, Michael Ellerman wrote:
> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
> 
>> On Fri, May 26, 2017 at 01:46:58PM +1000, Michael Ellerman wrote:
>>> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>>>
>>>> On Thu, May 25, 2017 at 04:19:53PM +1000, Michael Ellerman wrote:
>>>>> The commit message for 3af229f2071f says:
>>>>>
>>>>>    In practice, we never see a system with 256 NUMA nodes, and in fact, we
>>>>>    do not support node hotplug on power in the first place, so the nodes
>>>>>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>    that are online when we come up are the nodes that will be present for
>>>>>    the lifetime of this kernel.
>>>>>
>>>>> Is that no longer true?
>>>>
>>>> I don't know what the reasoning behind that statement was at the time,
>>>> but as far as I can tell, the only thing missing for node hotplug now is
>>>> Balbir's patchset [1]. He fixes the resource issue which motivated
>>>> 3af229f2071f and reverts it.
>>>>
>>>> With that set, I can instantiate a new numa node just by doing
>>>> add_memory(nid, ...) where nid doesn't currently exist.
>>>
>>> But does that actually happen on any real system?
>>
>> I don't know if anything currently tries to do this. My interest in 
>> having this working is so that in the future, our coherent gpu memory 
>> could be added as a distinct node by the device driver.
> 
> Sure. If/when that happens, we would hopefully still have some way to
> limit the size of the possible map.
> 
> That would ideally be a firmware property that tells us the maximum
> number of GPUs that might be hot-added, or we punt and cap it at some
> "sane" maximum number.
> 
> But until that happens it's silly to say we can have up to 256 nodes
> when in practice most of our systems have 8 or less.
> 
> So I'm still waiting for an explanation from Michael B on how he's
> seeing this bug in practice.

I already answered this in an earlier message.  I will give an example.

* Let there be a configuration with nodes (0, 4-5, 8) that boots with 1 VP
  and 10G of memory in a shared processor configuration.
* At boot time, 4 nodes are put into the possible map by the PowerPC boot
  code.
* Subsequently, the NUMA code executes and puts the 10G memory into nodes
  4 & 5.  No memory goes into Node 0.  So we now have 2 nodes in the
  node_online_map.
* The VP and its threads get assigned to Node 4.
* Then when 'initmem_init()' in 'powerpc/numa.c' executes the instruction,
     node_and(node_possible_map, node_possible_map, node_online_map);
  the content of the node_possible_map is reduced to nodes 4-5.
* Later on we hot-add 90G of memory to the system.  It tries to put the
  memory into nodes 0, 4-5, 8 based on the memory association map.  We
  should see memory put into all 4 nodes.  However, since we have reduced
  the 'node_possible_map' to only nodes 4 & 5, we can now only put memory
  into 2 of the configured nodes.

# We want to be able to put memory into all 4 nodes via hot-add operations,
  not only the nodes that 'survive' boot time initialization.  We could
  make a number of changes to ensure that all of the nodes in the initial
  configuration provided by the pHyp can be used, but this one appears to
  be the simplest, only using resources requested by the pHyp at boot --
  even if those resource are not used immediately.

> 
> cheers
> 

Regards,
Michael

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
