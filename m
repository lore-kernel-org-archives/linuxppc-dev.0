Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EBF61A02AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 08:48:53 +1100 (AEDT)
Message-ID: <1425592132.13327.0.camel@ellerman.id.au>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Rientjes <rientjes@google.com>
Date: Fri, 06 Mar 2015 08:48:52 +1100
In-Reply-To: <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Thu, 2015-03-05 at 13:16 -0800, David Rientjes wrote:
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
 
Yeah. Though at this point in boot I don't think it matters that the two maps
are out-of-sync temporarily.

But it would simpler to just set the possible map to be the online map. That
would also maintain the invariant that the possible map is always a superset of
the online map.

Or did I miss a detail there (sleep deprived parent mode).

cheers
