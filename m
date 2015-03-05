Return-Path: <rientjes@google.com>
Received: from mail-ig0-x230.google.com (mail-ig0-x230.google.com
 [IPv6:2607:f8b0:4001:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BA271A02AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 08:58:31 +1100 (AEDT)
Received: by igqa13 with SMTP id a13so49773702igq.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 13:58:29 -0800 (PST)
Date: Thu, 5 Mar 2015 13:58:27 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
In-Reply-To: <1425592132.13327.0.camel@ellerman.id.au>
Message-ID: <alpine.DEB.2.10.1503051352540.25375@chino.kir.corp.google.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <1425592132.13327.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 6 Mar 2015, Michael Ellerman wrote:

> > > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > > index 0257a7d659ef..24de29b3651b 100644
> > > --- a/arch/powerpc/mm/numa.c
> > > +++ b/arch/powerpc/mm/numa.c
> > > @@ -958,9 +958,17 @@ void __init initmem_init(void)
> > >  
> > >  	memblock_dump_all();
> > >  
> > > +	/*
> > > +	 * zero out the possible nodes after we parse the device-tree,
> > > +	 * so that we lower the maximum NUMA node ID to what is actually
> > > +	 * present.
> > > +	 */
> > > +	nodes_clear(node_possible_map);
> > > +
> > >  	for_each_online_node(nid) {
> > >  		unsigned long start_pfn, end_pfn;
> > >  
> > > +		node_set(nid, node_possible_map);
> > >  		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> > >  		setup_node_data(nid, start_pfn, end_pfn);
> > >  		sparse_memory_present_with_active_regions(nid);
> > 
> > This seems a bit strange, node_possible_map is supposed to be a superset 
> > of node_online_map and this loop is iterating over node_online_map to set 
> > nodes in node_possible_map.
>  
> Yeah. Though at this point in boot I don't think it matters that the two maps
> are out-of-sync temporarily.
> 
> But it would simpler to just set the possible map to be the online map. That
> would also maintain the invariant that the possible map is always a superset of
> the online map.
> 
> Or did I miss a detail there (sleep deprived parent mode).
> 

I think reset_numa_cpu_lookup_table() which iterates over the possible 
map, and thus only a subset of nodes now, may be concerning.

I'm not sure why this is being proposed as a powerpc patch and now a patch 
for mem_cgroup_css_alloc().  In other words, why do we have to allocate 
for all possible nodes?  We should only be allocating for online nodes in 
N_MEMORY with mem hotplug disabled initially and then have a mem hotplug 
callback implemented to alloc_mem_cgroup_per_zone_info() for nodes that 
transition from memoryless -> memory.  The extra bonus is that 
alloc_mem_cgroup_per_zone_info() need never allocate remote memory and the 
TODO in that function can be removed.
