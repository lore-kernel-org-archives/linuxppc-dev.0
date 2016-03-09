Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1F0A1A011E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 01:38:25 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 18AD7140297
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 01:38:24 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 9 Mar 2016 20:08:12 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u29EbrKO15728646
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 20:07:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u29Ec1PI022823
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Mar 2016 20:08:06 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>, Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
In-Reply-To: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
Date: Wed, 09 Mar 2016 20:07:56 +0530
Message-ID: <87a8m7iunv.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ian,

Sorry for getting into this discussion late. I have few suggestions.

Ian Munsie <imunsie@au1.ibm.com> writes:
>
> diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
> index 8756d06..560412c 100644
> --- a/drivers/misc/cxl/Kconfig
> +++ b/drivers/misc/cxl/Kconfig
> @@ -15,12 +15,17 @@ config CXL_EEH
>  	bool
>  	default n
>  
> +config CXL_AFU_DRIVER_OPS
> +	bool
> +	default n
> +
>  config CXL
>  	tristate "Support for IBM Coherent Accelerators (CXL)"
>  	depends on PPC_POWERNV && PCI_MSI && EEH
>  	select CXL_BASE
>  	select CXL_KERNEL_API
>  	select CXL_EEH
> +	select CXL_AFU_DRIVER_OPS
I suggest wrapping the driver_ops struct definition and other related
functions inside a #ifdef CONFIG_CXL_AFU_DRIVER_OPS.

>  	default m
>  	help
>  	  Select this option to enable driver support for IBM Coherent
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index ea3eeb7..eebc9c3 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -296,6 +296,14 @@ struct cxl_context *cxl_fops_get_context(struct file *file)
>  }
>  EXPORT_SYMBOL_GPL(cxl_fops_get_context);
>  
> +void cxl_set_driver_ops(struct cxl_context *ctx,
> +			struct cxl_afu_driver_ops *ops)
> +{
> +	WARN_ON(!ops->event_pending || !ops->deliver_event);
> +	ctx->afu_driver_ops = ops;
> +}
I would recommend adding a "struct module *" member to afu_driver_ops
and doing a __module_get on to it here and module_put when we destroy
the context. Since these callbacks will be residing within an external
module .text region hence it should stay in the memory until the context
is alive.


> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 783337d..d1cc297 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -295,6 +295,17 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
>  	return cxl_context_iomap(ctx, vm);
>  }
>  
> +static inline bool ctx_event_pending(struct cxl_context *ctx)
> +{
> +	if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
> +		return true;
> +
> +	if (ctx->afu_driver_ops)
> +		return ctx->afu_driver_ops->event_pending(ctx);
Should also check if ctx->afu_driver_ops->event_pending is NULL before
calling it.

> +/*
> + * AFU driver ops allows an AFU driver to create their own events to pass to
> + * userspace through the file descriptor as a simpler alternative to overriding
> + * the read() and poll() calls that works with the generic cxl events. These
> + * events are given priority over the generic cxl events, so they will be
> + * delivered first if multiple types of events are pending.
> + *
> + * event_pending() will be called by the cxl driver to check if an event is
> + * pending (e.g. in select/poll/read calls).
> + *
> + * deliver_event() will be called to fill out a cxl_event structure with the
> + * driver specific event. The header will already have the type and
> + * process_element fields filled in, and header.size will be set to
> + * sizeof(struct cxl_event_header). The AFU driver can extend that size up to
> + * max_size (if an afu driver requires more space, they should submit a patch
> + * increasing the size in the struct cxl_event_afu_driver_reserved definition).
> + *
> + * Both of these calls are made with a spin lock held, so they must not sleep.
> + */
> +struct cxl_afu_driver_ops {
> +	bool (*event_pending) (struct cxl_context *ctx);
> +	void (*deliver_event) (struct cxl_context *ctx,
> +			struct cxl_event *event, size_t max_size);
> +};
> +

I would propose these two apis.

/*
*  fetches an event from the driver event queue. NULL means that queue
*  is empty. Can sleep if needed. The memory for cxl_event is allocated
*  by module being called. Hence it can be potentially be larger then
*  sizeof(struct cxl_event). Multiple calls to this should return same
*  pointer untill ack_event is called.
*/
struct cxl_event * fetch_event(struct cxl_context * ctx);

/*
* Returns and acknowledge the struct cxl_event * back to the driver
* which can then free it or maybe put it back in a kmem_cache. This
* should be called once we have completely returned the current
* struct cxl_event from the readcall
*/
void ack_event(struct cxl_context * ctx, struct cxl_event *);

I think above apis would give us more flexbility in the future when
drivers would want to send larger events without breaking the abi.

Cheers,
~ Vaibhav
