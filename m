Return-Path: <rientjes@google.com>
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com
 [IPv6:2607:f8b0:4001:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE7101A02AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 08:16:39 +1100 (AEDT)
Received: by iecrp18 with SMTP id rp18so12448914iec.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 13:16:37 -0800 (PST)
Date: Thu, 5 Mar 2015 13:16:35 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
In-Reply-To: <20150305180549.GA29601@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Thu, 5 Mar 2015, Nishanth Aravamudan wrote:

> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 0257a7d659ef..24de29b3651b 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -958,9 +958,17 @@ void __init initmem_init(void)
>  
>  	memblock_dump_all();
>  
> +	/*
> +	 * zero out the possible nodes after we parse the device-tree,
> +	 * so that we lower the maximum NUMA node ID to what is actually
> +	 * present.
> +	 */
> +	nodes_clear(node_possible_map);
> +
>  	for_each_online_node(nid) {
>  		unsigned long start_pfn, end_pfn;
>  
> +		node_set(nid, node_possible_map);
>  		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
>  		setup_node_data(nid, start_pfn, end_pfn);
>  		sparse_memory_present_with_active_regions(nid);

This seems a bit strange, node_possible_map is supposed to be a superset 
of node_online_map and this loop is iterating over node_online_map to set 
nodes in node_possible_map.
