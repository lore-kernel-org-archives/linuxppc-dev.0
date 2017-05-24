Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wY8R00D3kzDqLB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 09:55:23 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4ONro0M056077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 19:55:13 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2andxuf75d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 19:55:13 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 24 May 2017 19:55:12 -0400
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
To: Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ib>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Wed, 24 May 2017 18:55:08 -0500
MIME-Version: 1.0
In-Reply-To: <87poeya4dt.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/24/2017 06:19 AM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> 
>> On 05/23/2017 04:49 PM, Reza Arbab wrote:
>>> On Tue, May 23, 2017 at 03:05:08PM -0500, Michael Bringmann wrote:
>>>> On 05/23/2017 10:52 AM, Reza Arbab wrote:
>>>>> On Tue, May 23, 2017 at 10:15:44AM -0500, Michael Bringmann wrote:
>>>>>> +static void setup_nodes(void)
>>>>>> +{
>>>>>> +    int i, l = 32 /* MAX_NUMNODES */;
>>>>>> +
>>>>>> +    for (i = 0; i < l; i++) {
>>>>>> +        if (!node_possible(i)) {
>>>>>> +            setup_node_data(i, 0, 0);
>>>>>> +            node_set(i, node_possible_map);
>>>>>> +        }
>>>>>> +    }
>>>>>> +}
>>>>>
>>>>> This seems to be a workaround for 3af229f2071f ("powerpc/numa: Reset node_possible_map to only node_online_map").
>>>>
>>>> They may be related, but that commit is not a replacement.  The above patch ensures that
>>>> there are enough of the nodes initialized at startup to allow for memory hot-add into a
>>>> node that was not used at boot.  (See 'setup_node_data' function in 'numa.c'.)  That and
>>>> recording that the node was initialized.
>>>
>>> Is it really necessary to preinitialize these empty nodes using setup_node_data()? When you do memory hotadd into a node that was not used at boot, the node data already gets set up by
>>>
>>> add_memory
>>>  add_memory_resource
>>>    hotadd_new_pgdat
>>>      arch_alloc_nodedata <-- allocs the pg_data_t
>>>      ...
>>>      free_area_init_node <-- sets NODE_DATA(nid)->node_id, etc.
>>>
>>> Removing setup_node_data() from that loop leaves only the call to node_set(). If 3af229f2071f (which reduces node_possible_map) was reverted, you wouldn't need to do that either.
>>
>> With or without 3af229f2071f, we would still need to add something, somewhere to add new
>> bits to the 'node_possible_map'.  That is not being done.
> 
> You mustn't add bits to the possible map after boot.
> 
> That's its purpose, to tell you what nodes could ever *possibly* exist.

The problem that I have been encountering is that the 'possible map' did *not*
show all of the possible nodes.  Rather, it showed only the nodes that were
assigned memory at boot-up.  If more memory were hot-added to the kernel, it
could be assigned into one of the nodes that were skipped at boot.  However,
nothing was updating the 'node_possible_map' correctly in the kernel memory
code.

Reza pointed out a code change in commit 3af229f2071f that has not made it into
the 4.12 checkout i.e. removing the instruction that reduces the node_possible_map.
This may well be a suitable replacement for the code that I have here, and I
will test it here next.

> 
> cheers
> 
> 
Later.

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
