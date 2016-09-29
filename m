Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slFPR3LN4zDsjG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 23:13:15 +1000 (AEST)
In-Reply-To: <2e840fe0-40cf-abf0-4fe6-a621ce46ae13@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [v3] KVM: PPC: Book3S HV: Migrate pinned pages out of CMA
Message-Id: <3slFPR2kWQz9sC3@ozlabs.org>
Date: Thu, 29 Sep 2016 23:13:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-06-09 at 06:27:31 UTC, Balbir Singh wrote:
> When PCI Device pass-through is enabled via VFIO, KVM-PPC will
> pin pages using get_user_pages_fast(). One of the downsides of
> the pinning is that the page could be in CMA region. The CMA
> region is used for other allocations like the hash page table.
> Ideally we want the pinned pages to be from non CMA region.
> 
> This patch (currently only for KVM PPC with VFIO) forcefully
> migrates the pages out (huge pages are omitted for the moment).
> There are more efficient ways of doing this, but that might
> be elaborate and might impact a larger audience beyond just
> the kvm ppc implementation.
> 
> The magic is in new_iommu_non_cma_page() which allocates the
> new page from a non CMA region.
> 
> I've tested the patches lightly at my end. The full solution
> requires migration of THP pages in the CMA region. That work
> will be done incrementally on top of this.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2e5bbb5461f138cac631fe21b4ad95

cheers
