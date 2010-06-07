Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89599B6F11
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 20:30:23 +1000 (EST)
Date: Mon, 7 Jun 2010 12:30:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Esben Haabendal <eha@doredevelopment.dk>
Subject: Re: [PATCH 2/2] gpio: pca953x: add powerpc irq support
In-Reply-To: <1275889820.2970.63.camel@eha.doredevelopment.dk>
Message-ID: <alpine.LFD.2.00.1006071223040.2933@localhost.localdomain>
References: <cover.1275686504.git.eha@doredevelopment.dk>
	<1275686731.2970.14.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006070129530.2933@localhost.localdomain>
	<1275889820.2970.63.camel@eha.doredevelopment.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 7 Jun 2010, Esben Haabendal wrote:
> On Mon, 2010-06-07 at 01:39 +0200, Thomas Gleixner wrote: 
> > On Fri, 4 Jun 2010, Esben Haabendal wrote:
>
> > > @@ -120,6 +124,10 @@ static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
> > >  	chip = container_of(gc, struct pca953x_chip, gpio_chip);
> > >  
> > >  	reg_val = chip->reg_direction | (1u << off);
> > > +
> > > +	if (reg_val == chip->reg_direction)
> > > +		return 0;
> > > +
> > 
> >  This is an optimization of its own value.
> 
> Yes, but is need to avoid doing I2C work from irq_chip map().

Still it should be a separate patch, that's all I said. 

It can be documented that it is also necessary to support powerpcs
virq thing if at all.

> > 3) it breaks the driver. See http://lkml.org/lkml/2010/6/6/177 for a
> >    detailed explanation
> 
> I believe there is still a few things that needs to be discussed before
> that is closed.

Not with me. Period.

> > 4) the virq/powerpc churn is horrible and I bet there are sane ways to
> >    solve this, but it leave this to the powerpc experts.
> 
> Do you suggest that a seperate pca953x driver should be implemented for
> powerpc?  (I guess not).  Or do you say that the who irq handling in
> powerpc should be changed?
> 
> There must be an acceptable way to extend pca953x.c for the powerpc virq
> handling and get it accepted in the kernel.

Yes, there certainly is. I just think that there are cleaner ways,
that's why I defered that to the powerpc wizards.

Thanks,

	tglx
