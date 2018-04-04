Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GTBZ5qVKzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 00:39:50 +1000 (AEST)
In-Reply-To: <20180330120408.25036-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [V3] powerpc/mm/hugetlb: initialize the pagetable cache correctly
 for hugetlb
Message-Id: <40GTBZ55l4z9s2S@ozlabs.org>
Date: Thu,  5 Apr 2018 00:39:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-30 at 12:04:08 UTC, "Aneesh Kumar K.V" wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> With 64k page size, we have hugetlb pte entries at the pmd and pud level for
> book3s64. We don't need to create a separate page table cache for that. With 4k
> we need to make sure hugepd page table cache for 16M is placed at PUD level
> and 16G at the PGD level.
> 
> Simplify all these by not using HUGEPD_PD_SHIFT which is confusing for book3s64.
> 
> Without this patch, with 64k page size we create pagetable caches with shift
> value 10 and 7 which are not used at all.
> 
> Fixes: 419df06eea5b ("powerpc: Reduce the PTE_INDEX_SIZE")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6fa504835d6969144b2bd3699684dd

cheers
