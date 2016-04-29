Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxHxZ3wJBzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 01:41:54 +1000 (AEST)
Date: Fri, 29 Apr 2016 09:41:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dan Carpenter
 <dan.carpenter@oracle.com>, Daniel Axtens <dja@axtens.net>, David Gibson
 <david@gibson.dropbear.id.au>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v4 02/11] vfio/spapr: Relax the IOMMU
 compatibility check
Message-ID: <20160429094146.4ed23f4b@t450s.home>
In-Reply-To: <1461920124-21719-3-git-send-email-aik@ozlabs.ru>
References: <1461920124-21719-1-git-send-email-aik@ozlabs.ru>
 <1461920124-21719-3-git-send-email-aik@ozlabs.ru>
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

On Fri, 29 Apr 2016 18:55:15 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> We are going to have multiple different types of PHB on the same system
> with POWER8 + NVLink and PHBs will have different IOMMU ops. However
> we only really care about one callback - create_table - so we can
> relax the compatibility check here.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 0582b72..3054e3f 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1188,7 +1188,8 @@ static int tce_iommu_attach_group(void *iommu_data,
>  			goto unlock_exit;
>  		}
>  		table_group_tmp = iommu_group_get_iommudata(tcegrp->grp);
> -		if (table_group_tmp->ops != table_group->ops) {
> +		if (table_group_tmp->ops->create_table !=
> +				table_group->ops->create_table) {
>  			pr_warn("tce_vfio: Group %d is incompatible with group %d\n",
>  					iommu_group_id(iommu_group),
>  					iommu_group_id(tcegrp->grp));

Acked-by: Alex Williamson <alex.williamson@redhat.com>
