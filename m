Date: Thu, 23 Aug 2001 05:23:40 -0700
From: Matt Porter <mporter@mvista.com>
To: Brian Waite <bwaite@cspi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCSI PMC card
Message-ID: <20010823052340.A32510@cx258813-a.chnd1.az.home.com>
References: <200108231432.KAA09949@orchid.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200108231432.KAA09949@orchid.cspi.com>; from bwaite@cspi.com on Thu, Aug 23, 2001 at 10:24:56AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Aug 23, 2001 at 10:24:56AM -0400, Brian Waite wrote:
>
> I am trying to put a Cyclone SCSI PMC (symbios 53c895 chipset) card on my
> Motorola MVME2400 and I see some wierd stuff. If I put the SCSI card on a
> SPAN card, the kernel comes up and see the card, but when I place the SCSI
> card on either of the 2 PMC slots on the base, I hang while probing PCI
> hardware. It gets part way through the PCI fixup resources section and just
> hangs. Here is my boot

<snip>

> PCI: Probing PCI hardware
> Fixup mem res, dev: 0.0, res_start: 3c000000->fc000000
> Fixup mem res, dev: 0.d, res_start: 2ff7f000->eff7f000
> Fixup mem res, dev: 0.e, res_start: 2ff7ec00->eff7ec00
> Fixup mem res, dev: 0.e, res_start: fffc0000->bffc0000

You are in resource hell.

In a PReP map, 0xfffc0000 isn't a legal PCI base address since
it lies in PCI's system memory space (0x80000000-0xffffffff).
I seem to remember a bug in the ppc resource pci_mem_offset
handling that applied pci_mem_offset twice in some cases.
It is fixed at least in the 2_4_devel tree.  You can confirm
this by reading the contents of the BAR corresponding to that
last fixup directly.  I'll bet that it is 0x3ffc0000, PPCBUG's
autoconfiguration code is real good so I highly doubt that it
assigned 0xfffc0000 to a memory BAR.

#define DEBUG in drivers/pci/pci.c and arch/ppc/kernel/pci.c and
repost your results.

> A thing to note is that I do not have and SCSI support built into this
> kernel. I built scsi_mod, sd_md, and sym53c8xx and load them as modules.
> I am using the 2.4.3 kernel and I have tried building the sym module into the
> driver, but the hangs occurs before the driver ever loads! Any idea what has
> gone wrong while tring to probe this card? It is strage that it works fine on
> a SPAN card. Too bad that is not a solution for us. PS this worked under 2.2
> so I know the card is OK.

By SPAN card do you mean a PMCSPAN?  Which 2.4.3 are you using?  kernel.org,
linuxppc_2_4, linuxppc_2_4_devel?

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
