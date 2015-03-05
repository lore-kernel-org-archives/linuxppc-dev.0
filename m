Return-Path: <rientjes@google.com>
Received: from mail-ie0-x22a.google.com (mail-ie0-x22a.google.com
 [IPv6:2607:f8b0:4001:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71E041A05B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 10:29:05 +1100 (AEDT)
Received: by iecar1 with SMTP id ar1so81222604iec.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 15:29:02 -0800 (PST)
Date: Thu, 5 Mar 2015 15:29:00 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
In-Reply-To: <20150305231555.GB30570@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1503051527281.2184@chino.kir.corp.google.com>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <20150305231555.GB30570@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Thu, 5 Mar 2015, Nishanth Aravamudan wrote:

> So if we compare to x86:
> 
> arch/x86/mm/numa.c::numa_init():
> 
>         nodes_clear(numa_nodes_parsed);
>         nodes_clear(node_possible_map);
>         nodes_clear(node_online_map);
> 	...
> 	numa_register_memblks(...);
> 
> arch/x86/mm/numa.c::numa_register_memblks():
> 
> 	node_possible_map = numa_nodes_parsed;
> 
> Basically, it looks like x86 NUMA init clears out possible map and
> online map, probably for a similar reason to what I gave in the
> changelog that by default, the possible map seems to be based off
> MAX_NUMNODES, rather than nr_node_ids or anything dynamic.
> 
> My patch was an attempt to emulate the same thing on powerpc. You are
> right that there is a window in which the node_possible_map and
> node_online_map are out of sync with my patch. It seems like it
> shouldn't matter given how early in boot we are, but perhaps the
> following would have been clearer:
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 0257a7d659ef..1a118b08fad2 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -958,6 +958,13 @@ void __init initmem_init(void)
>  
>         memblock_dump_all();
>  
> +       /*
> +        * Reduce the possible NUMA nodes to the online NUMA nodes,
> +        * since we do not support node hotplug. This ensures that  we
> +        * lower the maximum NUMA node ID to what is actually present.
> +        */
> +       nodes_and(node_possible_map, node_possible_map, node_online_map);

If you don't support node hotplug, then a node should always be possible 
if it's online unless there are other tricks powerpc plays with 
node_possible_map.  Shouldn't this just be 
node_possible_map = node_online_map?

> +
>         for_each_online_node(nid) {
>                 unsigned long start_pfn, end_pfn;
>  
> 
> 
