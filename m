Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC5321A0197
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 10:13:16 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 13 Aug 2014 20:13:13 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 43B4338C804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 20:13:11 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7E0DBOs6881722
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 00:13:11 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7E0D7l2017470
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 20:13:11 -0400
Date: Wed, 13 Aug 2014 17:13:01 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 0/4] Improve slab consumption with memoryless nodes
Message-ID: <20140814001301.GI11121@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Anton noticed (http://www.spinics.net/lists/linux-mm/msg67489.html) that
on ppc LPARs with memoryless nodes, a large amount of memory was
consumed by slabs and was marked unreclaimable. He tracked it down to
slab deactivations in the SLUB core when we allocate remotely, leading
to poor efficiency always when memoryless nodes are present.

After much discussion, Joonsoo provided a few patches that help
significantly. They don't resolve the problem altogether:

 - memory hotplug still needs testing, that is when a memoryless node
   becomes memory-ful, we want to dtrt
 - there are other reasons for going off-node than memoryless nodes,
   e.g., fully exhausted local nodes

Neither case is resolved with this series, but I don't think that should
block their acceptance, as they can be explored/resolved with follow-on
patches.

The series consists of:

[1/4] topology: add support for node_to_mem_node() to determine the fallback node
[2/4] slub: fallback to node_to_mem_node() node if allocating on memoryless node

 - Joonsoo's patches to cache the nearest node with memory for each
   NUMA node

[3/4] Partial revert of 81c98869faa5 (""kthread: ensure locality of task_struct allocations")

 - At Tejun's request, keep the knowledge of memoryless node fallback to
   the allocator core.

[4/4] powerpc: reorder per-cpu NUMA information's initialization

 - Fix what appears to be a bug with when the NUMA topology information
   is stored in the powerpc initialization code.

 arch/powerpc/kernel/smp.c | 12 ++++++------
 arch/powerpc/mm/numa.c    | 13 ++++++++++---
 include/linux/topology.h  | 17 +++++++++++++++++
 kernel/kthread.c          |  2 +-
 mm/page_alloc.c           |  1 +
 mm/slub.c                 | 24 ++++++++++++++++++------
 6 files changed, 53 insertions(+), 16 deletions(-)
