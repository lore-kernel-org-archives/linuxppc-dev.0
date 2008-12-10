Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07126DDF76
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 06:06:40 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBAJ6C0i030389
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 14:06:12 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBAJ6a9i154186
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 14:06:36 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBAJ6Z1T001337
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 14:06:36 -0500
Date: Wed, 10 Dec 2008 14:06:30 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix build of 4xx simple platforms without
	CONFIG_PCI
Message-ID: <20081210140630.3dfaa9fd@zod.rchland.ibm.com>
In-Reply-To: <20081210092508.66e566f8@zod.rchland.ibm.com>
References: <20081208045411.0CE03DDE0E@ozlabs.org>
	<1228714329.23242.52.camel@localhost>
	<1228714694.7101.27.camel@pasglop>
	<20081210092508.66e566f8@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Dec 2008 09:25:08 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Mon, 08 Dec 2008 16:38:14 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > 
> > > > --- linux-work.orig/arch/powerpc/platforms/40x/ppc40x_simple.c	2008-12-08 15:51:49.000000000 +1100
> > > > +++ linux-work/arch/powerpc/platforms/40x/ppc40x_simple.c	2008-12-08 15:51:52.000000000 +1100
> > > > @@ -61,7 +61,9 @@ static int __init ppc40x_probe(void)
> > > >  
> > > >  	for (i = 0; i < ARRAY_SIZE(board); i++) {
> > > >  		if (of_flat_dt_is_compatible(root, board[i])) {
> > > > +#ifdef CONFIG_PCI
> > > >  			ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
> > > > +#endif
> > > 
> > > No! #ifdefs! in C code!
> > > 
> > > To the tune of you-know-what.
> > > 
> > > Looks like we need an accessor we can replace with an empty version in
> > > the !PCI case.
> > 
> > If you have plenty of time on your hands :-) In the meantime, this is a
> > build fix.
> 
> I have time.  I hate ifdefs.

Oh, and:
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048214.html

I told you so (sort of).  Ha!  ;)

josh
