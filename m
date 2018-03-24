Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407Y9k63DpzF1jl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 19:15:06 +1100 (AEDT)
Message-ID: <1521879295.16434.377.camel@kernel.crashing.org>
Subject: Re: [PATCH] cxl: disable the lazy approach for irqs in POWERVM
 environment.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Date: Sat, 24 Mar 2018 19:14:55 +1100
In-Reply-To: <fd18ea29-18f9-ae02-4e26-535ee189f739@linux.vnet.ibm.com>
References: <1521736674-13128-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1521771288.16434.326.camel@au1.ibm.com>
 <fd18ea29-18f9-ae02-4e26-535ee189f739@linux.vnet.ibm.com>
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

On Fri, 2018-03-23 at 17:17 +0100, christophe lombard wrote:
> Le 23/03/2018 à 03:14, Benjamin Herrenschmidt a écrit :
> > On Thu, 2018-03-22 at 17:37 +0100, Christophe Lombard wrote:
> > > The cxl driver cannot disable the interrupt at the device level and has
> > > to use disable_irq[_nosync] instead.
> > > To avoid the implementation of the lazy optimisation (the interrupt is
> > > marked disabled, but the hardware is left unmasked), we can disable it,
> > > for a particular irq line, by calling
> > > 'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'.
> > 
> > Why do you need that ? What's wrong with the lazy approach ? It makes
> > disable_irq/enable_irq faster...
> > 
> > You shouldn't need that unless your device is generating a *LOT* of
> > irqs while disabled.
> > 
> 
> An issue on POWERVM (CAPI) has been introduced with the following patch
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bf22ff45bed664aefb5c4e43029057a199b7070c 
> 
> The PSL or AFU interrupts are never received by the cxl driver because 
> the interrupts are never unmasked.
> 
> Without this patch (genirq: Avoid unnecessary low level irq function 
> calls), the callback desc->irq_data.chip->irq_unmask(&desc->irq_data); 
> (= ics_rtas_unmask_irq()) is called by default through irq_enable().

I don't see why this would change with the patch... 

> The cxl driver disables the interrupts before attaching the process 
> element and enables the interrupts after that.

How ? Using disable_irq or something else ?

> In the current code, irq_enable() unmasks the irq only if the irq state 
> is IRQD_IRQ_MASKED but it does not.

Sorry I don't really parse your sentence. You mean there's a disconnect
between the "HW" (or pHyp) state of the interrupt and the
IRQD_IRQ_MASKED flag ? That shouldn't happen... if that's the case the
bug is elsewhere, what is causing the disconnect in the first place ?

> Call irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY) allows forcing 
> irq_disable() to update the irq state to IRQD_IRQ_MASKED and by default
> irq_enable() will unmask the irq through ics_rtas_unmask_irq().

Hrm. I don't quite understand. You shouldn't need that, I suspect you
are papering over a different bug but I'm not 100% certain as I don't
completely understand what's happening.

Cheers,
Ben.
> 
> 
> 
> > > Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> > > ---
> > >   drivers/misc/cxl/guest.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
> > > index f58b4b6c..dc476e1 100644
> > > --- a/drivers/misc/cxl/guest.c
> > > +++ b/drivers/misc/cxl/guest.c
> > > @@ -389,6 +389,7 @@ static void disable_afu_irqs(struct cxl_context *ctx)
> > >   		hwirq = ctx->irqs.offset[r];
> > >   		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
> > >   			virq = irq_find_mapping(NULL, hwirq);
> > > +			irq_set_status_flags(virq, IRQ_DISABLE_UNLAZY);
> > >   			disable_irq(virq);
> > >   		}
> > >   	}
