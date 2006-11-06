Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD32867CCE
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 12:01:56 +1100 (EST)
Subject: Re: [PATCH/RFC] Hookable IO operations #3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200611060038.07117.arnd@arndb.de>
References: <1162710572.28571.225.camel@localhost.localdomain>
	<200611060038.07117.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 12:01:47 +1100
Message-Id: <1162774908.28571.264.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Why do you write stuff like
> 
> if (pointer != NULL) ?
> 
> It looks really pointless, since the existence of the object
> is already a well-understood conditional.

I've always preferred an explicit comparison to 0 or NULL rather
than if (pointer)... I can't explain why though :-) I also think
I'm not alone, do a grep "!= NULL" kernel/* :)

> > +static inline void iosync(void)
> > +{
> > +        __asm__ __volatile__ ("sync" : : : "memory");
> > +}
> 
> It's way more common to write 'asm volatile' instead of
> '__asm__ __volatile__' now. It's also nicer on the eye.

It is. Those are things I haven't touched though, just moved around. I
could do that additional cleanup pass I suppose.

> > +	 */
> > +	ppc_pci_io.readb = iseries_readb;
> > +	ppc_pci_io.readw = iseries_readw;
> > +	ppc_pci_io.readl = iseries_readl;
> > +	ppc_pci_io.readw_be = iseries_readw_be;
> > +	ppc_pci_io.readl_be = iseries_readl_be;
> > +	ppc_pci_io.writeb = iseries_writeb;
> > +	ppc_pci_io.writew = iseries_writew;
> > +	ppc_pci_io.writel = iseries_writel;
> > +	ppc_pci_io.writew_be = iseries_writew_be;
> > +	ppc_pci_io.writel_be = iseries_writel_be;
> > +	ppc_pci_io.readsb = iseries_readsb;
> > +	ppc_pci_io.readsw = iseries_readsw;
> > +	ppc_pci_io.readsl = iseries_readsl;
> > +	ppc_pci_io.writesb = iseries_writesb;
> > +	ppc_pci_io.writesw = iseries_writesw;
> > +	ppc_pci_io.writesl = iseries_writesl;
> > +	ppc_pci_io.memset_io = iseries_memset_io;
> > +	ppc_pci_io.memcpy_fromio = iseries_memcpy_fromio;
> > +	ppc_pci_io.memcpy_toio = iseries_memcpy_toio;
> 
> I guess it would be slightly more readable and more space
> efficient to write this as 
> 
> static struct ppc_pci_io __initdata iseries_pci_io = {
> 	.readb = iseries_readb;
> 	.readw = iseries_readw;
> 	.readl = iseries_readl;
> 	.readw_be = iseries_readw_be;
> 	.readl_be = iseries_readl_be;
> 	.writeb = iseries_writeb;
> 	.writew = iseries_writew;
> 	.writel = iseries_writel;
> 	.writew_be = iseries_writew_be;
> 	.writel_be = iseries_writel_be;
> 	.readsb = iseries_readsb;
> 	.readsw = iseries_readsw;
> 	.readsl = iseries_readsl;
> 	.writesb = iseries_writesb;
> 	.writesw = iseries_writesw;
> 	.writesl = iseries_writesl;
> 	.memset_io = iseries_memset_io;
> 	.memcpy_fromio = iseries_memcpy_fromio;
> 	.memcpy_toio = iseries_memcpy_toio;
> };
> ppc_pci_io = iseries_pci_io;

Indeed.

Thanks.
Ben.
