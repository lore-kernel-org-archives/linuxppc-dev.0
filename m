Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 9ED9F67B99
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 07:08:06 +1100 (EST)
Message-ID: <456F3A16.7070204@freescale.com>
Date: Thu, 30 Nov 2006 14:07:50 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: 2 PCI devices behind PCI bridge on Yosemite board.
References: <406A31B117F2734987636D6CCC93EE3C99D6F2@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C99D6F2@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Balajee Premraj <balajee@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Leonid wrote:
> Problem starts when I work with Dreamchip. Interrupt arrives from it and
> kernel doesn't know what to do with this interrupt and it gets disabled.
> Looks like interrupt doesn't get acknowledged properly.
> 
> I tried to register Dreamchip PCI device by 2 ways:
> 
> 1) I request interrupt and provide as interrupt handler empty function:
> 
> irqreturn_t snd_dream_interrupt(int irq, void *dev_id, struct pt_regs
> *regs)
> {
> 	return IRQ_NONE;
> }

You didn't deal with the source of the interrupt.  Since it's apparently 
level-triggered, the interrupt just comes right back.

> 2) Because I don't need interrupt from Dreamchip anyway, I tried don't
> request interrupt upon Dreamchip PCI driver registration. Result was the
> same though kernel output different:

Not requesting the IRQ doesn't stop the device from asserting it.

> Any ideas what I have done wrong? Can I just tell to the bridge don't
> interrupt CPU if Dreamchip is interrupting?

No, because both devices share the same physical IRQ line.  The PIC 
can't tell which device is asserting it.  You need to either provide a 
real IRQ handler for the Dreamchip, or tell the Dreamchip itself to mask 
the IRQ.

-Scott
