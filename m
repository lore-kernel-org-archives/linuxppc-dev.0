Date: Tue, 13 Nov 01 13:45:01 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111132145.AA21341@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Current linuxppc_2_4_devel breakage
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

Current linuxppc_2_4_devel is broken on the Adirondack and I presume a bunch of
other platforms. After making it compile again (after the cpuinfo change), I
found that it dies as soon as it tries to perform a PCI config cycle in
find_bridges. Now this is after it has called setup_indirect_pci() to tell it
how to make these cycles. On the Adirondack I don't currently use a static
mapping for the CPC710 registers, and when I call setup_indirect_pci I pass it
physical addresses. setup_indirect_pci does its own ioremaps on both addresses
(CONFIG_ADDR and CONFIG_DATA), and it always worked before. It doesn't work
right now, however. Hacking the port to map the CPC710 registers virtual=
physical with io_block_mapping() in my ppc_md.setup_io_mappings() makes it
work, so I know the problem is there.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
