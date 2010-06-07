Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48EFAB7D16
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 20:23:05 +1000 (EST)
Date: Mon, 7 Jun 2010 12:22:53 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Esben Haabendal <eha@doredevelopment.dk>
Subject: Re: [PATCH 1/2] powerpc: ipic: use set_irq_chip to ensure irq_chip
	defaults are applied
In-Reply-To: <1275887175.2970.20.camel@eha.doredevelopment.dk>
Message-ID: <alpine.LFD.2.00.1006071209140.2933@localhost.localdomain>
References: <cover.1275686504.git.eha@doredevelopment.dk>
	<1275686717.2970.13.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006070141230.2933@localhost.localdomain>
	<1275887175.2970.20.camel@eha.doredevelopment.dk>
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

> On Mon, 2010-06-07 at 01:45 +0200, Thomas Gleixner wrote:
> 
> > This patch has never been tested with spinlock debugging enabled and
> > will break SMP as it causes a deadlock on irq_desc->lock.
> > 
> > Again: See Documentation/Submit*
> 
> Ok, will do so.
> 
> But do you see the problem?  In __setup_irq(), irq_chip_set_defaults()
> is called first, and then __irq_set_trigger(), which calls
> chip->set_type(). When you request an edge irq with ipic, you get the
> defaults applied to ipic_level_irq_chip, and then it sets
> ipic_edge_irq_chip, which now is missing startup(), enable(), and so
> on.
> 
> Would it be better to change the call order in __setup_irq(), and
> call irq_chip_set_defaults after __irq_set_trigger() ?   Or perhaps
> even calling it twice (again after __irq_set_trigger()) ?

Grmpf, set_type() was never meant to change the chip. It's fatal do
so, as the code in setup_irq already has a reference to desc->chip and
calls the wrong functions anyway aside of having not run through the
set defaults code.

That needs more thought, as it requires to reload the reference.

Ben, any thoughts ?

Thanks,

	tglx
