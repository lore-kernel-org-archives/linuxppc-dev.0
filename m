Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [150.101.137.131])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zgTYG3hZ9zF11y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 15:08:34 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/npu-dma.c: Fix crash after
 __mmu_notifier_register failure
Date: Tue, 13 Feb 2018 15:07:26 +1100
Message-ID: <3566487.0GKW0azfUC@new-mexico>
In-Reply-To: <1518232806-17661-1-git-send-email-mhairgrove@nvidia.com>
References: <1518232806-17661-1-git-send-email-mhairgrove@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Mark, this will also fix the lack of cleanup OPAL call in the unlikely
case the kzalloc() fails.

Acked-By: Alistair Popple <alistair@popple.id.au>

On Friday, 9 February 2018 7:20:06 PM AEDT Mark Hairgrove wrote:
> pnv_npu2_init_context wasn't checking the return code from
> __mmu_notifier_register. If  __mmu_notifier_register failed, the
> npu_context was still assigned to the mm and the caller wasn't given any
> indication that things went wrong. Later on pnv_npu2_destroy_context would
> be called, which in turn called mmu_notifier_unregister and dropped
> mm->mm_count without having incremented it in the first place. This led to
> various forms of corruption like mm use-after-free and mm double-free.
> 
> __mmu_notifier_register can fail with EINTR if a signal is pending, so
> this case can be frequent.
> 
> This patch calls opal_npu_destroy_context on the failure paths, and makes
> sure not to assign mm->context.npu_context until past the failure points.
> 
> Signed-off-by: Mark Hairgrove <mhairgrove@nvidia.com>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c |   32 +++++++++++++++++++----------
>  1 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index f6cbc1a..48c73aa 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -677,6 +677,11 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  		/* No nvlink associated with this GPU device */
>  		return ERR_PTR(-ENODEV);
>  
> +	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
> +	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
> +							&nvlink_index)))
> +		return ERR_PTR(-ENODEV);
> +
>  	if (!mm || mm->context.id == 0) {
>  		/*
>  		 * Kernel thread contexts are not supported and context id 0 is
> @@ -704,25 +709,30 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  	 */
>  	npu_context = mm->context.npu_context;
>  	if (!npu_context) {
> +		rc = -ENOMEM;
>  		npu_context = kzalloc(sizeof(struct npu_context), GFP_KERNEL);
> -		if (!npu_context)
> -			return ERR_PTR(-ENOMEM);
> +		if (npu_context) {
> +			kref_init(&npu_context->kref);
> +			npu_context->mm = mm;
> +			npu_context->mn.ops = &nv_nmmu_notifier_ops;
> +			rc = __mmu_notifier_register(&npu_context->mn, mm);
> +		}
> +
> +		if (rc) {
> +			kfree(npu_context);
> +			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
> +					PCI_DEVID(gpdev->bus->number,
> +						gpdev->devfn));
> +			return ERR_PTR(rc);
> +		}
>  
>  		mm->context.npu_context = npu_context;
> -		npu_context->mm = mm;
> -		npu_context->mn.ops = &nv_nmmu_notifier_ops;
> -		__mmu_notifier_register(&npu_context->mn, mm);
> -		kref_init(&npu_context->kref);
>  	} else {
> -		kref_get(&npu_context->kref);
> +		WARN_ON(!kref_get_unless_zero(&npu_context->kref));
>  	}
>  
>  	npu_context->release_cb = cb;
>  	npu_context->priv = priv;
> -	nvlink_dn = of_parse_phandle(npdev->dev.of_node, "ibm,nvlink", 0);
> -	if (WARN_ON(of_property_read_u32(nvlink_dn, "ibm,npu-link-index",
> -							&nvlink_index)))
> -		return ERR_PTR(-ENODEV);
>  	npu_context->npdev[npu->index][nvlink_index] = npdev;
>  
>  	if (!nphb->npu.nmmu_flush) {
> 
