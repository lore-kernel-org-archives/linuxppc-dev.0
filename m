Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1C6C1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 11:10:32 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 21 Aug 2014 19:10:30 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 64CC838C8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 21:10:27 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7M1AR3P66715814
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 01:10:27 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7M1APNe026952
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 21:10:27 -0400
Date: Thu, 21 Aug 2014 18:10:11 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/4] Improve slab consumption with memoryless nodes
Message-ID: <20140822011011.GF13999@linux.vnet.ibm.com>
References: <20140814001301.GI11121@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140814001301.GI11121@linux.vnet.ibm.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Tejun Heo <tj@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.08.2014 [17:13:01 -0700], Nishanth Aravamudan wrote:
> Anton noticed (http://www.spinics.net/lists/linux-mm/msg67489.html) that
> on ppc LPARs with memoryless nodes, a large amount of memory was
> consumed by slabs and was marked unreclaimable. He tracked it down to
> slab deactivations in the SLUB core when we allocate remotely, leading
> to poor efficiency always when memoryless nodes are present.
> 
> After much discussion, Joonsoo provided a few patches that help
> significantly. They don't resolve the problem altogether:
> 
>  - memory hotplug still needs testing, that is when a memoryless node
>    becomes memory-ful, we want to dtrt
>  - there are other reasons for going off-node than memoryless nodes,
>    e.g., fully exhausted local nodes
> 
> Neither case is resolved with this series, but I don't think that should
> block their acceptance, as they can be explored/resolved with follow-on
> patches.
> 
> The series consists of:
> 
> [1/4] topology: add support for node_to_mem_node() to determine the fallback node
> [2/4] slub: fallback to node_to_mem_node() node if allocating on memoryless node
> 
>  - Joonsoo's patches to cache the nearest node with memory for each
>    NUMA node
> 
> [3/4] Partial revert of 81c98869faa5 (""kthread: ensure locality of task_struct allocations")
> 
>  - At Tejun's request, keep the knowledge of memoryless node fallback to
>    the allocator core.
> 
> [4/4] powerpc: reorder per-cpu NUMA information's initialization
> 
>  - Fix what appears to be a bug with when the NUMA topology information
>    is stored in the powerpc initialization code.

Andrew & others,

I know kernel summit is going on, so I'll be patient, but was just
curious if anyone had any further comments other than Christoph's on the
naming.

Thanks,
Nish

> 
>  arch/powerpc/kernel/smp.c | 12 ++++++------
>  arch/powerpc/mm/numa.c    | 13 ++++++++++---
>  include/linux/topology.h  | 17 +++++++++++++++++
>  kernel/kthread.c          |  2 +-
>  mm/page_alloc.c           |  1 +
>  mm/slub.c                 | 24 ++++++++++++++++++------
>  6 files changed, 53 insertions(+), 16 deletions(-)
