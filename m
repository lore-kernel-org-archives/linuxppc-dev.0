Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 6AAECB6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 21:19:39 +1000 (EST)
Subject: Re: [PATCH 6/8] powerpc 8xx: cascade eoi will be performed by
	generic_handle_irq handler
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Milton Miller <miltonm@bga.com>
In-Reply-To: <1306380753.7481.350.camel@pasglop>
References: <more-irq-cleanups@mdm.bga.com> <8xx-cascade-eoi@mdm.bga.com>
	<1306380753.7481.350.camel@pasglop>
Message-ID: <reply-ben-8xx-cascade@mdm.bga.com>
Date: Thu, 26 May 2011 06:19:34 -0500
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 May 2011 about 13:32:33 +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2011-05-25 at 01:34 -0500, Milton Miller wrote:
> > > The 8xx cpm_cascade was calling irq_eoi for the cascaded irq,
> > > but that will already have been called by the handle_fasteoi_irq
> > > that generic_handle_irq will call.  The handler is set in
> > > arch/powerpc/sysdev/cpm1.c by the host map routine.
> > 
> > No it won't unless I'm missing something. The flow handler
> > (handle_fasteoi_irq) is going to be replaced by the chained handler when
> > mpc8xx_pics_init() calls irq_set_chained_handle(irq, cpm_cascade) no ?
> > 
> > Cheers,
> > Ben.

No.   We set the chained handler on the top level irq (on the irq
to the primary irq controller).  The handler is set to this 8xx_cascade
function.  We don't change the handler on the subordnate irq that
is invoked via generic_handle_irq in this function.

Or that is how I understand things to work, and this makes the 8xx
code match the current 8xxx cpm1 cascade handler.

Of course, it would be good for someone with hardware to confirm
that it works with the patch (or even put a printk or counter in the
handler if that would not cause printk recursion -- don't do it on
your console).

milton

> > 
> > > Signed-off-by: Milton Miller <miltonm@bga.com>
> > > 
> > > Index: work.git/arch/powerpc/platforms/8xx/m8xx_setup.c
> > > ===================================================================
> > > --- work.git.orig/arch/powerpc/platforms/8xx/m8xx_setup.c	2011-05-18 22:50:38.983498572 -0500
> > > +++ work.git/arch/powerpc/platforms/8xx/m8xx_setup.c	2011-05-18 22:52:48.920532258 -0500
> > > @@ -221,15 +221,9 @@ static void cpm_cascade(unsigned int irq
> > >  	struct irq_chip *chip;
> > >  	int cascade_irq;
> > >  
> > > -	if ((cascade_irq = cpm_get_irq()) >= 0) {
> > > -		struct irq_desc *cdesc = irq_to_desc(cascade_irq);
> > > -
> > > +	if ((cascade_irq = cpm_get_irq()) >= 0)
> > >  		generic_handle_irq(cascade_irq);
> > >  
> > > -		chip = irq_desc_get_chip(cdesc);
> > > -		chip->irq_eoi(&cdesc->irq_data);
> > > -	}
> > > -
> > >  	chip = irq_desc_get_chip(desc);
> > >  	chip->irq_eoi(&desc->irq_data);
> > >  }
> > 
> > 
