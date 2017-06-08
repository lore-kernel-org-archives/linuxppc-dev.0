Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjsMX3PptzDqP9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 14:07:36 +1000 (AEST)
In-Reply-To: <20170502051706.19043-2-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, vdavydov.dev@gmail.com,
 oss@buserror.net
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,1/3] powerpc/mm/book(e)(3s)/64: Add page table accounting
Message-Id: <3wjsMX2r61z9s8F@ozlabs.org>
Date: Thu,  8 Jun 2017 14:07:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-02 at 05:17:04 UTC, Balbir Singh wrote:
> Introduce a helper pgtable_gfp_flags() which
> just returns the current gfp flags and adds
> __GFP_ACCOUNT to account for page table allocation.
> The generic helper is added to include/asm/pgalloc.h
> and has two variants - WARNING ugly bits ahead
> 
> 1. If the header is included from a module, no check
> for mm == &init_mm is done, since init_mm is not
> exported
> 2. For kernel includes, the check is done and required
> see (3e79ec7 arch: x86: charge page tables to kmemcg)
> 
> The fundamental assumption is that no module should be
> doing pgd/pud/pmd and pte alloc's on behalf of init_mm
> directly.
> 
> NOTE: This adds an overhead to pmd/pud/pgd allocations
> similar to x86.  The other alternative was to implement
> pmd_alloc_kernel/pud_alloc_kernel and pgd_alloc_kernel
> with their offset variants.
> 
> For 4k page size, pte_alloc_one no longer calls
> pte_alloc_one_kernel.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/de3b87611dd1f3c00f4e42fe298457

cheers
