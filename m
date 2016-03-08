Return-Path: <mrochs@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7CF71A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 11:27:03 +1100 (AEDT)
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 05E59140BFB
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 11:27:02 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mrochs@us.ibm.com>;
 Mon, 7 Mar 2016 19:27:00 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D7D30C90041
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2016 19:26:54 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u280QwEG33423602
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 00:26:58 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u280Qvgi029281
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Mar 2016 19:26:57 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
From: Matt Ochs <mrochs@us.ibm.com>
In-Reply-To: <1457377164-22234-1-git-send-email-imunsie@au.ibm.com>
Date: Mon, 7 Mar 2016 18:26:55 -0600
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Manoj Kumar <kumarmn@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>
Message-Id: <2E3C996E-C050-426F-878D-F25905E3C584@us.ibm.com>
References: <1457377164-22234-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A couple of minor nits below...

> On Mar 7, 2016, at 12:59 PM, Ian Munsie <imunsie@au1.ibm.com> wrote:
>=20
> @@ -346,7 +350,7 @@ ssize_t afu_read(struct file *file, char __user =
*buf, size_t count,
>=20
> 	for (;;) {
> 		prepare_to_wait(&ctx->wq, &wait, TASK_INTERRUPTIBLE);
> -		if (ctx_event_pending(ctx))
> +		if (ctx_event_pending(ctx) || (ctx->status =3D=3D =
CLOSED))
> 			break;
>=20
> 		if (!cxl_adapter_link_ok(ctx->afu->adapter)) {
> @@ -376,7 +380,14 @@ ssize_t afu_read(struct file *file, char __user =
*buf, size_t count,
> 	memset(&event, 0, sizeof(event));
> 	event.header.process_element =3D ctx->pe;
> 	event.header.size =3D sizeof(struct cxl_event_header);
> -	if (ctx->pending_irq) {
> +
> +	if (ctx->afu_driver_ops && =
ctx->afu_driver_ops->event_pending(ctx)) {
> +		pr_devel("afu_read delivering AFU driver specific =
event\n");
> +		event.header.type =3D CXL_EVENT_AFU_DRIVER;
> +		ctx->afu_driver_ops->deliver_event(ctx, &event, =
sizeof(event));
> +		WARN_ON(event.header.size > sizeof(event));
> +
> +	} else if (ctx->pending_irq) {
> 		pr_devel("afu_read delivering AFU interrupt\n");
> 		event.header.size +=3D sizeof(struct =
cxl_event_afu_interrupt);
> 		event.header.type =3D CXL_EVENT_AFU_INTERRUPT;
> @@ -384,6 +395,7 @@ ssize_t afu_read(struct file *file, char __user =
*buf, size_t count,
> 		clear_bit(event.irq.irq - 1, ctx->irq_bitmap);
> 		if (bitmap_empty(ctx->irq_bitmap, ctx->irq_count))
> 			ctx->pending_irq =3D false;
> +
> 	} else if (ctx->pending_fault) {
> 		pr_devel("afu_read delivering data storage fault\n");
> 		event.header.size +=3D sizeof(struct =
cxl_event_data_storage);
> @@ -391,12 +403,14 @@ ssize_t afu_read(struct file *file, char __user =
*buf, size_t count,
> 		event.fault.addr =3D ctx->fault_addr;
> 		event.fault.dsisr =3D ctx->fault_dsisr;
> 		ctx->pending_fault =3D false;
> +
> 	} else if (ctx->pending_afu_err) {
> 		pr_devel("afu_read delivering afu error\n");
> 		event.header.size +=3D sizeof(struct =
cxl_event_afu_error);
> 		event.header.type =3D CXL_EVENT_AFU_ERROR;
> 		event.afu_error.error =3D ctx->afu_err;
> 		ctx->pending_afu_err =3D false;
> +

Any reason for adding these extra lines as part of this commit?

> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> index f2ffe5b..f198a42 100644
> --- a/include/misc/cxl.h
> +++ b/include/misc/cxl.h
> @@ -210,4 +210,33 @@ ssize_t cxl_fd_read(struct file *file, char =
__user *buf, size_t count,
> void cxl_perst_reloads_same_image(struct cxl_afu *afu,
> 				  bool perst_reloads_same_image);
>=20
> +/*
> + * AFU driver ops allows an AFU driver to create their own events to =
pass to
> + * userspace through the file descriptor as a simpler alternative to =
overriding
> + * the read() and poll() calls that works with the generic cxl =
events. These
> + * events are given priority over the generic cxl events, so will be =
delivered

so _they_ will be delivered

> + * first if multiple types of events are pending.
> + *
> + * even_pending() will be called by the cxl driver to check if an =
event is
> + * pending (e.g. in select/poll/read calls).

event_pending() <- missing 't'

> + *
> + * deliver_event() will be called to fill out a cxl_event structure =
with the
> + * driver specific event. The header will already have the type and
> + * process_element fields filled in, and header.size will be set to
> + * sizeof(struct cxl_event_header). The AFU driver can extend that =
size up to
> + * max_size (if an afu driver requires more space, they should submit =
a patch
> + * increasing the size in the struct cxl_event_afu_driver_reserved =
definition).
> + *
> + * Both of these calls are made with a spin lock held, so they must =
not sleep.
> + */
> +struct cxl_afu_driver_ops {
> +	bool (*event_pending) (struct cxl_context *ctx);
> +	void (*deliver_event) (struct cxl_context *ctx,
> +			struct cxl_event *event, size_t max_size);
> +};
> +
> +/* Associate the above driver ops with a specific context */
> +void cxl_set_driver_ops(struct cxl_context *ctx,
> +			struct cxl_afu_driver_ops *ops);
> +
> #endif /* _MISC_CXL_H */
> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
> index 1e889aa..8b097db 100644
> --- a/include/uapi/misc/cxl.h
> +++ b/include/uapi/misc/cxl.h
> @@ -69,6 +69,7 @@ enum cxl_event_type {
> 	CXL_EVENT_AFU_INTERRUPT =3D 1,
> 	CXL_EVENT_DATA_STORAGE  =3D 2,
> 	CXL_EVENT_AFU_ERROR     =3D 3,
> +	CXL_EVENT_AFU_DRIVER    =3D 4,
> };
>=20
> struct cxl_event_header {
> @@ -100,12 +101,33 @@ struct cxl_event_afu_error {
> 	__u64 error;
> };
>=20
> +struct cxl_event_afu_driver_reserved {
> +	/*
> +	 * Reserves space for AFU driver specific events. Not actually
> +	 * reserving any more space compared to other events as we can't =
know
> +	 * how much an AFU driver will need (but it is likely to be =
small). If
> +	 * your AFU driver needs more than this, please submit a patch
> +	 * increasing it as part of your driver submission.
> +	 *
> +	 * This is not ABI since the event header.size passed to the =
user for
> +	 * existing events is set in the read call to =
sizeof(cxl_event_header)
> +	 * + sizeof(whatever event is being dispatched) and will not =
increase
> +	 * just because this is, and the user is already required to use =
a 4K
> +	 * buffer on the read call. This is merely the size of the =
buffer
> +	 * passed between the cxl and AFU drivers.
> +	 *
> +	 * Of course the contents will be ABI, but that's up the AFU =
driver.
> +	 */
> +	__u64 reserved[4];
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
> 2.1.4
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
