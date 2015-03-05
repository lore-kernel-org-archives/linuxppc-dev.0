Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7652D1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 10:16:00 +1100 (AEDT)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 5 Mar 2015 18:15:58 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 149F1C90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 18:07:07 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t25NFuxM30212322
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 23:15:56 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t25NFtwd000755
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 18:15:55 -0500
Date: Thu, 5 Mar 2015 15:15:55 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305231555.GB30570@linux.vnet.ibm.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
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

Hi David,

On 05.03.2015 [13:16:35 -0800], David Rientjes wrote:
> On Thu, 5 Mar 2015, Nishanth Aravamudan wrote:
> 
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index 0257a7d659ef..24de29b3651b 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -958,9 +958,17 @@ void __init initmem_init(void)
> >  
> >  	memblock_dump_all();
> >  
> > +	/*
> > +	 * zero out the possible nodes after we parse the device-tree,
> > +	 * so that we lower the maximum NUMA node ID to what is actually
> > +	 * present.
> > +	 */
> > +	nodes_clear(node_possible_map);
> > +
> >  	for_each_online_node(nid) {
> >  		unsigned long start_pfn, end_pfn;
> >  
> > +		node_set(nid, node_possible_map);
> >  		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> >  		setup_node_data(nid, start_pfn, end_pfn);
> >  		sparse_memory_present_with_active_regions(nid);
> 
> This seems a bit strange, node_possible_map is supposed to be a superset 
> of node_online_map and this loop is iterating over node_online_map to set 
> nodes in node_possible_map.

So if we compare to x86:

arch/x86/mm/numa.c::numa_init():

        nodes_clear(numa_nodes_parsed);
        nodes_clear(node_possible_map);
        nodes_clear(node_online_map);
	...
	numa_register_memblks(...);

arch/x86/mm/numa.c::numa_register_memblks():

	node_possible_map = numa_nodes_parsed;

Basically, it looks like x86 NUMA init clears out possible map and
online map, probably for a similar reason to what I gave in the
changelog that by default, the possible map seems to be based off
MAX_NUMNODES, rather than nr_node_ids or anything dynamic.

My patch was an attempt to emulate the same thing on powerpc. You are
right that there is a window in which the node_possible_map and
node_online_map are out of sync with my patch. It seems like it
shouldn't matter given how early in boot we are, but perhaps the
following would have been clearer:

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0257a7d659ef..1a118b08fad2 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -958,6 +958,13 @@ void __init initmem_init(void)
 
        memblock_dump_all();
 
+       /*
+        * Reduce the possible NUMA nodes to the online NUMA nodes,
+        * since we do not support node hotplug. This ensures that  we
+        * lower the maximum NUMA node ID to what is actually present.
+        */
+       nodes_and(node_possible_map, node_possible_map, node_online_map);
+
        for_each_online_node(nid) {
                unsigned long start_pfn, end_pfn;
 
