Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E15C91A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 04:39:36 +1100 (AEDT)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47347140773
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Mar 2016 04:39:35 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 10 Mar 2016 23:09:33 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2AHdTug30081106
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 23:09:30 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2AHdSde015739
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 23:09:29 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v3 1/2] cxl: Add mechanism for delivering AFU driver
 specific events
In-Reply-To: <1457570763-sup-7740@delenn.ozlabs.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
 <87a8m7iunv.fsf@vajain21.in.ibm.com>
 <1457570763-sup-7740@delenn.ozlabs.ibm.com>
Date: Thu, 10 Mar 2016 23:09:26 +0530
Message-ID: <87d1r2p701.fsf@vajain21.in.ibm.com>
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

Ian Munsie <imunsie@au1.ibm.com> writes:

> No, the kconfig option is there so that cxlflash can add support for
> this and not have to worry about breaking any builds if their code is
> merged into the scsi tree that doesn't have our code yet.
>
> There is nothing optional about this within our driver, which is why
> this is a select and has no configuration choice of it's own.
>
> On a related matter, we should send a patch to remove some of the
> leftover config options that were added to smooth the merging of
> cxlflash in the first place (CXL_KERNEL_API, CXL_EEH).
Agreed.

>> > diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
>> > index 783337d..d1cc297 100644
>> > --- a/drivers/misc/cxl/file.c
>> > +++ b/drivers/misc/cxl/file.c
>> > @@ -295,6 +295,17 @@ int afu_mmap(struct file *file, struct vm_area_struct *vm)
>> >      return cxl_context_iomap(ctx, vm);
>> >  }
>> >  
>> > +static inline bool ctx_event_pending(struct cxl_context *ctx)
>> > +{
>> > +    if (ctx->pending_irq || ctx->pending_fault || ctx->pending_afu_err)
>> > +        return true;
>> > +
>> > +    if (ctx->afu_driver_ops)
>> > +        return ctx->afu_driver_ops->event_pending(ctx);
>> Should also check if ctx->afu_driver_ops->event_pending is NULL before
>> calling it.
>
> The v1 patch did exactly that and mpe rejected it as it made this code
> too ugly - we now check that event_pending field is valid when it is
> registered and WARN if it is not.
The driver_ops struct pointer being passed is still owned by the
external module and its free change it even after calling this
function. We can mitigate this to some extent by accepting a const
pointer to the struct or by copying this struct to the context object.

> I'm very reluctant to make this kind of change - while nice on paper,
> poll() and read() are already very easy calls to screw up, and we have
> seen that happen countless times in the past from different drivers that
> e.g. and end up in a situation where poll says there is an event but
> then read blocks, or poll blocks even though there is an event already
> pending.
>
> The API at the moment fits into the poll() / read() model and has
> appropriate locking and the correct waiting semantics to avoid those
> kind of issues (provided that the afu driver doesn't do something that
> violates these semantics like sleep in one of these calls, but the
> kernel has debug features to detect that), but any deviation from this
> is too risky in my view.

Ian I have responded to Fred with an example implementation of these
calls. Requesting you to please take a look.

Cheers,
~ Vaibhav
