Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTV4K4jDczDr2j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 01:56:49 +1000 (AEST)
Subject: Re: [v6 05/15] mm: don't accessed uninitialized struct pages
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <1502138329-123460-6-git-send-email-pasha.tatashin@oracle.com>
 <20170811093746.GF30811@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <8444cb2b-b134-e9fc-a458-1ba7b22a8df1@oracle.com>
Date: Fri, 11 Aug 2017 11:55:39 -0400
MIME-Version: 1.0
In-Reply-To: <20170811093746.GF30811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2017 05:37 AM, Michal Hocko wrote:
> On Mon 07-08-17 16:38:39, Pavel Tatashin wrote:
>> In deferred_init_memmap() where all deferred struct pages are initialized
>> we have a check like this:
>>
>>      if (page->flags) {
>>              VM_BUG_ON(page_zone(page) != zone);
>>              goto free_range;
>>      }
>>
>> This way we are checking if the current deferred page has already been
>> initialized. It works, because memory for struct pages has been zeroed, and
>> the only way flags are not zero if it went through __init_single_page()
>> before.  But, once we change the current behavior and won't zero the memory
>> in memblock allocator, we cannot trust anything inside "struct page"es
>> until they are initialized. This patch fixes this.
>>
>> This patch defines a new accessor memblock_get_reserved_pfn_range()
>> which returns successive ranges of reserved PFNs.  deferred_init_memmap()
>> calls it to determine if a PFN and its struct page has already been
>> initialized.
> 
> Why don't we simply check the pfn against pgdat->first_deferred_pfn?

Because we are initializing deferred pages, and all of them have pfn 
greater than pgdat->first_deferred_pfn. However, some of deferred pages 
were already initialized if they were reserved, in this path:

mem_init()
  free_all_bootmem()
   free_low_memory_core_early()
    for_each_reserved_mem_region()
     reserve_bootmem_region()
      init_reserved_page() <- if this is deferred reserved page
       __init_single_pfn()
        __init_single_page()

So, currently, we are using the value of page->flags to figure out if 
this page has been initialized while being part of deferred page, but 
this is not going to work for this project, as we do not zero the memory 
that is backing the struct pages, and size the value of page->flags can 
be anything.
