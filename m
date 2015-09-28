Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4185A1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 03:32:53 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 13:32:50 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CB6686E8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 13:24:31 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8SHWmFd65208514
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 17:32:48 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8SHWlQf023781
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 13:32:48 -0400
Date: Mon, 28 Sep 2015 10:32:45 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cl@linux.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC  4/5] powerpc:numa Add helper functions to maintain
 chipid to nid mapping
Message-ID: <20150928173245.GD48470@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1443378553-2146-5-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443378553-2146-5-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.09.2015 [23:59:12 +0530], Raghavendra K T wrote:
> Create arrays that maps serial nids and sparse chipids.
> 
> Note: My original idea had only two arrays of chipid to nid map. Final
> code is inspired by driver/acpi/numa.c that maps a proximity node with
> a logical node by Takayoshi Kochi <t-kochi@bq.jp.nec.com>, and thus
> uses an additional chipid_map nodemask. The mask helps in first unused
> nid easily by knowing first unset bit in the mask.
> 
> No change in functionality.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index dd2073b..f015cad 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -63,6 +63,11 @@ static int form1_affinity;
>  static int distance_ref_points_depth;
>  static const __be32 *distance_ref_points;
>  static int distance_lookup_table[MAX_NUMNODES][MAX_DISTANCE_REF_POINTS];
> +static nodemask_t chipid_map = NODE_MASK_NONE;
> +static int chipid_to_nid_map[MAX_NUMNODES]
> +				= { [0 ... MAX_NUMNODES - 1] = NUMA_NO_NODE };

Hrm, conceptually there are *more* chips than nodes, right? So what
guarantees we won't see > MAX_NUMNODES chips?

> +static int nid_to_chipid_map[MAX_NUMNODES]
> +				= { [0 ... MAX_NUMNODES - 1] = NUMA_NO_NODE };
> 
>  /*
>   * Allocate node_to_cpumask_map based on number of available nodes
> @@ -133,6 +138,48 @@ static int __init fake_numa_create_new_node(unsigned long end_pfn,
>  	return 0;
>  }
> 
> +int chipid_to_nid(int chipid)
> +{
> +	if (chipid < 0)
> +		return NUMA_NO_NODE;

Do you really want to support these cases? Or should they be
bugs/warnings indicating that you got an unexpected input? Or at least
WARN_ON_ONCE?

> +	return chipid_to_nid_map[chipid];
> +}
> +
> +int nid_to_chipid(int nid)
> +{
> +	if (nid < 0)
> +		return NUMA_NO_NODE;
> +	return nid_to_chipid_map[nid];
> +}
> +
> +static void __map_chipid_to_nid(int chipid, int nid)
> +{
> +	if (chipid_to_nid_map[chipid] == NUMA_NO_NODE
> +	     || nid < chipid_to_nid_map[chipid])
> +		chipid_to_nid_map[chipid] = nid;
> +	if (nid_to_chipid_map[nid] == NUMA_NO_NODE
> +	    || chipid < nid_to_chipid_map[nid])
> +		nid_to_chipid_map[nid] = chipid;
> +}

chip <-> node mapping is a static (physical) concept, right? Should we
emit some debugging if for some reason we get a runtime call to remap
an already mapped chip to a new node?

> +
> +int map_chipid_to_nid(int chipid)
> +{
> +	int nid;
> +
> +	if (chipid < 0 || chipid >= MAX_NUMNODES)
> +		return NUMA_NO_NODE;
> +
> +	nid = chipid_to_nid_map[chipid];
> +	if (nid == NUMA_NO_NODE) {
> +		if (nodes_weight(chipid_map) >= MAX_NUMNODES)
> +			return NUMA_NO_NODE;

If you create a KVM guest with a bogus topology, doesn't this just start
losing NUMA information for very high-noded guests?

> +		nid = first_unset_node(chipid_map);
> +		__map_chipid_to_nid(chipid, nid);
> +		node_set(nid, chipid_map);
> +	}
> +	return nid;
> +}
> +
>  int numa_cpu_lookup(int cpu)
>  {
>  	return numa_cpu_lookup_table[cpu];
> @@ -264,7 +311,6 @@ out:
>  	return chipid;
>  }
> 
> -

stray change?

>   /* Return the nid from associativity */
>  static int associativity_to_nid(const __be32 *associativity)
>  {
> -- 
> 1.7.11.7
> 
