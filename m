Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0142.outbound.protection.outlook.com [65.55.169.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C7611A0CE0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 11:50:11 +1100 (AEDT)
Message-ID: <1422578995.10544.138.camel@freescale.com>
Subject: Re: AW: SPE & Interrupt context (was how to make use of SPE
 instructions)
From: Scott Wood <scottwood@freescale.com>
To: Markus Stockhausen <stockhausen@collogia.de>
Date: Thu, 29 Jan 2015 18:49:55 -0600
In-Reply-To: <12EF8D94C6F8734FB2FF37B9FBEDD1735F9160AA@EXCHANGE.collogia.de>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F915B69@EXCHANGE.collogia.de>
 ,<1422418883.10544.73.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F9160AA@EXCHANGE.collogia.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-28 at 05:00 +0000, Markus Stockhausen wrote:
> > > Von: Scott Wood [scottwood@freescale.com]
> > > Gesendet: Mittwoch, 28. Januar 2015 05:21
> > > An: Markus Stockhausen
> > > Cc: Michael Ellerman; linuxppc-dev@lists.ozlabs.org; Herbert Xu
> > > Betreff: Re: SPE & Interrupt context (was how to make use of SPE instructions)
> > > 
> > > Hi Scott,
> > >
> > > thanks for your helpful feedback. As you might have seen I sent a first
> > > patch for the sha256 kernel module that takes care about preemption.
> > >
> > > Herbert Xu noticed that my module won't run in for IPsec as all
> > > work will be done from interrupt context. Do you have a tip how I can
> > > mitigate the check I implemented:
> > >
> > > static bool spe_usable(void)
> > > {
> > >   return !in_interrupt();
> > > }
> > >
> > > Intel guys have something like that
> > >
> > > bool irq_fpu_usable(void)
> > > {
> > >   return !in_interrupt() ||
> > >     interrupted_user_mode() ||
> > >     interrupted_kernel_fpu_idle();
> > > }
> > >
> > > But I have no idea how to transfer it to the PPC/SPE case.
> > 
> > I'm not sure what sort of tip you're looking for, other than
> > implementing it myself. :-)
> 
> Hi Scott,
> 
> maybe I did not explain it correctly. interrupted_kernel_fpu_idle()
> is x86 specific. The same applies to interrupted_user_mode().
> I'm just searching for a similar feature in the PPC/SPE world.

There isn't one.

> I can see that enable_kernel_spe() does something with the
> MSR_SPE flag, but I have no idea  how to determine if I'm allowed
> to enable SPE although I'm inside an interrupt context.

As with x86, you'd want to check whether the kernel interrupted
userspace.  I don't know what x86 is doing with TS, but on PPC you might
check whether the interrupted thread had MSR_FP enabled.

> I'm asking because from the previous posts I conclude that 
> running SPE instructions inside an interrupt might be critical. 
> Because of registers not being saved?

Yes.  Currently callers of enable_kernel_spe() only need to disable
preemption, not interrupts.

> Or can I just save the register contents myself and interrupt
> context is no longer a showstopper?

If you only need a small number of registers that might be reasonable,
but if you need a bunch then you don't want to save them when you don't
have to.

Another option is to change enable_kernel_spe() to require interrupts to
be disabled.

-Scott
