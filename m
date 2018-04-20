Return-Path: <alistair@popple.id.au>
Received: from ipmail01.adl6.internode.on.net (ipmail01.adl6.internode.on.net
 [150.101.137.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 40S21z3Bm1zF24X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 13:50:31 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, mhairgrove@nvidia.com, arbab@linux.ibm.com
Subject: Re: [PATCH 1/2] powernv/npu: Add lock to prevent race in concurrent
 context init/destroy
Date: Fri, 20 Apr 2018 13:50:29 +1000
Message-ID: <3916221.8MgYd66MMk@new-mexico>
In-Reply-To: <20180411063855.5451-1-alistair@popple.id.au>
References: <20180411063855.5451-1-alistair@popple.id.au>
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

Sorry, forgot to include:

Fixes: 1ab66d1fbada ("powerpc/powernv: Introduce address translation services for Nvlink2")

Thanks

On Wednesday, 11 April 2018 4:38:54 PM AEST Alistair Popple wrote:
> The pnv_npu2_init_context() and pnv_npu2_destroy_context() functions are
> used to allocate/free contexts to allow address translation and shootdown
> by the NPU on a particular GPU. Context initialisation is implicitly safe
> as it is protected by the requirement mmap_sem be held in write mode,
> however pnv_npu2_destroy_context() does not require mmap_sem to be held and
> it is not safe to call with a concurrent initialisation for a different
> GPU.
> 
> It was assumed the driver would ensure destruction was not called
> concurrently with initialisation. However the driver may be simplified by
> allowing concurrent initialisation and destruction for different GPUs. As
> npu context creation/destruction is not a performance critical path and the
> critical section is not large a single spinlock is used for simplicity.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 51 ++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 1cbef1f9cd37..cb77162f4e7a 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -34,6 +34,12 @@
>  #define npu_to_phb(x) container_of(x, struct pnv_phb, npu)
>  
>  /*
> + * spinlock to protect initialisation of an npu_context for a particular
> + * mm_struct.
> + */
> +DEFINE_SPINLOCK(npu_context_lock);
> +
> +/*
>   * Other types of TCE cache invalidation are not functional in the
>   * hardware.
>   */
> @@ -694,7 +700,8 @@ static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
>   * Returns an error if there no contexts are currently available or a
>   * npu_context which should be passed to pnv_npu2_handle_fault().
>   *
> - * mmap_sem must be held in write mode.
> + * mmap_sem must be held in write mode and must not be called from interrupt
> + * context.
>   */
>  struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  			unsigned long flags,
> @@ -741,7 +748,9 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  	/*
>  	 * Setup the NPU context table for a particular GPU. These need to be
>  	 * per-GPU as we need the tables to filter ATSDs when there are no
> -	 * active contexts on a particular GPU.
> +	 * active contexts on a particular GPU. It is safe for these to be
> +	 * called concurrently with destroy as the OPAL call takes appropriate
> +	 * locks and refcounts on init/destroy.
>  	 */
>  	rc = opal_npu_init_context(nphb->opal_id, mm->context.id, flags,
>  				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
> @@ -752,8 +761,19 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  	 * We store the npu pci device so we can more easily get at the
>  	 * associated npus.
>  	 */
> +	spin_lock(&npu_context_lock);
>  	npu_context = mm->context.npu_context;
> +	if (npu_context)
> +		WARN_ON(!kref_get_unless_zero(&npu_context->kref));
> +	spin_unlock(&npu_context_lock);
> +
>  	if (!npu_context) {
> +		/*
> +		 * We can set up these fields without holding the
> +		 * npu_context_lock as the npu_context hasn't been returned to
> +		 * the caller meaning it can't be destroyed. Parallel allocation
> +		 * is protected against by mmap_sem.
> +		 */
>  		rc = -ENOMEM;
>  		npu_context = kzalloc(sizeof(struct npu_context), GFP_KERNEL);
>  		if (npu_context) {
> @@ -772,8 +792,6 @@ struct npu_context *pnv_npu2_init_context(struct pci_dev *gpdev,
>  		}
>  
>  		mm->context.npu_context = npu_context;
> -	} else {
> -		WARN_ON(!kref_get_unless_zero(&npu_context->kref));
>  	}
>  
>  	npu_context->release_cb = cb;
> @@ -811,15 +829,16 @@ static void pnv_npu2_release_context(struct kref *kref)
>  		mm_context_remove_copro(npu_context->mm);
>  
>  	npu_context->mm->context.npu_context = NULL;
> -	mmu_notifier_unregister(&npu_context->mn,
> -				npu_context->mm);
> -
> -	kfree(npu_context);
>  }
>  
> +/*
> + * Destroy a context on the given GPU. May free the npu_context if it is no
> + * longer active on any GPUs. Must not be called from interrupt context.
> + */
>  void pnv_npu2_destroy_context(struct npu_context *npu_context,
>  			struct pci_dev *gpdev)
>  {
> +	int removed;
>  	struct pnv_phb *nphb;
>  	struct npu *npu;
>  	struct pci_dev *npdev = pnv_pci_get_npu_dev(gpdev, 0);
> @@ -841,7 +860,21 @@ void pnv_npu2_destroy_context(struct npu_context *npu_context,
>  	WRITE_ONCE(npu_context->npdev[npu->index][nvlink_index], NULL);
>  	opal_npu_destroy_context(nphb->opal_id, npu_context->mm->context.id,
>  				PCI_DEVID(gpdev->bus->number, gpdev->devfn));
> -	kref_put(&npu_context->kref, pnv_npu2_release_context);
> +	spin_lock(&npu_context_lock);
> +	removed = kref_put(&npu_context->kref, pnv_npu2_release_context);
> +	spin_unlock(&npu_context_lock);
> +
> +	/*
> +	 * We need to do this outside of pnv_npu2_release_context so that it is
> +	 * outside the spinlock as mmu_notifier_destroy uses SRCU.
> +	 */
> +	if (removed) {
> +		mmu_notifier_unregister(&npu_context->mn,
> +					npu_context->mm);
> +
> +		kfree(npu_context);
> +	}
> +
>  }
>  EXPORT_SYMBOL(pnv_npu2_destroy_context);
>  
> 
