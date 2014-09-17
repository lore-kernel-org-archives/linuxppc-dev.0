Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0BFF1A013A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 05:45:14 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 17 Sep 2014 13:45:12 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 553861FF003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 13:45:09 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8HJjAt549741900
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 21:45:10 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8HJj9mV004222
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 13:45:09 -0600
Message-ID: <5419E4C4.4000305@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 14:45:08 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [4/5] pseries: Implement memory hotplug add in the kernel
References: <54174CF3.1010802@linux.vnet.ibm.com>
 <1410937639.27681.12.camel@concordia>
In-Reply-To: <1410937639.27681.12.camel@concordia>
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

On 09/17/2014 02:07 AM, Michael Ellerman wrote:
> 
> On Mon, 2014-09-15 at 15:32 -0500, Nathan Fontenot wrote:
>> This patch adds the ability to do memory hotplug adding in the kernel.
>>
>> Currently the hotplug add/remove of memory is handled by the drmgr
>> command. The drmgr command performs the add/remove by performing
>> some work in user-space and making requests to the kernel to handle 
>> other pieces. By moving all of the work to the kernel we can do the
>> add and remove faster, and provide a common place to do memory hotplug
>> for both the PowerVM and PowerKVM environments.
>>
>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/hotplug-memory.c |  170 +++++++++++++++++++++++
>>  1 file changed, 170 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index 0e60e15..b254773 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/vmalloc.h>
>>  #include <linux/memory.h>
>>  #include <linux/memory_hotplug.h>
>> +#include <linux/slab.h>
>>  
>>  #include <asm/firmware.h>
>>  #include <asm/machdep.h>
>> @@ -24,6 +25,8 @@
>>  #include <asm/sparsemem.h>
>>  #include <asm/rtas.h>
>>  
>> +#include "pseries.h"
>> +
>>  DEFINE_MUTEX(dlpar_mem_mutex);
>>  
>>  unsigned long pseries_memory_block_size(void)
>> @@ -69,6 +72,53 @@ unsigned long pseries_memory_block_size(void)
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
>> +	new_prop->value = kmalloc(prop->length + 1, GFP_KERNEL);
>> +	if (!new_prop->name || !new_prop->value) {
>> +		dlpar_free_drconf_property(new_prop);
>> +		return NULL;
>> +	}
>> +
>> +	memcpy(new_prop->value, prop->value, prop->length);
>> +	new_prop->length = prop->length;
>> +	*(((char *)new_prop->value) + new_prop->length) = 0;
> 
> It's not a string, is it?

No, property->value is a void*. I'll drop that line of code.

> 
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
>>  static int pseries_remove_memory(u64 start, u64 size)
>>  {
>> @@ -155,13 +205,133 @@ static inline int pseries_remove_mem_node(struct device_node *np)
>>  }
>>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>>  
>> +static int dlpar_add_one_lmb(struct of_drconf_cell *lmb)
>> +{
>> +	struct memory_block *mem_block;
>> +	u64 phys_addr;
>> +	unsigned long pages_per_block;
>> +	unsigned long block_sz;
>> +	int nid, sections_per_block;
>> +	int rc;
>> +
>> +	phys_addr = be64_to_cpu(lmb->base_addr);
> 
> of_drconf_cell needs endian annotations.

Yes it does. I can include a patch to update the struct.

> 
>> +	block_sz = memory_block_size_bytes();
>> +	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
>> +	pages_per_block = PAGES_PER_SECTION * sections_per_block;
>> +
>> +	if (phys_addr & ((pages_per_block << PAGE_SHIFT) - 1))
>> +		return -EINVAL;
>> +
>> +	nid = memory_add_physaddr_to_nid(phys_addr);
>> +	rc = add_memory(nid, phys_addr, block_sz);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = memblock_add(phys_addr, block_sz);
>> +	if (rc) {
>> +		remove_memory(nid, phys_addr, block_sz);
>> +		return rc;
>> +	}
>> +
>> +	mem_block = lmb_to_memblock(lmb);
>> +	if (!mem_block) {
>> +		remove_memory(nid, phys_addr, block_sz);
>> +		return -EINVAL;
>> +	}
> 
> That could all use a lot of comments. ie. why do we have to add it twice?

We don't actually add it twice, though I can see how one could think
that based on the names of the routines called. I'll add comments to 
clarify this in v2 of the patch.

memory_add_physaddr_to_nid(), this doesn't add anything despite its naming.
The routine finds the node id for the specified physical address.

add_memory(), this actually adds the memory.

memblock_add(), this informs the memory block information tracking about the
newly added memory. Why this is not done as part of add_memory I don't know.

> 
>> +	rc = device_online(&mem_block->dev);
>> +	put_device(&mem_block->dev);
>> +	if (rc)
>> +		remove_memory(nid, phys_addr, block_sz);
>> +
>> +	return rc;
>> +}
>> +
>> +static int dlpar_memory_add(struct pseries_hp_errorlog *hp_elog)
>> +{
>> +	struct of_drconf_cell *lmb;
>> +	struct device_node *dn;
>> +	struct property *prop;
>> +	uint32_t entries, *p;
> 
> *p should be __be32.

Yes.

> 
>> +	int i, lmbs_to_add;
>> +	int lmbs_added = 0;
>> +	int rc = -EINVAL;
> 
> Don't pre-initialise your rc variables.

I did this here for a reason. When asking to add memory by drc_index it
is possible to fall out of the for() loop traversing the lmb entries
and not find the requested drc_index.

Adding a check for this situation after the loop would do the same thing
and probably make this situation more clear.
 
> 
>> +	if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
>> +		lmbs_to_add = be32_to_cpu(hp_elog->_drc_u.drc_count);
>> +		pr_info("Attempting to hot-add %d LMB(s)\n", lmbs_to_add);
>> +	} else {
>> +		lmbs_to_add = 1;
>> +		pr_info("Attempting to hot-add LMB, drc index %x\n",
>> +			be32_to_cpu(hp_elog->_drc_u.drc_index));
>> +	}
>> +
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
>> +	p = prop->value;
>> +	entries = be32_to_cpu(*p++);
>> +	lmb = (struct of_drconf_cell *)p;
> 
> 
> So if I'm reading this right the hp_elog either contains an index or a count of
> LMBs to add. But it doesn't contain anything about which address ranges to add
> or any of those details. That is all in the ibm,dynamic-memory property - but
> how did it get in there?

The ibm,dynamic-memory property of the device tree is passed to the kernel
by phyp/qemu. The property is an array that associates each LMB with a
starting physical address and associativity.

> 
>> +
>> +	for (i = 0; i < entries; i++, lmb++) {
>> +		u32 drc_index = be32_to_cpu(lmb->drc_index);
>> +
>> +		if (lmbs_to_add == lmbs_added)
>> +			break;
>> +
>> +		if (be32_to_cpu(lmb->flags) & DRCONF_MEM_ASSIGNED)
>> +			continue;
>> +
>> +		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX
>> +		    && lmb->drc_index != hp_elog->_drc_u.drc_index)
>> +			continue;
>> +
>> +		rc = dlpar_acquire_drc(drc_index);
>> +		if (rc)
>> +			continue;
>> +
>> +		rc = dlpar_add_one_lmb(lmb);
>> +		if (rc) {
>> +			dlpar_release_drc(drc_index);
>> +			continue;
>> +		}
> 
> In both the above error cases you just move along. That means we potentially
> hotplugged some memory but not everything that we were asked to. That seems
> like a bad idea, we should either do everything or nothing.
> 
> 

That can be done, though will require some additional tracking.

The current hotplug handling for PowerVM make a best effort and tries to
add/remove as much of the requested memory as possible. I was going with
that same approach here, but have no problem moving to an all or nothing
approach.

We will need to keep track of the LMBs added/removed during a request so
we can return to the original state if the request cannot be satisfied.
 
>> +
>> +		lmb->flags |= cpu_to_be32(DRCONF_MEM_ASSIGNED);
>> +		lmbs_added++;
>> +		pr_info("Memory at %llx (drc index %x) has been hot-added\n",
>> +			be64_to_cpu(lmb->base_addr), drc_index);
>> +	}
>> +
>> +	if (lmbs_added)
>> +		rc = of_update_property(dn, prop);
>> +	else
>> +		dlpar_free_drconf_property(prop);
> 
> The value of rc here is not clear. It could be EINVAL or it could be the result
> of the last dlpar_add_one_lmb(lmb). gcc would have told you that if you hadn't
> initialised it.
> 
>> +
>> +	of_node_put(dn);
>> +	return rc ? rc : lmbs_added;
> 
> This looks wrong.
> 
> Doesn't the rc eventually go back to dlpar_write(), which expects 0 for success?
> 
> That should show up as the write failing in userspace.
> 
> 

Based on previous comments I think the handling of rc will be updated so
we either return success or failure.

>>  int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>>  {
>>  	int rc = 0;
> 
> Don't initialise to zero, that way gcc can tell you if there's a path where you
> forget to initialise it. It also means you can't accidentally return success.
> 
>> +	if (hp_elog->id_type != PSERIES_HP_ELOG_ID_DRC_COUNT
>> +	    && hp_elog->id_type != PSERIES_HP_ELOG_ID_DRC_INDEX)
>> +		return -EINVAL;
> 
> This would look nicer as a switch I think.

can do.

-Nathan
