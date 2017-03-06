Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc2HH5zfwzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 12:28:26 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 77so5434795pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 17:28:26 -0800 (PST)
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Gracefully fail if too many
 TCE levels requested
To: benh@au1.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <20170222044359.3663-1-aik@ozlabs.ru>
 <87innvrj9h.fsf@concordia.ellerman.id.au>
 <1488755034.2870.114.camel@au1.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <cd84399e-73d6-72dd-8509-f45db5e47d31@ozlabs.ru>
Date: Mon, 6 Mar 2017 12:28:19 +1100
MIME-Version: 1.0
In-Reply-To: <1488755034.2870.114.camel@au1.ibm.com>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/17 10:03, Benjamin Herrenschmidt wrote:
> On Mon, 2017-02-27 at 22:00 +1100, Michael Ellerman wrote:
>>> The alternative would be allocating TCE tables as big as PAGE_SIZE
>>> but
>>> only using parts of it but this would complicate a bit bits of code
>>> responsible for overall amount of memory used for TCE table.
>>>
>>> Or kmem_cache_create() could be used to allocate as big TCE table
>>> levels
>>> as we really need but that API does not seem to support NUMA nodes.
>>
>> kmem_cache_alloc_node() ?
> 
> Is that 55 bits of address space (ie, 3 indirect levels + 64k pages) ?
> Or only 39 (2 indirect level + 64k pages) ?

39, yes.

> In the former case, I'm happy to limit the levels to 3 for 64K pages,
> 55 bits of TCE space is more than enough. 39 isn't however.

8192*8192*8192*65536>>40 = 32768TB of addressable memory (but there is no
good reason not to use huge pages);
8192*8192*8192*4096>>40 = 2048TB or addressable memory (even with 2
indirect levels but we can have all 5 levels with 4K IOMMU pages).

Looks enough to me...

And in this particular patch I am not limiting anything, I just replace
already existing EEH condition with -EINVAL. If it is this important to
have all 5 levels, then we can switch from alloc_pages_node() to
kmem_cache_alloc_node(), in a separate patch.


-- 
Alexey
