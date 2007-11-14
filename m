Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7A7C0DDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:14:41 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id lAE2Dmmg019478
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:13:48 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAE2E0Qp2695372
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:14:00 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAE2DiTm027576
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 13:13:44 +1100
Date: Wed, 14 Nov 2007 13:13:26 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/2] PowerPC: make 4xx uic use generic edge and level
	irq handlers
Message-ID: <20071114021326.GB19378@localhost.localdomain>
References: <20071113201559.GA26172@ru.mvista.com>
	<20071113202731.GA26319@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071113202731.GA26319@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 13, 2007 at 11:27:31PM +0300, Valentine Barshak wrote:
> This patch makes PowerPC 4xx UIC use generic edge and level irq handlers
> instead of a custom handle_uic_irq() function. Acking a level irq on UIC
> has no effect if the interrupt is still asserted by the device, even if
> the interrupt is already masked. So, to really de-assert the interrupt
> we need to de-assert the external source first *and* ack it on UIC then.
> The handle_level_irq() function masks and ack's the interrupt with mask_ack
> callback prior to calling the actual ISR and unmasks it at the end.
> So, to use it with UIC level interrupts we need to ack in the unmask
> callback instead, after the ISR has de-asserted the external interrupt source.
> Even if we ack the interrupt that we didn't handle (unmask/ack it at
> the end of the handler, while next irq is already pending) it will not
> de-assert the irq, untill we de-assert its exteral source.

Hrm.  I *think* I'm convinced this is safe, although acking in a
callback which doesn't say it acks is rather yucky.  Essentially this
code is trading flow readability (because just reading
handle_level_irq will tell you something other than what it does in
our case) for smaller code size.  I'm not sure if this is a good trade
or not.

There's also one definite problem: according to the discussions I had
with Thomas Gleixner when I wrote uic.c, handle_edge_irq is not what
we want for edge interrupts.

Apparently handle_edge_irq is only for edge interrupts on "broken"
PICs which won't latch new interrupts while the irq is masked.  UIC is
not in this category, so handle_level_irq is actually what we want,
even for an edge irq.

Yes, I thought the naming was more than a little confusing, too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
