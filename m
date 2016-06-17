Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWQWG28vJzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 02:22:02 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5HGJNRv083357
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 12:22:00 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kbtx462b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 12:22:00 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 17 Jun 2016 10:21:59 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [v6,
 1/2] cxl: Add mechanism for delivering AFU driver specific events
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1466086415-30586-1-git-send-email-felix@linux.vnet.ibm.com>
Date: Fri, 17 Jun 2016 11:21:52 -0500
Cc: linuxppc-dev@lists.ozlabs.org, manoj@linux.vnet.ibm.com,
 mpe@ellerman.id.au, imunsie@au1.ibm.com, mikey@neuling.org
References: <1466086415-30586-1-git-send-email-felix@linux.vnet.ibm.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Message-Id: <CD1BE180-1104-4515-B6CD-F4D9460EAB4B@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Jun 16, 2016, at 9:13 AM, Philippe Bergheaud =
<felix@linux.vnet.ibm.com> wrote:
>=20
> This adds an afu_driver_ops structure with fetch_event() and
> event_delivered() callbacks. An AFU driver such as cxlflash can fill
> this out and associate it with a context to enable passing custom
> AFU specific events to userspace.
>=20
> This also adds a new kernel API function cxl_context_pending_events(),
> that the AFU driver can use to notify the cxl driver that new specific
> events are ready to be delivered, and wake up anyone waiting on the
> context wait queue.
>=20
> The current count of AFU driver specific events is stored in the field
> afu_driver_events of the context structure.
>=20
> The cxl driver checks the afu_driver_events count during poll, select,
> read, etc. calls to check if an AFU driver specific event is pending,
> and calls fetch_event() to obtain and deliver that event. This way,
> the cxl driver takes care of all the usual locking semantics around =
these
> calls and handles all the generic cxl events, so that the AFU driver =
only
> needs to worry about it's own events.
>=20
> fetch_event() return a struct cxl_event_afu_driver_reserved, allocated
> by the AFU driver, and filled in with the specific event information =
and
> size. Data size should not be greater than CXL_MAX_EVENT_DATA_SIZE.
>=20
> Th cxl driver prepends an appropriate cxl event header, copies the =
event
> to userspace, and finally calls event_delivered() to return the status =
of
> the operation to the AFU driver. The event is identified by the =
context
> and cxl_event_afu_driver_reserved pointers.
>=20
> Since AFU drivers provide their own means for userspace to obtain the
> AFU file descriptor (i.e. cxlflash uses an ioctl on their scsi file
> descriptor to obtain the AFU file descriptor) and the generic cxl =
driver
> will never use this event, the ABI of the event is up to each =
individual
> AFU driver.
>=20
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> Changes since v5:
> - s/deliver_event/fetch_event/
> - Fixed the handling of fetch_event errors
> - Documented the return codes of event_delivered
>=20
> Changes since v4:
> - Addressed comments from Vaibhav:
>  - Changed struct cxl_event_afu_driver_reserved from
>    { __u64 reserved[4]; } to { size_t data_size; u8 data[]; }
>  - Modified deliver_event to return a struct =
cxl_event_afu_driver_reserved
>  - Added new callback event_delivered
>  - Added static function afu_driver_event_copy
>=20
> Changes since v3:
> - Removed driver ops callback ctx_event_pending
> - Created cxl function cxl_context_pending_events
> - Created cxl function cxl_unset_driver_ops
> - Added atomic event counter afu_driver_events
>=20
> Changes since v2:
> - Fixed some typos spotted by Matt Ochs
>=20
> Changes since v1:
> - Rebased on upstream
> - Bumped cxl api version to 3
> - Addressed comments from mpe:
>  - Clarified commit message & some comments
>  - Mentioned 'cxlflash' as a possible user of this event
>  - Check driver ops on registration and warn if missing calls
>  - Remove redundant checks where driver ops is used
>  - Simplified ctx_event_pending and removed underscore version
>  - Changed deliver_event to take the context as the first argument
>=20
> drivers/misc/cxl/Kconfig |  5 +++++
> drivers/misc/cxl/api.c   | 27 ++++++++++++++++++++++
> drivers/misc/cxl/cxl.h   |  7 +++++-
> drivers/misc/cxl/file.c  | 58 =
+++++++++++++++++++++++++++++++++++++++++-------
> include/misc/cxl.h       | 53 =
+++++++++++++++++++++++++++++++++++++++++++
> include/uapi/misc/cxl.h  | 21 ++++++++++++++++++
> 6 files changed, 162 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
> index 8756d06..560412c 100644
> --- a/drivers/misc/cxl/Kconfig
> +++ b/drivers/misc/cxl/Kconfig
> @@ -15,12 +15,17 @@ config CXL_EEH
> 	bool
> 	default n
>=20
> +config CXL_AFU_DRIVER_OPS
> +	bool
> +	default n
> +
> config CXL
> 	tristate "Support for IBM Coherent Accelerators (CXL)"
> 	depends on PPC_POWERNV && PCI_MSI && EEH
> 	select CXL_BASE
> 	select CXL_KERNEL_API
> 	select CXL_EEH
> +	select CXL_AFU_DRIVER_OPS
> 	default m
> 	help
> 	  Select this option to enable driver support for IBM Coherent
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 6d228cc..23f98f4 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -323,6 +323,33 @@ struct cxl_context *cxl_fops_get_context(struct =
file *file)
> }
> EXPORT_SYMBOL_GPL(cxl_fops_get_context);
>=20
> +void cxl_set_driver_ops(struct cxl_context *ctx,
> +			struct cxl_afu_driver_ops *ops)
> +{
> +	WARN_ON(!ops->fetch_event || !ops->event_delivered);
> +	atomic_set(&ctx->afu_driver_events, 0);
> +	ctx->afu_driver_ops =3D ops;
> +}
> +EXPORT_SYMBOL_GPL(cxl_set_driver_ops);
> +
> +int cxl_unset_driver_ops(struct cxl_context *ctx)
> +{
> +	if (atomic_read(&ctx->afu_driver_events))
> +		return -EBUSY;
> +
> +	ctx->afu_driver_ops =3D NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_unset_driver_ops);
> +
> +void cxl_context_events_pending(struct cxl_context *ctx,
> +				unsigned int new_events)
> +{
> +	atomic_add(new_events, &ctx->afu_driver_events);
> +	wake_up_all(&ctx->wq);
> +}
> +EXPORT_SYMBOL_GPL(cxl_context_events_pending);
> +
> int cxl_start_work(struct cxl_context *ctx,
> 		   struct cxl_ioctl_start_work *work)
> {
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 4fe5078..b0027e6 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -24,6 +24,7 @@
> #include <asm/reg.h>
> #include <misc/cxl-base.h>
>=20
> +#include <misc/cxl.h>
> #include <uapi/misc/cxl.h>
>=20
> extern uint cxl_verbose;
> @@ -34,7 +35,7 @@ extern uint cxl_verbose;
>  * Bump version each time a user API change is made, whether it is
>  * backwards compatible ot not.
>  */
> -#define CXL_API_VERSION 2
> +#define CXL_API_VERSION 3
> #define CXL_API_VERSION_COMPATIBLE 1
>=20
> /*
> @@ -522,6 +523,10 @@ struct cxl_context {
> 	bool pending_fault;
> 	bool pending_afu_err;
>=20
> +	/* Used by AFU drivers for driver specific event delivery */
> +	struct cxl_afu_driver_ops *afu_driver_ops;
> +	atomic_t afu_driver_events;
> +
> 	struct rcu_head rcu;
> };
>=20
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index eec468f..cce2622 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -293,6 +293,17 @@ int afu_mmap(struct file *file, struct =
vm_area_struct *vm)
> 	return cxl_context_iomap(ctx, vm);
> }
>=20
> +static inline bool ctx_event_pending(struct cxl_context *ctx)
> +{
> +	if (ctx->pending_irq || ctx->pending_fault || =
ctx->pending_afu_err)
> +		return true;
> +
> +	if (ctx->afu_driver_ops && atomic_read(&ctx->afu_driver_events))
> +		return true;
> +
> +	return false;
> +}
> +
> unsigned int afu_poll(struct file *file, struct poll_table_struct =
*poll)
> {
> 	struct cxl_context *ctx =3D file->private_data;
> @@ -305,8 +316,7 @@ unsigned int afu_poll(struct file *file, struct =
poll_table_struct *poll)
> 	pr_devel("afu_poll wait done pe: %i\n", ctx->pe);
>=20
> 	spin_lock_irqsave(&ctx->lock, flags);
> -	if (ctx->pending_irq || ctx->pending_fault ||
> -	    ctx->pending_afu_err)
> +	if (ctx_event_pending(ctx))
> 		mask |=3D POLLIN | POLLRDNORM;
> 	else if (ctx->status =3D=3D CLOSED)
> 		/* Only error on closed when there are no futher events =
pending
> @@ -319,16 +329,40 @@ unsigned int afu_poll(struct file *file, struct =
poll_table_struct *poll)
> 	return mask;
> }
>=20
> -static inline int ctx_event_pending(struct cxl_context *ctx)
> +static ssize_t afu_driver_event_copy(struct cxl_context *ctx,
> +				     char __user *buf,
> +				     struct cxl_event *event,
> +				     struct =
cxl_event_afu_driver_reserved *pl)
> {
> -	return (ctx->pending_irq || ctx->pending_fault ||
> -	    ctx->pending_afu_err || (ctx->status =3D=3D CLOSED));
> +	/* Check data size */
> +	if (!pl || (pl->data_size > CXL_MAX_EVENT_DATA_SIZE)) {
> +		ctx->afu_driver_ops->event_delivered(ctx, pl, -EINVAL);
> +		return -EFAULT;
> +	}
> +
> +	/* Copy event header */
> +	event->header.size +=3D pl->data_size;
> +	if (copy_to_user(buf, event, sizeof(struct cxl_event_header))) {
> +		ctx->afu_driver_ops->event_delivered(ctx, pl, -EFAULT);
> +		return -EFAULT;
> +	}
> +
> +	/* Copy event data */
> +	buf +=3D sizeof(struct cxl_event_header);
> +	if (copy_to_user(buf, &pl->data, pl->data_size)) {
> +		ctx->afu_driver_ops->event_delivered(ctx, pl, -EFAULT);
> +		return -EFAULT;
> +	}
> +
> +	ctx->afu_driver_ops->event_delivered(ctx, pl, 0); /* Success */
> +	return event->header.size;
> }
>=20
> ssize_t afu_read(struct file *file, char __user *buf, size_t count,
> 			loff_t *off)
> {
> 	struct cxl_context *ctx =3D file->private_data;
> +	struct cxl_event_afu_driver_reserved *pl =3D NULL;
> 	struct cxl_event event;
> 	unsigned long flags;
> 	int rc;
> @@ -344,7 +378,7 @@ ssize_t afu_read(struct file *file, char __user =
*buf, size_t count,
>=20
> 	for (;;) {
> 		prepare_to_wait(&ctx->wq, &wait, TASK_INTERRUPTIBLE);
> -		if (ctx_event_pending(ctx))
> +		if (ctx_event_pending(ctx) || (ctx->status =3D=3D =
CLOSED))
> 			break;
>=20
> 		if (!cxl_ops->link_ok(ctx->afu->adapter, ctx->afu)) {
> @@ -374,7 +408,12 @@ ssize_t afu_read(struct file *file, char __user =
*buf, size_t count,
> 	memset(&event, 0, sizeof(event));
> 	event.header.process_element =3D ctx->pe;
> 	event.header.size =3D sizeof(struct cxl_event_header);
> -	if (ctx->pending_irq) {
> +	if (ctx->afu_driver_ops && atomic_read(&ctx->afu_driver_events)) =
{
> +		pr_devel("afu_read delivering AFU driver specific =
event\n");
> +		pl =3D ctx->afu_driver_ops->fetch_event(ctx);
> +		atomic_dec(&ctx->afu_driver_events);
> +		event.header.type =3D CXL_EVENT_AFU_DRIVER;
> +	} else if (ctx->pending_irq) {
> 		pr_devel("afu_read delivering AFU interrupt\n");
> 		event.header.size +=3D sizeof(struct =
cxl_event_afu_interrupt);
> 		event.header.type =3D CXL_EVENT_AFU_INTERRUPT;
> @@ -404,6 +443,9 @@ ssize_t afu_read(struct file *file, char __user =
*buf, size_t count,
>=20
> 	spin_unlock_irqrestore(&ctx->lock, flags);
>=20
> +	if (event.header.type =3D=3D CXL_EVENT_AFU_DRIVER)
> +		return afu_driver_event_copy(ctx, buf, &event, pl);
> +
> 	if (copy_to_user(buf, &event, event.header.size))
> 		return -EFAULT;
> 	return event.header.size;
> @@ -558,7 +600,7 @@ int __init cxl_file_init(void)
> 	 * If these change we really need to update API.  Either change =
some
> 	 * flags or update API version number CXL_API_VERSION.
> 	 */
> -	BUILD_BUG_ON(CXL_API_VERSION !=3D 2);
> +	BUILD_BUG_ON(CXL_API_VERSION !=3D 3);
> 	BUILD_BUG_ON(sizeof(struct cxl_ioctl_start_work) !=3D 64);
> 	BUILD_BUG_ON(sizeof(struct cxl_event_header) !=3D 8);
> 	BUILD_BUG_ON(sizeof(struct cxl_event_afu_interrupt) !=3D 8);
> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> index 56560c5..1d8dde8 100644
> --- a/include/misc/cxl.h
> +++ b/include/misc/cxl.h
> @@ -220,4 +220,57 @@ void cxl_perst_reloads_same_image(struct cxl_afu =
*afu,
>  */
> ssize_t cxl_read_adapter_vpd(struct pci_dev *dev, void *buf, size_t =
count);
>=20
> +/*
> + * AFU driver ops allow an AFU driver to create their own events to =
pass to
> + * userspace through the file descriptor as a simpler alternative to =
overriding
> + * the read() and poll() calls that works with the generic cxl =
events. These
> + * events are given priority over the generic cxl events, so they =
will be
> + * delivered first if multiple types of events are pending.
> + *
> + * The AFU driver must call cxl_context_events_pending() to notify =
the cxl
> + * driver that new events are ready to be delivered for a specific =
context.
> + * cxl_context_events_pending() will adjust the current count of AFU =
driver
> + * events for this context, and wake up anyone waiting on the context =
wait
> + * queue.
> + *
> + * The cxl driver will then call fetch_event() to get a structure =
defining
> + * the size and address of the driver specific event data. Data size =
cannot
> + * be greater than CXL_MAX_EVENT_DATA_SIZE. The cxl driver will build =
a cxl
> + * header with type and process_element fields filled in, and =
header.size
> + * set to sizeof(struct cxl_event_header) + data_size.
> + *
> + * fetch_event() is called with a spin lock held, so it must not =
sleep.
> + *
> + * The cxl driver will then deliver the event to userspace, and =
finally
> + * call event_delivered() to return the status of the operation, =
identified
> + * by its context and AFU driver event data pointers:
> + *   0        Success
> + *   -EFAULT  copy_to_user() has failed
> + *   -EINVAL  Event data pointer is NULL, or
> + *            event data size is greater than CXL_MAX_EVENT_DATA_SIZE
> + */
> +struct cxl_afu_driver_ops {
> +	struct cxl_event_afu_driver_reserved *(*fetch_event) (
> +						struct cxl_context =
*ctx);
> +	void (*event_delivered) (struct cxl_context *ctx,
> +				 struct cxl_event_afu_driver_reserved =
*event,
> +				 int rc);
> +};
> +
> +/*
> + * Associate the above driver ops with a specific context.
> + * Reset the current count of AFU driver events.
> + */
> +void cxl_set_driver_ops(struct cxl_context *ctx,
> +			struct cxl_afu_driver_ops *ops);
> +/*
> + * Remove the driver ops from a specific context.
> + * The current count of AFU driver events must be 0.
> + */
> +int cxl_unset_driver_ops(struct cxl_context *ctx);
> +
> +/* Notify cxl driver that new events are ready to be delivered for =
context */
> +void cxl_context_events_pending(struct cxl_context *ctx,
> +				unsigned int new_events);
> +
> #endif /* _MISC_CXL_H */
> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
> index 8cd334f..4fa36e4 100644
> --- a/include/uapi/misc/cxl.h
> +++ b/include/uapi/misc/cxl.h
> @@ -93,6 +93,7 @@ enum cxl_event_type {
> 	CXL_EVENT_AFU_INTERRUPT =3D 1,
> 	CXL_EVENT_DATA_STORAGE  =3D 2,
> 	CXL_EVENT_AFU_ERROR     =3D 3,
> +	CXL_EVENT_AFU_DRIVER    =3D 4,
> };
>=20
> struct cxl_event_header {
> @@ -124,12 +125,32 @@ struct cxl_event_afu_error {
> 	__u64 error;
> };
>=20
> +#define CXL_MAX_EVENT_DATA_SIZE 128

Any reason this can't be larger if the user buffer is 4K?

Having a cap is good, and our current plans for exploiting this will
not use anywhere near this limit, however I feel that since we've
moved to a dynamic model, the size limit should be a bit more
accommodating - especially since changing this later would require
a version bump.

How about 2K?

> +
> +struct cxl_event_afu_driver_reserved {
> +	/*
> +	 * Defines the buffer passed to the cxl driver by the AFU =
driver.
> +	 *
> +	 * This is not ABI since the event header.size passed to the =
user for
> +	 * existing events is set in the read call to =
sizeof(cxl_event_header)
> +	 * + sizeof(whatever event is being dispatched) and the user is =
already
> +	 * required to use a 4K buffer on the read call.
> +	 *
> +	 * Of course the contents will be ABI, but that's up the AFU =
driver.
> +	 *
> +	 * data_size is limited to MAX_EVENT_DATA_SIZE to prevent abuse.
> +	 */
> +	size_t data_size;
> +	u8 data[];
> +};
> +
> struct cxl_event {
> 	struct cxl_event_header header;
> 	union {
> 		struct cxl_event_afu_interrupt irq;
> 		struct cxl_event_data_storage fault;
> 		struct cxl_event_afu_error afu_error;
> +		struct cxl_event_afu_driver_reserved afu_driver_event;
> 	};
> };
>=20
> --=20
> 2.1.0
>=20
