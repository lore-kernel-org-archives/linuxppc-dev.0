Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB4442C00F5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 23:02:01 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 12 Aug 2013 22:48:48 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E14762BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 23:01:54 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7CCk7fM1704218
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 22:46:07 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7CD1rnm003791
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 23:01:53 +1000
Message-ID: <5208DCBC.7060205@linux.vnet.ibm.com>
Date: Mon, 12 Aug 2013 08:01:48 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Register bootmem pages at boot on powerpc
References: <52050ACE.4090001@linux.vnet.ibm.com>
 <52050B80.8010602@linux.vnet.ibm.com> <1376266763.32100.144.camel@pasglop>
In-Reply-To: <1376266763.32100.144.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2013 07:19 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-09 at 10:32 -0500, Nathan Fontenot wrote:
> 
>> +void register_page_bootmem_memmap(unsigned long section_nr,
>> +				  struct page *start_page, unsigned long size)
>> +{
>> +	WARN_ONCE(1, KERN_INFO
>> +		  "Sparse Vmemmap not fully supported for bootmem info nodes\n");
>> +}
>>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> 
> But SPARSEMEM_VMEMMAP is our default on ppc64 pseries ... and you are
> select'ing the new option, so it looks like we are missing something
> here...
> 
> Can you tell me a bit more, the above makes me nervous...

Ok, I agree. that message isn't quite right.

What I wanted to convey is that memory hotplug is not fully supported
on powerpc with SPARSE_VMEMMAP enabled.. Perhaps the message should read
"Memory hotplug is not fully supported for bootmem info nodes".

Thoughts?

-Nathan

> 
> Cheers,
> Ben.
> 
>> Index: powerpc/arch/powerpc/mm/mem.c
>> ===================================================================
>> --- powerpc.orig/arch/powerpc/mm/mem.c
>> +++ powerpc/arch/powerpc/mm/mem.c
>> @@ -297,12 +297,21 @@ void __init paging_init(void)
>>  }
>>  #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
>>
>> +static void __init register_page_bootmem_info(void)
>> +{
>> +	int i;
>> +
>> +	for_each_online_node(i)
>> +		register_page_bootmem_info_node(NODE_DATA(i));
>> +}
>> +
>>  void __init mem_init(void)
>>  {
>>  #ifdef CONFIG_SWIOTLB
>>  	swiotlb_init(0);
>>  #endif
>>
>> +	register_page_bootmem_info();
>>  	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
>>  	set_max_mapnr(max_pfn);
>>  	free_all_bootmem();
>> Index: powerpc/mm/Kconfig
>> ===================================================================
>> --- powerpc.orig/mm/Kconfig
>> +++ powerpc/mm/Kconfig
>> @@ -183,7 +183,7 @@ config MEMORY_HOTPLUG_SPARSE
>>  config MEMORY_HOTREMOVE
>>  	bool "Allow for memory hot remove"
>>  	select MEMORY_ISOLATION
>> -	select HAVE_BOOTMEM_INFO_NODE if X86_64
>> +	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
>>  	depends on MEMORY_HOTPLUG && ARCH_ENABLE_MEMORY_HOTREMOVE
>>  	depends on MIGRATION
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
