Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 42D03B7B66
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 07:07:17 +1100 (EST)
Date: Thu, 3 Dec 2009 11:44:26 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Jeff Hane <jeff.hane@maxim-ic.com>
Subject: Re: PCI interrupt question
Message-ID: <20091203194426.GA16874@ovro.caltech.edu>
References: <1259821316.12651.26.camel@qu102.quarc.com>
	<4B17F14A.1060001@ovro.caltech.edu>
	<1259869140.18190.52.camel@qu102.quarc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1259869140.18190.52.camel@qu102.quarc.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 03, 2009 at 11:39:00AM -0800, Jeff Hane wrote:
> On Thu, 2009-12-03 at 09:11 -0800, David Hawkins wrote:
> > Hi Jeff,
> > 
> > >  I'm trying to get interrupts working for my PCI device on a 460ex and
> > > am having problem.  My ISR never triggers.
> > > 
> > > I'm new to PCI(and ppc) and LDD said that I could read the config reg
> > > INTURRUPT_LINE to get the interrupt assigned to my PCI device.  Well,
> > > this always reads zero. 
> > > 
> > > After reading through the code it appears that the interrupt is being
> > > assigned after reading some information out of the device tree and then
> > > filling in the irg in the pci_dev structure.  
> > > 
> > > I'm just looking for confirmation that I should be calling request_irq
> > > with the irq that I found in the pci_dev struct.
> > 
> > Can you clarify:
> > 
> > 1. 460EX is your PCI host CPU?
> 
> yes.  We are using a canyonlands board with 460ex.
> 
> > 
> > 2. You have some PCI device - what? Have you tested it works in a
> >     standard PCI bus? Eg. ran lspci from an x86 host.
> 
> It is a FPGA board that we are using to develop a video codec/SOC.  We
> have not connected it an x86; however, we know the the PCI interface is
> working because we can talk to the FPGA board.
> 
> > 
> > 3. When your host processor boots, it assigns the PCI resources.
> >     On an x86, its the BIOS that assigns the PCI addresses and IRQs
> >     on the PCI devices. For your 460EX, it could be your bootloader,
> >     or it could be your host OS (Linux).
> 
> We are using the vanilla versions of u-boot and linux for the
> canyonlands boards and have made few changes and definitely not to the
> PCI setup.
> 
> > 
> > 4. If you boot Linux on your 460EX and run lspci, and the device
> >     configuration space register for the IRQ line is 0, then your
> >     host has not setup the PCI interface on your device correctly.
> >
> > 5. Once you have the PCI IRQ assigned to the device correctly,
> >     you need to know which IRQ line on the host this corresponds to.
> >     I'm pretty sure that needs to be described in the DTS as
> >     commented by Stefan.
> > 
> 
>  So are you saying linux should be writing the irq number to the
> INTERRUPT_LINE config reg?  This is what I expected but I do not see
> it.  
>  I believe the DTS is being parsed properly and the connection is made
> to the correct interrupt line on the device.  But somebody still needs
> to assign and IRQ number, right?  This is the part that is not clear,
> there is an irq field in pci_dev structure which is filled in after
> looking at the DTS and I just want to be sure this is the irq number to
> be used when calling request_irq.
> 

Last time I checked, Linux did not write the assigned IRQ to the card's
PCI configuration space. However, the struct pci_dev irq member
contained the correct value. You should be using the value from the
structure for request_irq(). That's how all PCI drivers I've ever seen
work.

Ira
