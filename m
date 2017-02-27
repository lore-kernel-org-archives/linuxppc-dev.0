Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWzJC378pzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 22:00:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Gracefully fail if too many
 TCE levels requested
In-Reply-To: <20170222044359.3663-1-aik@ozlabs.ru>
References: <20170222044359.3663-1-aik@ozlabs.ru>
Date: Mon, 27 Feb 2017 22:00:10 +1100
Message-ID: <87innvrj9h.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> The IODA2 specification says that a 64 DMA address cannot use top 4 bits
> (3 are reserved and one is a "TVE select"); bottom page_shift bits
> cannot be used for multilevel table addressing either.
>
> The existing IODA2 table allocation code aligns the minimum TCE table
> size to PAGE_SIZE so in the case of 64K system pages and 4K IOMMU pages,
> we have 64-4-12=48 bits. Since 64K page stores 8192 TCEs, i.e. needs
> 13 bits, the maximum number of levels is 48/13 = 3 so we physically
> cannot address more and EEH happens on DMA accesses.
>
> This adds a check that too many levels were requested.
>
> It is still possible to have 5 levels in the case of 4K system page size.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> The alternative would be allocating TCE tables as big as PAGE_SIZE but
> only using parts of it but this would complicate a bit bits of code
> responsible for overall amount of memory used for TCE table.
>
> Or kmem_cache_create() could be used to allocate as big TCE table levels
> as we really need but that API does not seem to support NUMA nodes.

kmem_cache_alloc_node() ?

cheers
