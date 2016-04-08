Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qh7Jm1ZpnzDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 15:27:51 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 8 Apr 2016 01:27:49 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 86BF0C90042
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 01:27:41 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u385RkVL31588600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 05:27:46 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u385Rj1X011442
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 01:27:46 -0400
Subject: Re: [RFC FIX PATCH v0] powerpc,numa: Fix memory_hotplug_max()
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1459935883-29445-1-git-send-email-bharata@linux.vnet.ibm.com>
Cc: nfonteno@us.ibm.com, aik@au1.ibm.com, mdroth@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Message-ID: <57074150.6070105@linux.vnet.ibm.com>
Date: Fri, 8 Apr 2016 00:27:44 -0500
MIME-Version: 1.0
In-Reply-To: <1459935883-29445-1-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/2016 04:44 AM, Bharata B Rao wrote:
> memory_hotplug_max() uses hot_add_drconf_memory_max() to get maxmimum
> addressable memory by referring to ibm,dyanamic-memory property. There
> are three problems with the current approach:
> 
> 1 hot_add_drconf_memory_max() assumes that ibm,dynamic-memory includes
>   all the LMBs of the guest, but that is not true for PowerKVM which
>   populates only DR LMBs (LMBs that can be hotplugged/removed) in that
>   property.
> 2 hot_add_drconf_memory_max() multiplies lmb-size with lmb-count to arrive
>   at the max possible address. Since ibm,dynamic-memory doesn't include
>   RMA LMBs, the address thus obtained will be less than the actual max
>   address. For example, if max possible memory size is 32G, with lmb-size
>   of 256MB there can be 127 LMBs in ibm,dynamic-memory (1 LMB for RMA
>   which won't be present here).  hot_add_drconf_memory_max() would then
>   return the max addressable memory as 127 * 256MB = 31.75GB, the max
>   address should have been 32G which is what ibm,lrdr-capacity shows.
> 3 In PowerKVM, there can be a gap between the end of boot time RAM and
>   beginning of hotplug RAM area. So just multiplying lmb-count with
>   lmb-size will not provide the correct max possible address for PowerKVM.
> 
> This patch fixes 1 by using ibm,lrdr-capacity property to return the max
> addressable memory whenever the property is present. Then it fixes 2 & 3
> by fetching the address of the last LMB in ibm,dynamic-memory property.
> 
> NOTE: There are some unnecessary changes in the patch because of converting
> spaces to tabs w/o which checkpatch.pl complains.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 669a15e..57d5877 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1164,17 +1164,32 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
>  static u64 hot_add_drconf_memory_max(void)
>  {
>          struct device_node *memory = NULL;
> -        unsigned int drconf_cell_cnt = 0;
> -        u64 lmb_size = 0;
> +	struct device_node *dn = NULL;
> +	unsigned int drconf_cell_cnt = 0;
> +	u64 lmb_size = 0;
>  	const __be32 *dm = NULL;
> +	const __be64 *lrdr = NULL;
> +	struct of_drconf_cell drmem;
> +
> +	dn = of_find_node_by_path("/rtas");
> +	if (dn) {
> +		lrdr = of_get_property(dn, "ibm,lrdr-capacity", NULL);
> +		of_node_put(dn);
> +		if (lrdr)
> +			return be64_to_cpup(lrdr);
> +	}
>  
>          memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>          if (memory) {
> -                drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
> -                lmb_size = of_get_lmb_size(memory);
> -                of_node_put(memory);
> -        }
> -        return lmb_size * drconf_cell_cnt;
> +		drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
> +		lmb_size = of_get_lmb_size(memory);
> +
> +		/* Advance to the last cell, each cell has 6 32 bit integers */
> +		dm += (drconf_cell_cnt - 1) * 6;

You could do this as follows to avoid hard-coding 6
		dm += (drconf_cell_cnt - 1) * sizeof(struct of_drconf_cell)

> +		read_drconf_cell(&drmem, &dm);
> +		of_node_put(memory);
> +	}
> +	return drmem.base_addr + lmb_size;

I assume it is a safe assumption that there will only be 1 RMA LMB?

I do see that the PAPR defines a bit in the flags field for each LMB
in ibm,dynamic-memory as 'reserved'. Is this something you could use
to flag RMA LMBs and put them in the ibm,dynamic-memory property?

I'm just curious why these LMBs are not in this property.

-Nathan 
>  }
>  
>  /*
> 
