Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 1B132B7D09
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 03:42:13 +1100 (EST)
Message-ID: <4BA257DF.2040300@harris.com>
Date: Thu, 18 Mar 2010 12:42:07 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: PPC405EX PCI CPU vs bus address mapping question
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have a Kilauea board with one custom PCIE card plugged
into the PCIE1 slot.  The custom card contains four PCI
devices which are connected via a PCIE-PCI bridge to the
Kilauea.

These devices need to communicate directly with each other.
This is done by telling each device the PCI bus address of
its partners.

I tried using pci_resource_start() to get the bus address,
but that apparently gives me the cpu address.

Specifically, pci_resource_start() returns the following
addresses for the four devices:

0x0000000090000000, 0x0000000094000000,
0x0000000098000000, and 0x000000009c000000.

However, if I look at the BAR registers in config space, they
are set to 80000000, 84000000, 88000000, and 8c000000.

During boot, I see:

PCI host bridge /plb/pciex@0c0000000 (primary) ranges:
 MEM 0x0000000090000000..0x000000009fffffff -> 0x0000000080000000

And that does correspond to the "ranges" line in my dts file.

So there is clearly an offset of 0x10000000 between the CPU and
bus address.

My question is:  What is the correct way for the driver to learn
of this offset, so that it can tell the devices where to find
their partners?

I see in pci_process_bridge_OF_ranges() that hose->pci_mem_offset
is calculated.  That is probably the value I want, but I don't
see a "clean" way to access it.

	Steve
