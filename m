Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0AE31A024B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 08:18:26 +1000 (AEST)
Message-ID: <1430173102.4472.118.camel@redhat.com>
Subject: Re: [PATCH kernel v9 30/32] vfio: powerpc/spapr: Use 32bit DMA
 window properties from table_group
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 27 Apr 2015 16:18:22 -0600
In-Reply-To: <1429964096-11524-31-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-31-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-04-25 at 22:14 +1000, Alexey Kardashevskiy wrote:
> A table group might not have a table but it always has the default 32bit
> window parameters so use these.
> 
> No change in behavior is expected.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v9:
> * new in the series - to make the next patch simpler
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)


Acked-by: Alex Williamson <alex.williamson@redhat.com>


> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 4cfc2c1..a7d6729 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -185,7 +185,6 @@ static int tce_iommu_enable(struct tce_container *container)
>  {
>  	int ret = 0;
>  	unsigned long locked;
> -	struct iommu_table *tbl;
>  	struct iommu_table_group *table_group;
>  
>  	if (!container->grp)
> @@ -221,13 +220,19 @@ static int tce_iommu_enable(struct tce_container *container)
>  	 * this is that we cannot tell here the amount of RAM used by the guest
>  	 * as this information is only available from KVM and VFIO is
>  	 * KVM agnostic.
> +	 *
> +	 * So we do not allow enabling a container without a group attached
> +	 * as there is no way to know how much we should increment
> +	 * the locked_vm counter.
>  	 */
>  	table_group = iommu_group_get_iommudata(container->grp);
>  	if (!table_group)
>  		return -ENODEV;
>  
> -	tbl = &table_group->tables[0];
> -	locked = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
> +	if (!table_group->tce32_size)
> +		return -EPERM;
> +
> +	locked = table_group->tce32_size >> PAGE_SHIFT;
>  	ret = try_increment_locked_vm(locked);
>  	if (ret)
>  		return ret;
> @@ -504,7 +509,6 @@ static long tce_iommu_ioctl(void *iommu_data,
>  
>  	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
>  		struct vfio_iommu_spapr_tce_info info;
> -		struct iommu_table *tbl;
>  		struct iommu_table_group *table_group;
>  
>  		if (WARN_ON(!container->grp))
> @@ -512,8 +516,7 @@ static long tce_iommu_ioctl(void *iommu_data,
>  
>  		table_group = iommu_group_get_iommudata(container->grp);
>  
> -		tbl = &table_group->tables[0];
> -		if (WARN_ON_ONCE(!tbl))
> +		if (!table_group)
>  			return -ENXIO;
>  
>  		minsz = offsetofend(struct vfio_iommu_spapr_tce_info,
> @@ -525,8 +528,8 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (info.argsz < minsz)
>  			return -EINVAL;
>  
> -		info.dma32_window_start = tbl->it_offset << tbl->it_page_shift;
> -		info.dma32_window_size = tbl->it_size << tbl->it_page_shift;
> +		info.dma32_window_start = table_group->tce32_start;
> +		info.dma32_window_size = table_group->tce32_size;
>  		info.flags = 0;
>  
>  		if (copy_to_user((void __user *)arg, &info, minsz))
