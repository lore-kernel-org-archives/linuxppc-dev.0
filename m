Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwlnX2qFHzDqB4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 04:33:04 +1000 (AEST)
Date: Thu, 28 Apr 2016 12:33:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel] vfio_iommu_spapr_tce: Remove unneeded
 iommu_group_get_iommudata
Message-ID: <20160428123300.34dfff51@t450s.home>
In-Reply-To: <1460091281-14664-1-git-send-email-aik@ozlabs.ru>
References: <1460091281-14664-1-git-send-email-aik@ozlabs.ru>
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

On Fri,  8 Apr 2016 14:54:41 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This removes iommu_group_get_iommudata() as the result is never used.
> As this is a minor cleanup, no change in behavior is expected.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 0582b72..6419566 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -331,14 +331,12 @@ static void tce_iommu_free_table(struct iommu_table *tbl);
>  static void tce_iommu_release(void *iommu_data)
>  {
>  	struct tce_container *container = iommu_data;
> -	struct iommu_table_group *table_group;
>  	struct tce_iommu_group *tcegrp;
>  	long i;
>  
>  	while (tce_groups_attached(container)) {
>  		tcegrp = list_first_entry(&container->group_list,
>  				struct tce_iommu_group, next);
> -		table_group = iommu_group_get_iommudata(tcegrp->grp);
>  		tce_iommu_detach_group(iommu_data, tcegrp->grp);
>  	}
>  

Applied to next with David's R-b for v4.7.  Thanks,

Alex
