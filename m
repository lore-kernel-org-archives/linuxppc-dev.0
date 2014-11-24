Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D57AF1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 01:56:43 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 24 Nov 2014 07:56:41 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3D1821FF0027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 07:45:24 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOEv9Gf18874498
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 07:57:09 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOEudjZ014625
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 07:56:39 -0700
Message-ID: <54734726.5070006@linux.vnet.ibm.com>
Date: Mon, 24 Nov 2014 08:56:38 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyril.bur@au1.ibm.com>
Subject: Re: [PATCH v2 5/6] pseries: Implement memory hotplug add in the kernel
References: <546A6C23.1080800@linux.vnet.ibm.com>
 <546A6EA7.3030806@linux.vnet.ibm.com> <1416556176.2855.68.camel@cyril>
In-Reply-To: <1416556176.2855.68.camel@cyril>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2014 01:49 AM, Cyril Bur wrote:
> 
> On Mon, 2014-11-17 at 15:54 -0600, Nathan Fontenot wrote:
>> Move handling of memory hotplug add on pseries completely into the kernel.
>>
>> The current memory hotplug add path involves the drmgr command doing part
>> of this work in userspace and requesting the kernel to do additional pieces.
>> This patch allows us to handle the act completely in the kernel via rtas
>> hotplug events. This allows us to perform the operation faster and provide
>> a common memory hotplug add path for PowerVM and PowerKVM systems.
>>
>> The patch does introduce a static rtas_hp_event variable that is set to
>> true when updating the device tree during memory hotplug initiated from
>> a rtas hotplug event. This is needed because we do not need to do the
>> work in the of notifier, this work is already performed in handling the
>> hotplug request. At a later time we can remove this when we deprecate the
>> previous method of memory hotplug.
>>
>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/hotplug-memory.c |  244 +++++++++++++++++++++++
>>  1 file changed, 243 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index 69d178b..b57d42b 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/memory.h>
>>  #include <linux/memory_hotplug.h>
>> +#include <linux/slab.h>
>>  
>>  #include <asm/firmware.h>
>>  #include <asm/machdep.h>
>> @@ -23,6 +24,8 @@
>>  #include <asm/sparsemem.h>
>>  #include "pseries.h"
>>  
>> +static bool rtas_hp_event;
>> +
>>  unsigned long pseries_memory_block_size(void)
>>  {
>>  	struct device_node *np;
>> @@ -66,6 +69,52 @@ unsigned long pseries_memory_block_size(void)
>>  	return memblock_size;
>>  }
>>  
>> +static void dlpar_free_drconf_property(struct property *prop)
>> +{
>> +	kfree(prop->name);
>> +	kfree(prop->value);
>> +	kfree(prop);
>> +}
>> +
>> +static struct property *dlpar_clone_drconf_property(struct device_node *dn)
>> +{
>> +	struct property *prop, *new_prop;
>> +
>> +	prop = of_find_property(dn, "ibm,dynamic-memory", NULL);
>> +	if (!prop)
>> +		return NULL;
>> +
>> +	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
>> +	if (!new_prop)
>> +		return NULL;
>> +
>> +	new_prop->name = kstrdup(prop->name, GFP_KERNEL);
>> +	new_prop->value = kmalloc(prop->length, GFP_KERNEL);
>> +	if (!new_prop->name || !new_prop->value) {
>> +		dlpar_free_drconf_property(new_prop);
>> +		return NULL;
>> +	}
>> +
>> +	memcpy(new_prop->value, prop->value, prop->length);
>> +	new_prop->length = prop->length;
>> +
>> +	return new_prop;
>> +}
>> +
>> +static struct memory_block *lmb_to_memblock(struct of_drconf_cell *lmb)
>> +{
>> +	unsigned long section_nr;
>> +	struct mem_section *mem_sect;
>> +	struct memory_block *mem_block;
>> +	u64 phys_addr = be64_to_cpu(lmb->base_addr);
>> +
>> +	section_nr = pfn_to_section_nr(PFN_DOWN(phys_addr));
>> +	mem_sect = __nr_to_section(section_nr);
>> +
>> +	mem_block = find_memory_block(mem_sect);
>> +	return mem_block;
>> +}
>> +
>>  #ifdef CONFIG_MEMORY_HOTREMOVE
>>  static int pseries_remove_memblock(unsigned long base, unsigned int memblock_size)
>>  {
>> @@ -136,19 +185,209 @@ static inline int pseries_remove_mem_node(struct device_node *np)
>>  }
>>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>>  
>> +static int dlpar_add_lmb(struct of_drconf_cell *lmb)
>> +{
>> +	struct memory_block *mem_block;
>> +	u64 phys_addr;
>> +	uint32_t drc_index;
> I started commenting this and it turns out you've used uint32_t almost
> everywhere for values you've pulled from the device tree or the elog.
> These should be u32.

ok, that should be an easy fix.

>> +	unsigned long pages_per_block;
>> +	unsigned long block_sz;
>> +	int nid, sections_per_block;
>> +	int rc;
>> +
>> +	if (be32_to_cpu(lmb->flags) & DRCONF_MEM_ASSIGNED)
>> +		return -EINVAL;
>> +
>> +	phys_addr = be64_to_cpu(lmb->base_addr);
>> +	drc_index = be32_to_cpu(lmb->drc_index);
>> +	block_sz = memory_block_size_bytes();
>> +	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
>> +	pages_per_block = PAGES_PER_SECTION * sections_per_block;
>> +
> Perhaps I'm being a bit slow here but it isn't exactly clear what you're
> getting with all those variables and could you explain what that
> statement below is checking for?
> 
>> +	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
>> +		return -EINVAL;

We could probably get rid of this check, The values were are validating
come from the device tree and if it's wrong we have more serious problems
than a failure in mem hotplug.

This would also remove the need for the pages_per_block and sections_per_block
variables.

>> +
>> +	rc = dlpar_acquire_drc(drc_index);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Find the node id for this address */
>> +	nid = memory_add_physaddr_to_nid(phys_addr);
>> +
>> +	/* Add the memory */
>> +	rc = add_memory(nid, phys_addr, block_sz);
>> +	if (rc) {
>> +		dlpar_release_drc(drc_index);
>> +		return rc;
>> +	}
>> +
>> +	/* Register this block of memory */
>> +	rc = memblock_add(phys_addr, block_sz);
>> +	if (rc) {
>> +		remove_memory(nid, phys_addr, block_sz);
>> +		dlpar_release_drc(drc_index);
>> +		return rc;
>> +	}
>> +
>> +	mem_block = lmb_to_memblock(lmb);
>> +	if (!mem_block) {
>> +		remove_memory(nid, phys_addr, block_sz);
>> +		dlpar_release_drc(drc_index);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = device_online(&mem_block->dev);
>> +	put_device(&mem_block->dev);
>> +	if (rc) {
>> +		remove_memory(nid, phys_addr, block_sz);
>> +		dlpar_release_drc(drc_index);
>> +		return rc;
>> +	}
>> +
>> +	lmb->flags |= cpu_to_be32(DRCONF_MEM_ASSIGNED);
>> +	return 0;
>> +}
>> +
>> +static int dlpar_memory_add_by_count(struct pseries_hp_errorlog *hp_elog,
>> +				     struct property *prop)
>> +{
>> +	struct of_drconf_cell *lmbs;
>> +	uint32_t num_lmbs;
>> +	__be32 *p;
>> +	int i, lmbs_to_add;
>> +	int lmbs_available = 0;
>> +	int lmbs_added = 0;
>> +	int rc;
>> +
>> +	lmbs_to_add = be32_to_cpu(hp_elog->_drc_u.drc_count);

> Didn't you already do the endian conversion back in
> handle_dlpar_errorlog?

Yep, already fixed in the next patchset.

>> +	pr_info("Attempting to hot-add %d LMB(s)\n", lmbs_to_add);
>> +
>> +	if (lmbs_to_add == 0)
>> +		return -EINVAL;
>> +
>> +	p = prop->value;
>> +	num_lmbs = be32_to_cpu(*p++);
>> +	lmbs = (struct of_drconf_cell *)p;
>> +
>> +	/* Validate that there are enough LMBs to satisfy the request */
>> +	for (i = 0; i < num_lmbs; i++) {
>> +		if (!(be32_to_cpu(lmbs[i].flags) & DRCONF_MEM_ASSIGNED))
>> +			lmbs_available++;
>> +	}
>> +
>> +	if (lmbs_available < lmbs_to_add)
>> +		return -EINVAL;
>> +
> I'm wondering why the next 3 lines when the if could be incorporated
> into the for condition
> for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
> (or lmbs_to_add < lmbs_added)...

It could. I tend to put less in the for() statement. Just my preference on
readability.

>> +	for (i = 0; i < num_lmbs; i++) {
>> +		if (lmbs_to_add == lmbs_added)
>> +			break;
>> +
>> +		rc = dlpar_add_lmb(&lmbs[i]);
>> +		if (rc)
>> +			continue;
>> +
>> +		lmbs_added++;
>> +		pr_info("Memory at %llx (drc index %x) has been hot-added\n",
>> +			be64_to_cpu(lmbs[i].base_addr),
>> +			be32_to_cpu(lmbs[i].drc_index));

> This message feels a tad premature, you're going to roll back if the
> requested amount couldn't be added which is good but then there's going
> to be a confusing mix of 'hot-added' followed by 'hot-removed'. Could
> this message be moved to when you clear the reserved fields?

Ahh... good point. I will do that.

>> +
>> +		/* Mark this lmb so we can remove it later if all of the
>> +		 * requested LMBs cannot be added.
>> +		 */
>> +		lmbs[i].reserved = 1;
> Writing 1 like that into a __be variable will upset sparse. 
> 
> As a more general comment that it might be worth not passing around __be
> structures and convert them all into CPU endian in one place so that all
> these functions can do away with the endian conversion calls.

This may be possible. I will have to look at how the struct is passed around
what is used in it. It would be nice to have fewer conversion calls.

>> +	}
>> +
>> +	if (lmbs_added != lmbs_to_add) {
>> +		/* TODO: remove added lmbs */
>> +		rc = -EINVAL;
>> +	}
>> +
>> +	/* Clear the reserved fields */
>> +	for (i = 0; i < num_lmbs; i++)
>> +		lmbs[i].reserved = 0;
>> +
>> +	return rc;
>> +}
>> +
>> +static int dlpar_memory_add_by_index(struct pseries_hp_errorlog *hp_elog,
>> +				     struct property *prop)
>> +{
>> +	struct of_drconf_cell *lmbs;
>> +	uint32_t num_lmbs, drc_index;
>> +	__be32 *p;
>> +	int i, lmb_found;
>> +	int rc;
>> +
>> +	drc_index = be32_to_cpu(hp_elog->_drc_u.drc_index);
> Didn't you already do the endian conversion back in
> handle_dlpar_errorlog?
>> +	pr_info("Attempting to hot-add LMB, drc index %x\n", drc_index);
>> +
>> +	p = prop->value;
>> +	num_lmbs = be32_to_cpu(*p++);
>> +	lmbs = (struct of_drconf_cell *)p;
>> +
>> +	lmb_found = 0;
>> +	for (i = 0; i < num_lmbs; i++) {
>> +		if (lmbs[i].drc_index == hp_elog->_drc_u.drc_index) {
> Probably wanted to use your local variable drc_index here also
> lmbs[i].drc_index is __be and I don't think you've converted it but the
> other side of the condition has been...

Yep.

-Nathan

>> +			lmb_found = 1;
>> +			rc = dlpar_add_lmb(&lmbs[i]);
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!lmb_found)
>> +		rc = -EINVAL;
>> +
>> +	if (rc)
>> +		pr_info("Failed to hot-add memory, drc index %x\n", drc_index);
>> +	else
>> +		pr_info("Memory at %llx (drc index %x) has been hot-added\n",
>> +			be64_to_cpu(lmbs[i].base_addr), drc_index);
>> +
>> +	return rc;
>> +}
>> +
>>  int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>>  {
>> -	int rc = 0;
>> +	struct device_node *dn;
>> +	struct property *prop;
>> +	int rc;
>>  
>>  	lock_device_hotplug();
>>  
>> +	dn = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>> +	if (!dn)
>> +		return -EINVAL;
>> +
>> +	prop = dlpar_clone_drconf_property(dn);
>> +	if (!prop) {
>> +		of_node_put(dn);
>> +		return -EINVAL;
>> +	}
>> +
>>  	switch (hp_elog->action) {
>> +	case PSERIES_HP_ELOG_ACTION_ADD:
>> +		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT)
>> +			rc = dlpar_memory_add_by_count(hp_elog, prop);
>> +		else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX)
>> +			rc = dlpar_memory_add_by_index(hp_elog, prop);
>> +		else
>> +			rc = -EINVAL;
>> +		break;
>>  	default:
>>  		pr_err("Invalid action (%d) specified\n", hp_elog->action);
>>  		rc = -EINVAL;
>>  		break;
>>  	}
>>  
>> +	if (rc)
>> +		dlpar_free_drconf_property(prop);
>> +	else {
>> +		rtas_hp_event = true;
>> +		of_update_property(dn, prop);
>> +		rtas_hp_event = false;
>> +	}
>> +
>> +	of_node_put(dn);
>>  	unlock_device_hotplug();
>>  	return rc;
>>  }
>> @@ -193,6 +432,9 @@ static int pseries_update_drconf_memory(struct of_prop_reconfig *pr)
>>  	__be32 *p;
>>  	int i, rc = -EINVAL;
>>  
>> +	if (rtas_hp_event)
>> +		return 0;
>> +
>>  	memblock_size = pseries_memory_block_size();
>>  	if (!memblock_size)
>>  		return -EINVAL;
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
> 
