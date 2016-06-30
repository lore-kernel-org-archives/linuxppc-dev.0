Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgNpC12qPzDr21
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 01:32:34 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UFTODX011177
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:32:32 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23utcahtxm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:32:32 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 1 Jul 2016 01:32:29 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 31E8B2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 01:32:27 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UFWR3i21561454
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 01:32:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UFWQPK025209
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 01:32:26 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
Subject: Re: [PATCH 1/2] cxl: Fix bug where AFU disable operation had no effect
In-reply-to: <57752A8A.1020501@linux.vnet.ibm.com>
References: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
 <57752A8A.1020501@linux.vnet.ibm.com>
Date: Fri, 01 Jul 2016 01:32:24 +1000
Message-Id: <1467298239-sup-4306@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Frederic Barrat's message of 2016-06-30 16:19:54 +0200:
> I'm not a big fan of the new "clear" argument, which forces us to pass 
> an extra 0 most of the time. Why not always clearing the "action" bits 
> of the register before applying the command? They are mutually 
> exclusive, so it should work. I.e. :
> 
> +    AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
> +    AFU_Cntl &= ~(CXL_AFU_Cntl_An_E | CXL_AFU_Cntl_An_RA);
> +    AFU_Cntl |= command;

In theory that should be OK, but I'd want to test it on some PSL images
first just in case they don't behave quite how we expect since we've had
problems in this area in the past (although after discovering the bug in
the disable path that may provide the explanation for those problems).

The risk I see with that approach is setting the reset bit and clearing
the enable bit at the same time is commanding the hardware to do two
similar but subtly different operations simultaneously, which is not
something we have done before or tested - we can always clean this up in
a later patch after we've tested it on a couple of PSLs, cxlflash, etc
and are happy that it works with no ill effects. I don't see any reason
that needs to be done in this patch though since it's just churn inside
the driver and doesn't impact anyone else.

> >   static inline int detach_process_native_dedicated(struct cxl_context *ctx)
> >   {
> > -    cxl_ops->afu_reset(ctx->afu);
> > +    if (ctx->afu->adapter->native->sl_ops->needs_reset_before_disable) {
> > +        /*
> > +         * XXX: We may be able to do away with this entirely - it is
> > +         * possible that this was only ever needed due to a bug where
> > +         * the disable operation did not clear the enable bit, however
> > +         * I will only consider dropping this after more regression
> > +         * testing on earlier PSL images.
> > +         */
> > +        cxl_ops->afu_reset(ctx->afu);
> > +    }
> 
> For dedicated mode, the CAIA recommends an explicit reset of the AFU 
> (section 2.1.1).

True, I had forgotten that procedure was added to the document before it
was made public - I'll update the comment and resend.

> For directed mode, CAIA says it's AFU-specific.

Damnit, that should never have been architected as AFU specific - PSL
implementation specific would have been ok, but AFU specific is just
asking for trouble since this is all generic code with no way to
identify the AFU.

Oh well, in practice the AFU developers will be coding against our
implementation now, so I guess we effectively became the authority on
how this works by default... and therefore should probably continue to
do the reset here.

Just hope there aren't too many more ASIC implementations that implement
some contradictory behaviour and are set in stone before anyone
realises.

I'll resend this with these two comments updated.

> So for xsl, we only disable the afu and purge the xsl. Are we getting
> rid of the reset because it's useless in that environment, or because
> it times out?
>
> If just because of timeout, would it make sense to switch the order
> and disable first, then reset? I don't see any afu-reset on the next
> activation.

It times out if the AFU is enabled when we attempt the reset - that's
OK, but is a bit of a waste of time and generates unnecessary noise in
the kernel log. We could switch the order, but I don't think that the
AFU reset is necessary - the documentation certainly suggests that only
a disable is required (but then again, the XSL has been full of
surprises already so I reserve the right to send a later patch adding a
reset if it has one more in store for me :-p).

A reset is also pretty meaningless on the XSL as far as I can tell - it
looks like it will assert a bit to the CX4 hardware, so I assume the
rest of the card could choose to do something with it, but unlike the
FPGA cards I don't think it actually resets anything (and I doubt we
even need the one we do while initialising the card since the AFU
descriptor is in the CX4 hardware and should be readable without that).

Cheers,
-Ian
