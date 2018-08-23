Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x6381j69zF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 00:18:44 +1000 (AEST)
In-Reply-To: <20180823000858.GA17719@fergus>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org,
 kvm-ppc@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: KVM: PPC: Book3S: Fix guest DMA when guest partially backed by
 THP pages
Message-Id: <41x6374LGgz9s3C@ozlabs.org>
Date: Fri, 24 Aug 2018 00:18:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-23 at 00:08:58 UTC, Paul Mackerras wrote:
> Commit 76fa4975f3ed ("KVM: PPC: Check if IOMMU page is contained in the
> pinned physical page", 2018-07-17) added some checks to ensure that guest
> DMA mappings don't attempt to map more than the guest is entitled to
> access.  However, errors in the logic mean that legitimate guest requests
> to map pages for DMA are being denied in some situations.  Specifically,
> if the first page of the range passed to mm_iommu_get() is mapped with
> a normal page, and subsequent pages are mapped with transparent huge
> pages, we end up with mem->pageshift == 0.  That means that the page
> size checks in mm_iommu_ua_to_hpa() and mm_iommu_up_to_hpa_rm() will
> always fail for every page in that region, and thus the guest can never
> map any memory in that region for DMA, typically leading to a flood of
> error messages like this:
> 
> qemu-system-ppc64: VFIO_MAP_DMA: -22
> qemu-system-ppc64: vfio_dma_map(0x10005f47780, 0x800000000000000, 0x10000, 0x7fff63ff0000) = -22 (Invalid argument)
> 
> The logic errors in mm_iommu_get() are:
> 
> (a) use of 'ua' not 'ua + (i << PAGE_SHIFT)' in the find_linux_pte() call
>     (meaning that find_linux_pte() returns the pte for the first address
>     in the range, not the address we are currently up to);
> (b) use of 'pageshift' as the variable to receive the hugepage shift
>     returned by find_linux_pte() - for a normal page this gets set to
>     0, leading to us setting mem->pageshift to 0 when we conclude that
>     the pte returned by find_linux_pte didn't match the page we were
>     looking at;
> (c) comparing 'compshift', which is a page order, i.e. log base 2 of the
>     number of pages, with 'pageshift', which is a log base 2 of the number
>     of bytes.
> 
> To fix these problems, this patch introduces 'cur_ua' to hold the current
> user address and uses that in the find_linux_pte call; introduces
> 'pteshift' to hold the hugepage shift found by find_linux_pte(); and
> compares 'pteshift' with 'compshift + PAGE_SHIFT' rather than 'compshift'.
> The patch also moves the local_irq_restore to the point after the pte
> pointer returned by find_linux_pte has been dereferenced because that
> seems safer, and adds a check to avoid doing the find_linux_pte() call
> once mem->pageshift has been reduced to PAGE_SHIFT, as an optimization.
> 
> Cc: stable@vger.kernel.org # v4.12+
> Fixes: 76fa4975f3ed ("KVM: PPC: Check if IOMMU page is contained in the
> pinned physical page")
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8cfbdbdc24815417a3ab35101ccf70

cheers
