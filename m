Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh7cf3rvwzF13M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:43:46 +1100 (AEDT)
In-Reply-To: <20180211150009.21297-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, Ram Pai <linuxram@us.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V2,1/4] powerpc/mm: Fix crashes with PUD level hugetlb config
Message-Id: <3zh7cf2sx1z9t3M@ozlabs.org>
Date: Wed, 14 Feb 2018 16:43:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-11 at 15:00:06 UTC, "Aneesh Kumar K.V" wrote:
> To support memory keys, we moved the hash pte slot information to the second
> half of the page table. This was ok with PTE entries at level 4 and level 3.
> We already allocate larger page table pages at those level to accomodate extra
> details. For level 4 we already have the extra space which was used to track
> 4k hash page table entry details and at pmd level the extra space was allocated
> to track the THP details.
> 
> With hugetlbfs PTE, we used this extra space at the PMD level to store the
> slot details. But we also support hugetlbfs PTE at PUD leve and PUD level page
> didn't allocate extra space. This resulted in memory corruption.
> 
> Fix this by allocating extra space at PUD level when HUGETLB is enabled. We
> may need further changes to allocate larger space at PMD level when we enable
> HUGETLB. That will be done in next patch.
> 
> Fixes:bf9a95f9a6481bc6e(" powerpc: Free up four 64K PTE bits in 64K backed HPTE pages")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reviewed-by: Ram Pai <linuxram@us.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fae2211697c9490414e974431051f7

cheers
