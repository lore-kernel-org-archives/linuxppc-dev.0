Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DB191A006D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 12:21:02 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 54C29140216
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 12:21:02 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 10 Mar 2016 11:21:01 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 79B732BB0054
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 12:20:58 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2A1Ko9x56623202
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 12:20:58 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2A1IxBc030932
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 12:20:01 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
In-reply-to: <87a8m7iunv.fsf@vajain21.in.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <87a8m7iunv.fsf@vajain21.in.ibm.com>
Date: Thu, 10 Mar 2016 12:18:33 +1100
Message-Id: <1457570763-sup-7740@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Vaibhav Jain's message of 2016-03-10 01:37:56 +1100:
> > +    select CXL_AFU_DRIVER_OPS
> I suggest wrapping the driver_ops struct definition and other related
> functions inside a #ifdef CONFIG_CXL_AFU_DRIVER_OPS.

No, the kconfig option is there so that cxlflash can add support for
this and not have to worry about breaking any builds if their code is
merged into the scsi tree that doesn't have our code yet.

There is nothing optional about this within our driver, which is why
this is a select and has no configuration choice of it's own.

On a related matter, we should send a patch to remove some of the
leftover config options that were added to smooth the merging of
cxlflash in the first place (CXL_KERNEL_API, CXL_EEH).

> > +void cxl_set_driver_ops(struct cxl_context *ctx,
> > +            struct cxl_afu_driver_ops *ops)
> > +{
> > +    WARN_ON(!ops->event_pending || !ops->deliver_event);
> > +    ctx->afu_driver_ops = ops;
> > +}
> I would recommend adding a "struct module *" member to afu_driver_ops
> and doing a __module_get on to it here and module_put when we destroy
> the context. Since these callbacks will be residing within an external
> module .text region hence it should stay in the memory until the context
> is alive.

ok

> > diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> > index 783337d..d1cc297 100644
> > --- a/drivers/misc/cxl/file.c
> > +++ b/drivers/misc/cxl/file.c
> > @@ -295,6 +295,17 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
> >      return cxl_context_iomap(ctx, vm);
> >  }
> >  
> > +static inline bool ctx_event_pending(struct cxl_context *ctx)
> > +{
> > +    if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
> > +        return true;
> > +
> > +    if (ctx->afu_driver_ops)
> > +        return ctx->afu_driver_ops->event_pending(ctx);
> Should also check if ctx->afu_driver_ops->event_pending is NULL before
> calling it.

The v1 patch did exactly that and mpe rejected it as it made this code
too ugly - we now check that event_pending field is valid when it is
registered and WARN if it is not.

> I would propose these two apis.
> 
> /*
> *  fetches an event from the driver event queue. NULL means that queue
> *  is empty. Can sleep if needed. The memory for cxl_event is allocated
> *  by module being called. Hence it can be potentially be larger then
> *  sizeof(struct cxl_event). Multiple calls to this should return same
> *  pointer untill ack_event is called.
> */
> struct cxl_event * fetch_event(struct cxl_context * ctx);
> 
> /*
> * Returns and acknowledge the struct cxl_event * back to the driver
> * which can then free it or maybe put it back in a kmem_cache. This
> * should be called once we have completely returned the current
> * struct cxl_event from the readcall
> */
> void ack_event(struct cxl_context * ctx, struct cxl_event *);
> 
> I think above apis would give us more flexbility in the future when
> drivers would want to send larger events without breaking the abi.

I'm very reluctant to make this kind of change - while nice on paper,
poll() and read() are already very easy calls to screw up, and we have
seen that happen countless times in the past from different drivers that
e.g. and end up in a situation where poll says there is an event but
then read blocks, or poll blocks even though there is an event already
pending.

The API at the moment fits into the poll() / read() model and has
appropriate locking and the correct waiting semantics to avoid those
kind of issues (provided that the afu driver doesn't do something that
violates these semantics like sleep in one of these calls, but the
kernel has debug features to detect that), but any deviation from this
is too risky in my view.

Cheers,
-Ian
