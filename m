To: linuxppc-embedded@lists.linuxppc.org
Subject: mpc755, sandpoint port and 1Gb of ram
Date: Tue, 01 Jul 2003 22:21:08 -0400 (EDT)
Message-Id: <31237.1057112468@mja-pc-linux.dhcp.pit.laurelnetworks.com>
From: "Michael J. Accetta" <mja@laurelnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

We have a custom board built around the mpc755 and patterned after the
Sandpoint reference design using the MontaVista Pro 3.0 distribution.
This is a base 2.4.18 kernel which, according to the MV web, page includes the
2.4.17 linuxppc code.  When 1Gb ram is used, CONFIG_HIGHMEM is required
to access the top 256Mb.  However, the sandpoint port does

   io_block_mapping(0xfe000000, 0xfe000000, 0x02000000, _PAGE_IO);

whichs maps all of virtual 0xfexxxxxx to physical 0xfexxxxxx.  This call
ends up using BAT#0 to map the entire block.  However, the CONFIG_HIGHMEM
support in the base ppc port sets PKMAP_BASE to 0xfe000000 and expects
these virtual addresses to be available for dynamic mapping via kmap()
of high memory.  The conflicting mapping in the BAT takes precedence,
wreaking havoc with any accesses to high memory.  In our case NFS mounts
of the root file system was the first high memory user and init could
not be found.

I've made a stab at fixing this by configuring PKMAP_BASE down to 0xfc000000
and things now seem to work fine.  Is this a correct solution?  Are there
likely to be any negative side effects of this approach?  Are there
better solutions?

Mike Accetta
Laurel Networks, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
