Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D77C467C48
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Aug 2006 02:08:07 +1000 (EST)
In-Reply-To: <20060824125206.18305.qmail@web36612.mail.mud.yahoo.com>
References: <20060824125206.18305.qmail@web36612.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E6E785F-7282-45EA-99C9-E77A82D4577B@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: MPC8555 PCI interrupts are not coming
Date: Fri, 25 Aug 2006 11:08:05 -0500
To: Parav Pandit <paravpandit@yahoo.com>
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


On Aug 24, 2006, at 07:52, Parav Pandit wrote:

> Hi,
>
> Can someone give light on PCI interrupts routing to the OS from the  
> openPIC?


The routing depends on your board.  On the CDS board, PCI interrupts  
are mapped to ext[0-3].  On the ADS, they are mapped to ext[1-4].   
There are four PCI interrupts (A,B,C,D), and they are usually  
swizzled so that different slots have a different mapping (this way,  
two cards in different slots which use interrupt A don't conflict).


>
> Basically I am able to talk to PCI end device connected on MPC8555  
> board in 2.6.13 but not getting interrupts reported by my device.
>
> When I read the INTERRUPT_LINE byte, it comes as 0. pdev->irq is  
> also reporting 0.
> Due to that request_irq() fails. But now I request for IRQ line 8 +  
> openPIC offset.
> Handler gets registered but still not getting the interrupts. (PCI  
> interrupt line is 8,9 in case of MPC8555).


When are you trying to read the interrupt_line byte?  In 2.6.13, you  
need to have an IRQ mapping function, which takes the idsel reported  
by the slot, and converts it to the interrupt number for the PIC.   
That code also writes the INTERRUPT_LINE byte.


>
> Can anyone please guide me, what are the different things need be  
> configure in the platform code to receive the PCI interrupts in the  
> driver?
>
> I don't understand the pci_irq_table, and what it should represent?
> Currrently no one is writing the INTERRUPT LINE value in the config  
> space.
> In which function I should configure that value? pcibios_fixup??
>
> Regards,
> Parav Pandit
>
>
> Do you Yahoo!?
> Get on board. You're invited to try the new Yahoo! Mail.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
