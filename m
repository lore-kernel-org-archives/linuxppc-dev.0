Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wXw2d1PmXzDqdM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 00:36:56 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4OEUX8D043395
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 10:36:53 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2an7qfyuq2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 May 2017 10:36:52 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 24 May 2017 08:36:52 -0600
Date: Wed, 24 May 2017 09:36:46 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ib>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
Message-Id: <20170524143645.vaunm2i7fbb6c2zk@arbab-laptop.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 23, 2017 at 05:44:23PM -0500, Michael Bringmann wrote:
>On 05/23/2017 04:49 PM, Reza Arbab wrote:
>> On Tue, May 23, 2017 at 03:05:08PM -0500, Michael Bringmann wrote:
>>> On 05/23/2017 10:52 AM, Reza Arbab wrote:
>>>> On Tue, May 23, 2017 at 10:15:44AM -0500, Michael Bringmann wrote:
>>>>> +static void setup_nodes(void)
>>>>> +{
>>>>> +    int i, l = 32 /* MAX_NUMNODES */;
>>>>> +
>>>>> +    for (i = 0; i < l; i++) {
>>>>> +        if (!node_possible(i)) {
>>>>> +            setup_node_data(i, 0, 0);
>>>>> +            node_set(i, node_possible_map);
>>>>> +        }
>>>>> +    }
>>>>> +}
>>>>
>>>> This seems to be a workaround for 3af229f2071f ("powerpc/numa: Reset node_possible_map to only node_online_map").
>>>
>>> They may be related, but that commit is not a replacement.  The above patch ensures that
>>> there are enough of the nodes initialized at startup to allow for memory hot-add into a
>>> node that was not used at boot.  (See 'setup_node_data' function in 'numa.c'.)  That and
>>> recording that the node was initialized.
>>
>> Is it really necessary to preinitialize these empty nodes using setup_node_data()? When you do memory hotadd into a node that was not used at boot, the node data already gets set up by
>>
>> add_memory
>>  add_memory_resource
>>    hotadd_new_pgdat
>>      arch_alloc_nodedata <-- allocs the pg_data_t
>>      ...
>>      free_area_init_node <-- sets NODE_DATA(nid)->node_id, etc.
>>
>> Removing setup_node_data() from that loop leaves only the call to node_set(). If 3af229f2071f (which reduces node_possible_map) was reverted, you wouldn't need to do that either.
>
>With or without 3af229f2071f, we would still need to add something, somewhere to add new
>bits to the 'node_possible_map'.  That is not being done.

Without 3af229f2071f, those bits would already BE set in 
node_possible_map. You wouldn't have to do anything.

-- 
Reza Arbab
