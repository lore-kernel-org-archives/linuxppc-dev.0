Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E5CDB7D40
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 21:41:25 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: ipic: use set_irq_chip to ensure irq_chip
	defaults are applied
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <alpine.LFD.2.00.1006071209140.2933@localhost.localdomain>
References: <cover.1275686504.git.eha@doredevelopment.dk>
	<1275686717.2970.13.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006070141230.2933@localhost.localdomain>
	<1275887175.2970.20.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006071209140.2933@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Jun 2010 21:41:05 +1000
Message-ID: <1275910865.31303.451.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Esben Haabendal <eha@doredevelopment.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-06-07 at 12:22 +0200, Thomas Gleixner wrote:

> > Would it be better to change the call order in __setup_irq(), and
> > call irq_chip_set_defaults after __irq_set_trigger() ?   Or perhaps
> > even calling it twice (again after __irq_set_trigger()) ?
> 
> Grmpf, set_type() was never meant to change the chip. It's fatal do
> so, as the code in setup_irq already has a reference to desc->chip and
> calls the wrong functions anyway aside of having not run through the
> set defaults code.
> 
> That needs more thought, as it requires to reload the reference.
> 
> Ben, any thoughts ?

Not off hand. It's common to have a different chip ops for different
types, so we need to sort that out. I'll try to have a look asap but I'm
really really swamped at the moment, so I can make no promise that I'll
come up with a solution tomorrow.

/me off to bed

Cheers,
Ben.
