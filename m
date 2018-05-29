Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wNkG10cqzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 05:16:21 +1000 (AEST)
Message-ID: <1527621245.30674.30.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Diana Madalina Craciun <diana.craciun@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, Leo Li <leoyang.li@nxp.com>
Date: Tue, 29 May 2018 14:14:05 -0500
In-Reply-To: <VI1PR0401MB246345AD11EC8666B7187F8DFF6D0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
 <1527020969.30674.13.camel@buserror.net>
 <VI1PR0401MB246345AD11EC8666B7187F8DFF6D0@VI1PR0401MB2463.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-05-29 at 15:22 +0000, Diana Madalina Craciun wrote:
> Hi Scott,
> 
> Thanks for the review.
> 
> On 05/22/2018 11:31 PM, Scott Wood wrote:
> > On Tue, 2018-05-22 at 10:10 +0300, Diana Craciun wrote:
> > > Implement the barrier_nospec as a isync;sync instruction sequence.
> > > The implementation uses the infrastructure built for BOOK3S 64
> > > with the difference that for NXP platforms there is no firmware involved
> > > and the need for a speculation barrier is read from the device tree.
> > > I have used the same name for the property:
> > > fsl,needs-spec-barrier-for-bounds-check
> > 
> > Using the device tree this way means that anyone without an updated device
> > tree won't get the protection.  I also don't see any device tree updates
> > --
> > which chips are affected?
> 
> I was planning to have the device tree changes in a different patch-set.
> The affected cores are e500, e500mc, e5500, e6500.

So, all supported FSL/NXP book E chips.  Why not just enable the workaround
unconditionally (and revisit if NXP ever produces a book E chip that doesn't
need it and/or e200 is ever supported if that's simple enough to be immune)?

> > Why patch nops in if not enabled?  Aren't those locations already
> > nops?  For
> > that matter, how can this function even be called on FSL_BOOK3E with
> > enable !=
> > true?
> 
> There is some code in arch/powerpc/kernel/security.c which allows
> control of barrier_nospec via debugfs.

OK.

> > Should there be a way for the user to choose not to enable this (editing
> > the
> > device tree doesn't count), for a use case that is not sufficiently
> > security
> > sensitive to justify the performance loss?  What is the performance impact
> > of
> > this patch?
> 
> My reason was that on the other architectures Spectre variant 1
> mitigations are not disabled either. But I think that it might be a good
> idea to add a bootarg parameter to disable the barrier.

Is there a specific policy reason why they allow spectre v2 to be disabled but
not v1, or just a matter of not having a mechanism to disable it, or the parts
which could practically be disabled not impacting performance much?

-Scott
