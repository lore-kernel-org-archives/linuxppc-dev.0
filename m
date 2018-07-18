Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VnMm2WBTzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 16:30:44 +1000 (AEST)
Date: Wed, 18 Jul 2018 16:28:31 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH kernel v7 0/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180718062831.GA27453@fergus>
References: <20180717071913.2167-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717071913.2167-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2018 at 05:19:11PM +1000, Alexey Kardashevskiy wrote:
> This is to improve page boundaries checking and should probably
> be cc:stable. I came accross this while debugging nvlink2 passthrough
> but the lack of checking might be exploited by the existing userspace.
> 
> The get_user_pages() comment says it should be "phased out" but the only
> alternative seems to be get_user_pages_longterm(), should that be used
> instead (this is longterm reference elevation, however it is not DAX,
> whatever this implies)? get_user_pages_remote() seems unnecessarily
> complicated because of @locked.
> 
> 
> Changes:
> v7:
> * 2/2: do not fail if pte is not found, fall back to the default case instead
> 
> v6:
> * 2/2: read pageshift from pte
> 
> v5:
> * 2/2: changed compound pages handling
> 
> v4:
> * 2/2: implemented less strict but still safe max pageshift as David suggested
> 
> v3:
> * enforced huge pages not to cross preregistered chunk boundaries
> 
> v2:
> * 2/2: explicitly check for compound pages before calling compound_order()
> 
> 
> This is based on sha1
> 9d3cce1 Linus Torvalds "Linux 4.18-rc5".
> 
> Please comment. Thanks.
> 
> 
> 
> Alexey Kardashevskiy (2):
>   vfio/spapr: Use IOMMU pageshift rather than pagesize
>   KVM: PPC: Check if IOMMU page is contained in the pinned physical page
> 
>  arch/powerpc/include/asm/mmu_context.h |  4 ++--
>  arch/powerpc/kvm/book3s_64_vio.c       |  2 +-
>  arch/powerpc/kvm/book3s_64_vio_hv.c    |  6 ++++--
>  arch/powerpc/mm/mmu_context_iommu.c    | 37 ++++++++++++++++++++++++++++++++--
>  drivers/vfio/vfio_iommu_spapr_tce.c    | 10 ++++-----
>  5 files changed, 47 insertions(+), 12 deletions(-)

Thanks, series applied to my kvm-ppc-next branch.

Paul.
