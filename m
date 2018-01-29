Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGNC6Cp1zDqmV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:47 +1100 (AEDT)
In-Reply-To: <4faec177-a704-1404-c7ae-7f064153de2b@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Re: [V8,1/3] powerpc/nodes: Ensure enough nodes avail for operations
Message-Id: <3zVGNC4JMtz9t3F@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-28 at 22:58:36 UTC, Michael Bringmann wrote:
> On powerpc systems which allow 'hot-add' of CPU or memory resources,
> it may occur that the new resources are to be inserted into nodes
> that were not used for these resources at bootup.  In the kernel,
> any node that is used must be defined and initialized.  These empty
> nodes may occur when,
> 
> * Dedicated vs. shared resources.  Shared resources require
>   information such as the VPHN hcall for CPU assignment to nodes.
>   Associativity decisions made based on dedicated resource rules,
>   such as associativity properties in the device tree, may vary
>   from decisions made using the values returned by the VPHN hcall.
> * memoryless nodes at boot.  Nodes need to be defined as 'possible'
>   at boot for operation with other code modules.  Previously, the
>   powerpc code would limit the set of possible nodes to those which
>   have memory assigned at boot, and were thus online.  Subsequent
>   add/remove of CPUs or memory would only work with this subset of
>   possible nodes.
> * memoryless nodes with CPUs at boot.  Due to the previous restriction
>   on nodes, nodes that had CPUs but no memory were being collapsed
>   into other nodes that did have memory at boot.  In practice this
>   meant that the node assignment presented by the runtime kernel
>   differed from the affinity and associativity attributes presented
>   by the device tree or VPHN hcalls.  Nodes that might be known to
>   the pHyp were not 'possible' in the runtime kernel because they did
>   not have memory at boot.
> 
> This patch ensures that sufficient nodes are defined to support
> configuration requirements after boot, as well as at boot.  This
> patch set fixes a couple of problems.
> 
> * Nodes known to powerpc to be memoryless at boot, but to have
>   CPUs in them are allowed to be 'possible' and 'online'.  Memory
>   allocations for those nodes are taken from another node that does
>   have memory until and if memory is hot-added to the node.
> * Nodes which have no resources assigned at boot, but which may still
>   be referenced subsequently by affinity or associativity attributes,
>   are kept in the list of 'possible' nodes for powerpc.  Hot-add of
>   memory or CPUs to the system can reference these nodes and bring
>   them online instead of redirecting to one of the set of nodes that
>   were known to have memory at boot.
> 
> This patch extracts the value of the lowest domain level (number of
> allocable resources) from the device tree property
> "ibm,max-associativity-domains" to use as the maximum number of nodes
> to setup as possibly available in the system.  This new setting will
> override the instruction,
> 
>     nodes_and(node_possible_map, node_possible_map, node_online_map);
> 
> presently seen in the function arch/powerpc/mm/numa.c:initmem_init().
> 
> If the "ibm,max-associativity-domains" property is not present at boot,
> no operation will be performed to define or enable additional nodes, or
> enable the above 'nodes_and()'.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a346137e9142b039fd13af2e59696e

cheers
