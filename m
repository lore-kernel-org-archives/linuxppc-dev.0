Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1FEBCDDF33
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 10:52:40 +1100 (EST)
Message-ID: <45E75859.3090508@ovro.caltech.edu>
Date: Thu, 01 Mar 2007 14:48:57 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Oliver Rutsch <orutsch@sympatec.com>
Subject: Re: MPC5200, PLX9054 PCI Card - stalled DMA transfers
References: <45E6CAC8.8090007@sympatec.com>
In-Reply-To: <45E6CAC8.8090007@sympatec.com>
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

Oliver Rutsch wrote:
> Hi,
> 
> we're using a TQM5200S-Module (MPC5200) on a STK52xx-board with a 
> PLX9054-based PCI card. The 2.4.25-kernel on the 3.1.1 ELDK had big 
> problems to map the PCI resources of this card, so I tried the latest 
> 2.6.19.2-kernel of the 4.1 ELDK. This kernel mapped successfully the PCI 
> resources on this card.
> After building the latest PLX driver on the 2.6.19-kernel (I had to make 
> some changes for the .19 kernel and for some litte/big endian issues) I 
> was able to transfer data with programmed I/O. But as this is too slow I 
> like to use the DMA functions of this device and here is the problem:
> PLX provides an example program for scatter/gather DMA. This program 
> works with their latetst driver on a linux PC. But on the TQM5200 the 
> 'Channel 0 done' flag of the DMASR0 register is never set after starting 
> the DMA transfer. What can be the reason for this? The debug output of 
> the driver looks O.K., but waiting for the DMA done interrupt gives a 
> timeout, because the flag is not set. I wrote some test patterns in my 
> DMA buffer before the DMA transfer and no byte of the buffer was 
> altered, so the DMA engine seems not to be able to write a single byte.
> Has anybody this or a similar card running on a ppc environment? Any 
> ideas what I can do?
> 
> Thanks in advance and bye,

Hi,

I use the PLX-9054 in my custom boards (TI DSP on-board), and
Linux x86 host computer. When debugging, I load a simple memmap
driver, and 'tickle' the board registers directly.

There's a copy of the PLX driver in here ...
http://www.ovro.caltech.edu/~dwh/correlator/pdf/cobra_driver.pdf
http://www.ovro.caltech.edu/~dwh/correlator/software/cobra_driver-2.9.tar.gz

And if my memory serves me right, I think I wrote a generic
one that lets you map any PCI device ...
http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-723-Hawkins.pdf
http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz

Anyway, manually setup a DMA transfer and convince yourself that
you know which bits to twiddle, then figure out why the driver
code isn't doing as its asked.

Take a look at the COBRA driver code, it has PLX-9054 DMA control.

There might be a few clues in my docs that'll help you.

Cheers
Dave
