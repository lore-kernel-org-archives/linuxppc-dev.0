Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYs0Y6nmwzDqkw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 13:23:25 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id w69so42989581pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 20:23:25 -0700 (PDT)
Date: Fri, 26 May 2017 13:23:05 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Reza Arbab
 <arbab@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Bharata B
 Rao <bharata@linux.vnet.ib>, Shailendra Singh <shailendras@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH V2 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
Message-ID: <20170526132305.19ef3590@firefly.ozlabs.ibm.com>
In-Reply-To: <9b006866-5a8e-dc05-d603-bfe8eb02eef2@linux.vnet.ibm.com>
References: <20170525171932.29159.89311.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
 <9b006866-5a8e-dc05-d603-bfe8eb02eef2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 25 May 2017 12:37:40 -0500
Michael Bringmann <mwb@linux.vnet.ibm.com> wrote:

> Removing or adding memory via the PowerPC hotplug interface shows
> anomalies in the association between memory and nodes.  The code
> was updated to ensure that all nodes found at boot are still available
> to subsequent DLPAR hotplug-memory operations, even if they are not
> needed at boot time.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> Changes in V2:
>   -- Simplify patches to ensure more nodes in possible map, removing
>      code from PowerPC numa.c that constrained possible map to size
>      of online map.
> ---
>  arch/powerpc/mm/numa.c |    7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 15c2dd5..18f3038 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -907,13 +907,6 @@ void __init initmem_init(void)
>  
>  	memblock_dump_all();
>  
> -	/*
> -	 * Reduce the possible NUMA nodes to the online NUMA nodes,
> -	 * since we do not support node hotplug. This ensures that  we
> -	 * lower the maximum NUMA node ID to what is actually present.
> -	 */
> -	nodes_and(node_possible_map, node_possible_map, node_online_map);
> -

There is an overhead with turning this off if you have too many cgroups
with the memory controller. I think this fix was added for a pathological
test case. On my system I see 84 cgroups with 1 node, so the probable
overhead is 84*255*sizeof(struct mem_cgroup_tree_per_node).

I tried some patches to reduce the overhead, but those need more overhauling
and rework.

Balbir Singh.
