Return-Path: <andrew.dennison@motec.com.au>
Received: from mail.netspace.net.au (cumulus.netspace.net.au [203.10.110.72])
	by ozlabs.org (Postfix) with ESMTP id 7BE9E2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 10:48:18 +1100 (EST)
Received: from motec.com.au (dsl-210-15-234-78.VIC.netspace.net.au
	[210.15.234.78])
	by mail.netspace.net.au (Postfix) with SMTP id 82AF9711E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 10:48:09 +1100 (EST)
From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: "'Zeitler, Nathan'" <nzeitler@osii.com>, <wd@denx.de>
Date: Tue, 14 Dec 2004 10:48:11 +1100
Message-ID: <002a01c4e16e$34451010$4000a8c0@CAT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <01C22B6B78D52B46BE3C38FB525617EF909AC7@osimail.osii.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Lite5200 and PCI1520 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Nathan Zeitler wrote:

> Hello Wolfgang,
>=20
>> Now what? Is it a custom board, or a Lite5200?
>=20
> My apologies.  It is a custom board based closely on the design of the
> Lite5200.  Thus we are able to put a PCI1520 chip on the same PCB and
> connect it to the MPC5200 PCI bus.

Nathan,
I posted a question on cardbus with the 5200 a few weeks ago but got no
reply. I think the reason is that cardbus / pcmcia support may not have
been considered when the 5200 PCI memory map was laid out, but I would
love to be contradicted!

I also have a custom board with a mpc5200, pci1520 cardbus bridge, DDR,
etc.

Which kernel are you using?

I'm using Denx linuxppc_2_4_devel cvs and so far I've had to make =
several
changes to get close to a working system. I've changed the PCI bus =
mapping
so ISA I/O (ie PCMCIA) is at the bottom of the PCI address space, from =
my
reading / debugging this seems to be required to get PCMCIA to work. I
initially tried hacking yenta.c to use a high I/O range (like you have)
but this doesn't seem to be the solution. My memory map is now as =
follows:

/*
 * VPC mapping deviates from icecube so PCMCIA can work!
 * From Processor to PCI:
 *   PCI Mem Space: 0x40000000 - 0x50000000 -> 0x40000000 - 0x50000000
(256 MB)
 *   PCI I/O Space: 0x50000000 - 0x51000000 -> 0x00000000 - 0x01000000 =
(16
MB)
 *
 * From PCI to Processor:
 *   System Memory: 0x80000000 -> 0x00000000
 */

this also requires:
#define _IO_BASE	isa_io_base=20
and isa_io_base to be set to the correct virtual address, =
pci_dram_offset
=3D 0x8000000, among other changes.

I also have a few outstanding issues that I haven't resolved yet, hence =
I
haven't posted a full patch, but I can now load and configure a wireless
ethernet card. Loading cardbus drivers currently fails when accessing =
PCI
configuration space on the cardbus bus, and I haven't sorted this out =
yet.

Part of the reason for my reply is also to check if my current approach
(remapping the PCI address space) is sane - comments anyone? I have made
similar changes in u-boot and can now read / write CF cards so it seems
like the right approach for the kernel too.

Andrew
