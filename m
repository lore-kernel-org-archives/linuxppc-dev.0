Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1597E2C0190
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 08:56:44 +1000 (EST)
Message-ID: <1376952992.31636.382.camel@snotra.buserror.net>
Subject: Re: Pull request: scottwood/linux.git next
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 19 Aug 2013 17:56:32 -0500
In-Reply-To: <1376514060.4255.73.camel@pasglop>
References: <20130808224501.GA8925@home.buserror.net>
 <1376453881.4255.57.camel@pasglop>
 <1376499759.31636.15.camel@snotra.buserror.net>
 <1376514060.4255.73.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-15 at 07:01 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2013-08-14 at 12:02 -0500, Scott Wood wrote:
> > On Wed, 2013-08-14 at 14:18 +1000, Benjamin Herrenschmidt wrote:
> > > On Thu, 2013-08-08 at 17:45 -0500, Scott Wood wrote:
> > > >       powerpc/e500: Update compilation flags with core specific
> > > > options
> > > 
> > > This breaks the build for my FSL test configs. For some reason gcc 4.7.3
> > > doesn't know about -mcpu=e5500
> > 
> > Ugh.  I guess that's what I get for using toolchains provided internally
> > rather than building them myself
> 
> :-)
> 
> I recommend you use one of tony's on kernel.org, that way you have
> something that matches what other people use :-)

It looks like -mcpu=e500mc64 has been supported for a while.

> > > Additionally, on 64-bit, that means one can no longer make a kernel that
> > > does both A2 and e5500...
> > 
> > Other than the toolchain issue, I'm not sure how this is worse than it
> > was before, when such a kernel would have had -Wa,-me500 forced.
> 
> Probably similarly bad though it did work ... but if you are touching
> it, may as well do it right...

There are worms inside that can...

> > What -mcpu value should be used in such a combined kernel?
> 
> Good question. We lack a generic booke option. What about powerpc64 ?
> 
> A default like that is fine as long as tricky asm uses the macros for
> that and the *optional* -mcpu=<xxx> option is available (and you can put
> it in defconfig).
> 
> It might be worth asking gcc to add something like -march=<arch version>
> or something like that though.

If we use the generic CPU target then mftb won't get turned into mfspr
(I assume this is what you meant by "tricky asm").  Does mfspr work
everywhere, including from userspace?  Or do we need to patch?  What
about 403GCX which seems to need some special SPR (I could leave the
existing ifdef alone, but what about vdso)?

-Scott
