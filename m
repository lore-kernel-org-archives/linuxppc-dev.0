Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D96B71A02AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 16:27:56 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 5 Mar 2015 22:27:54 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 95E2E1FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 22:19:03 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t265S5p936831336
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 22:28:05 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t265Rph0022702
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 22:27:51 -0700
Date: Thu, 5 Mar 2015 21:27:50 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: [PATCH v2] powerpc/numa: set node_possible_map to only
 node_online_map during boot
Message-ID: <20150306052750.GA9576@linux.vnet.ibm.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <20150305231555.GB30570@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051527281.2184@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1503051527281.2184@chino.kir.corp.google.com>
Cc: Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05.03.2015 [15:29:00 -0800], David Rientjes wrote:
> On Thu, 5 Mar 2015, Nishanth Aravamudan wrote:
> 
> > So if we compare to x86:
> > 
> > arch/x86/mm/numa.c::numa_init():
> > 
> >         nodes_clear(numa_nodes_parsed);
> >         nodes_clear(node_possible_map);
> >         nodes_clear(node_online_map);
> > 	...
> > 	numa_register_memblks(...);
> > 
> > arch/x86/mm/numa.c::numa_register_memblks():
> > 
> > 	node_possible_map = numa_nodes_parsed;
> > 
> > Basically, it looks like x86 NUMA init clears out possible map and
> > online map, probably for a similar reason to what I gave in the
> > changelog that by default, the possible map seems to be based off
> > MAX_NUMNODES, rather than nr_node_ids or anything dynamic.
> > 
> > My patch was an attempt to emulate the same thing on powerpc. You are
> > right that there is a window in which the node_possible_map and
> > node_online_map are out of sync with my patch. It seems like it
> > shouldn't matter given how early in boot we are, but perhaps the
> > following would have been clearer:
> > 
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index 0257a7d659ef..1a118b08fad2 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -958,6 +958,13 @@ void __init initmem_init(void)
> >  
> >         memblock_dump_all();
> >  
> > +       /*
> > +        * Reduce the possible NUMA nodes to the online NUMA nodes,
> > +        * since we do not support node hotplug. This ensures that  we
> > +        * lower the maximum NUMA node ID to what is actually present.
> > +        */
> > +       nodes_and(node_possible_map, node_possible_map, node_online_map);
> 
> If you don't support node hotplug, then a node should always be possible 
> if it's online unless there are other tricks powerpc plays with 
> node_possible_map.  Shouldn't this just be 
> node_possible_map = node_online_map?

Yeah, but I was too dumb to think of that before sending :)

Updated version follows...

-Nish


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

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0257a7d659ef..0c1716cd271f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -958,6 +958,13 @@ void __init initmem_init(void)
 
 	memblock_dump_all();
 
+	/*
+	 * Reduce the possible NUMA nodes to the online NUMA nodes,
+	 * since we do not support node hotplug. This ensures that  we
+	 * lower the maximum NUMA node ID to what is actually present.
+	 */
+	node_possible_map = node_online_map;
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
