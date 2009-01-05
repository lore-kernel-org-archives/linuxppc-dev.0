Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id BB6C4DE25A
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 07:09:17 +1100 (EST)
Message-ID: <496268E7.5090907@harris.com>
Date: Mon, 05 Jan 2009 15:09:11 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [QUESTION] 440EPx with PCI to PCIe bridge error
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have a Sequoia board (440EPx) with kernel 2.6.27.9.  I've recently
plugged in a PLX adapter board to convert one of the PCI connectors
on the Sequoia to PCIe.

When the kernel boots, I get the following error messages regarding
mem resource allocation.  Device 0000:00:0c.0 is the PCI<->PCIe bridge,
and device 0000:01:00.0 is an FPGA PCIe evaluation board.

	PCI host bridge /plb/pci@1ec000000 (primary) ranges:
	 MEM 0x0000000180000000..0x000000018fffffff -> 0x0000000080000000
	  IO 0x00000001e8000000..0x00000001e80fffff -> 0x0000000000000000
	4xx PCI DMA offset set to 0x00000000
	PCI: Probing PCI hardware
	PCI: Hiding 4xx host bridge resources 0000:00:00.0
	pci 0000:00:0c.0: PME# supported from D0 D1 D3hot
	pci 0000:00:0c.0: PME# disabled
	pci 0000:00:0c.0: BAR 8: can't allocate mem resource [0x180000000-0x18fffffff]
	pci 0000:01:00.0: BAR 1: can't allocate mem resource [0x1f0000000-0x1ffffffff]
	pci 0000:01:00.0: BAR 0: can't allocate mem resource [0x180000000-0x18007ffff]
	pci 0000:00:0c.0: PCI bridge, secondary bus 0000:01
	pci 0000:00:0c.0:   IO window: disabled
	pci 0000:00:0c.0:   MEM window: disabled
	pci 0000:00:0c.0:   PREFETCH window: disabled

Plain PCI cards plugged directly into the Sequoia work fine.  Is there
something I have to add to the .dts file to represent the PCI<->PCIe
bridge?

	Thanks,
	Steve
