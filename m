Return-Path: <eha@doredevelopment.dk>
Received: from zmta01.irigo.dk (zmta01.cabocomm.dk [193.200.44.52])
	by ozlabs.org (Postfix) with ESMTP id 8B8F51007D3
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 15:50:28 +1000 (EST)
Subject: Re: [PATCH 2/2] gpio: pca953x: add powerpc irq support
From: Esben Haabendal <eha@doredevelopment.dk>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <alpine.LFD.2.00.1006070129530.2933@localhost.localdomain>
References: <cover.1275686504.git.eha@doredevelopment.dk>
	<1275686731.2970.14.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006070129530.2933@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Jun 2010 07:50:20 +0200
Message-ID: <1275889820.2970.63.camel@eha.doredevelopment.dk>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-06-07 at 01:39 +0200, Thomas Gleixner wrote: 
> On Fri, 4 Jun 2010, Esben Haabendal wrote:
> 
> NAK for various reasons (no particular order):

Ok. I can address 1 and 2, and I believe 3 is still under discussion, at
least as far as I am concerned.

> 1) That patch misses a sensible changelog. See Documentation/Submit*

I will address that.

> 2) patch contains several independent changes, which need to be separated

I will send a split up patch series. That is, if there is any chance
that it will be ACK'ed.  No need to waste time on it if it is dead
NAK'ed before arriving to list.

> > @@ -120,6 +124,10 @@ static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
> >  	chip = container_of(gc, struct pca953x_chip, gpio_chip);
> >  
> >  	reg_val = chip->reg_direction | (1u << off);
> > +
> > +	if (reg_val == chip->reg_direction)
> > +		return 0;
> > +
> 
>  This is an optimization of its own value.

Yes, but is need to avoid doing I2C work from irq_chip map().

> 3) it breaks the driver. See http://lkml.org/lkml/2010/6/6/177 for a
>    detailed explanation

I believe there is still a few things that needs to be discussed before
that is closed.

> 4) the virq/powerpc churn is horrible and I bet there are sane ways to
>    solve this, but it leave this to the powerpc experts.

Do you suggest that a seperate pca953x driver should be implemented for
powerpc?  (I guess not).  Or do you say that the who irq handling in
powerpc should be changed?

There must be an acceptable way to extend pca953x.c for the powerpc virq
handling and get it accepted in the kernel.

/Esben
