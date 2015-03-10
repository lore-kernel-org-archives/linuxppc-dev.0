Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02E211A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 10:52:01 +1100 (AEDT)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 10 Mar 2015 17:51:59 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3443BC40004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 17:43:09 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2ANphfa33554550
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 16:51:51 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2ANpOYb015192
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 17:51:25 -0600
Date: Tue, 10 Mar 2015 16:50:59 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3] powerpc/numa: set node_possible_map to only
 node_online_map during boot
Message-ID: <20150310235059.GA40490@linux.vnet.ibm.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <20150305231555.GB30570@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051527281.2184@chino.kir.corp.google.com>
 <20150306052750.GA9576@linux.vnet.ibm.com>
 <1425945305.19022.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425945305.19022.4.camel@ellerman.id.au>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10.03.2015 [10:55:05 +1100], Michael Ellerman wrote:
> On Thu, 2015-03-05 at 21:27 -0800, Nishanth Aravamudan wrote:
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index 0257a7d659ef..0c1716cd271f 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -958,6 +958,13 @@ void __init initmem_init(void)
> >  
> >  	memblock_dump_all();
> >  
> > +	/*
> > +	 * Reduce the possible NUMA nodes to the online NUMA nodes,
> > +	 * since we do not support node hotplug. This ensures that  we
> > +	 * lower the maximum NUMA node ID to what is actually present.
> > +	 */
> > +	node_possible_map = node_online_map;
> 
> That looks nice, but is it generating what we want?
> 
> ie. is the content of node_online_map being *copied* into node_possible_map.
> 
> Or are we changing node_possible_map to point at node_online_map?

I think it ends up being the latter, which is probably fine in practice
(I think node_online_map is static on power after boot), but perhaps it
would be better to do:

nodes_and(node_possible_map, node_possible_map, node_online_map);

?

e.g.:


powerpc/numa: reset node_possible_map to only node_online_map

Raghu noticed an issue with excessive memory allocation on power with a
simple cgroup test, specifically, in mem_cgroup_css_alloc ->
for_each_node -> alloc_mem_cgroup_per_zone_info(), which ends up blowing
up the kmalloc-2048 slab (to the order of 200MB for 400 cgroup
directories).

The underlying issue is that NODES_SHIFT on power is 8 (256 NUMA nodes
possible), which defines node_possible_map, which in turn defines the
value of nr_node_ids in setup_nr_node_ids and the iteration of
for_each_node.

In practice, we never see a system with 256 NUMA nodes, and in fact, we
do not support node hotplug on power in the first place, so the nodes
that are online when we come up are the nodes that will be present for
the lifetime of this kernel. So let's, at least, drop the NUMA possible
map down to the online map at runtime. This is similar to what x86 does
in its initialization routines.

mem_cgroup_css_alloc should also be fixed to only iterate over
memory-populated nodes and handle hotplug, but that is a separate
change.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Tejun Heo <tj@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
    
---
v1 -> v2:
  Rather than clear node_possible_map and set it nid-by-nid, just
  directly assign node_online_map to it, as suggested by Michael
  Ellerman and Tejun Heo.

v2 -> v3:
  Rather than direct assignment (which is just repointing the pointer),
  modify node_possible_map in-place.

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0257a7d659ef..1a118b08fad2 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -958,6 +958,13 @@ void __init initmem_init(void)
 
 	memblock_dump_all();
 
+	/*
+	 * Reduce the possible NUMA nodes to the online NUMA nodes,
+	 * since we do not support node hotplug. This ensures that  we
+	 * lower the maximum NUMA node ID to what is actually present.
+	 */
+	nodes_and(node_possible_map, node_possible_map, node_online_map);
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
