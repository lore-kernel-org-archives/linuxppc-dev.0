Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHjV63rrmzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 19:57:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 2/3] pseries/findnodes: Find nodes with memory for
 memoryless nodes
In-Reply-To: <bcccffb8-8472-463d-cca5-698db5cbc8e1@linux.vnet.ibm.com>
References: <bcccffb8-8472-463d-cca5-698db5cbc8e1@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 19:56:59 +1100
Message-ID: <87vajbldlw.fsf@concordia.ellerman.id.au>
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

Hi Michael,

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> pseries/findnodes: On pseries systems which allow 'hot-add' of

This isn't a powerpc or pseries patch, so the subject/prefix is wrong.

Also because you're changing generic code you need to provide an
explanation that makes sense in general, across all architectures, not
just in terms of what the pseries platform does.

> resources, we may boot configurations that have CPUs, but no memory
> associated to a node by the affinity calculations.

This is called a "memory-less node" and is understood by the generic
code.

> Previously, the
> software took a shortcut to collapse initialization and references

What software? What shortcut?

> to such memoryless nodes with other nodes that did have memory
> associated with them at boot.  This patch is based on fixes that

What fixes?

> allow the proper initialization and distinguishment of memoryless
> and memory-plus nodes after NUMA initialization.

What exactly is unproper about the current code?

> It extends the 
> use of the 'node_to_mem_node()' API from 'topology.h' to modules

The term "modules" has a specific meaning in Linux which is not correct
here. We would just say "in two functions" or "in two files".

> that are allocating node-specific memory at boot, and allows such
> references to find available memory in another node.


> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 9f8cffc..a27a31f 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -73,7 +73,8 @@ int blk_mq_hw_queue_to_node(unsigned int *mq_map, unsigned int index)
>  
>  	for_each_possible_cpu(i) {
>  		if (index == mq_map[i])
> -			return local_memory_node(cpu_to_node(i));
> +			return local_memory_node(
> +					node_to_mem_node(cpu_to_node(i)));

What is this trying to do?

local_memory_node() is supposed to return a "local" node for nodes with
no memory.

And in fact the comment says:

  * Used for initializing percpu 'numa_mem'

Which is what we do:

	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));

And is what's returned by node_to_mem_node():

  static inline void set_numa_mem(int node)
  {
  	this_cpu_write(_numa_mem_, node);
  	_node_numa_mem_[numa_node_id()] = node;
  }
  
  static inline int node_to_mem_node(int node)
  {
  	return _node_numa_mem_[node];
  }

So your change effectively ends up doing:

	return local_memory_node(local_memory_node(cpu_to_node(i)));

Which doesn't look right.


cheers
