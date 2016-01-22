Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 278241A184E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jan 2016 04:24:22 +1100 (AEDT)
Message-ID: <1453483460.32741.420.camel@redhat.com>
Subject: Re: [PATCH kernel] vfio: Only check for bus IOMMU when NOIOMMU is
 selected
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 22 Jan 2016 10:24:20 -0700
In-Reply-To: <1453444494-46900-1-git-send-email-aik@ozlabs.ru>
References: <1453444494-46900-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-01-22 at 17:34 +1100, Alexey Kardashevskiy wrote:
> Recent change 03a76b60 "vfio: Include No-IOMMU mode" disabled VFIO
> on systems which do not implement iommu_ops for the PCI bus even
> though
> there is an VFIO IOMMU driver for it such as SPAPR TCE driver for
> PPC64/powernv platform.
> 
> This moves iommu_present() call under #ifdef CONFIG_VFIO_NOIOMMU as
> it is done in the rest of the file to re-enable VFIO on powernv.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 82f25cc..3f8060e 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -343,7 +343,6 @@ static struct vfio_group
> *vfio_create_group(struct iommu_group *iommu_group,
>  	atomic_set(&group->opened, 0);
>  	group->iommu_group = iommu_group;
>  	group->noiommu = !iommu_present;
> -
>  	group->nb.notifier_call = vfio_iommu_group_notifier;
>  
>  	/*
> @@ -767,7 +766,11 @@ int vfio_add_group_dev(struct device *dev,
>  
>  	group = vfio_group_get_from_iommu(iommu_group);
>  	if (!group) {
> +#ifdef CONFIG_VFIO_NOIOMMU
>  		group = vfio_create_group(iommu_group,
> iommu_present(dev->bus));
> +#else
> +		group = vfio_create_group(iommu_group, true);
> +#endif
>  		if (IS_ERR(group)) {
>  			iommu_group_put(iommu_group);
>  			return PTR_ERR(group);


A serious problem indeed, but this isn't the right solution.  I've
copied you on a patch that I think fixes it.  Please verify.  Thanks,

Alex
