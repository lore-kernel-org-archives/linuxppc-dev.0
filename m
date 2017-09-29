Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3mBt3rqbzDqG2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Sep 2017 08:17:26 +1000 (AEST)
Date: Fri, 29 Sep 2017 16:17:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH kernel v3] vfio/spapr: Add cond_resched() for huge updates
Message-ID: <20170929161722.36ff1771@w520.home>
In-Reply-To: <20170928091612.20717-1-aik@ozlabs.ru>
References: <20170928091612.20717-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 28 Sep 2017 19:16:12 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> Clearing very big IOMMU tables can trigger soft lockups. This adds
> cond_resched() to allow the scheduler to do context switching when
> it decides to.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> The testcase is POWER9 box with 264GB guest, 4 VFIO devices from
> independent IOMMU groups, 64K IOMMU pages. This configuration produces
> 4325376 TCE entries, each entry update incurs 4 OPAL calls to update
> an individual PE TCE cache; this produced lockups for more than 20s.
> Reducing table size to 4194304 (i.e. 256GB guest) or removing one
> of 4 VFIO devices makes the problem go away.
> 
> ---
> Changes:
> v3:
> * cond_resched() checks for should_resched() so we just call resched()
> and let the cpu scheduler decide whether to switch or not
> 
> v2:
> * replaced with time based solution
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 63112c36ab2d..759a5bdd40e1 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -507,6 +507,8 @@ static int tce_iommu_clear(struct tce_container *container,
>  	enum dma_data_direction direction;
>  
>  	for ( ; pages; --pages, ++entry) {
> +		cond_resched();
> +
>  		direction = DMA_NONE;
>  		oldhpa = 0;
>  		ret = iommu_tce_xchg(tbl, entry, &oldhpa, &direction);

This looks fine to me, I've applied it to my local next branch for
v4.15.  I'll push that branch next week, once I can rebase to
4.14-rc3.  Thanks,

Alex
