Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A42C81A0514
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 17:04:42 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 587AB1404A8
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 17:04:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 19 Aug 2015 17:04:41 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0D8322CE802D
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 17:04:38 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7J74TE8721400
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 17:04:38 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7J745LZ001803
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 17:04:05 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Ochs <mrochs@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cxl: Add mechanism for delivering AFU driver specific
 events
In-reply-to: <1439962246.24918.7.camel@ellerman.id.au>
References: <1439957971-30483-1-git-send-email-imunsie@au.ibm.com>
 <1439962246.24918.7.camel@ellerman.id.au>
Date: Wed, 19 Aug 2015 17:03:40 +1000
Message-Id: <1439963824-sup-6017@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of 2015-08-19 15:30:46 +1000:
> On Wed, 2015-08-19 at 14:19 +1000, Ian Munsie wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > This adds an afu_driver_ops structure with event_pending and
> > deliver_event callbacks. An AFU driver can fill these out and associate
> > it with a context to enable passing custom AFU specific events to
> > userspace.
> 
> What's an AFU driver? Give me an example.

Maybe I should say user of the in-kernel cxl API? I've been referring to
these as AFU drivers because they are binding to an AFU - somehow I
thought we had already used that terminology in the API, but it appears
that I must have imagined that ;-)

The only real example currently (cxlflash) is still trying to get merged
(and their current patches do not depend on this functionality).

> > Conflicts between AFU specific events are not expected, due to the fact
> > that each AFU specific driver has it's own mechanism to deliver an AFU
> > file descriptor to userspace.
> 
> I don't grok this bit.

So, cxlflash might define a set of AFU specific events that they want to
use and all is fine, but later we might get a second AFU driver (maybe a
gzip, maybe a video codec, maybe networking, whatever) that also wants
to deliver some AFU specific events. If a userspace application were
reading from the AFU file descriptor and got one of these events it
couldn't tell just from the event alone whether it was a cxlflash event,
a gzip event or something else.

Except, the application must know what AFU driver it's talking to
because it has to have used whatever user API that driver exported to
obtain the AFU file descriptor (e.g. cxlflash is handing it out through
an ioctl on their scsi device). Any userspace application that obtains
an AFU file descriptor through the generic cxl driver's user API won't
get any AFU specific events. Hence, the user application already knows
what AFU driver specific events it could expect and therefore there is
no conflict between events from different drivers.

The alternative is adding something similar to an ioctl number...

> > +void cxl_set_driver_ops(struct cxl_context *ctx,
> > +            struct cxl_afu_driver_ops *ops)
> > +{
> > +    ctx->afu_driver_ops = ops;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_set_driver_ops);
> 
> This is pointless.

Not entirely as the contents of the struct cxl_context is not intended
to be exposed to the AFU driver.

> BUT, it wouldn't be if you actually checked the ops. Which you should do,
> because then later you can avoid checking them on every event.

ok

> IIUI you should never have one op set but not the other, so you check in here
> that both are set and error out otherwise.

I was thinking about the possibility of extending the ops later so I put
the checks where it was used, but ok - that can come later if/when we
actually need it.

> > -#define CXL_API_VERSION 1
> > +#define CXL_API_VERSION 2
> 
> I'm not clear on why we're bumping the API version?
> 
> Isn't this purely about in-kernel drivers?
> 
> I see below you're touching the uapi header, so I guess it's that simple. But
> if you can explain it better that would be great.

We are defining a new event type in the generic cxl driver (though
notably it will never be used by the generic cxl driver's user API). I
figured it was safer to bump it just in case, but arguably we could
leave it alone as the changes should only be visible to userspace code
that is using an AFU driver's user API and not the generic cxl user API.

What do you think?

Either way I left the compatible version number alone.

> > +static inline int _ctx_event_pending(struct cxl_context *ctx)
> 
> Why isn't this returning bool?

No reason, will change it.

> > +    if (ctx->afu_driver_ops && ctx->afu_driver_ops->event_pending)
> > +        afu_driver_event_pending = ctx->afu_driver_ops->event_pending(ctx);
> 
> You can drop the 2nd test in the if, if you enforce sane ops in cxl_set_driver_ops().

ok

> > +    return (ctx->pending_irq || ctx->pending_fault ||
> > +        ctx->pending_afu_err || afu_driver_event_pending);
> 
> This would be nicer if you could short-circuit and avoid the function call when
> the easy & cheap bool tests are true.

ok

> > +static inline int ctx_event_pending(struct cxl_context *ctx)
> > +{
> > +    return _ctx_event_pending(ctx) || (ctx->status == CLOSED);
> > +}
> 
> It's not at all clear why you would call this version vs the underscore version
> _ctx_event_pending(), can they be named better to make it clear?

I might rename it (cxl_event_pending_or_error?) - the difference here is
only because the poll call will want to set POLLERR if status == CLOSED
and no other events are pending, so it checks that case explicitly.

> > -    if (ctx->pending_irq) {
> > +    if (ctx->afu_driver_ops
> > +            && ctx->afu_driver_ops->event_pending
> > +            && ctx->afu_driver_ops->deliver_event
> > +            && ctx->afu_driver_ops->event_pending(ctx)) {
> 
> As I said above this would be much less gross if you enforced the ops being
> sane when they're registered.

ok

> > +        pr_devel("afu_read delivering AFU driver specific event\n");
> > +        event.header.type = CXL_EVENT_AFU_DRIVER;
> > +        ctx->afu_driver_ops->deliver_event(&event, ctx, sizeof(event));
> > +        WARN_ON(event.header.size > sizeof(event));
> 
> Some newlines in here would really help my eyes.

ok

> > +struct cxl_afu_driver_ops {
> > +    bool (*event_pending) (struct cxl_context *cxl);
> > +    void (*deliver_event) (struct cxl_event *event,
> > +                   struct cxl_context *cxl, size_t max_size);
> 
> context should always be the first param IMHO.

ok

> > +struct cxl_event_afu_driver_reserved {
> > +    /*
> > +     * Reserves space for AFU driver specific events. If an AFU driver
> > +     * needs a larger buffer they should increase this to match so the cxl
> > +     * driver will allocate enough space.
> 
> This is odd, or at least oddly worded.
> 
> An AFU driver can't increase this. The author of an AFU driver can ask us to
> increase it, which requires a source change and a recompile.

ok, will reword (I really meant that they can increase it when they send
the patch for their driver, not dynamically at runtime).

> > +     *
> > +     * This is not ABI. The contents will be, but that's up the AFU driver.
> > +     */
> > +    __u64 reserved[4];
> 
> It is ABI. An old client is within its rights to assume header.size will only
> ever be <= sizeof(cxl_event).
> 
> It looks like by choosing 4 here you've not actually increased the maximum
> possible size of cxl_event. But if you make it any bigger that would break ABI.

I intentionally haven't increased the size as allocated, because I have
no idea how much they will want to put in there - I could reserve more
space here, but how long is a piece of string? I could go for the max
of 4k, but that seemed a bit excessive as my gut feeling is that it is
more likely going to be small. Rather, I opted to just let the AFU
driver author them send us a patch if they need more, but if you have a
better idea to handle this I'm listening :)

It shouldn't be an ABI change to increase this - header.size passed to
the user will not change for existing events (as that is set in the read
call to sizeof(cxl_event_header) + sizeof(whatever event is being
dispatched), regardless of what the overall size of struct cxl_event
is). Plus, the user is already required to use a 4k buffer for reads, so
the size of the struct is only tangentially related to how much data we
actually hand them.

Cheers,
-Ian
