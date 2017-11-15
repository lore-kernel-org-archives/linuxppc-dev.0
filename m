Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ycWn06039zDql8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 04:38:12 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAFHaJu2074630
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 12:38:09 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e8re3d9dr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Nov 2017 12:38:09 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 15 Nov 2017 10:38:08 -0700
Subject: Re: [PATCH V2 2/3] pseries/findnodes: Find nodes with memory for
 memoryless nodes
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
References: <bcccffb8-8472-463d-cca5-698db5cbc8e1@linux.vnet.ibm.com>
 <87vajbldlw.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 11:38:04 -0600
MIME-Version: 1.0
In-Reply-To: <87vajbldlw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <54cbcf15-3493-f94f-fa1f-771dec4925ca@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello:
    Sorry for the out-of-date description.  This entire patch has been
removed / eliminated from subsequent patch sets.  All changes to correct
powerpc memoryless nodes will be confined to powerpc-specific code.
    Regards,
Michael

On 10/19/2017 03:56 AM, Michael Ellerman wrote:
> Hi Michael,
> 
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>> pseries/findnodes: On pseries systems which allow 'hot-add' of
> 
> This isn't a powerpc or pseries patch, so the subject/prefix is wrong.
> 
> Also because you're changing generic code you need to provide an
> explanation that makes sense in general, across all architectures, not
> just in terms of what the pseries platform does.
> 
>> resources, we may boot configurations that have CPUs, but no memory
>> associated to a node by the affinity calculations.
> 
> This is called a "memory-less node" and is understood by the generic
> code.
> 
>> Previously, the
>> software took a shortcut to collapse initialization and references
> 
> What software? What shortcut?
> 
>> to such memoryless nodes with other nodes that did have memory
>> associated with them at boot.  This patch is based on fixes that
> 
> What fixes?
> 
>> allow the proper initialization and distinguishment of memoryless
>> and memory-plus nodes after NUMA initialization.
> 
> What exactly is unproper about the current code?
> 
>> It extends the 
>> use of the 'node_to_mem_node()' API from 'topology.h' to modules
> 
> The term "modules" has a specific meaning in Linux which is not correct
> here. We would just say "in two functions" or "in two files".
> 
>> that are allocating node-specific memory at boot, and allows such
>> references to find available memory in another node.
> 
> 
>> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
>> index 9f8cffc..a27a31f 100644
>> --- a/block/blk-mq-cpumap.c
>> +++ b/block/blk-mq-cpumap.c
>> @@ -73,7 +73,8 @@ int blk_mq_hw_queue_to_node(unsigned int *mq_map, unsigned int index)
>>  
>>  	for_each_possible_cpu(i) {
>>  		if (index == mq_map[i])
>> -			return local_memory_node(cpu_to_node(i));
>> +			return local_memory_node(
>> +					node_to_mem_node(cpu_to_node(i)));
> 
> What is this trying to do?
> 
> local_memory_node() is supposed to return a "local" node for nodes with
> no memory.
> 
> And in fact the comment says:
> 
>   * Used for initializing percpu 'numa_mem'
> 
> Which is what we do:
> 
> 	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
> 
> And is what's returned by node_to_mem_node():
> 
>   static inline void set_numa_mem(int node)
>   {
>   	this_cpu_write(_numa_mem_, node);
>   	_node_numa_mem_[numa_node_id()] = node;
>   }
>   
>   static inline int node_to_mem_node(int node)
>   {
>   	return _node_numa_mem_[node];
>   }
> 
> So your change effectively ends up doing:
> 
> 	return local_memory_node(local_memory_node(cpu_to_node(i)));
> 
> Which doesn't look right.
> 
> 
> cheers
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
