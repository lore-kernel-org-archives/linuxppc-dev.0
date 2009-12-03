Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 1B87FB70B3
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 04:37:18 +1100 (EST)
Message-ID: <4B17F14A.1060001@ovro.caltech.edu>
Date: Thu, 03 Dec 2009 09:11:38 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Jeff Hane <jeff.hane@maxim-ic.com>
Subject: Re: PCI interrupt question
References: <1259821316.12651.26.camel@qu102.quarc.com>
In-Reply-To: <1259821316.12651.26.camel@qu102.quarc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jeff,

>  I'm trying to get interrupts working for my PCI device on a 460ex and
> am having problem.  My ISR never triggers.
> 
> I'm new to PCI(and ppc) and LDD said that I could read the config reg
> INTURRUPT_LINE to get the interrupt assigned to my PCI device.  Well,
> this always reads zero. 
> 
> After reading through the code it appears that the interrupt is being
> assigned after reading some information out of the device tree and then
> filling in the irg in the pci_dev structure.  
> 
> I'm just looking for confirmation that I should be calling request_irq
> with the irq that I found in the pci_dev struct.

Can you clarify:

1. 460EX is your PCI host CPU?

2. You have some PCI device - what? Have you tested it works in a
    standard PCI bus? Eg. ran lspci from an x86 host.

3. When your host processor boots, it assigns the PCI resources.
    On an x86, its the BIOS that assigns the PCI addresses and IRQs
    on the PCI devices. For your 460EX, it could be your bootloader,
    or it could be your host OS (Linux).

4. If you boot Linux on your 460EX and run lspci, and the device
    configuration space register for the IRQ line is 0, then your
    host has not setup the PCI interface on your device correctly.

5. Once you have the PCI IRQ assigned to the device correctly,
    you need to know which IRQ line on the host this corresponds to.
    I'm pretty sure that needs to be described in the DTS as
    commented by Stefan.

These comments might not be 100% correct, but the list of things
to check should be close enough for you to track down your
problem.

Cheers,
Dave
