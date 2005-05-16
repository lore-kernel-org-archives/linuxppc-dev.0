Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 08C05679F0
	for <linuxppc-dev@ozlabs.org>; Mon, 16 May 2005 16:25:35 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
References: <1116222720.5095.86.camel@gaston>
	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 16:22:48 +1000
Message-Id: <1116224569.5095.90.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'm interested to see if Paul is aware of any other embedded port 
> issues, since he mentioned the problem there.

Well, we need to dig out from the part of our memory containing things
we don't want to have to deal with anymore things details about the
booke, 4xx, 8xx, ... memory management :)
 
> Agreed, the other problem that comes up from time to time due to 
> io_block_mapping() that I've see is problem with modules not working 
> because the kernel doesn't think it has any vmalloc() space left.

How so ? Because we ioremap too much ? Well, that's an ooooold problem.
ppc32 PCI code for example goes at length trying to minimize the amount
of IO space mapped by PCI bridges (since IO space, unlike memory space,
on our current PCI implementation is permanently mapped in). With a
standard setup, we can only ioremap/vmalloc what is left between top of
memory and 1Gb ... Unless you force your lowmem limit to something lower
than the current limit which I think is 768Mb.

> > > I'm in agreement that we should bump TASK_SIZE to 3GB and fix things,
> > > how about after 2.6.12 is out?
> >
> > Agreed. I'll fix PReP/CHRP/pmac & defconfig. Every embedded board
> >  vendor/maintainer will be responsible for fixing his/her boards 
> > support.
> 
> Agreed.  We should probably send an email to linuxppc-embedded with a 
> more proper subject line to let people know.
> 
> - kumar
> 
