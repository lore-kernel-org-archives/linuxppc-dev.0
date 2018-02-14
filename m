Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh7cm2thbzDqgJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:43:52 +1100 (AEDT)
In-Reply-To: <20180213110933.5491-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, Ram Pai <linuxram@us.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V3] powerpc/mm/hash64: memset the pagetable pages on allocation.
Message-Id: <3zh7cl4ZvNz9t6j@ozlabs.org>
Date: Wed, 14 Feb 2018 16:43:50 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-02-13 at 11:09:33 UTC, "Aneesh Kumar K.V" wrote:
> On powerpc we allocate page table pages from slab cache of different sizes. For
> now we have a constructor that zero out the objects when we allocate then for
> the first time. We expect the objects to be zeroed out when we free the the
> object back to slab cache. This happens in the unmap path. For hugetlb pages
> we call huge_pte_get_and_clear to do that. With the current configuration of
> page table size, both pud and pgd level tables get allocated from the same slab
> cache. At the pud level, we use the second half of the table to store the slot
> information. But never clear that when unmapping. When such an freed object get
> allocated at pgd level, we will have part of the page table page not initlaized
> correctly. This result in kernel crash
> 
> Simplify this by calling the object initialization after kmem_cache_alloc
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fc5c2f4a55a2c258e12013cdf287cf

cheers
