Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXKq65jrlzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 11:54:42 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id x17so2730191pgi.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 16:54:42 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Gracefully fail if too many
 TCE levels requested
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20170222044359.3663-1-aik@ozlabs.ru>
 <87innvrj9h.fsf@concordia.ellerman.id.au>
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ece02143-73b4-c03b-a2cd-950134fd8f69@ozlabs.ru>
Date: Tue, 28 Feb 2017 11:54:36 +1100
MIME-Version: 1.0
In-Reply-To: <87innvrj9h.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/02/17 22:00, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> The IODA2 specification says that a 64 DMA address cannot use top 4 bits
>> (3 are reserved and one is a "TVE select"); bottom page_shift bits
>> cannot be used for multilevel table addressing either.
>>
>> The existing IODA2 table allocation code aligns the minimum TCE table
>> size to PAGE_SIZE so in the case of 64K system pages and 4K IOMMU pages,
>> we have 64-4-12=48 bits. Since 64K page stores 8192 TCEs, i.e. needs
>> 13 bits, the maximum number of levels is 48/13 = 3 so we physically
>> cannot address more and EEH happens on DMA accesses.
>>
>> This adds a check that too many levels were requested.
>>
>> It is still possible to have 5 levels in the case of 4K system page size.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> The alternative would be allocating TCE tables as big as PAGE_SIZE but
>> only using parts of it but this would complicate a bit bits of code
>> responsible for overall amount of memory used for TCE table.
>>
>> Or kmem_cache_create() could be used to allocate as big TCE table levels
>> as we really need but that API does not seem to support NUMA nodes.
> 
> kmem_cache_alloc_node() ?


Yeah, discovered this later. Still, if a single level is used, then the
table is 4MB and kmem_cache_alloc_node() does not seem the right tool here
(although I cannot find any enforced upper limit).

So to keep things simpler, I decided to stick to alloc_pages_node() and
avoid mixing memory allocation APIs.


-- 
Alexey
