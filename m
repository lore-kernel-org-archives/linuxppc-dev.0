Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp727242wzDqyf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 00:36:15 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6BEXuge100214
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 10:36:12 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 242vjvguxa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 10:36:12 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 11 Jul 2016 08:36:10 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C0DF53E40052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 08:36:08 -0600 (MDT)
Subject: Re: [PATCH 2/2] powerpc/pseries: Implemented indexed-count hotplug
 memory remove
To: Sahil Mehta <smehta@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <19ab11fc-9771-1ad4-95d7-d26dd8f18184@linux.vnet.ibm.com>
 <71ca109d-052f-484e-29d5-763e836695f4@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 11 Jul 2016 09:36:04 -0500
MIME-Version: 1.0
In-Reply-To: <71ca109d-052f-484e-29d5-763e836695f4@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <5783AED4.9060609@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2016 02:24 PM, Sahil Mehta wrote:
> Indexed-count remove for memory hotplug guarantees that a contiguous block
> of <count> lmbs beginning at a specified <index> will be unassigned (NOT
> that <count> lmbs will be removed). Because of Qemu's per-DIMM memory
> management, the removal of a contiguous block of memory currently
> requires a series of individual calls. Indexed-count remove reduces
> this series into a single call.
> 
> Signed-off-by: Sahil Mehta <smehta@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c |   85 +++++++++++++++++++++++
>  1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index cf359bf..4d81810 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -503,6 +503,86 @@ static int dlpar_memory_remove_by_index(u32 drc_index, struct property *prop)
>  	return rc;
>  }
> 
> +static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index,
> +				     struct property *prop)
> +{
> +	struct of_drconf_cell *lmbs;
> +	u32 num_lmbs, *p;
> +	int i, rc;
> +	int lmbs_available = 0, start_index = 0, end_index;
> +
> +	pr_info("Attempting to hot-remove %u LMB(s) at %x\n",
> +		lmbs_to_remove, drc_index);
> +
> +	if (lmbs_to_remove == 0)
> +		return -EINVAL;
> +
> +	p = prop->value;
> +	num_lmbs = *p++;
> +	lmbs = (struct of_drconf_cell *)p;
> +
> +	/* Navigate to drc_index */
> +	while (start_index < num_lmbs) {
> +		if (lmbs[start_index].drc_index == drc_index)
> +			break;
> +
> +		start_index++;
> +	}
> +
> +	end_index = start_index + lmbs_to_remove;
> +
> +	/* Validate that there are enough LMBs to satisfy the request */
> +	for (i = start_index; i < end_index; i++) {
> +		if (lmbs[i].flags & DRCONF_MEM_RESERVED)
> +			break;
> +
> +		lmbs_available++;
> +	}
> +
> +	if (lmbs_available < lmbs_to_remove)
> +		return -EINVAL;
> +
> +	for (i = 0; i < end_index; i++) {
> +		if (!(lmbs[i].flags & DRCONF_MEM_ASSIGNED))
> +			continue;
> +
> +		rc = dlpar_remove_lmb(&lmbs[i]);
> +		if (rc)
> +			break;
> +
> +		lmbs[i].reserved = 1;
> +	}
> +
> +	if (rc) {
> +		pr_err("Memory indexed-count-remove failed, adding any removed LMBs\n");
> +
> +		for (i = start_index; i < end_index; i++) {
> +			if (!lmbs[i].reserved)
> +				continue;
> +
> +			rc = dlpar_add_lmb(&lmbs[i]);
> +			if (rc)
> +				pr_err("Failed to add LMB, drc index %x\n",
> +				       be32_to_cpu(lmbs[i].drc_index));
> +
> +			lmbs[i].reserved = 0;
> +		}
> +		rc = -EINVAL;
> +	} else {
> +		for (i = start_index; i < end_index; i++) {
> +			if (!lmbs[i].reserved)
> +				continue;
> +
> +			pr_info("Memory at %llx (drc index %x) was hot-removed\n",
> +				lmbs[i].base_addr, lmbs[i].drc_index);
> +
> +			lmbs[i].reserved = 0;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
>  #else
>  static inline int pseries_remove_memblock(unsigned long base,
>  					  unsigned int memblock_size)
> @@ -770,7 +850,6 @@ static int dlpar_memory_add_by_ic(u32 lmbs_to_add, u32 drc_index,
> 
>  			pr_info("Memory at %llx (drc index %x) was hot-added\n",
>  				lmbs[i].base_addr, lmbs[i].drc_index);
> -			lmbs[i].reserved = 0;

I'm not sure why you're removing the reserved field setting here, especially
since this is in the add case and your patch is for remove.


>  		}
>  	}
> 
> @@ -820,6 +899,10 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
>  			drc_index = hp_elog->_drc_u.drc_index;
>  			rc = dlpar_memory_remove_by_index(drc_index, prop);
> +		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_IC) {
> +			ic[0] = hp_elog->_drc_u.indexed_count[0];
> +			ic[1] = hp_elog->_drc_u.indexed_count[1];
> +			rc = dlpar_memory_remove_by_ic(ic[0], ic[1], prop);

Same comment here as for the add patch and using ic[].

-Nathan

>  		} else
>  			rc = -EINVAL;
>  		break;
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
