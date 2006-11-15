Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CAC9E67D7F
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:31:49 +1100 (EST)
Subject: Re: [PATCH 3/16] add base support for Celleb platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20061115183621.GB21633@lst.de>
References: <200611150931.kAF9VciJ023243@toshiba.co.jp>
	<20061115183621.GB21633@lst.de>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 10:31:37 +1100
Message-Id: <1163633498.5940.272.camel@localhost.localdomain>
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

On Wed, 2006-11-15 at 19:36 +0100, Christoph Hellwig wrote:
> On Wed, Nov 15, 2006 at 06:31:36PM +0900, Ishizaki Kou wrote:
> > diff -u linux-2.6.19/arch/powerpc/kernel/udbg.c:1.1.1.1 linux-2.6.19/arch/powerpc/kernel/udbg.c:1.2
> > --- linux-2.6.19/arch/powerpc/kernel/udbg.c:1.1.1.1	Fri Oct  6 10:40:04 2006
> > +++ linux-2.6.19/arch/powerpc/kernel/udbg.c	Fri Oct  6 12:26:35 2006
> > @@ -45,6 +45,8 @@
> >  #elif defined(CONFIG_PPC_EARLY_DEBUG_ISERIES)
> >  	/* For iSeries - hit Ctrl-x Ctrl-x to see the output */
> >  	udbg_init_iseries();
> > +#elif defined(CONFIG_PPC_EARLY_DEBUG_BEAT)
> > +	udbg_init_debug_beat();
> >  #endif
> 
> At some point we should make this a machvec pointer :)

Except that we call the early debug init before we probe the boards,
which is why it's a special debug option and not always enabled.

> So another platforms directory.  I think we need to sort out the
> mess we have currently.
> 
> I'd prefer either
> 
>   arch/powerpc/platforms/cell		generic cell code (spufs, ..)

That should actually go in kernel/ and sysdev/ imho

>   arch/powerpc/platforms/ibmcell	cell blade & co support
>   arch/powerpc/platforms/ps3hv		Sony hypervisor support
>   arch/powerpc/platforms/celleb		Toshiba

I'm ok with separate platform directories for different HVs like Toshiba
and Sony. I'm not sure we need to keep ibmcell only in the first dir
tho, could be cellnative for all native cell (non-HV) implementations.

It's unclear to me wether things like the cell RAS bits, or the iic
controller etc... shoud be in platform/cellnative or sysdev/
 
> 
> > +static void beat_lpar_hpte_updateboltedpp(unsigned long newpp,
> > +					  unsigned long ea,
> > +					  int psize)
> > +{
> 
> All this htab code should go into a separate file, e.g.
> 
> arch/powerpc/mm/hash_beat.c

Currently, we put platfotm-specific htab code in the corresponding
platform dirs. That's what pSeries LPAR and iSeries do. There are
arguments pro and con for both ways, but that's how we do now. However,
I agree that it could be a spearate file

Ben. 
