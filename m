Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4320F68A8C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 05:55:21 +1100 (EST)
Date: Wed, 25 Jan 2006 10:55:18 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Yosemite/440EP is there a global interrupt enable mask?
Message-ID: <20060125185518.GB7425@gate.ebshome.net>
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu>
	<43D67AF6.6070403@ovro.caltech.edu> <200601251128.05370.sr@denx.de>
	<43D7C3C6.8020709@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43D7C3C6.8020709@ovro.caltech.edu>
Cc: Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2006 at 10:30:30AM -0800, David Hawkins wrote:
> 
> Hi Stephan,
> 
> > You seem to have used the wrong IRQ number though. Please see below.
> > 
> > You are using the "External IRQ 8". This results in IRQ number 19 of the 2nd 
> > interrupt controller of the 440ep. So please try (19+32) as the IRQ number 
> > upon requesting the interrupt.
> 
> Yep, that was it!
> 
> Now while looking at some of the other drivers, I noticed the use
> of the following syntax:
> 
>    unsigned long flags;
>    local_irq_save(flags);
> 
>    ... mfdcr, mtdcr, etc operations ...
> 
>    local_irq_restore(flags);
> 
> which is treating the operations on the DCRs as a critical section.
> 
> I should probably be doing the same when I enable the external IRQs
> and modify the GPIO registers.

You have to use locks if you access GPIO registers, because other bits 
can be used by other device drivers, although there is no drivers in 
the official tree which use GPIO (I have tons of them in my private 
tree and I added global "gpio_lock" to serialize GPIO access).

DCRs are a little different, there are separate DCR for different 
peripherals, so generally, you don't have to use locks, because those 
DCR accesses are implicitly bound to particular device anyway and 
device "owns" them.

-- 
Eugene
