Return-Path: <jeff.hane@maxim-ic.com>
Received: from antispam02.maxim-ic.com.maxim-ic.com (antispam02.maxim-ic.com
	[205.153.101.183]) by ozlabs.org (Postfix) with ESMTP id 4FE36B7BFA
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 06:35:40 +1100 (EST)
Received: from mailhost.mobilygen.com (localhost [127.0.0.1])
	by antispam02.maxim-ic.com.maxim-ic.com (Spam & Virus Firewall) with
	ESMTP id E1C28A180A8
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Dec 2009 13:35:38 -0600 (CST)
Received: from mailhost.mobilygen.com ([10.32.80.116]) by
	antispam02.maxim-ic.com.maxim-ic.com with ESMTP id
	AOuMEuXrNXKkIDcI for <linuxppc-dev@ozlabs.org>;
	Thu, 03 Dec 2009 13:35:38 -0600 (CST)
Received: from [10.32.80.202] (qu102 [10.32.80.202]) (authenticated bits=0)
	by mailhost.mobilygen.com (8.13.8/8.13.8) with ESMTP id nB3JZZ71028463
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Dec 2009 11:35:35 -0800
Subject: Re: PCI interrupt question
From: Jeff Hane <jeff.hane@maxim-ic.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <4B17F14A.1060001@ovro.caltech.edu>
References: <1259821316.12651.26.camel@qu102.quarc.com>
	<4B17F14A.1060001@ovro.caltech.edu>
Content-Type: text/plain
Date: Thu, 03 Dec 2009 11:39:00 -0800
Message-Id: <1259869140.18190.52.camel@qu102.quarc.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 09:11 -0800, David Hawkins wrote:
> Hi Jeff,
> 
> >  I'm trying to get interrupts working for my PCI device on a 460ex and
> > am having problem.  My ISR never triggers.
> > 
> > I'm new to PCI(and ppc) and LDD said that I could read the config reg
> > INTURRUPT_LINE to get the interrupt assigned to my PCI device.  Well,
> > this always reads zero. 
> > 
> > After reading through the code it appears that the interrupt is being
> > assigned after reading some information out of the device tree and then
> > filling in the irg in the pci_dev structure.  
> > 
> > I'm just looking for confirmation that I should be calling request_irq
> > with the irq that I found in the pci_dev struct.
> 
> Can you clarify:
> 
> 1. 460EX is your PCI host CPU?

yes.  We are using a canyonlands board with 460ex.

> 
> 2. You have some PCI device - what? Have you tested it works in a
>     standard PCI bus? Eg. ran lspci from an x86 host.

It is a FPGA board that we are using to develop a video codec/SOC.  We
have not connected it an x86; however, we know the the PCI interface is
working because we can talk to the FPGA board.

> 
> 3. When your host processor boots, it assigns the PCI resources.
>     On an x86, its the BIOS that assigns the PCI addresses and IRQs
>     on the PCI devices. For your 460EX, it could be your bootloader,
>     or it could be your host OS (Linux).

We are using the vanilla versions of u-boot and linux for the
canyonlands boards and have made few changes and definitely not to the
PCI setup.

> 
> 4. If you boot Linux on your 460EX and run lspci, and the device
>     configuration space register for the IRQ line is 0, then your
>     host has not setup the PCI interface on your device correctly.
>
> 5. Once you have the PCI IRQ assigned to the device correctly,
>     you need to know which IRQ line on the host this corresponds to.
>     I'm pretty sure that needs to be described in the DTS as
>     commented by Stefan.
> 

 So are you saying linux should be writing the irq number to the
INTERRUPT_LINE config reg?  This is what I expected but I do not see
it.  
 I believe the DTS is being parsed properly and the connection is made
to the correct interrupt line on the device.  But somebody still needs
to assign and IRQ number, right?  This is the part that is not clear,
there is an irq field in pci_dev structure which is filled in after
looking at the DTS and I just want to be sure this is the irq number to
be used when calling request_irq.

thanks,
jeff



> These comments might not be 100% correct, but the list of things
> to check should be close enough for you to track down your
> problem.
> 
> Cheers,
> Dave
> 
