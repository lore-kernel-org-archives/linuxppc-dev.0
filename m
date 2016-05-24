Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDY411NBJzDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 21:25:20 +1000 (AEST)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 24 May 2016 12:25:16 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9D11D1B08075
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 12:26:07 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4OBP8vU41615394
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 11:25:08 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4OBP7QO022528
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 07:25:08 -0400
Subject: Re: [PATCH] cxl: Update process element after allocating interrupts
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1464020045-1385-1-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <57443A13.9080707@linux.vnet.ibm.com>
Date: Tue, 24 May 2016 13:25:07 +0200
MIME-Version: 1.0
In-Reply-To: <1464020045-1385-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 23/05/2016 18:14, Ian Munsie a écrit :
> From: Ian Munsie <imunsie@au1.ibm.com>
>
> In the kernel API, it is possible to attempt to allocate AFU interrupts
> after already starting a context. Since the process element structure
> used by the hardware is only filled out at the time the context is
> started, it will not be updated with the interrupt numbers that have
> just been allocated and therefore AFU interrupts will not work unless
> they were allocated prior to starting the context.
>
> This can present some difficulties as each CAPI enabled PCI device in
> the kernel API has a default context, which may need to be started very
> early to enable translations, potentially before interrupts can easily
> be set up.
>
> This patch makes the API more flexible to allow interrupts to be
> allocated after a context has already been started and takes care of
> updating the PE structure used by the hardware and notifying it to
> discard any cached copy it may have.
>
> The update is currently performed via a terminate/remove/add sequence.
> This is necessary on some hardware such as the XSL that does not
> properly support the update LLCMD.
>
> Note that this is only supported on powernv at present - attempting to
> perform this ordering on PowerVM will raise a warning.
>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>


Patch looks good.
Once this is in, we could potentially add a check to make sure
cxl_allocate_afu_irqs() is only called once, as it could lead to bad 
things. But that would be an API usage error from the outside driver.

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred

> ---
>   drivers/misc/cxl/api.c    | 12 +++++++-
>   drivers/misc/cxl/cxl.h    |  1 +
>   drivers/misc/cxl/guest.c  |  1 +
>   drivers/misc/cxl/native.c | 74 +++++++++++++++++++++++++++++++++++++----------
>   4 files changed, 71 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 6d228cc..99081b8 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -102,7 +102,10 @@ int cxl_allocate_afu_irqs(struct cxl_context *ctx, int num)
>   	if (num == 0)
>   		num = ctx->afu->pp_irqs;
>   	res = afu_allocate_irqs(ctx, num);
> -	if (!res && !cpu_has_feature(CPU_FTR_HVMODE)) {
> +	if (res)
> +		return res;
> +
> +	if (!cpu_has_feature(CPU_FTR_HVMODE)) {
>   		/* In a guest, the PSL interrupt is not multiplexed. It was
>   		 * allocated above, and we need to set its handler
>   		 */
> @@ -110,6 +113,13 @@ int cxl_allocate_afu_irqs(struct cxl_context *ctx, int num)
>   		if (hwirq)
>   			cxl_map_irq(ctx->afu->adapter, hwirq, cxl_ops->psl_interrupt, ctx, "psl");
>   	}
> +
> +	if (ctx->status == STARTED) {
> +		if (cxl_ops->update_ivtes)
> +			cxl_ops->update_ivtes(ctx);
> +		else WARN(1, "BUG: cxl_allocate_afu_irqs must be called prior to starting the context on this platform\n");
> +	}
> +
>   	return res;
>   }
>   EXPORT_SYMBOL_GPL(cxl_allocate_afu_irqs);
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index d23a3a5..d12a035 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -853,6 +853,7 @@ struct cxl_backend_ops {
>   	int (*attach_process)(struct cxl_context *ctx, bool kernel,
>   			u64 wed, u64 amr);
>   	int (*detach_process)(struct cxl_context *ctx);
> +	void (*update_ivtes)(struct cxl_context *ctx);
>   	bool (*support_attributes)(const char *attr_name, enum cxl_attrs type);
>   	bool (*link_ok)(struct cxl *cxl, struct cxl_afu *afu);
>   	void (*release_afu)(struct device *dev);
> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> index bc8d0b9..1edba52 100644
> --- a/drivers/misc/cxl/guest.c
> +++ b/drivers/misc/cxl/guest.c
> @@ -1182,6 +1182,7 @@ const struct cxl_backend_ops cxl_guest_ops = {
>   	.ack_irq = guest_ack_irq,
>   	.attach_process = guest_attach_process,
>   	.detach_process = guest_detach_process,
> +	.update_ivtes = NULL,
>   	.support_attributes = guest_support_attributes,
>   	.link_ok = guest_link_ok,
>   	.release_afu = guest_release_afu,
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 98f2cac..aa0be79 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -429,7 +429,6 @@ static int remove_process_element(struct cxl_context *ctx)
>   	return rc;
>   }
>
> -
>   void cxl_assign_psn_space(struct cxl_context *ctx)
>   {
>   	if (!ctx->afu->pp_size || ctx->master) {
> @@ -506,10 +505,39 @@ static u64 calculate_sr(struct cxl_context *ctx)
>   	return sr;
>   }
>
> +static void update_ivtes_directed(struct cxl_context *ctx)
> +{
> +	bool need_update = (ctx->status == STARTED);
> +	int r;
> +
> +	if (need_update) {
> +		WARN_ON(terminate_process_element(ctx));
> +		WARN_ON(remove_process_element(ctx));
> +	}
> +
> +	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> +		ctx->elem->ivte_offsets[r] = cpu_to_be16(ctx->irqs.offset[r]);
> +		ctx->elem->ivte_ranges[r] = cpu_to_be16(ctx->irqs.range[r]);
> +	}
> +
> +	/*
> +	 * Theoretically we could use the update llcmd, instead of a
> +	 * terminate/remove/add (or if an atomic update was required we could
> +	 * do a suspend/update/resume), however it seems there might be issues
> +	 * with the update llcmd on some cards (including those using an XSL on
> +	 * an ASIC) so for now it's safest to go with the commands that are
> +	 * known to work. In the future if we come across a situation where the
> +	 * card may be performing transactions using the same PE while we are
> +	 * doing this update we might need to revisit this.
> +	 */
> +	if (need_update)
> +		WARN_ON(add_process_element(ctx));
> +}
> +
>   static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
>   {
>   	u32 pid;
> -	int r, result;
> +	int result;
>
>   	cxl_assign_psn_space(ctx);
>
> @@ -544,10 +572,7 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
>   		ctx->irqs.range[0] = 1;
>   	}
>
> -	for (r = 0; r < CXL_IRQ_RANGES; r++) {
> -		ctx->elem->ivte_offsets[r] = cpu_to_be16(ctx->irqs.offset[r]);
> -		ctx->elem->ivte_ranges[r] = cpu_to_be16(ctx->irqs.range[r]);
> -	}
> +	update_ivtes_directed(ctx);
>
>   	ctx->elem->common.amr = cpu_to_be64(amr);
>   	ctx->elem->common.wed = cpu_to_be64(wed);
> @@ -599,6 +624,22 @@ static int activate_dedicated_process(struct cxl_afu *afu)
>   	return cxl_chardev_d_afu_add(afu);
>   }
>
> +static void update_ivtes_dedicated(struct cxl_context *ctx)
> +{
> +	struct cxl_afu *afu = ctx->afu;
> +
> +	cxl_p1n_write(afu, CXL_PSL_IVTE_Offset_An,
> +		       (((u64)ctx->irqs.offset[0] & 0xffff) << 48) |
> +		       (((u64)ctx->irqs.offset[1] & 0xffff) << 32) |
> +		       (((u64)ctx->irqs.offset[2] & 0xffff) << 16) |
> +			((u64)ctx->irqs.offset[3] & 0xffff));
> +	cxl_p1n_write(afu, CXL_PSL_IVTE_Limit_An, (u64)
> +		       (((u64)ctx->irqs.range[0] & 0xffff) << 48) |
> +		       (((u64)ctx->irqs.range[1] & 0xffff) << 32) |
> +		       (((u64)ctx->irqs.range[2] & 0xffff) << 16) |
> +			((u64)ctx->irqs.range[3] & 0xffff));
> +}
> +
>   static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
>   {
>   	struct cxl_afu *afu = ctx->afu;
> @@ -617,16 +658,7 @@ static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
>
>   	cxl_prefault(ctx, wed);
>
> -	cxl_p1n_write(afu, CXL_PSL_IVTE_Offset_An,
> -		       (((u64)ctx->irqs.offset[0] & 0xffff) << 48) |
> -		       (((u64)ctx->irqs.offset[1] & 0xffff) << 32) |
> -		       (((u64)ctx->irqs.offset[2] & 0xffff) << 16) |
> -			((u64)ctx->irqs.offset[3] & 0xffff));
> -	cxl_p1n_write(afu, CXL_PSL_IVTE_Limit_An, (u64)
> -		       (((u64)ctx->irqs.range[0] & 0xffff) << 48) |
> -		       (((u64)ctx->irqs.range[1] & 0xffff) << 32) |
> -		       (((u64)ctx->irqs.range[2] & 0xffff) << 16) |
> -			((u64)ctx->irqs.range[3] & 0xffff));
> +	update_ivtes_dedicated(ctx);
>
>   	cxl_p2n_write(afu, CXL_PSL_AMR_An, amr);
>
> @@ -708,6 +740,15 @@ static inline int detach_process_native_dedicated(struct cxl_context *ctx)
>   	return 0;
>   }
>
> +static void native_update_ivtes(struct cxl_context *ctx)
> +{
> +	if (ctx->afu->current_mode == CXL_MODE_DIRECTED)
> +		return update_ivtes_directed(ctx);
> +	if (ctx->afu->current_mode == CXL_MODE_DEDICATED)
> +		return update_ivtes_dedicated(ctx);
> +	WARN(1, "native_update_ivtes: Bad mode\n");
> +}
> +
>   static inline int detach_process_native_afu_directed(struct cxl_context *ctx)
>   {
>   	if (!ctx->pe_inserted)
> @@ -1097,6 +1138,7 @@ const struct cxl_backend_ops cxl_native_ops = {
>   	.ack_irq = native_ack_irq,
>   	.attach_process = native_attach_process,
>   	.detach_process = native_detach_process,
> +	.update_ivtes = native_update_ivtes,
>   	.support_attributes = native_support_attributes,
>   	.link_ok = cxl_adapter_link_ok,
>   	.release_afu = cxl_pci_release_afu,
>
