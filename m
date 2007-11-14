Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EFA1DDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 14:43:30 +1100 (EST)
Subject: Re: [PATCH 2/2] PowerPC: make 4xx uic use generic edge and level
	irq handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20071114021326.GB19378@localhost.localdomain>
References: <20071113201559.GA26172@ru.mvista.com>
	<20071113202731.GA26319@ru.mvista.com>
	<20071114021326.GB19378@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Nov 2007 14:43:16 +1100
Message-Id: <1195011796.28865.28.camel@pasglop>
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


On Wed, 2007-11-14 at 13:13 +1100, David Gibson wrote:
> Hrm.  I *think* I'm convinced this is safe, although acking in a
> callback which doesn't say it acks is rather yucky.  Essentially this
> code is trading flow readability (because just reading
> handle_level_irq will tell you something other than what it does in
> our case) for smaller code size.  I'm not sure if this is a good trade
> or not.
> 
> There's also one definite problem: according to the discussions I had
> with Thomas Gleixner when I wrote uic.c, handle_edge_irq is not what
> we want for edge interrupts.
> 
> Apparently handle_edge_irq is only for edge interrupts on "broken"
> PICs which won't latch new interrupts while the irq is masked.  UIC is
> not in this category, so handle_level_irq is actually what we want,
> even for an edge irq.
> 
> Yes, I thought the naming was more than a little confusing, too.

Hrm... handle_edge_irq works for both and you have a small performance
benefit in not masking, and thus using handle_edge_irq, so I don't
totally agree here. Basically, what handle_edge_irq() does is lazy
masking. Now there -is- an issue here is that if you do lazy masking,
you need to be able to re-emit in some convenient way.

Ben.
