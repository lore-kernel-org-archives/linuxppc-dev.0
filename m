Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rb7gz1sSMzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 03:27:27 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NHOVUI119170
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 13:27:24 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q6ynkhgt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 13:27:24 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 11:27:23 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 10C113E40055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 11:27:19 -0600 (MDT)
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5NHRJQj62521438
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 17:27:19 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DAB9112073
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 13:27:19 -0400 (EDT)
Received: from [9.41.92.173] (unknown [9.41.92.173])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP id 693F511206F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 13:27:19 -0400 (EDT)
Subject: Re: [PATCH] powerpc/mm: update arch_{add,remove}_memory() for radix
To: linuxppc-dev@lists.ozlabs.org
References: <1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com>
 <87mvmbygdb.fsf@skywalker.in.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 23 Jun 2016 12:27:18 -0500
MIME-Version: 1.0
In-Reply-To: <87mvmbygdb.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <576C1BF6.3010803@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2016 12:17 PM, Aneesh Kumar K.V wrote:
> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
> 
>> These functions are making direct calls to the hash table APIs,
>> leading to a BUG() on systems using radix.
>>
>> Switch them to the vmemmap_{create,remove}_mapping() wrappers, and
>> move to the __meminit section.
> 
> 
> They are really not the same. They can possibly end up using different
> base page size. Also vmemmap is available only with SPARSEMEM_VMEMMAP
> enabled. Does hotplug depend on sparsemem vmemmap ?

Sparse vmemmap is supported, and I think enabled by default for pseries,
but hotplug does not depend on sparse vmemmep.

-Nathan

> 
>>
>> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/mem.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> index 2fd57fa..80c6ee7 100644
>> --- a/arch/powerpc/mm/mem.c
>> +++ b/arch/powerpc/mm/mem.c
>> @@ -116,7 +116,7 @@ int memory_add_physaddr_to_nid(u64 start)
>>  }
>>  #endif
>>
>> -int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
>> +int __meminit arch_add_memory(int nid, u64 start, u64 size, bool for_device)
>>  {
>>  	struct pglist_data *pgdata;
>>  	struct zone *zone;
>> @@ -127,7 +127,7 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
>>  	pgdata = NODE_DATA(nid);
>>
>>  	start = (unsigned long)__va(start);
>> -	rc = create_section_mapping(start, start + size);
>> +	rc = vmemmap_create_mapping(start, size, __pa(start));
>>  	if (rc) {
>>  		pr_warning(
>>  			"Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
>> @@ -143,7 +143,7 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
>>  }
>>
>>  #ifdef CONFIG_MEMORY_HOTREMOVE
>> -int arch_remove_memory(u64 start, u64 size)
>> +int __meminit arch_remove_memory(u64 start, u64 size)
>>  {
>>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>> @@ -157,7 +157,7 @@ int arch_remove_memory(u64 start, u64 size)
>>
>>  	/* Remove htab bolted mappings for this section of memory */
>>  	start = (unsigned long)__va(start);
>> -	ret = remove_section_mapping(start, start + size);
>> +	vmemmap_remove_mapping(start, size);
>>
>>  	/* Ensure all vmalloc mappings are flushed in case they also
>>  	 * hit that section of memory
>> -- 
>> 1.8.3.1
> 
> We really want to look at memory hotplug to fully understand the
> radix impact. The unplug operation needs to do some additional freeing.
> 
> I did put in comments around that with the idea of coming back to that
> later
> 
> #ifdef CONFIG_MEMORY_HOTPLUG
> void radix__vmemmap_remove_mapping(unsigned long start, unsigned long page_size)
> {
> 	/* FIXME!! intel does more. We should free page tables mapping vmemmap ? */
> }
> #endif
> 
> -aneesh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
