Message-ID: <0b4d01c33b18$16b65d90$3000a8c0@primag>
From: "Mark Powell" <medp@primagraphics.co.uk>
To: "LinuxPPC-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Chris Zimman" <chris@cryptoapps.com>
References: <3EF8A001.2090603@gmx.net> <20030624191935.GA9845@dingdong.cryptoapps.com>
Subject: Re: PCI DMA memory problem
Date: Wed, 25 Jun 2003 13:48:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We found a problem with memory-memory DMA on 405GP. Some of our h/w runs
a standalone app directly from PPCBoot. We found that DMA didn't work
at all for physical addresses below 16MByte. This applies to the data
transfers and to the scatter/gather lists.

Chris, could you send me your PCI fixes. We tried some PCI cards in a
Walnut with the idea of building a server for native compilation, but
not much worked.

Mark
--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk

----- Original Message -----
From: "Chris Zimman" <chris@cryptoapps.com>
Sent: Tuesday, June 24, 2003 8:19 PM
Subject: Re: PCI DMA memory problem

On Tue, Jun 24, 2003 at 09:01:21PM +0200, Oliver Amft wrote:
>
> I am implementing a network driver for a DMA device on a custom
> 405GP/GPr based board. The networking device is attached over PCI bus.
> Kernel is currently 2.4.21. BIOS is PPCBoot 1.2.0.
>
> To map the data buffers from skb the driver uses pci_map_single().
> When starting the kernel with SDRAM size configurations other
> than 32MByte the device is unable to transfer data (currupted
> data) - descriptor dword read/write-back works (set up with
> pci_alloc_consistent()). For the kernel start option mem=32MB
> everything is fine (descriptor + correct data).

My first thought is -- is/are the SDRAM bank(s) configured correctly?

I don't know that it'd necessarily be related, but for the 405GP,
PPCBoot 1.2.0 doesn't have the PCI bridge setup quite right for all
PCI devices (eg. 82559 won't work).  I have code to fix the bridge
setup if you need it -- although I'm not even certain they exist in
the GPR.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
