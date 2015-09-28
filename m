Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79D8B1A0391
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 03:28:25 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 13:28:22 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C6D9AC90042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 13:19:22 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8SHSJ2x43122762
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 17:28:19 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8SHSIWH025337
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 13:28:19 -0400
Date: Mon, 28 Sep 2015 10:28:17 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cl@linux.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC 3/5] powerpc:numa create 1:1 mappaing between chipid
 and nid
Message-ID: <20150928172817.GC48470@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1443378553-2146-4-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443378553-2146-4-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.09.2015 [23:59:11 +0530], Raghavendra K T wrote:
> Once we have made the distinction between nid and chipid
> create a 1:1 mapping between them. This makes compacting the
> nids easy later.


Didn't the previous patch just do the opposite of...

> @@ -286,7 +308,7 @@ int of_node_to_nid(struct device_node *device)
> 
>  	of_node_get(device);
>  	while (device) {
> -		nid = of_node_to_chipid_single(device);
> +		nid = of_node_to_nid_single(device);
>  		if (nid != -1)
>  			break;
> 
> @@ -498,7 +520,7 @@ static int of_get_assoc_arrays(struct device_node *memory,
>  }
> 
>  /*
> - * This is like of_node_to_chipid_single() for memory represented in the
> + * This is like of_node_to_nid_single() for memory represented in the
>   * ibm,dynamic-reconfiguration-memory node.
>   */
>  static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
> @@ -557,7 +579,7 @@ static int numa_setup_cpu(unsigned long lcpu)
>  			goto out;
>  	}
> 
> -	nid = of_node_to_chipid_single(cpu);
> +	nid = of_node_to_nid_single(cpu);
> 
>  out_present:
>  	if (nid < 0 || !node_online(nid))
> @@ -754,7 +776,7 @@ static int __init parse_numa_properties(void)
> 
>  		cpu = of_get_cpu_node(i, NULL);
>  		BUG_ON(!cpu);
> -		nid = of_node_to_chipid_single(cpu);
> +		nid = of_node_to_nid_single(cpu);
>  		of_node_put(cpu);
> 
>  		/*
> @@ -796,7 +818,7 @@ new_range:
>  		 * have associativity properties.  If none, then
>  		 * everything goes to default_nid.
>  		 */
> -		nid = of_node_to_chipid_single(memory);
> +		nid = of_node_to_nid_single(memory);
>  		if (nid < 0)
>  			nid = default_nid;
> 
> @@ -1119,7 +1141,7 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
>  			if ((scn_addr < start) || (scn_addr >= (start + size)))
>  				continue;
> 
> -			nid = of_node_to_chipid_single(memory);
> +			nid = of_node_to_nid_single(memory);
>  			break;
>  		}
> 
> @@ -1415,7 +1437,7 @@ int arch_update_cpu_topology(void)
> 
>  		/* Use associativity from first thread for all siblings */
>  		vphn_get_associativity(cpu, associativity);
> -		new_nid = associativity_to_chipid(associativity);
> +		new_nid = associativity_to_nid(associativity);
>  		if (new_nid < 0 || !node_online(new_nid))
>  			new_nid = first_online_node;
> 

Why is this churn useful?
