Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWH9L02mmzDqh5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 23:52:21 +1000 (AEST)
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
 <8444cb2b-b134-e9fc-a458-1ba7b22a8df1@oracle.com>
 <20170814114755.GI19063@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <e339a33c-d16b-91bd-5df0-18f5ec03d52b@oracle.com>
Date: Mon, 14 Aug 2017 09:51:12 -0400
MIME-Version: 1.0
In-Reply-To: <20170814114755.GI19063@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> mem_init()
>>   free_all_bootmem()
>>    free_low_memory_core_early()
>>     for_each_reserved_mem_region()
>>      reserve_bootmem_region()
>>       init_reserved_page() <- if this is deferred reserved page
>>        __init_single_pfn()
>>         __init_single_page()
>>
>> So, currently, we are using the value of page->flags to figure out if this
>> page has been initialized while being part of deferred page, but this is not
>> going to work for this project, as we do not zero the memory that is backing
>> the struct pages, and size the value of page->flags can be anything.
> 
> True, this is the initialization part I've missed in one of the previous
> patches already. Would it be possible to only iterate over !reserved
> memory blocks instead? Now that we discard all the metadata later it
> should be quite easy to do for_each_memblock_type, no?

Hi Michal,

Clever suggestion to add a new iterator to go through unreserved 
existing memory, I do not think there is this iterator available, so it 
would need to be implemented, using similar approach to what I have done 
with a call back.

However, there is a different reason, why I took this current approach.

Daniel Jordan is working on a ktask support:
https://lkml.org/lkml/2017/7/14/666

He and I discussed on how to multi-thread struct pages initialization 
within memory nodes using ktasks. Having this callback interface makes 
that multi-threading quiet easy, improving the boot performance further, 
with his prototype we saw x4-6 improvements (using 4-8 threads per 
node). Reducing the total time it takes to initialize all struct pages 
on machines with terabytes of memory to less than one second.

Pasha
