Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 561191A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 04:20:53 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CB35D140216
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 04:20:52 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 11 Mar 2016 03:20:52 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 669BE2BB0054
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 04:20:43 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2AHKZCr8585626
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 04:20:43 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2AHKAM0023597
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 04:20:11 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
In-Reply-To: <56E05876.6090006@linux.vnet.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <87a8m7iunv.fsf@vajain21.in.ibm.com> <56E05876.6090006@linux.vnet.ibm.com>
Date: Thu, 10 Mar 2016 22:49:49 +0530
Message-ID: <87io0up7wq.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Hi Vaibhav,
>
> Le 09/03/2016 15:37, Vaibhav Jain a =C3=A9crit :
>
>> I would propose these two apis.
>>
>> /*
>> *  fetches an event from the driver event queue. NULL means that queue
>> *  is empty. Can sleep if needed. The memory for cxl_event is allocated
>> *  by module being called. Hence it can be potentially be larger then
>> *  sizeof(struct cxl_event). Multiple calls to this should return same
>> *  pointer untill ack_event is called.
>> */
>> struct cxl_event * fetch_event(struct cxl_context * ctx);
>>
>> /*
>> * Returns and acknowledge the struct cxl_event * back to the driver
>> * which can then free it or maybe put it back in a kmem_cache. This
>> * should be called once we have completely returned the current
>> * struct cxl_event from the readcall
>> */
>> void ack_event(struct cxl_context * ctx, struct cxl_event *);
>
>
> How would you implement polling on those APIs?
Hi Fred. I am looking at an implementation similar to this:

static inline bool ctx_event_pending(struct cxl_context *ctx)
{
	typeof (ctx->afu_driver_ops->fetch_event) fn_events =3D
		(ctx->afu_driver_ops !=3D NULL) ? ctx->afu_driver_ops->fetch_event : NULL;

	if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
		return true;

        /*
	 * if fn_event returns a not null then its gauranteed to return
	 * the same pointer on next call
	 */
	if (fn_events)
		return fn_events(ctx) !=3D NULL;

	return false;
}

unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
{
	struct cxl_context *ctx =3D file->private_data;
	int mask =3D 0;
	unsigned long flags;


	poll_wait(file, &ctx->wq, poll);

	pr_devel("afu_poll wait done pe: %i\n", ctx->pe);

	spin_lock_irqsave(&ctx->lock, flags);
	if (ctx_event_pending(ctx))
		mask |=3D POLLIN | POLLRDNORM;
	else if (ctx->status =3D=3D CLOSED)
		/* Only error on closed when there are no futher events pending
		 */
		mask |=3D POLLERR;
	spin_unlock_irqrestore(&ctx->lock, flags);

	pr_devel("afu_poll pe: %i returning %#x\n", ctx->pe, mask);

	return mask;
}

> How would you implement afu_read? There are several sources of events.
Looking at an implementation similar to this:

ssize_t afu_read(struct file *file, char __user *buf, size_t count,
			loff_t *off)
{
	unsigned long flags;
	ssize_t rc =3D 0;
	struct cxl_context *ctx =3D file->private_data;
	struct cxl_event *ptr_event, event =3D {
		.header.process_element =3D ctx->pe,
		.header.size =3D sizeof(struct cxl_event_header)
	};
	typeof (ctx->afu_driver_ops->fetch_event) fn_fetch_event =3D
		(ctx->afu_driver_ops !=3D NULL) ? ctx->afu_driver_ops->fetch_event : NULL;
	typeof (ctx->afu_driver_ops->ack_event) fn_ack_event =3D
		(ctx->afu_driver_ops !=3D NULL) ? ctx->afu_driver_ops->ack_event : NULL;
=20
	if (count < CXL_READ_MIN_SIZE)
		return -EINVAL;

       if (!cxl_adapter_link_ok(ctx->afu->adapter) ||
	   ctx->status =3D=3D CLOSED)
	       return -EIO;

       if (signal_pending(current))
	       return -ERESTARTSYS;

       /* if no events then wait */
       if (!ctx_event_pending(ctx)) {
=09=20=20=20=20=20=20=20
	       if ((file->f_flags & O_NONBLOCK))
		       return -EAGAIN;

	       pr_devel("afu_read going to sleep...\n");
	       rc =3D wait_event_interruptible(ctx->wq,
					     (ctx->status =3D=3D CLOSED) ||
					     cxl_adapter_link_ok(ctx->afu->adapter) ||
					     ctx_event_pending(ctx));
	       pr_devel("afu_read woken up\n");

       }
=20=20=20=20=20=20=20
       /* did we get interrupted during wait sleep */
       if (rc)
	       return rc;

       /* get driver events if any */
       ptr_event =3D fn_fetch_event ? fn_fetch_event(ctx) : NULL;

       /* In case of error feching driver specific event */
       if (IS_ERR(ptr_event)) {
	       pr_warn("Error fetching driver specific event %ld", PTR_ERR(ptr_eve=
nt));
	       ptr_event =3D NULL;
       }

       /* code below manipulates ctx so take a spin lock */
       spin_lock_irqsave(&ctx->lock, flags);

       /* give driver events first priority */
       if (ptr_event) {
		pr_devel("afu_read delivering AFU driver specific event\n");
		/* populate the header type and pe in the event struct */
		ptr_event->header.type =3D CXL_EVENT_AFU_DRIVER;
		ptr_event->header.process_element =3D ctx->pe;
		WARN_ON(event.header.size > count);

       } else if (ctx->pending_irq) {
		pr_devel("afu_read delivering AFU interrupt\n");
		event.header.size +=3D sizeof(struct cxl_event_afu_interrupt);
		event.header.type =3D CXL_EVENT_AFU_INTERRUPT;
		event.irq.irq =3D find_first_bit(ctx->irq_bitmap, ctx->irq_count) + 1;
		clear_bit(event.irq.irq - 1, ctx->irq_bitmap);
		if (bitmap_empty(ctx->irq_bitmap, ctx->irq_count))
			ctx->pending_irq =3D false;

	} else if (ctx->pending_fault) {
		pr_devel("afu_read delivering data storage fault\n");
		event.header.size +=3D sizeof(struct cxl_event_data_storage);
		event.header.type =3D CXL_EVENT_DATA_STORAGE;
		event.fault.addr =3D ctx->fault_addr;
		event.fault.dsisr =3D ctx->fault_dsisr;
		ctx->pending_fault =3D false;

	} else if (ctx->pending_afu_err) {
		pr_devel("afu_read delivering afu error\n");
		event.header.size +=3D sizeof(struct cxl_event_afu_error);
		event.header.type =3D CXL_EVENT_AFU_ERROR;
		event.afu_error.error =3D ctx->afu_err;
		ctx->pending_afu_err =3D false;

	} else if (ctx->status =3D=3D CLOSED) {
		pr_devel("afu_read fatal error\n");
		rc =3D -EIO;
	} else
		WARN(1, "afu_read must be buggy\n");

	spin_unlock_irqrestore(&ctx->lock, flags);

	if (!rc) {
		/* if we dont have a driver event then use 'event' var */
		ptr_event =3D ptr_event ? ptr_event : &event;
=09
		rc =3D min(((size_t)ptr_event->header.size), count);
=09
		if (copy_to_user(buf, ptr_event, rc))
			rc =3D -EFAULT;
	}
	/* if its a driver event ack it back to the driver */
	if (fn_ack_event && (ptr_event !=3D &event))
		fn_ack_event(ctx, ptr_event);
=09=09
	return rc;
}

Cheers,
~ Vaibhav
