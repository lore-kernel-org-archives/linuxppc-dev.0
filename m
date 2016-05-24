Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDRCj5zY8zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 17:01:37 +1000 (AEST)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 24 May 2016 17:01:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8BB322BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 17:01:17 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4O70rg91900818
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 17:01:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4O70FQs009430
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 17:00:15 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: Re: [v5,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
In-Reply-To: <1464007742-1941-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1464007742-1941-1-git-send-email-felix@linux.vnet.ibm.com>
Date: Tue, 24 May 2016 12:29:33 +0530
Message-ID: <87mvngx7oq.fsf@vajain21.in.ibm.com>
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

Hi Philippe,

Few comments,

Philippe Bergheaud <felix@linux.vnet.ibm.com> writes:

> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 4fe5078..b0027e6 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -24,6 +24,7 @@
>  #include <asm/reg.h>
>  #include <misc/cxl-base.h>
>  
> +#include <misc/cxl.h>
>  #include <uapi/misc/cxl.h>
>  
>  extern uint cxl_verbose;
> @@ -34,7 +35,7 @@ extern uint cxl_verbose;
>   * Bump version each time a user API change is made, whether it is
>   * backwards compatible ot not.
>   */
> -#define CXL_API_VERSION 2
> +#define CXL_API_VERSION 3
>  #define CXL_API_VERSION_COMPATIBLE 1
>  
>  /*
> @@ -522,6 +523,10 @@ struct cxl_context {
>  	bool pending_fault;
>  	bool pending_afu_err;
>  
> +	/* Used by AFU drivers for driver specific event delivery */
> +	struct cxl_afu_driver_ops *afu_driver_ops;
> +	atomic_t afu_driver_events;
If the afu_driver_ops.deliver_event is idempotent then instead of using
a refcount we can simply call afu_driver_ops.deliver_event to see if
there are any driver events queued. Since callback deliver_event is
called in context of a spinlock and cannot sleep hence requirement of
idempotency seems reasonable.

> +
>  	struct rcu_head rcu;
>  };
>  
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index eec468f..6aebd0d 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -293,6 +293,17 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
>  	return cxl_context_iomap(ctx, vm);
>  }
>  
> +static inline bool ctx_event_pending(struct cxl_context *ctx)
> +{
> +	if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
> +		return true;
> +
> +	if (ctx->afu_driver_ops && atomic_read(&ctx->afu_driver_events))
> +		return true;
> +
> +	return false;
> +}
> +
>  unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
>  {
>  	struct cxl_context *ctx = file->private_data;
> @@ -305,8 +316,7 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
>  	pr_devel("afu_poll wait done pe: %i\n", ctx->pe);
>  
>  	spin_lock_irqsave(&ctx->lock, flags);
> -	if (ctx->pending_irq || ctx->pending_fault ||
> -	    ctx->pending_afu_err)
> +	if (ctx_event_pending(ctx))
>  		mask |= POLLIN | POLLRDNORM;
>  	else if (ctx->status == CLOSED)
>  		/* Only error on closed when there are no futher events pending
> @@ -319,16 +329,32 @@ unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
>  	return mask;
>  }
>  
> -static inline int ctx_event_pending(struct cxl_context *ctx)
> +static ssize_t afu_driver_event_copy(struct cxl_context *ctx,
> +				     char __user *buf,
Instead of using (char __user *buf) as an argument it would be better to use
(struct cxl_event __user *buf) so that we dont have to use pointer
arithmetic in this function body; which may break with future iterations
of this struct. The struct cxl_event_afu_driver_reserved may simply be
referred to as &(buf.afu_driver_event)

> @@ -374,7 +400,14 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
>  	memset(&event, 0, sizeof(event));
>  	event.header.process_element = ctx->pe;
>  	event.header.size = sizeof(struct cxl_event_header);
> -	if (ctx->pending_irq) {
> +	if (ctx->afu_driver_ops && atomic_read(&ctx->afu_driver_events)) {
> +		pr_devel("afu_read delivering AFU driver specific event\n");
> +		pl = ctx->afu_driver_ops->deliver_event(ctx);
> +		atomic_dec(&ctx->afu_driver_events);
> +		WARN_ON(!pl || (pl->data_size >
> CXL_MAX_EVENT_DATA_SIZE));
Should return an error to the driver via
event_delivered(..,..,EOVERFLOW)

> +		event.header.size += pl->data_size;
> +		event.header.type = CXL_EVENT_AFU_DRIVER;
> +	} else if (ctx->pending_irq) {
>  		pr_devel("afu_read delivering AFU interrupt\n");
>  		event.header.size += sizeof(struct cxl_event_afu_interrupt);
>  		event.header.type = CXL_EVENT_AFU_INTERRUPT;
> @@ -404,6 +437,9 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
>  
>  	spin_unlock_irqrestore(&ctx->lock, flags);
>  
> +	if (event.header.type == CXL_EVENT_AFU_DRIVER)
> +		return afu_driver_event_copy(ctx, buf, &event, pl);
there should be check againt the count to see if driver event can fit
into the buffer provided. If not then the driver/userspace should be
notified. Otherwise it can result in corruption of userspace memory.

Cheers,
~ Vaibhav
