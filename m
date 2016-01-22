Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 099C61A060B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 17:48:35 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 65so2866382pff.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 22:48:35 -0800 (PST)
Subject: Re: [PATCH kernel] vfio: Only check for bus IOMMU when NOIOMMU is
 selected
To: linuxppc-dev@lists.ozlabs.org
References: <1453444494-46900-1-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56A1D0BC.6030405@ozlabs.ru>
Date: Fri, 22 Jan 2016 17:48:28 +1100
MIME-Version: 1.0
In-Reply-To: <1453444494-46900-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2016 05:34 PM, Alexey Kardashevskiy wrote:
> Recent change 03a76b60 "vfio: Include No-IOMMU mode" disabled VFIO
> on systems which do not implement iommu_ops for the PCI bus even though
> there is an VFIO IOMMU driver for it such as SPAPR TCE driver for
> PPC64/powernv platform.
>
> This moves iommu_present() call under #ifdef CONFIG_VFIO_NOIOMMU as
> it is done in the rest of the file to re-enable VFIO on powernv.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   drivers/vfio/vfio.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 82f25cc..3f8060e 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -343,7 +343,6 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
>   	atomic_set(&group->opened, 0);
>   	group->iommu_group = iommu_group;
>   	group->noiommu = !iommu_present;
> -


Agrh. Unrelated change, repost?


>   	group->nb.notifier_call = vfio_iommu_group_notifier;
>
>   	/*
> @@ -767,7 +766,11 @@ int vfio_add_group_dev(struct device *dev,
>
>   	group = vfio_group_get_from_iommu(iommu_group);
>   	if (!group) {
> +#ifdef CONFIG_VFIO_NOIOMMU
>   		group = vfio_create_group(iommu_group, iommu_present(dev->bus));
> +#else
> +		group = vfio_create_group(iommu_group, true);
> +#endif
>   		if (IS_ERR(group)) {
>   			iommu_group_put(iommu_group);
>   			return PTR_ERR(group);
>


-- 
Alexey
