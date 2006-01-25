Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7E2C668A5A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jan 2006 05:32:40 +1100 (EST)
Message-ID: <43D7C3C6.8020709@ovro.caltech.edu>
Date: Wed, 25 Jan 2006 10:30:30 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Yosemite/440EP is there a global interrupt enable mask?
References: <43CC3E37.4040707@softadvances.com>
	<43D66D06.9090904@ovro.caltech.edu>
	<43D67AF6.6070403@ovro.caltech.edu> <200601251128.05370.sr@denx.de>
In-Reply-To: <200601251128.05370.sr@denx.de>
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


Hi Stephan,

> You seem to have used the wrong IRQ number though. Please see below.
> 
> You are using the "External IRQ 8". This results in IRQ number 19 of the 2nd 
> interrupt controller of the 440ep. So please try (19+32) as the IRQ number 
> upon requesting the interrupt.

Yep, that was it!

Now while looking at some of the other drivers, I noticed the use
of the following syntax:

   unsigned long flags;
   local_irq_save(flags);

   ... mfdcr, mtdcr, etc operations ...

   local_irq_restore(flags);

which is treating the operations on the DCRs as a critical section.

I should probably be doing the same when I enable the external IRQs
and modify the GPIO registers.

Any comments on that?

Dave
