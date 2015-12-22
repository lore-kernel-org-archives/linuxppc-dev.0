Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 259D11A127C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 11:10:49 +1100 (AEDT)
Message-ID: <1450743048.27983.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: warn on spurious irq events (but ratelimited)
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
Date: Tue, 22 Dec 2015 11:10:48 +1100
In-Reply-To: <CAP=VYLq_JQuPwAze73mFYco=9pK=rvYKabsvUewnoPdNVzCXXw@mail.gmail.com>
References: <1449538707-7867-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLq_JQuPwAze73mFYco=9pK=rvYKabsvUewnoPdNVzCXXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-12-21 at 18:18 -0500, Paul Gortmaker wrote:
> On Mon, Dec 7, 2015 at 8:38 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> > It might be worth warning on spurious IRQ events; they might
> > point someone at a bogus DTS value or similar.
> > 
> > But ratelimit them to ensure we aren't too spammy about it.
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  arch/powerpc/kernel/irq.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > index 290559df1e8b..5c777e3a4c04 100644
> > --- a/arch/powerpc/kernel/irq.c
> > +++ b/arch/powerpc/kernel/irq.c
> > @@ -497,10 +497,12 @@ void __do_irq(struct pt_regs *regs)
> >         may_hard_irq_enable();
> > 
> >         /* And finally process it */
> > -       if (unlikely(irq == NO_IRQ))
> > +       if (unlikely(irq == NO_IRQ)) {
> > +               printk_ratelimited(KERN_WARNING "spurious irq on %d\n", irq);
> 
> If we did decide we cared about this patch, then no need for "irq" above, as
> we already know it is equal to NO_IRQ.

I'm not convinced it's worth printing, we already have a counter in proc.

I think it's more likely to just lead to console spam.

But maybe I'm wrong and you can convince me otherwise :)

cheers
