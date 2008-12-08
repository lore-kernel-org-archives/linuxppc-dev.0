Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EE02DDDF0
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Dec 2008 16:38:26 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix build of 4xx simple platforms without
	CONFIG_PCI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1228714329.23242.52.camel@localhost>
References: <20081208045411.0CE03DDE0E@ozlabs.org>
	<1228714329.23242.52.camel@localhost>
Content-Type: text/plain
Date: Mon, 08 Dec 2008 16:38:14 +1100
Message-Id: <1228714694.7101.27.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > --- linux-work.orig/arch/powerpc/platforms/40x/ppc40x_simple.c	2008-12-08 15:51:49.000000000 +1100
> > +++ linux-work/arch/powerpc/platforms/40x/ppc40x_simple.c	2008-12-08 15:51:52.000000000 +1100
> > @@ -61,7 +61,9 @@ static int __init ppc40x_probe(void)
> >  
> >  	for (i = 0; i < ARRAY_SIZE(board); i++) {
> >  		if (of_flat_dt_is_compatible(root, board[i])) {
> > +#ifdef CONFIG_PCI
> >  			ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
> > +#endif
> 
> No! #ifdefs! in C code!
> 
> To the tune of you-know-what.
> 
> Looks like we need an accessor we can replace with an empty version in
> the !PCI case.

If you have plenty of time on your hands :-) In the meantime, this is a
build fix.

Cheers,
Ben.
