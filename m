Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B6241A0020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 05:02:12 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 9 Sep 2014 15:02:10 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 4F5F0C90084
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 15:01:59 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s89J27hp59572400
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Sep 2014 19:02:07 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s89J23IR019919
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Sep 2014 15:02:07 -0400
Date: Tue, 9 Sep 2014 12:01:54 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/3] Improve slab consumption with memoryless nodes
Message-ID: <20140909190154.GC22906@linux.vnet.ibm.com>
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

[1/3] topology: add support for node_to_mem_node() to determine the fallback node
[2/3] slub: fallback to node_to_mem_node() node if allocating on memoryless node

 - Joonsoo's patches to cache the nearest node with memory for each
   NUMA node

[3/3] Partial revert of 81c98869faa5 (""kthread: ensure locality of task_struct allocations")

 - At Tejun's request, keep the knowledge of memoryless node fallback to
   the allocator core.

 include/linux/topology.h | 17 +++++++++++++++++
 kernel/kthread.c         |  2 +-
 mm/page_alloc.c          |  1 +
 mm/slub.c                | 24 ++++++++++++++++++------
 4 files changed, 37 insertions(+), 7 deletions(-)
