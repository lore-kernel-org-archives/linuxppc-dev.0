Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FCFA1A1272
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:49:45 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Fri, 21 Nov 2014 17:49:42 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B998E2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:49:39 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAL7nD7D41418820
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:49:13 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAL7ncuD030762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 18:49:39 +1100
Message-ID: <1416556178.2855.69.camel@cyril>
Subject: Re: [PATCH v2 6/6] pseries: Implement memory hotplug remove in the
 kernel
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 21 Nov 2014 18:49:38 +1100
In-Reply-To: <546A6EFD.2020001@linux.vnet.ibm.com>
References: <546A6C23.1080800@linux.vnet.ibm.com>
 <546A6EFD.2020001@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 2014-11-17 at 15:56 -0600, Nathan Fontenot wrote:
> Move handling of memory hotplug remove on pseries completely into the kernel.
> 
> The current memory hotplug remove path involves the drmgr command doing part
> of this work in userspace and requesting the kernel to do additional pieces.
> This patch allows us to handle the act completely in the kernel via rtas
> hotplug events. This allows us to perform the operation faster and provide
> a common memory hotplug remove path for PowerVM and PowerKVM systems.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c |  206 ++++++++++++++++++++++-
>  1 file changed, 201 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index b57d42b..c8189e8 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -173,6 +173,179 @@ static int pseries_remove_mem_node(struct device_node *np)
>  	pseries_remove_memblock(base, lmb_size);
>  	return 0;
>  }
> +
> +static int lmb_is_removable(struct of_drconf_cell *lmb)
> +{
> +	int i, scns_per_block;
> +	int rc = 1;
> +	unsigned long pfn, block_sz;
> +	u64 phys_addr;
> +
> +	if (!(be32_to_cpu(lmb->flags) & DRCONF_MEM_ASSIGNED))
> +		return -1;
This makes me kind of nervous. You're using the return value of
lmb_is_removable as a boolean but it returns three possible values -1,0
and 1. Functionally it looks correct to me so its not a massive issue
> +
> +	phys_addr = be64_to_cpu(lmb->base_addr);
> +	block_sz = memory_block_size_bytes();
> +	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
> +
> +	for (i = 0; i < scns_per_block; i++) {
> +		pfn = PFN_DOWN(phys_addr);
> +		if (!pfn_present(pfn))
> +			continue;
> +
> +		rc &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
> +		phys_addr += MIN_MEMORY_BLOCK_SIZE;
> +	}
> +
> +	return rc;
> +}
> +
> +static int dlpar_add_lmb(struct of_drconf_cell *);
> +
> +static int dlpar_remove_lmb(struct of_drconf_cell *lmb)
> +{
> +	struct memory_block *mem_block;
> +	unsigned long block_sz;
> +	u64 phys_addr;
> +	uint32_t drc_index;
> +	int nid, rc;
> +
> +	if (!lmb_is_removable(lmb))
> +		return -EINVAL;
> +
> +	phys_addr = be64_to_cpu(lmb->base_addr);
> +	drc_index = be32_to_cpu(lmb->drc_index);
> +
> +	mem_block = lmb_to_memblock(lmb);
> +	if (!mem_block)
> +		return -EINVAL;
> +
> +	rc = device_offline(&mem_block->dev);
> +	put_device(&mem_block->dev);
> +	if (rc)
> +		return rc;
> +
> +	block_sz = pseries_memory_block_size();
> +	nid = memory_add_physaddr_to_nid(phys_addr);
> +
> +	remove_memory(nid, phys_addr, block_sz);
> +
> +	/* Update memory regions for memory remove */
> +	memblock_remove(phys_addr, block_sz);
> +
> +	dlpar_release_drc(drc_index);
> +
> +	lmb->flags &= cpu_to_be32(~DRCONF_MEM_ASSIGNED);
> +	pr_info("Memory at %llx (drc index %x) has been hot-removed\n",
> +		be64_to_cpu(lmb->base_addr), drc_index);
dlpar_add_lmb doesn't print anything but dlpar_remove_lmb does? Related
to my comment about printing a 'hot-add' messages prematurely, perhaps
move this to the callers
> +
> +	return 0;
> +}
> +
> +static int dlpar_memory_remove_by_count(struct pseries_hp_errorlog *hp_elog,
> +					struct property *prop)
> +{
> +	struct of_drconf_cell *lmbs;
> +	int lmbs_to_remove, lmbs_removed = 0;
> +	int lmbs_available = 0;
> +	uint32_t num_lmbs;
> +	__be32 *p;
> +	int i, rc;
> +
> +	lmbs_to_remove = be32_to_cpu(hp_elog->_drc_u.drc_count);
Didn't you already do the endian conversion back in
handle_dlpar_errorlog?
> +	pr_info("Attempting to hot-remove %d LMB(s)\n", lmbs_to_remove);
> +
> +	if (lmbs_to_remove == 0)
> +		return -EINVAL;
> +
> +	p = prop->value;
> +	num_lmbs = be32_to_cpu(*p++);
> +	lmbs = (struct of_drconf_cell *)p;
> +
> +	/* Validate that there are enough LMBs to satisfy the request */
> +	for (i = 0; i < num_lmbs; i++) {
> +		if (be32_to_cpu(lmbs[i].flags) & DRCONF_MEM_ASSIGNED)
> +			lmbs_available++;
> +	}
> +
> +	if (lmbs_available < lmbs_to_remove)
> +		return -EINVAL;
> +
> +	for (i = 0; i < num_lmbs; i++) {
> +		if (lmbs_to_remove == lmbs_removed)
> +			break;
> +
> +		rc = dlpar_remove_lmb(&lmbs[i]);
> +		if (rc)
> +			continue;
> +
> +		lmbs_removed++;
> +
> +		/* Mark this lmb so we can add it later if all of the
> +		 * requested LMBs cannot be removed.
> +		 */
> +		lmbs[i].reserved = 1;
> +	}
> +
> +	if (lmbs_removed != lmbs_to_remove) {
> +		pr_err("Memory hot-remove failed, adding LMB's back\n");
> +
> +		for (i = 0; i < num_lmbs; i++) {
> +			if (!lmbs[i].reserved)
> +				continue;
> +
> +			rc = dlpar_add_lmb(&lmbs[i]);
> +			if (rc)
If this happens you this will leave an LMB removed but an error code
from this function will cause dlpar_memory to discard the dn prop that
it passed in. If you couldn't roll back completely the caller should
still update the dn property with the ones that it has left
removed/failed to re-add. Perhaps this function needs a mechanism to
report success/failure (as it currently does) and a mechanism to say
whether or not the dn property is dirty or not.
> +				pr_err("Failed to add LMB back, drc index %x\n",
> +				       be32_to_cpu(lmbs[i].drc_index));
> +
On a clean (everything rolled back successfully) failure, I don't think
you _need_ to bother although this is nice cleanup, you didn't do it
dlpar_memory_add_by_count - I'm in favour of being clean especially
since on an 'unclean' failure you should clear that flag - if you're
going to still update the device tree.
> +			lmbs[i].reserved = 0;
> +		}
> +		rc = -EINVAL;
> +	} else {
> +		/* remove any reserved markings */
> +		for (i = 0; i < num_lmbs; i++)
> +			lmbs[i].reserved = 0;
> +	}
Hmmmm since the if statements are checking for failures. It might be
more clear to return -EINVAL (rather than setting rc) and the code in
the else block can be moved out of it and come to think of it, return 0.
Otherwise it looks odd to me with the 'normal' success case code being
in an else statement.
> +
> +	return rc;
> +}
> +
> +static int dlpar_memory_remove_by_index(struct pseries_hp_errorlog *hp_elog,
> +					struct property *prop)
> +{
> +	struct of_drconf_cell *lmbs;
> +	uint32_t num_lmbs, drc_index;
> +	int lmb_found;
> +	__be32 *p;
> +	int i, rc;
> +
> +	drc_index = be32_to_cpu(hp_elog->_drc_u.drc_index);
Didn't you already do the endian conversion back in
handle_dlpar_errorlog?
> +	pr_info("Attempting to hot-remove LMB, drc index %x\n", drc_index);
> +
> +	p = prop->value;
> +	num_lmbs = be32_to_cpu(*p++);
> +	lmbs = (struct of_drconf_cell *)p;
> +
> +	lmb_found = 0;
> +	for (i = 0; i < num_lmbs; i++) {
> +		if (lmbs[i].drc_index == hp_elog->_drc_u.drc_index) {
> +			lmb_found = 1;
> +			rc = dlpar_remove_lmb(&lmbs[i]);
> +			break;
> +		}
> +	}
> +
> +	if (!lmb_found)
> +		rc = -EINVAL;
> +
> +	if (rc)
> +		pr_info("Failed to hot-remove memory, drc index %x\n",
> +			drc_index);
> +
> +	return rc;
> +}
> +
>  #else
>  static inline int pseries_remove_memblock(unsigned long base,
>  					  unsigned int memblock_size)
> @@ -183,6 +356,11 @@ static inline int pseries_remove_mem_node(struct device_node *np)
>  {
>  	return 0;
>  }
> +static inline int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
>  static int dlpar_add_lmb(struct of_drconf_cell *lmb)
> @@ -298,14 +476,24 @@ static int dlpar_memory_add_by_count(struct pseries_hp_errorlog *hp_elog,
>  	}
>  
>  	if (lmbs_added != lmbs_to_add) {
> -		/* TODO: remove added lmbs */
> +		pr_err("Memory hot-add failed, removing any added LMBs\n");
> +
> +		for (i = 0; i < num_lmbs; i++) {
> +			if (!lmbs[i].reserved)
> +				continue;
> +
> +			rc = dlpar_remove_lmb(&lmbs[i]);
> +			if (rc)
There is a very much related comment in dlpar_memory_remove_by_count
about this condition being true.
> +				pr_err("Failed to remove LMB, drc index %x\n",
> +				       be32_to_cpu(lmbs[i].drc_index));

You don't clear the reserved flag here?

> +		}
>  		rc = -EINVAL;
Same observation as in dlpar_memory_remove_by_count
> +	} else {
> +		/* Clear the reserved fields */
> +		for (i = 0; i < num_lmbs; i++)
> +			lmbs[i].reserved = 0;
>  	}
>  
> -	/* Clear the reserved fields */
> -	for (i = 0; i < num_lmbs; i++)
> -		lmbs[i].reserved = 0;
> -
>  	return rc;
>  }
>  
> @@ -373,6 +561,14 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  		else
>  			rc = -EINVAL;
>  		break;
> +	case PSERIES_HP_ELOG_ACTION_REMOVE:
> +		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
> +			rc = dlpar_memory_remove_by_count(hp_elog, prop);
> +		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
> +			rc = dlpar_memory_remove_by_index(hp_elog, prop);
> +		else
> +			rc = -EINVAL;
> +		break;
>  	default:
>  		pr_err("Invalid action (%d) specified\n", hp_elog->action);
>  		rc = -EINVAL;
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
