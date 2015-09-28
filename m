Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C06E1A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 03:28:06 +1000 (AEST)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 11:28:04 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3DEBC19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 11:18:54 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8SHQgiF6619588
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 10:26:50 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8SHRSBn021259
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 11:27:29 -0600
Date: Mon, 28 Sep 2015 10:27:02 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cl@linux.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC  2/5] powerpc:numa Rename functions referring to nid
 as chipid
Message-ID: <20150928172702.GB48470@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1443378553-2146-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443378553-2146-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.09.2015 [23:59:10 +0530], Raghavendra K T wrote:
> There is no change in the fuctionality
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index d5e6eee..f84ed2f 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -235,47 +235,47 @@ static void initialize_distance_lookup_table(int nid,
>  	}
>  }
> 
> -/* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
> +/* Returns chipid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
>   * info is found.
>   */
> -static int associativity_to_nid(const __be32 *associativity)
> +static int associativity_to_chipid(const __be32 *associativity)

This is confusing to me. This function is also used by the DLPAR code
under PowerVM to indicate what node the CPU is on -- not a chip (which I
don't believe is exposed at all under PowerVM).

>  {
> -	int nid = -1;
> +	int chipid = -1;
> 
>  	if (min_common_depth == -1)
>  		goto out;
> 
>  	if (of_read_number(associativity, 1) >= min_common_depth)
> -		nid = of_read_number(&associativity[min_common_depth], 1);
> +		chipid = of_read_number(&associativity[min_common_depth], 1);

Doesn't this, in the PAPR documentation, specifically refer to the NODE
level domain?

>  	/* POWER4 LPAR uses 0xffff as invalid node */
> -	if (nid == 0xffff || nid >= MAX_NUMNODES)
> -		nid = -1;
> +	if (chipid == 0xffff || chipid >= MAX_NUMNODES)
> +		chipid = -1;
> 
> -	if (nid > 0 &&
> +	if (chipid > 0 &&
>  		of_read_number(associativity, 1) >= distance_ref_points_depth) {
>  		/*
>  		 * Skip the length field and send start of associativity array
>  		 */
> -		initialize_distance_lookup_table(nid, associativity + 1);
> +		initialize_distance_lookup_table(chipid, associativity + 1);
>  	}
> 
>  out:
> -	return nid;
> +	return chipid;
>  }
> 
> -/* Returns the nid associated with the given device tree node,
> +/* Returns the chipid associated with the given device tree node,
>   * or -1 if not found.
>   */
> -static int of_node_to_nid_single(struct device_node *device)
> +static int of_node_to_chipid_single(struct device_node *device)
>  {
> -	int nid = -1;
> +	int chipid = -1;
>  	const __be32 *tmp;
> 
>  	tmp = of_get_associativity(device);
>  	if (tmp)
> -		nid = associativity_to_nid(tmp);
> -	return nid;
> +		chipid = associativity_to_chipid(tmp);
> +	return chipid;
>  }
> 
>  /* Walk the device tree upwards, looking for an associativity id */
> @@ -286,7 +286,7 @@ int of_node_to_nid(struct device_node *device)
> 
>  	of_node_get(device);
>  	while (device) {
> -		nid = of_node_to_nid_single(device);
> +		nid = of_node_to_chipid_single(device);
>  		if (nid != -1)
>  			break;
> 
> @@ -498,7 +498,7 @@ static int of_get_assoc_arrays(struct device_node *memory,
>  }
> 
>  /*
> - * This is like of_node_to_nid_single() for memory represented in the
> + * This is like of_node_to_chipid_single() for memory represented in the
>   * ibm,dynamic-reconfiguration-memory node.
>   */
>  static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
> @@ -557,7 +557,7 @@ static int numa_setup_cpu(unsigned long lcpu)
>  			goto out;
>  	}
> 
> -	nid = of_node_to_nid_single(cpu);
> +	nid = of_node_to_chipid_single(cpu);
> 
>  out_present:
>  	if (nid < 0 || !node_online(nid))
> @@ -754,7 +754,7 @@ static int __init parse_numa_properties(void)
> 
>  		cpu = of_get_cpu_node(i, NULL);
>  		BUG_ON(!cpu);
> -		nid = of_node_to_nid_single(cpu);
> +		nid = of_node_to_chipid_single(cpu);
>  		of_node_put(cpu);
> 
>  		/*
> @@ -796,7 +796,7 @@ new_range:
>  		 * have associativity properties.  If none, then
>  		 * everything goes to default_nid.
>  		 */
> -		nid = of_node_to_nid_single(memory);
> +		nid = of_node_to_chipid_single(memory);
>  		if (nid < 0)
>  			nid = default_nid;
> 
> @@ -1119,7 +1119,7 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
>  			if ((scn_addr < start) || (scn_addr >= (start + size)))
>  				continue;
> 
> -			nid = of_node_to_nid_single(memory);
> +			nid = of_node_to_chipid_single(memory);
>  			break;
>  		}
> 
> @@ -1415,7 +1415,7 @@ int arch_update_cpu_topology(void)
> 
>  		/* Use associativity from first thread for all siblings */
>  		vphn_get_associativity(cpu, associativity);
> -		new_nid = associativity_to_nid(associativity);
> +		new_nid = associativity_to_chipid(associativity);

If you are getting a chipid, shouldn't you be assigning it to a variable
called 'new_chipid'?

>  		if (new_nid < 0 || !node_online(new_nid))
>  			new_nid = first_online_node;
> 
> -- 
> 1.7.11.7
> 
