Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A22D41A02AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 10:17:42 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 5 Mar 2015 16:17:40 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3CFA93E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 16:17:39 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t25NHdtg31588522
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 16:17:39 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t25NHcfx032223
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Mar 2015 16:17:39 -0700
Date: Thu, 5 Mar 2015 15:17:37 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305231737.GC30570@linux.vnet.ibm.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <1425592132.13327.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425592132.13327.0.camel@ellerman.id.au>
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

On 06.03.2015 [08:48:52 +1100], Michael Ellerman wrote:
> On Thu, 2015-03-05 at 13:16 -0800, David Rientjes wrote:
> > On Thu, 5 Mar 2015, Nishanth Aravamudan wrote:
> > 
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
> But it would simpler to just set the possible map to be the online
> map. That would also maintain the invariant that the possible map is
> always a superset of the online map.

Yes, we could do that (see my reply to David just now). I didn't
consider just setting the map directly, that would be clearer. I didn't
want to post my nodes_and() version, because the cost of nodes_and
seemed higher than nodes_clear & node_set appropriately.

-Nish
