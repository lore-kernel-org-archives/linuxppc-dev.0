Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B8BB1A0246
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 10:21:01 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 5 Mar 2015 18:20:56 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0C42B6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 18:12:44 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t25NKqGj28049510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 23:20:52 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t25NKqD2015342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 18:20:52 -0500
Date: Thu, 5 Mar 2015 15:20:51 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305232051.GD30570@linux.vnet.ibm.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <1425592132.13327.0.camel@ellerman.id.au>
 <alpine.DEB.2.10.1503051352540.25375@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1503051352540.25375@chino.kir.corp.google.com>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
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

On 05.03.2015 [13:58:27 -0800], David Rientjes wrote:
> On Fri, 6 Mar 2015, Michael Ellerman wrote:
> 
> > > > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > > > index 0257a7d659ef..24de29b3651b 100644
> > > > --- a/arch/powerpc/mm/numa.c
> > > > +++ b/arch/powerpc/mm/numa.c
> > > > @@ -958,9 +958,17 @@ void __init initmem_init(void)
> > > >  
> > > >  	memblock_dump_all();
> > > >  
> > > > +	/*
> > > > +	 * zero out the possible nodes after we parse the device-tree,
> > > > +	 * so that we lower the maximum NUMA node ID to what is actually
> > > > +	 * present.
> > > > +	 */
> > > > +	nodes_clear(node_possible_map);
> > > > +
> > > >  	for_each_online_node(nid) {
> > > >  		unsigned long start_pfn, end_pfn;
> > > >  
> > > > +		node_set(nid, node_possible_map);
> > > >  		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
> > > >  		setup_node_data(nid, start_pfn, end_pfn);
> > > >  		sparse_memory_present_with_active_regions(nid);
> > > 
> > > This seems a bit strange, node_possible_map is supposed to be a superset 
> > > of node_online_map and this loop is iterating over node_online_map to set 
> > > nodes in node_possible_map.
> >  
> > Yeah. Though at this point in boot I don't think it matters that the
> > two maps are out-of-sync temporarily.
> > 
> > But it would simpler to just set the possible map to be the online
> > map. That would also maintain the invariant that the possible map is
> > always a superset of the online map.
> > 
> > Or did I miss a detail there (sleep deprived parent mode).
> > 
> 
> I think reset_numa_cpu_lookup_table() which iterates over the possible
> map, and thus only a subset of nodes now, may be concerning.


I think you are confusing the CPU online map and the NUMA node online
map. reset_numa_cpu_lookup_table is a cpu->node mapping, only called at
boot-time, and iterates over the CPU online map, which is unaltered by
my patch.

> I'm not sure why this is being proposed as a powerpc patch and now a
> patch for mem_cgroup_css_alloc().

I think mem_cgroup_css_alloc() is just an example of a larger issue. I
should have made that clearer in my changelog. Even if we change
mem_cgroup_css_alloc(), I think we want to fix the node_possible_map on
powerpc to be accurate at run-time, just like x86 does.

> In other words, why do we have to allocate for all possible nodes?  We
> should only be allocating for online nodes in N_MEMORY with mem
> hotplug disabled initially and then have a mem hotplug callback
> implemented to alloc_mem_cgroup_per_zone_info() for nodes that
> transition from memoryless -> memory.  The extra bonus is that
> alloc_mem_cgroup_per_zone_info() need never allocate remote memory and
> the TODO in that function can be removed.

This is a good idea, and seems like it can be a follow-on parallel patch
to the one I provided (which does need an updated changelog now).

Thanks,
Nish
