Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9A7782C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 01:41:44 +1100 (EST)
Message-ID: <1363617693.15862.1.camel@pasglop>
Subject: Re: [PATCH 1/3] powerpc/mpic: add irq_set_wake support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Mon, 18 Mar 2013 15:41:33 +0100
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EB6434@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1362728327-21013-1-git-send-email-dongsheng.wang@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259EB6434@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-03-18 at 09:28 +0000, Wang Dongsheng-B40534 wrote:
> Hi Benjamin & Kumar,
> 
> I am not sure who can apply these patches...
> 
> Could you apply these patches?

I can but I need somebody to review them, I don't have the bandwidth nor
am I familiar with the FSL changes to the MPIC.

Cheers,
Ben.

> Thanks.
> 
> [1/3] powerpc/mpic: add irq_set_wake support
> http://patchwork.ozlabs.org/patch/226034/
> 
> [2/3] powerpc/mpic: add global timer support
> http://patchwork.ozlabs.org/patch/226035/
> 
> [3/3] powerpc/fsl: add MPIC timer wakeup support
> http://patchwork.ozlabs.org/patch/226036/
> 
> > -----Original Message-----
> > From: Wang Dongsheng-B40534
> > Sent: Friday, March 08, 2013 3:39 PM
> > To: Wood Scott-B07421; Gala Kumar-B11780
> > Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> > Subject: [PATCH 1/3] powerpc/mpic: add irq_set_wake support
> > 
> > Add irq_set_wake support. Just add IRQF_NO_SUSPEND to desc->action->flag.
> > So the wake up interrupt will not be disable in suspend_device_irqs.
> > 
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> >  arch/powerpc/sysdev/mpic.c |   15 +++++++++++++++
> >  1 files changed, 15 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 3b2efd4..10e474e 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -920,6 +920,18 @@ int mpic_set_irq_type(struct irq_data *d, unsigned
> > int flow_type)
> >  	return IRQ_SET_MASK_OK_NOCOPY;
> >  }
> > 
> > +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on) {
> > +	struct irq_desc *desc = container_of(d, struct irq_desc, irq_data);
> > +
> > +	if (on)
> > +		desc->action->flags |= IRQF_NO_SUSPEND;
> > +	else
> > +		desc->action->flags &= ~IRQF_NO_SUSPEND;
> > +
> > +	return 0;
> > +}
> > +
> >  void mpic_set_vector(unsigned int virq, unsigned int vector)  {
> >  	struct mpic *mpic = mpic_from_irq(virq); @@ -957,6 +969,7 @@ static
> > struct irq_chip mpic_irq_chip = {
> >  	.irq_unmask	= mpic_unmask_irq,
> >  	.irq_eoi	= mpic_end_irq,
> >  	.irq_set_type	= mpic_set_irq_type,
> > +	.irq_set_wake	= mpic_irq_set_wake,
> >  };
> > 
> >  #ifdef CONFIG_SMP
> > @@ -971,6 +984,7 @@ static struct irq_chip mpic_tm_chip = {
> >  	.irq_mask	= mpic_mask_tm,
> >  	.irq_unmask	= mpic_unmask_tm,
> >  	.irq_eoi	= mpic_end_irq,
> > +	.irq_set_wake	= mpic_irq_set_wake,
> >  };
> > 
> >  #ifdef CONFIG_MPIC_U3_HT_IRQS
> > @@ -981,6 +995,7 @@ static struct irq_chip mpic_irq_ht_chip = {
> >  	.irq_unmask	= mpic_unmask_ht_irq,
> >  	.irq_eoi	= mpic_end_ht_irq,
> >  	.irq_set_type	= mpic_set_irq_type,
> > +	.irq_set_wake	= mpic_irq_set_wake,
> >  };
> >  #endif /* CONFIG_MPIC_U3_HT_IRQS */
> > 
> > --
> > 1.7.5.1
> 
