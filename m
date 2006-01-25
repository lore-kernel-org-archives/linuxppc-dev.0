Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EF38C68A62
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 07:13:22 +1100 (EST)
Date: Wed, 25 Jan 2006 12:13:20 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Yosemite/440EP is there a global interrupt enable mask?
Message-ID: <20060125201320.GB19460@gate.ebshome.net>
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu>
	<43D67AF6.6070403@ovro.caltech.edu> <200601251128.05370.sr@denx.de>
	<43D7C3C6.8020709@ovro.caltech.edu>
	<20060125185518.GB7425@gate.ebshome.net>
	<43D7D5A1.70704@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43D7D5A1.70704@ovro.caltech.edu>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2006 at 11:46:41AM -0800, David Hawkins wrote:
> Hi Eugene,
> 
> >>Now while looking at some of the other drivers, I noticed the use
> >>of the following syntax:
> >>
> >>  unsigned long flags;
> >>  local_irq_save(flags);
> >>
> >>  ... mfdcr, mtdcr, etc operations ...
> >>
> >>  local_irq_restore(flags);
> >>
> >>which is treating the operations on the DCRs as a critical section.
> >>
> >>I should probably be doing the same when I enable the external IRQs
> >>and modify the GPIO registers.
> >
> >You have to use locks if you access GPIO registers, because other bits 
> >can be used by other device drivers, although there is no drivers in 
> >the official tree which use GPIO (I have tons of them in my private 
> >tree and I added global "gpio_lock" to serialize GPIO access).
> 
> What kind of global lock; a spinlock?

yes, spinlock.

> What is the advantage of say using the gpio_lock, rather than
> the irq_save/restore sequence above - which is what is used in
> the emac and usb code?

emac doesn't use GPIO registers :). Also, if there is no IRQ code 
accesses GPIO registers, you don't need IRQ disabling lock, and 
spin_lock effectively becomes just a preemption lock. Personally, I use 
spinlocks just out of habit, I think it's a good style, even if you 
know your chip doesn't support SMP (but some day might :).

> >DCRs are a little different, there are separate DCR for different 
> >peripherals, so generally, you don't have to use locks, because those 
> >DCR accesses are implicitly bound to particular device anyway and 
> >device "owns" them.
> 
> Right, but I was accessing the DCR for the UIC status register,
> which, I assume, is also used by the Linux IRQ handling subsystem.

DO NOT access UIC registers directly. DO NOT.

> Well, ok perhaps that is not a good example, I have not tested
> whether the IRQ handler in the example code I posted needs to
> clear the UIC1_SR bit, or whether the Linux IRQ handling code
> already takes care of it. I suspect the latter, since the IRQ
> could be shared, and Linux needs to go through and call all
> handlers on that IRQ line.
> 
> But in a debug context of reading those registers, I would
> expect some form of lock holding would be recommended.
> Do you happen to know if the Linux IRQ handling code uses a
> lock?

4xx IRQ code takes care of all this. You don't need to mess with UIC 
registers. 4xx PIC code doesn't use locks because it's being called 
from special context (IRQs disabled), 4xx doesn't support SMP and PIC 
code "owns" those DCRs.

> I'm just learning, so feel free to enlighten me.
> 
> What drivers do you have in your 'private' tree that you might
> be willing to share?

Nothing that can be of interest for a general public. They are 
board-specific (lots of bit-banging SPI stuff). All other drivers I 
wrote are already in public tree.

-- 
Eugene
