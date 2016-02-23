Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93E991A08CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 06:08:45 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 12:08:43 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 68FF41FF002E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 11:56:50 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NJ8ehi33620058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:08:40 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NJ8euR014604
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:08:40 -0700
Received: from [9.41.250.246] (manoj.austin.ibm.com [9.41.250.246])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1NJ8egn014567
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 12:08:40 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v5 02/18] cxl: Move bare-metal specific code to
 specialized files
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-3-git-send-email-fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CCAE4D.5070205@linux.vnet.ibm.com>
Date: Tue, 23 Feb 2016 13:09:01 -0600
MIME-Version: 1.0
In-Reply-To: <1456244519-18934-3-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

---
Manoj Kumar

On 2/23/2016 10:21 AM, Frederic Barrat wrote:
> Move a few functions around to better separate code specific to
> bare-metal environment from code which will be commonly used between
> guest and bare-metal.
>
> Code specific to bare-metal is meant to be in native.c or pci.c
> only. It's basically anything which touches the card p1 registers,
> some p2 registers not needed from a guest and the PCI interface.
>
> Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>   drivers/misc/cxl/cxl.h    |  24 +----
>   drivers/misc/cxl/irq.c    | 205 +--------------------------------------
>   drivers/misc/cxl/main.c   |   2 +-
>   drivers/misc/cxl/native.c | 240 +++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/misc/cxl/pci.c    |  18 ----
>   5 files changed, 245 insertions(+), 244 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 3f88140..3b824e3 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -623,23 +623,8 @@ static inline u64 cxl_p2n_read(struct cxl_afu *afu, cxl_p2n_reg_t reg)
>   		return ~0ULL;
>   }
>
> -static inline u64 cxl_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off)
> -{
> -	if (likely(cxl_adapter_link_ok(afu->adapter)))
> -		return in_le64((afu)->afu_desc_mmio + (afu)->crs_offset +
> -			       ((cr) * (afu)->crs_len) + (off));
> -	else
> -		return ~0ULL;
> -}
> -
> -static inline u32 cxl_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off)
> -{
> -	if (likely(cxl_adapter_link_ok(afu->adapter)))
> -		return in_le32((afu)->afu_desc_mmio + (afu)->crs_offset +
> -			       ((cr) * (afu)->crs_len) + (off));
> -	else
> -		return 0xffffffff;
> -}
> +u64 cxl_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off);
> +u32 cxl_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off);
>   u16 cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off);
>   u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off);
>
> @@ -654,7 +639,6 @@ struct cxl_calls {
>   int register_cxl_calls(struct cxl_calls *calls);
>   void unregister_cxl_calls(struct cxl_calls *calls);
>
> -int cxl_alloc_adapter_nr(struct cxl *adapter);
>   void cxl_remove_adapter_nr(struct cxl *adapter);
>
>   int cxl_alloc_spa(struct cxl_afu *afu);
> @@ -697,7 +681,8 @@ void cxl_release_serr_irq(struct cxl_afu *afu);
>   int afu_register_irqs(struct cxl_context *ctx, u32 count);
>   void afu_release_irqs(struct cxl_context *ctx, void *cookie);
>   void afu_irq_name_free(struct cxl_context *ctx);
> -irqreturn_t cxl_slice_irq_err(int irq, void *data);
> +irqreturn_t handle_psl_slice_error(struct cxl_context *ctx, u64 dsisr,
> +				u64 errstat);
>
>   int cxl_debugfs_init(void);
>   void cxl_debugfs_exit(void);
> @@ -746,7 +731,6 @@ int cxl_attach_process(struct cxl_context *ctx, bool kernel, u64 wed,
>   			    u64 amr);
>   int cxl_detach_process(struct cxl_context *ctx);
>
> -int cxl_get_irq(struct cxl_afu *afu, struct cxl_irq_info *info);
>   int cxl_ack_irq(struct cxl_context *ctx, u64 tfc, u64 psl_reset_mask);
>
>   int cxl_check_error(struct cxl_afu *afu);
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index e468e6c..16fd67f 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -19,72 +19,6 @@
>   #include "cxl.h"
>   #include "trace.h"
>
> -/* XXX: This is implementation specific */
> -static irqreturn_t handle_psl_slice_error(struct cxl_context *ctx, u64 dsisr, u64 errstat)
> -{
> -	u64 fir1, fir2, fir_slice, serr, afu_debug;
> -
> -	fir1 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR1);
> -	fir2 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR2);
> -	fir_slice = cxl_p1n_read(ctx->afu, CXL_PSL_FIR_SLICE_An);
> -	serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
> -	afu_debug = cxl_p1n_read(ctx->afu, CXL_AFU_DEBUG_An);
> -
> -	dev_crit(&ctx->afu->dev, "PSL ERROR STATUS: 0x%016llx\n", errstat);
> -	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%016llx\n", fir1);
> -	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
> -	dev_crit(&ctx->afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
> -	dev_crit(&ctx->afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
> -	dev_crit(&ctx->afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
> -
> -	dev_crit(&ctx->afu->dev, "STOPPING CXL TRACE\n");
> -	cxl_stop_trace(ctx->afu->adapter);
> -
> -	return cxl_ack_irq(ctx, 0, errstat);
> -}
> -
> -irqreturn_t cxl_slice_irq_err(int irq, void *data)
> -{
> -	struct cxl_afu *afu = data;
> -	u64 fir_slice, errstat, serr, afu_debug;
> -
> -	WARN(irq, "CXL SLICE ERROR interrupt %i\n", irq);
> -
> -	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> -	fir_slice = cxl_p1n_read(afu, CXL_PSL_FIR_SLICE_An);
> -	errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
> -	afu_debug = cxl_p1n_read(afu, CXL_AFU_DEBUG_An);
> -	dev_crit(&afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
> -	dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
> -	dev_crit(&afu->dev, "CXL_PSL_ErrStat_An: 0x%016llx\n", errstat);
> -	dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
> -
> -	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t cxl_irq_err(int irq, void *data)
> -{
> -	struct cxl *adapter = data;
> -	u64 fir1, fir2, err_ivte;
> -
> -	WARN(1, "CXL ERROR interrupt %i\n", irq);
> -
> -	err_ivte = cxl_p1_read(adapter, CXL_PSL_ErrIVTE);
> -	dev_crit(&adapter->dev, "PSL_ErrIVTE: 0x%016llx\n", err_ivte);
> -
> -	dev_crit(&adapter->dev, "STOPPING CXL TRACE\n");
> -	cxl_stop_trace(adapter);
> -
> -	fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
> -	fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
> -
> -	dev_crit(&adapter->dev, "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n", fir1, fir2);
> -
> -	return IRQ_HANDLED;
> -}
> -
>   static irqreturn_t schedule_cxl_fault(struct cxl_context *ctx, u64 dsisr, u64 dar)
>   {
>   	ctx->dsisr = dsisr;
> @@ -179,45 +113,6 @@ irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
>   	return IRQ_HANDLED;
>   }
>
> -static irqreturn_t fail_psl_irq(struct cxl_afu *afu, struct cxl_irq_info *irq_info)
> -{
> -	if (irq_info->dsisr & CXL_PSL_DSISR_TRANS)
> -		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
> -	else
> -		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t cxl_irq_multiplexed(int irq, void *data)
> -{
> -	struct cxl_afu *afu = data;
> -	struct cxl_context *ctx;
> -	struct cxl_irq_info irq_info;
> -	int ph = cxl_p2n_read(afu, CXL_PSL_PEHandle_An) & 0xffff;
> -	int ret;
> -
> -	if ((ret = cxl_get_irq(afu, &irq_info))) {
> -		WARN(1, "Unable to get CXL IRQ Info: %i\n", ret);
> -		return fail_psl_irq(afu, &irq_info);
> -	}
> -
> -	rcu_read_lock();
> -	ctx = idr_find(&afu->contexts_idr, ph);
> -	if (ctx) {
> -		ret = cxl_irq(irq, ctx, &irq_info);
> -		rcu_read_unlock();
> -		return ret;
> -	}
> -	rcu_read_unlock();
> -
> -	WARN(1, "Unable to demultiplex CXL PSL IRQ for PE %i DSISR %016llx DAR"
> -		" %016llx\n(Possible AFU HW issue - was a term/remove acked"
> -		" with outstanding transactions?)\n", ph, irq_info.dsisr,
> -		irq_info.dar);
> -	return fail_psl_irq(afu, &irq_info);
> -}
> -
>   static irqreturn_t cxl_irq_afu(int irq, void *data)
>   {
>   	struct cxl_context *ctx = data;
> @@ -316,104 +211,6 @@ err:
>   	return -ENOMEM;
>   }
>
> -int cxl_register_psl_err_irq(struct cxl *adapter)
> -{
> -	int rc;
> -
> -	adapter->irq_name = kasprintf(GFP_KERNEL, "cxl-%s-err",
> -				      dev_name(&adapter->dev));
> -	if (!adapter->irq_name)
> -		return -ENOMEM;
> -
> -	if ((rc = cxl_register_one_irq(adapter, cxl_irq_err, adapter,
> -				       &adapter->err_hwirq,
> -				       &adapter->err_virq,
> -				       adapter->irq_name))) {
> -		kfree(adapter->irq_name);
> -		adapter->irq_name = NULL;
> -		return rc;
> -	}
> -
> -	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, adapter->err_hwirq & 0xffff);
> -
> -	return 0;
> -}
> -
> -void cxl_release_psl_err_irq(struct cxl *adapter)
> -{
> -	if (adapter->err_virq != irq_find_mapping(NULL, adapter->err_hwirq))
> -		return;
> -
> -	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
> -	cxl_unmap_irq(adapter->err_virq, adapter);
> -	cxl_release_one_irq(adapter, adapter->err_hwirq);
> -	kfree(adapter->irq_name);
> -}
> -
> -int cxl_register_serr_irq(struct cxl_afu *afu)
> -{
> -	u64 serr;
> -	int rc;
> -
> -	afu->err_irq_name = kasprintf(GFP_KERNEL, "cxl-%s-err",
> -				      dev_name(&afu->dev));
> -	if (!afu->err_irq_name)
> -		return -ENOMEM;
> -
> -	if ((rc = cxl_register_one_irq(afu->adapter, cxl_slice_irq_err, afu,
> -				       &afu->serr_hwirq,
> -				       &afu->serr_virq, afu->err_irq_name))) {
> -		kfree(afu->err_irq_name);
> -		afu->err_irq_name = NULL;
> -		return rc;
> -	}
> -
> -	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> -	serr = (serr & 0x00ffffffffff0000ULL) | (afu->serr_hwirq & 0xffff);
> -	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> -
> -	return 0;
> -}
> -
> -void cxl_release_serr_irq(struct cxl_afu *afu)
> -{
> -	if (afu->serr_virq != irq_find_mapping(NULL, afu->serr_hwirq))
> -		return;
> -
> -	cxl_p1n_write(afu, CXL_PSL_SERR_An, 0x0000000000000000);
> -	cxl_unmap_irq(afu->serr_virq, afu);
> -	cxl_release_one_irq(afu->adapter, afu->serr_hwirq);
> -	kfree(afu->err_irq_name);
> -}
> -
> -int cxl_register_psl_irq(struct cxl_afu *afu)
> -{
> -	int rc;
> -
> -	afu->psl_irq_name = kasprintf(GFP_KERNEL, "cxl-%s",
> -				      dev_name(&afu->dev));
> -	if (!afu->psl_irq_name)
> -		return -ENOMEM;
> -
> -	if ((rc = cxl_register_one_irq(afu->adapter, cxl_irq_multiplexed, afu,
> -				    &afu->psl_hwirq, &afu->psl_virq,
> -				    afu->psl_irq_name))) {
> -		kfree(afu->psl_irq_name);
> -		afu->psl_irq_name = NULL;
> -	}
> -	return rc;
> -}
> -
> -void cxl_release_psl_irq(struct cxl_afu *afu)
> -{
> -	if (afu->psl_virq != irq_find_mapping(NULL, afu->psl_hwirq))
> -		return;
> -
> -	cxl_unmap_irq(afu->psl_virq, afu);
> -	cxl_release_one_irq(afu->adapter, afu->psl_hwirq);
> -	kfree(afu->psl_irq_name);
> -}
> -
>   void afu_irq_name_free(struct cxl_context *ctx)
>   {
>   	struct cxl_irq_name *irq_name, *tmp;
> @@ -504,7 +301,7 @@ int afu_register_irqs(struct cxl_context *ctx, u32 count)
>
>   	afu_register_hwirqs(ctx);
>   	return 0;
> - }
> +}
>
>   void afu_release_irqs(struct cxl_context *ctx, void *cookie)
>   {
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index 7ef5b43..90933eb 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -173,7 +173,7 @@ struct cxl *get_cxl_adapter(int num)
>   	return adapter;
>   }
>
> -int cxl_alloc_adapter_nr(struct cxl *adapter)
> +static int cxl_alloc_adapter_nr(struct cxl *adapter)
>   {
>   	int i;
>
> diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
> index 0b0a4c8..3103e33 100644
> --- a/drivers/misc/cxl/native.c
> +++ b/drivers/misc/cxl/native.c
> @@ -712,7 +712,7 @@ int cxl_detach_process(struct cxl_context *ctx)
>   	return detach_process_native_afu_directed(ctx);
>   }
>
> -int cxl_get_irq(struct cxl_afu *afu, struct cxl_irq_info *info)
> +static int cxl_get_irq(struct cxl_afu *afu, struct cxl_irq_info *info)
>   {
>   	u64 pidtid;
>
> @@ -734,6 +734,208 @@ int cxl_get_irq(struct cxl_afu *afu, struct cxl_irq_info *info)
>   	return 0;
>   }
>
> +irqreturn_t handle_psl_slice_error(struct cxl_context *ctx, u64 dsisr, u64 errstat)
> +{
> +	u64 fir1, fir2, fir_slice, serr, afu_debug;
> +
> +	fir1 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR1);
> +	fir2 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR2);
> +	fir_slice = cxl_p1n_read(ctx->afu, CXL_PSL_FIR_SLICE_An);
> +	serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
> +	afu_debug = cxl_p1n_read(ctx->afu, CXL_AFU_DEBUG_An);
> +
> +	dev_crit(&ctx->afu->dev, "PSL ERROR STATUS: 0x%016llx\n", errstat);
> +	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%016llx\n", fir1);
> +	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
> +	dev_crit(&ctx->afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
> +	dev_crit(&ctx->afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
> +	dev_crit(&ctx->afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
> +
> +	dev_crit(&ctx->afu->dev, "STOPPING CXL TRACE\n");
> +	cxl_stop_trace(ctx->afu->adapter);
> +
> +	return cxl_ack_irq(ctx, 0, errstat);
> +}
> +
> +static irqreturn_t fail_psl_irq(struct cxl_afu *afu, struct cxl_irq_info *irq_info)
> +{
> +	if (irq_info->dsisr & CXL_PSL_DSISR_TRANS)
> +		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
> +	else
> +		cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t cxl_irq_multiplexed(int irq, void *data)
> +{
> +	struct cxl_afu *afu = data;
> +	struct cxl_context *ctx;
> +	struct cxl_irq_info irq_info;
> +	int ph = cxl_p2n_read(afu, CXL_PSL_PEHandle_An) & 0xffff;
> +	int ret;
> +
> +	if ((ret = cxl_get_irq(afu, &irq_info))) {
> +		WARN(1, "Unable to get CXL IRQ Info: %i\n", ret);
> +		return fail_psl_irq(afu, &irq_info);
> +	}
> +
> +	rcu_read_lock();
> +	ctx = idr_find(&afu->contexts_idr, ph);
> +	if (ctx) {
> +		ret = cxl_irq(irq, ctx, &irq_info);
> +		rcu_read_unlock();
> +		return ret;
> +	}
> +	rcu_read_unlock();
> +
> +	WARN(1, "Unable to demultiplex CXL PSL IRQ for PE %i DSISR %016llx DAR"
> +		" %016llx\n(Possible AFU HW issue - was a term/remove acked"
> +		" with outstanding transactions?)\n", ph, irq_info.dsisr,
> +		irq_info.dar);
> +	return fail_psl_irq(afu, &irq_info);
> +}
> +
> +static irqreturn_t cxl_slice_irq_err(int irq, void *data)
> +{
> +	struct cxl_afu *afu = data;
> +	u64 fir_slice, errstat, serr, afu_debug;
> +
> +	WARN(irq, "CXL SLICE ERROR interrupt %i\n", irq);
> +
> +	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> +	fir_slice = cxl_p1n_read(afu, CXL_PSL_FIR_SLICE_An);
> +	errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
> +	afu_debug = cxl_p1n_read(afu, CXL_AFU_DEBUG_An);
> +	dev_crit(&afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
> +	dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
> +	dev_crit(&afu->dev, "CXL_PSL_ErrStat_An: 0x%016llx\n", errstat);
> +	dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
> +
> +	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t cxl_irq_err(int irq, void *data)
> +{
> +	struct cxl *adapter = data;
> +	u64 fir1, fir2, err_ivte;
> +
> +	WARN(1, "CXL ERROR interrupt %i\n", irq);
> +
> +	err_ivte = cxl_p1_read(adapter, CXL_PSL_ErrIVTE);
> +	dev_crit(&adapter->dev, "PSL_ErrIVTE: 0x%016llx\n", err_ivte);
> +
> +	dev_crit(&adapter->dev, "STOPPING CXL TRACE\n");
> +	cxl_stop_trace(adapter);
> +
> +	fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
> +	fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
> +
> +	dev_crit(&adapter->dev, "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n", fir1, fir2);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +int cxl_register_psl_err_irq(struct cxl *adapter)
> +{
> +	int rc;
> +
> +	adapter->irq_name = kasprintf(GFP_KERNEL, "cxl-%s-err",
> +				      dev_name(&adapter->dev));
> +	if (!adapter->irq_name)
> +		return -ENOMEM;
> +
> +	if ((rc = cxl_register_one_irq(adapter, cxl_irq_err, adapter,
> +				       &adapter->err_hwirq,
> +				       &adapter->err_virq,
> +				       adapter->irq_name))) {
> +		kfree(adapter->irq_name);
> +		adapter->irq_name = NULL;
> +		return rc;
> +	}
> +
> +	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, adapter->err_hwirq & 0xffff);
> +
> +	return 0;
> +}
> +
> +void cxl_release_psl_err_irq(struct cxl *adapter)
> +{
> +	if (adapter->err_virq != irq_find_mapping(NULL, adapter->err_hwirq))
> +		return;
> +
> +	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
> +	cxl_unmap_irq(adapter->err_virq, adapter);
> +	cxl_release_one_irq(adapter, adapter->err_hwirq);
> +	kfree(adapter->irq_name);
> +}
> +
> +int cxl_register_serr_irq(struct cxl_afu *afu)
> +{
> +	u64 serr;
> +	int rc;
> +
> +	afu->err_irq_name = kasprintf(GFP_KERNEL, "cxl-%s-err",
> +				      dev_name(&afu->dev));
> +	if (!afu->err_irq_name)
> +		return -ENOMEM;
> +
> +	if ((rc = cxl_register_one_irq(afu->adapter, cxl_slice_irq_err, afu,
> +				       &afu->serr_hwirq,
> +				       &afu->serr_virq, afu->err_irq_name))) {
> +		kfree(afu->err_irq_name);
> +		afu->err_irq_name = NULL;
> +		return rc;
> +	}
> +
> +	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
> +	serr = (serr & 0x00ffffffffff0000ULL) | (afu->serr_hwirq & 0xffff);
> +	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
> +
> +	return 0;
> +}
> +
> +void cxl_release_serr_irq(struct cxl_afu *afu)
> +{
> +	if (afu->serr_virq != irq_find_mapping(NULL, afu->serr_hwirq))
> +		return;
> +
> +	cxl_p1n_write(afu, CXL_PSL_SERR_An, 0x0000000000000000);
> +	cxl_unmap_irq(afu->serr_virq, afu);
> +	cxl_release_one_irq(afu->adapter, afu->serr_hwirq);
> +	kfree(afu->err_irq_name);
> +}
> +
> +int cxl_register_psl_irq(struct cxl_afu *afu)
> +{
> +	int rc;
> +
> +	afu->psl_irq_name = kasprintf(GFP_KERNEL, "cxl-%s",
> +				      dev_name(&afu->dev));
> +	if (!afu->psl_irq_name)
> +		return -ENOMEM;
> +
> +	if ((rc = cxl_register_one_irq(afu->adapter, cxl_irq_multiplexed, afu,
> +				    &afu->psl_hwirq, &afu->psl_virq,
> +				    afu->psl_irq_name))) {
> +		kfree(afu->psl_irq_name);
> +		afu->psl_irq_name = NULL;
> +	}
> +	return rc;
> +}
> +
> +void cxl_release_psl_irq(struct cxl_afu *afu)
> +{
> +	if (afu->psl_virq != irq_find_mapping(NULL, afu->psl_hwirq))
> +		return;
> +
> +	cxl_unmap_irq(afu->psl_virq, afu);
> +	cxl_release_one_irq(afu->adapter, afu->psl_hwirq);
> +	kfree(afu->psl_irq_name);
> +}
> +
>   static void recover_psl_err(struct cxl_afu *afu, u64 errstat)
>   {
>   	u64 dsisr;
> @@ -763,3 +965,39 @@ int cxl_check_error(struct cxl_afu *afu)
>   {
>   	return (cxl_p1n_read(afu, CXL_PSL_SCNTL_An) == ~0ULL);
>   }
> +
> +u64 cxl_afu_cr_read64(struct cxl_afu *afu, int cr, u64 off)
> +{
> +	if (likely(cxl_adapter_link_ok(afu->adapter)))
> +		return in_le64((afu)->afu_desc_mmio + (afu)->crs_offset +
> +			       ((cr) * (afu)->crs_len) + (off));
> +	else
> +		return ~0ULL;
> +}
> +
> +u32 cxl_afu_cr_read32(struct cxl_afu *afu, int cr, u64 off)
> +{
> +	if (likely(cxl_adapter_link_ok(afu->adapter)))
> +		return in_le32((afu)->afu_desc_mmio + (afu)->crs_offset +
> +			       ((cr) * (afu)->crs_len) + (off));
> +	else
> +		return 0xffffffff;
> +}
> +
> +u16 cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off)
> +{
> +	u64 aligned_off = off & ~0x3L;
> +	u32 val;
> +
> +	val = cxl_afu_cr_read32(afu, cr, aligned_off);
> +	return (val >> ((off & 0x2) * 8)) & 0xffff;
> +}
> +
> +u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off)
> +{
> +	u64 aligned_off = off & ~0x3L;
> +	u32 val;
> +
> +	val = cxl_afu_cr_read32(afu, cr, aligned_off);
> +	return (val >> ((off & 0x3) * 8)) & 0xff;
> +}
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index ad28c56..c6279e5 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -116,24 +116,6 @@
>   #define   AFUD_EB_LEN(val)		EXTRACT_PPC_BITS(val, 8, 63)
>   #define AFUD_READ_EB_OFF(afu)		AFUD_READ(afu, 0x48)
>
> -u16 cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off)
> -{
> -	u64 aligned_off = off & ~0x3L;
> -	u32 val;
> -
> -	val = cxl_afu_cr_read32(afu, cr, aligned_off);
> -	return (val >> ((off & 0x2) * 8)) & 0xffff;
> -}
> -
> -u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off)
> -{
> -	u64 aligned_off = off & ~0x3L;
> -	u32 val;
> -
> -	val = cxl_afu_cr_read32(afu, cr, aligned_off);
> -	return (val >> ((off & 0x3) * 8)) & 0xff;
> -}
> -
>   static const struct pci_device_id cxl_pci_tbl[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0477), },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
>
