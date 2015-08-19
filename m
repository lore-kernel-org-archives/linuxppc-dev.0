Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD1021A0151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 15:30:46 +1000 (AEST)
Message-ID: <1439962246.24918.7.camel@ellerman.id.au>
Subject: Re: [PATCH 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Matt Ochs <mrochs@us.ibm.com>
Date: Wed, 19 Aug 2015 15:30:46 +1000
In-Reply-To: <1439957971-30483-1-git-send-email-imunsie@au.ibm.com>
References: <1439957971-30483-1-git-send-email-imunsie@au.ibm.com>
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

On Wed, 2015-08-19 at 14:19 +1000, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This adds an afu_driver_ops structure with event_pending and
> deliver_event callbacks. An AFU driver can fill these out and associate
> it with a context to enable passing custom AFU specific events to
> userspace.

What's an AFU driver? Give me an example.

> The cxl driver will call event_pending() during poll, select, read, etc.
> calls to check if an AFU driver specific event is pending, and will call
> deliver_event() to deliver that event. This way, the cxl driver takes
> care of all the usual locking semantics around these calls and handles
> all the generic cxl events, so that the AFU driver only needs to worry
> about it's own events.
> 
> The deliver_event() call is passed a struct cxl_event buffer to fill in.
> The header will already be filled in for an AFU driver event, and the
> AFU driver is expected to expand the header.size as necessary (up to
> max_size, defined by struct cxl_event_afu_driver_reserved) and fill out
> it's own information.
> 
> Conflicts between AFU specific events are not expected, due to the fact
> that each AFU specific driver has it's own mechanism to deliver an AFU
> file descriptor to userspace.

I don't grok this bit.

> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> ---
>  drivers/misc/cxl/Kconfig |  5 +++++
>  drivers/misc/cxl/api.c   |  7 +++++++
>  drivers/misc/cxl/cxl.h   |  6 +++++-
>  drivers/misc/cxl/file.c  | 37 +++++++++++++++++++++++++++----------
>  include/misc/cxl.h       | 29 +++++++++++++++++++++++++++++
>  include/uapi/misc/cxl.h  | 13 +++++++++++++
>  6 files changed, 86 insertions(+), 11 deletions(-)
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
>  	default m
>  	help
>  	  Select this option to enable driver support for IBM Coherent
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 6a768a9..e0f0c78 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -267,6 +267,13 @@ struct cxl_context *cxl_fops_get_context(struct file *file)
>  }
>  EXPORT_SYMBOL_GPL(cxl_fops_get_context);
>  
> +void cxl_set_driver_ops(struct cxl_context *ctx,
> +			struct cxl_afu_driver_ops *ops)
> +{
> +	ctx->afu_driver_ops = ops;
> +}
> +EXPORT_SYMBOL_GPL(cxl_set_driver_ops);

This is pointless.

BUT, it wouldn't be if you actually checked the ops. Which you should do,
because then later you can avoid checking them on every event.

IIUI you should never have one op set but not the other, so you check in here
that both are set and error out otherwise.

Then in afu_read() you can change this:

> +	if (ctx->afu_driver_ops
> +			&& ctx->afu_driver_ops->event_pending
> +			&& ctx->afu_driver_ops->deliver_event
> +			&& ctx->afu_driver_ops->event_pending(ctx)) {

to:

> +	if (ctx->afu_driver_ops && ctx->afu_driver_ops->event_pending(ctx)) {


> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 6f53866..30e44a8 100644
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
> -#define CXL_API_VERSION 1
> +#define CXL_API_VERSION 2

I'm not clear on why we're bumping the API version?

Isn't this purely about in-kernel drivers?

I see below you're touching the uapi header, so I guess it's that simple. But
if you can explain it better that would be great.

>  #define CXL_API_VERSION_COMPATIBLE 1
>  
>  /*
> @@ -462,6 +463,9 @@ struct cxl_context {
>  	bool pending_fault;
>  	bool pending_afu_err;
>  
> +	/* Used by AFU drivers for driver specific event delivery */
> +	struct cxl_afu_driver_ops *afu_driver_ops;
> +
>  	struct rcu_head rcu;
>  };
>  
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index 57bdb47..2ebaca3 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -279,6 +279,22 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
>  	return cxl_context_iomap(ctx, vm);
>  }
>  
> +static inline int _ctx_event_pending(struct cxl_context *ctx)

Why isn't this returning bool?

> +{
> +	bool afu_driver_event_pending = false;
> +
> +	if (ctx->afu_driver_ops && ctx->afu_driver_ops->event_pending)
> +		afu_driver_event_pending = ctx->afu_driver_ops->event_pending(ctx);

You can drop the 2nd test in the if, if you enforce sane ops in cxl_set_driver_ops().

> +
> +	return (ctx->pending_irq || ctx->pending_fault ||
> +	    ctx->pending_afu_err || afu_driver_event_pending);

This would be nicer if you could short-circuit and avoid the function call when
the easy & cheap bool tests are true.

eg.

	if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
		return 1;

	if (ctx->afu_driver_ops && ctx->afu_driver_ops->event_pending)
		return ctx->afu_driver_ops->event_pending(ctx);

	return 0;

Or you could do it all in a single return if you wanted to.

	return ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err ||
	       (ctx->afu_driver_ops ? ctx->afu_driver_ops->event_pending(ctx) : 0);


> +static inline int ctx_event_pending(struct cxl_context *ctx)
> +{
> +	return _ctx_event_pending(ctx) || (ctx->status == CLOSED);
> +}

It's not at all clear why you would call this version vs the underscore version
_ctx_event_pending(), can they be named better to make it clear?

> @@ -360,7 +369,15 @@ ssize_t afu_read(struct file *file, char __user *buf, size_t count,
>  	memset(&event, 0, sizeof(event));
>  	event.header.process_element = ctx->pe;
>  	event.header.size = sizeof(struct cxl_event_header);
> -	if (ctx->pending_irq) {
> +	if (ctx->afu_driver_ops
> +			&& ctx->afu_driver_ops->event_pending
> +			&& ctx->afu_driver_ops->deliver_event
> +			&& ctx->afu_driver_ops->event_pending(ctx)) {

As I said above this would be much less gross if you enforced the ops being
sane when they're registered.

> +		pr_devel("afu_read delivering AFU driver specific event\n");
> +		event.header.type = CXL_EVENT_AFU_DRIVER;
> +		ctx->afu_driver_ops->deliver_event(&event, ctx, sizeof(event));
> +		WARN_ON(event.header.size > sizeof(event));

Some newlines in here would really help my eyes.


> +	} else if (ctx->pending_irq) {
>  		pr_devel("afu_read delivering AFU interrupt\n");
>  		event.header.size += sizeof(struct cxl_event_afu_interrupt);
>  		event.header.type = CXL_EVENT_AFU_INTERRUPT;
> @@ -538,7 +555,7 @@ int __init cxl_file_init(void)
>  	 * If these change we really need to update API.  Either change some
>  	 * flags or update API version number CXL_API_VERSION.
>  	 */
> -	BUILD_BUG_ON(CXL_API_VERSION != 1);
> +	BUILD_BUG_ON(CXL_API_VERSION != 2);
>  	BUILD_BUG_ON(sizeof(struct cxl_ioctl_start_work) != 64);
>  	BUILD_BUG_ON(sizeof(struct cxl_event_header) != 8);
>  	BUILD_BUG_ON(sizeof(struct cxl_event_afu_interrupt) != 8);
> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> index f2ffe5b..73e03a6 100644
> --- a/include/misc/cxl.h
> +++ b/include/misc/cxl.h
> @@ -210,4 +210,33 @@ ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
>  void cxl_perst_reloads_same_image(struct cxl_afu *afu,
>  				  bool perst_reloads_same_image);
>  
> +/*
> + * AFU driver ops allows an AFU driver to create their own events to pass to
> + * userspace through the file descriptor as a simpler alternative to overriding
> + * the read() and poll() calls that works with the generic cxl events. These
> + * events are given priority over the generic cxl events, so will be delivered
> + * first if multiple types of events are pending.
> + *
> + * even_pending() will be called by the cxl driver to check if an event is
> + * pending (e.g. in select/poll/read calls).
> + *
> + * deliver_event() will be called to fill out a cxl_event structure with the
> + * driver specific event. The header will already have the type and
> + * process_element fields filled in, and header.size will be set to
> + * sizeof(struct cxl_event_header). The AFU driver can extend that size up to
> + * max_size (which can be increased if necessary by reserving more space in the
> + * struct cxl_event_afu_driver_reserved definition).
> + *
> + * Both of these calls are made with a spin lock held, so they must not sleep.
> + */
> +struct cxl_afu_driver_ops {
> +	bool (*event_pending) (struct cxl_context *cxl);
> +	void (*deliver_event) (struct cxl_event *event,
> +			       struct cxl_context *cxl, size_t max_size);

context should always be the first param IMHO.

> +};
> +
> +/* Associate the above driver ops with a specific context */
> +void cxl_set_driver_ops(struct cxl_context *ctx,
> +			struct cxl_afu_driver_ops *ops);
> +
>  #endif /* _MISC_CXL_H */
> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
> index 99a8ca1..97f20b3 100644
> --- a/include/uapi/misc/cxl.h
> +++ b/include/uapi/misc/cxl.h
> @@ -67,6 +67,7 @@ enum cxl_event_type {
>  	CXL_EVENT_AFU_INTERRUPT = 1,
>  	CXL_EVENT_DATA_STORAGE  = 2,
>  	CXL_EVENT_AFU_ERROR     = 3,
> +	CXL_EVENT_AFU_DRIVER    = 4,
>  };
>  
>  struct cxl_event_header {
> @@ -98,12 +99,24 @@ struct cxl_event_afu_error {
>  	__u64 error;
>  };
>  
> +struct cxl_event_afu_driver_reserved {
> +	/*
> +	 * Reserves space for AFU driver specific events. If an AFU driver
> +	 * needs a larger buffer they should increase this to match so the cxl
> +	 * driver will allocate enough space.

This is odd, or at least oddly worded.

An AFU driver can't increase this. The author of an AFU driver can ask us to
increase it, which requires a source change and a recompile.

> +	 *
> +	 * This is not ABI. The contents will be, but that's up the AFU driver.
> +	 */
> +	__u64 reserved[4];

It is ABI. An old client is within its rights to assume header.size will only
ever be <= sizeof(cxl_event).

It looks like by choosing 4 here you've not actually increased the maximum
possible size of cxl_event. But if you make it any bigger that would break ABI.

> +};
> +
>  struct cxl_event {
>  	struct cxl_event_header header;
>  	union {
>  		struct cxl_event_afu_interrupt irq;
>  		struct cxl_event_data_storage fault;
>  		struct cxl_event_afu_error afu_error;
> +		struct cxl_event_afu_driver_reserved afu_driver_event;
>  	};
>  };
>  

cheers
