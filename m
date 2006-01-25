Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3D20668A8F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 06:48:52 +1100 (EST)
Message-ID: <43D7D5A1.70704@ovro.caltech.edu>
Date: Wed, 25 Jan 2006 11:46:41 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Yosemite/440EP is there a global interrupt enable mask?
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu>
	<43D67AF6.6070403@ovro.caltech.edu> <200601251128.05370.sr@denx.de>
	<43D7C3C6.8020709@ovro.caltech.edu>
	<20060125185518.GB7425@gate.ebshome.net>
In-Reply-To: <20060125185518.GB7425@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Eugene,

>>Now while looking at some of the other drivers, I noticed the use
>>of the following syntax:
>>
>>   unsigned long flags;
>>   local_irq_save(flags);
>>
>>   ... mfdcr, mtdcr, etc operations ...
>>
>>   local_irq_restore(flags);
>>
>>which is treating the operations on the DCRs as a critical section.
>>
>>I should probably be doing the same when I enable the external IRQs
>>and modify the GPIO registers.
> 
> You have to use locks if you access GPIO registers, because other bits 
> can be used by other device drivers, although there is no drivers in 
> the official tree which use GPIO (I have tons of them in my private 
> tree and I added global "gpio_lock" to serialize GPIO access).

What kind of global lock; a spinlock?

What is the advantage of say using the gpio_lock, rather than
the irq_save/restore sequence above - which is what is used in
the emac and usb code?

> DCRs are a little different, there are separate DCR for different 
> peripherals, so generally, you don't have to use locks, because those 
> DCR accesses are implicitly bound to particular device anyway and 
> device "owns" them.

Right, but I was accessing the DCR for the UIC status register,
which, I assume, is also used by the Linux IRQ handling subsystem.

Well, ok perhaps that is not a good example, I have not tested
whether the IRQ handler in the example code I posted needs to
clear the UIC1_SR bit, or whether the Linux IRQ handling code
already takes care of it. I suspect the latter, since the IRQ
could be shared, and Linux needs to go through and call all
handlers on that IRQ line.

But in a debug context of reading those registers, I would
expect some form of lock holding would be recommended.
Do you happen to know if the Linux IRQ handling code uses a
lock?

I'm just learning, so feel free to enlighten me.

What drivers do you have in your 'private' tree that you might
be willing to share?

I'm planning on putting the 440EP on custom boards with a
number of Altera FPGAs located in the peripheral bus. I'll
post results and code as I go. Ulimately I'll open-source
the lot (hardware and all).

Here's the existing hardware I'm revising:
http://www.ovro.caltech.edu/~dwh/correlator

Cheers
Dave
