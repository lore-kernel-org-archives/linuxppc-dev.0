Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6F5BB7D66
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jun 2010 16:59:12 +1000 (EST)
Date: Tue, 8 Jun 2010 08:58:41 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [RFC][PATCH] irq: support IRQ_NESTED_THREAD with non-threaded
	interrupt handlers
In-Reply-To: <AANLkTilPhof5cnhBCXSzKJSnWl6Vuu2fRts2pBBBNl6K@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1006080853220.2933@localhost.localdomain>
References: <1275686352.2970.2.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006042343150.2933@localhost.localdomain>
	<AANLkTilb7---Qg1oLwzanKP1RGe04fkAXDtZzz0w9MGz@mail.gmail.com>
	<20100605151031.2d562268@hina.wild-wind.fr.eu.org>
	<alpine.LFD.2.00.1006051732270.2933@localhost.localdomain>
	<AANLkTimlSBEhl58CNuScKjxbqdTwTYgqo7vrHTcd1x9G@mail.gmail.com>
	<alpine.LFD.2.00.1006051915290.2933@localhost.localdomain>
	<AANLkTimcB9vRqnNYyBh6hjHXZHcmFvw72MZUEIGfeexq@mail.gmail.com>
	<alpine.LFD.2.00.1006052155100.2933@localhost.localdomain>
	<AANLkTik2so7osQJFq6NRaIFK2GVLURVozOqSsejd1K0F@mail.gmail.com>
	<alpine.LFD.2.00.1006062228120.2933@localhost.localdomain>
	<1275914058.2818.8.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006071440520.2933@localhost.localdomain>
	<AANLkTilPhof5cnhBCXSzKJSnWl6Vuu2fRts2pBBBNl6K@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: joachim.eastwood@jotron.com, Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Esben Haabendal <eha@doredevelopment.dk>,
	linuxppc-dev@ozlabs.org, Marc Zyngier <maz@misterjones.org>,
	Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 7 Jun 2010, Esben Haabendal wrote:

> On Mon, Jun 7, 2010 at 5:06 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Maybe you understand now, why I was pretty sure upfront, that your
> > approach was wrong even without knowing all the gory details ? :)
> 
> I understand.  There is a better solution, which is to use threaded
> interrupts where needed.

FWIW, it just occured to me, that the only reason why the
disable_irq_nosysnc() trips up on the in_atomic() check is your
fiddling with the nested irq dispatcher. 

If you just would have changed the phy driver to
request_irq_any_context() it would have simply worked out of the box,
without any need to remove buslock and changing genirq code at all.

That would not give you the advantage of getting rid of the two
additional I2C transfers, but that's nn optimzation not a functional
requirement.

Thanks,

	tglx
