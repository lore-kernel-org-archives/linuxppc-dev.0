Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 7C9B3DDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Mar 2007 19:48:07 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: PPC405EP Custom Board. Question for PCI init.
Date: Fri, 9 Mar 2007 09:49:29 +0100
References: <45F03501.4040902@googlemail.com>
In-Reply-To: <45F03501.4040902@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703090949.30172.sr@denx.de>
Cc: powerpc440 <powerpc440@googlemail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 08 March 2007 17:08, powerpc440 wrote:
> /* Some IRQs unique to the board
>  * Used by the generic 405 PCI setup functions in ppc4xx_pci.c
>  */
> int __init
> ppc405_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
> {
>     static char pci_irq_table[][4] =
>         /*
>          *      PCI IDSEL/INTPIN->INTLINE
>          *      A       B       C       D
>          */
>     {
>         /*{25, 26, 27, 28},    *//* IDSEL 1 - PCI slot 1 */
>         /*{26, 27, 28, 25},    *//* IDSEL 2 - PCI slot 2 */
>     };
>
>     const long min_idsel = 6, max_idsel = 7, irqs_per_slot = 4;
>     return PCI_IRQ_TABLE_LOOKUP;
> };
>
> My question is what exactly means these values {25, 26, 27, 28},

Those are the interrupt numbers. Please take a look at the 405EP users manual 
and read the description of the UIC and it's external interrupts. In your 
board design you most likely have connected the PCI interrupts to some 
external PPC interrupts, right? This configuration is totally board 
dependant. And please don't forget to configure the external interrupts 
correctly (level, edge...).

> and how 
> I can determinate and complete the correct config for my board.
> The PCI slot IDSEL pin is connected to PCI_AD11 (CPU);
> SATA IDSEL - to PCI_AD12;
> USB IDSEL - to PCI_AD13

Since I can't remember how to "calculate" the idsel number from the connected 
AD signal, I'm just adding a printk() in this function to point the idsel 
number here.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
=====================================================================
