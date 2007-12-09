Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84D18DDDEE
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 17:58:49 +1100 (EST)
Subject: Re: [PATCH 16/25] powerpc: EP405 boards support for arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071206210550.520e5131@zod.rchland.ibm.com>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080127.1F2ACDDED0@ozlabs.org>
	<20071206210550.520e5131@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Dec 2007 17:57:47 +1100
Message-Id: <1197183467.6572.4.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-12-06 at 21:05 -0600, Josh Boyer wrote:
> On Thu, 06 Dec 2007 19:00:15 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > Index: linux-work/arch/powerpc/boot/dts/ep405.dts
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-work/arch/powerpc/boot/dts/ep405.dts	2007-12-03 12:58:45.000000000 +1100
> > @@ -0,0 +1,221 @@
> > +/*
> > + * Device Tree Source for EP405
> > + *
> > + * Copyright 2007 IBM Corp.
> > + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> I still don't think I wrote this ;)

Yeah, right, I'll fix that, easy enough.


 .../...

> > +	if (!machine_is(ep405))
> > +		return 0;
> > +
> > +	/* FIXME: do bus probe here */
> 
> I should really remove this stupid FIXME from my files so people stop
> copying it into theirs ;)

Yup :-) Your fault ;-)

  .../...

> > +	/* Find the bloody thing & map it */
> > +	bcsr_node = of_find_compatible_node(NULL, NULL, "ep405-bcsr");
> > +	if (bcsr_node == NULL) {
> > +		printk(KERN_ERR "EP405 BCSR not found !\n");
> > +		return;
> > +	}
> > +	bcsr_regs = of_iomap(bcsr_node, 0);
> > +	if (bcsr_regs == NULL) {
> > +		printk(KERN_ERR "EP405 BCSR failed to map !\n");
> > +		return;
> > +	}
> 
> Is there a reason you have bcsr_node and bcsr_regs as static globals
> and leave the mapping present?  I can't see another use of them outside
> of this function, which only gets called once.

For future use mostly. There's truckloads of things on this board going
trough this FPGA and It's likely that a more complete port will need to
use this things. In fact, the CPLD can more/less be used as a cascaded
IRQ on the PCI interrupts on that thing.

Ben.
