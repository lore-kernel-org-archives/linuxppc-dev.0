Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C4F6B6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 18:32:08 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: PCI interrupt question
Date: Thu, 3 Dec 2009 08:31:58 +0100
References: <1259821316.12651.26.camel@qu102.quarc.com>
In-Reply-To: <1259821316.12651.26.camel@qu102.quarc.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200912030831.58528.sr@denx.de>
Cc: Jeff Hane <jeff.hane@maxim-ic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeff,

On Thursday 03 December 2009 07:21:56 Jeff Hane wrote:
>  I'm trying to get interrupts working for my PCI device on a 460ex and
> am having problem.  My ISR never triggers.

Which 460EX board is this? Canyonlands or some custom board?
 
> I'm new to PCI(and ppc) and LDD said that I could read the config reg
> INTURRUPT_LINE to get the interrupt assigned to my PCI device.  Well,
> this always reads zero.
> 
> After reading through the code it appears that the interrupt is being
> assigned after reading some information out of the device tree and then
> filling in the irg in the pci_dev structure.

Yes. The device tree has to describe the PCI interrupt layout.
 
> I'm just looking for confirmation that I should be calling request_irq
> with the irq that I found in the pci_dev struct.

Yes.

Canyonlands dts correctly describes the PCI interrupts assignments. If you 
have a custom 460EX board, then you probably have a different interrupt routed 
to the PCI slot. This needs to be described in your device tree file.
 
Cheers,
Stefan
