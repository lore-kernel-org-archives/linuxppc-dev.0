Return-Path: <nfont@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2EF471A0184
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 05:58:54 +1000 (EST)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 743FD140180
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2014 05:58:53 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 17 Sep 2014 13:58:51 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id BD163C90045
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2014 15:58:38 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8HJwlIq56950886
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2014 19:58:47 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8HJwkOr018248
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2014 15:58:46 -0400
Message-ID: <5419E7F5.2040000@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 14:58:45 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [5/5] pseries: Implement memory hotplug remove in the kernel
References: <54174D36.4000002@linux.vnet.ibm.com>
 <1410937650.27681.13.camel@concordia>
In-Reply-To: <1410937650.27681.13.camel@concordia>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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
> On Mon, 2014-09-15 at 15:33 -0500, Nathan Fontenot wrote:
>> This patch adds the ability to do memory hotplug remove in the kernel.
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
>>  arch/powerpc/platforms/pseries/hotplug-memory.c |  140 +++++++++++++++++++++++
>>  1 file changed, 139 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index b254773..160c424 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -193,7 +193,137 @@ static int pseries_remove_mem_node(struct device_node *np)
>>  	pseries_remove_memblock(base, lmb_size);
>>  	return 0;
>>  }
>> +
>> +static int lmb_is_removable(struct of_drconf_cell *lmb)
>> +{
> 
> Do we not already have something like this?

No. Perhaps your thinking of the code in drivers/base/memory.c that
handles the sysfs removable file. That code just calls the same
is_mem_section_removable() routine.

> 
>> +	int i, scns_per_block;
>> +	int rc = 1;
> 
> I can see this makes the &= work below.
> 
> But what if block_sz / MIN_MEMORY_BLOCK_SIZE = 0 ?

If that happens, something else is really wrong. Most
likely a malformed device tree.

For pseries MIN_MEMORY_BLOCK_SIZE is defined to be the smallest
LMB size we suppport, 16MB.

I can add a pr_warn() statement here and bail if that happens.

> 
>> +	unsigned long pfn, block_sz;
>> +	u64 phys_addr;
>> +
>> +	phys_addr = be64_to_cpu(lmb->base_addr);
>> +	block_sz = memory_block_size_bytes();
>> +	scns_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
>> +
>> +	for (i = 0; i < scns_per_block; i++) {
>> +		pfn = PFN_DOWN(phys_addr);
>> +		if (!pfn_present(pfn))
>> +			continue;
>> +
>> +		rc &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
>> +		phys_addr += MIN_MEMORY_BLOCK_SIZE;
>> +	}
>> +
>> +	return rc;
>> +}
> 
>> +static int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
>> +{
> 
> ...
> 
>> +}
> 
> Most of the same comments as for add.
> 

ok, I'll go through them and apply them to the remove code.

Thanks for the review.

-Nathan
