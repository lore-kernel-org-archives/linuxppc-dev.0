Return-Path: <mhairgrove@nvidia.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Mh4s5pJqzF1RZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 12:07:57 +1000 (AEST)
Date: Thu, 12 Apr 2018 19:02:43 -0700
From: Mark Hairgrove <mhairgrove@nvidia.com>
To: Alistair Popple <alistair@popple.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
 <arbab@linux.ibm.com>, <bsingharora@gmail.com>
Subject: Re: [PATCH 2/2] powernv/npu: Prevent overwriting of
 pnv_npu2_init_contex() callback parameters
In-Reply-To: <20180411063855.5451-2-alistair@popple.id.au>
Message-ID: <alpine.DEB.2.00.1804121902240.21240@mdh-linux64-2.nvidia.com>
References: <20180411063855.5451-1-alistair@popple.id.au>
 <20180411063855.5451-2-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wed, 11 Apr 2018, Alistair Popple wrote:

> There is a single npu context per set of callback parameters. Callers
> should be prevented from overwriting existing callback values so instead
> return an error if different parameters are passed.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/include/asm/powernv.h       |  2 +-
>  arch/powerpc/platforms/powernv/npu-dma.c | 16 +++++++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/powernv.h b/arch/powerpc/include/asm/powernv.h
> index dc5f6a5d4575..362ea12a4501 100644
> --- a/arch/powerpc/include/asm/powernv.h
> +++ b/arch/powerpc/include/asm/powernv.h
> @@ -15,7 +15,7 @@
>  extern void powernv_set_nmmu_ptcr(unsigned long ptcr);
>  extern struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  			unsigned long flags,
> -			struct npu_context *(*cb)(struct npu_context *, void *),
> +			void (*cb)(struct npu_context *, void *),
>  			void *priv);
>  extern void pnv_npu2_destroy_context(struct npu_context *context,
>  				struct pci_dev *gpdev);
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index cb77162f4e7a..193f43ea3fbc 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -407,7 +407,7 @@ struct npu_context {
>  	bool nmmu_flush;
>  
>  	/* Callback to stop translation requests on a given GPU */
> -	struct npu_context *(*release_cb)(struct npu_context *, void *);
> +	void (*release_cb)(struct npu_context *context, void *priv);
>  
>  	/*
>  	 * Private pointer passed to the above callback for usage by
> @@ -705,7 +705,7 @@ static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
>   */
>  struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  			unsigned long flags,
> -			struct npu_context *(*cb)(struct npu_context *, void *),
> +			void (*cb)(struct npu_context *, void *),
>  			void *priv)
>  {
>  	int rc;
> @@ -763,8 +763,18 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  	 */
>  	spin_lock(&npu_context_lock);
>  	npu_context = mm->context.npu_context;
> -	if (npu_context)
> +	if (npu_context) {
> +		if (npu_context->release_cb != cb ||
> +			npu_context->priv != priv) {
> +			spin_unlock(&npu_context_lock);
> +			opal_npu_destroy_context(nphb->opal_id, mm->context.id,
> +						PCI_DEVID(gpdev->bus->number,
> +							gpdev->devfn));
> +			return ERR_PTR(-EINVAL);
> +		}
> +
>  		WARN_ON(!kref_get_unless_zero(&npu_context->kref));
> +	}
>  	spin_unlock(&npu_context_lock);
>  
>  	if (!npu_context) {
> -- 
> 2.11.0
> 
> 

Reviewed-by: Mark Hairgrove <mhairgrove@nvidia.com>
Tested-by: Mark Hairgrove <mhairgrove@nvidia.com>
