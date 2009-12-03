Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id B7BC6B7C51
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 06:59:10 +1100 (EST)
Date: Thu, 3 Dec 2009 11:59:08 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: PCI interrupt question
Message-ID: <20091203195908.GA17100@ovro.caltech.edu>
References: <1259821316.12651.26.camel@qu102.quarc.com>
	<4B17F14A.1060001@ovro.caltech.edu>
	<1259869140.18190.52.camel@qu102.quarc.com>
	<4B1816F9.1020601@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B1816F9.1020601@ovro.caltech.edu>
Cc: Jeff Hane <jeff.hane@maxim-ic.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 03, 2009 at 11:52:25AM -0800, David Hawkins wrote:
> Hi Jeff,
> 
> > yes.  We are using a canyonlands board with 460ex.
> 
> Ok.
> 
> >> 2. You have some PCI device - what? Have you tested it works in a
> >>     standard PCI bus? Eg. ran lspci from an x86 host.
> > 
> > It is a FPGA board that we are using to develop a video codec/SOC.  We
> > have not connected it an x86; however, we know the the PCI interface is
> > working because we can talk to the FPGA board.
> 
> Ok, so that means the BARs are setup.
> 
> >> 3. When your host processor boots, it assigns the PCI resources.
> >>     On an x86, its the BIOS that assigns the PCI addresses and IRQs
> >>     on the PCI devices. For your 460EX, it could be your bootloader,
> >>     or it could be your host OS (Linux).
> > 
> > We are using the vanilla versions of u-boot and linux for the
> > canyonlands boards and have made few changes and definitely not to the
> > PCI setup.
> > 
> >> 4. If you boot Linux on your 460EX and run lspci, and the device
> >>     configuration space register for the IRQ line is 0, then your
> >>     host has not setup the PCI interface on your device correctly.
> 
> So what does the output of lspci look like?
> 
> >> 5. Once you have the PCI IRQ assigned to the device correctly,
> >>     you need to know which IRQ line on the host this corresponds to.
> >>     I'm pretty sure that needs to be described in the DTS as
> >>     commented by Stefan.
> >>
> > 
> >  So are you saying linux should be writing the irq number to the
> > INTERRUPT_LINE config reg?  This is what I expected but I do not see
> > it.
> 
> Yes. U-Boot or Linux needs to configure the PCI interface.
> The output of lspci, or a logic analyzer trace of the PCI
> activity on boot would help tell you what is happening.
> 
> > I believe the DTS is being parsed properly and the connection is made
> > to the correct interrupt line on the device. 
> 
> Right, so if someone asserted the interrupt the host would
> understand it was from the PCI system.
> 
> > But somebody still needs to assign and IRQ number, right? 
> 
> Yep. It might require enabling a PCI subsystem in U-Boot.
> I recall playing with a Yosemite board and a PCI card,
> but I forget whether I had to do anything to enable
> PCI configuration space setup. Post a question to the
> U-Boot list.
> 
> > This is the part that is not clear, there is an irq field in
> > pci_dev structure which is filled in after looking at the
> > DTS and I just want to be sure this is the irq number to
> > be used when calling request_irq.
> 
> Really? I thought the pci_dev structures represent the
> devices found on the PCI bus, and the IRQ line in
> that structure was merely copied from the configuration
> space registers. When you request that interrupt, the
> code would have to remap it to a host IRQ line, which
> it would use the DTS for. (But I'm just speculating).
> 

The DTS shouldn't need to specify PCI cards, only the PCI controller.
Linux can probe the PCI bus to figure out what is plugged in, just like
it does on x86.

When Linux is assigning BARs and IRQs, it writes the BAR addresses to
the PCI cards, but does not write the IRQ. This was my experience with
PCI hotplug.

> Bottom line is; if the IRQ field of lspci is 0, then you
> need to figure out that problem first :)
> 

In the PCI hotplug case mentioned above, lspci would show the IRQ as 0
until I called request_irq() in the kernel. Afterwards, the correct IRQ
showed up in the lspci output.

Try request_irq(pdev->irq, ....) and see if it works.

Ira
