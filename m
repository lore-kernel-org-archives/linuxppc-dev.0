Message-ID: <3C1F9452.AB979826@aquilagroup.com>
Date: Tue, 18 Dec 2001 12:09:06 -0700
From: Jeff Studer <jstuder@aquilagroup.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: PCI QSPAN2 resource conflicts
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello list,

I am working with a linux 2.4.2 kernel in an MPC860 custom board using a
Tundra QSPAN2 PCI controller.  I have set up configuration space and can
successfully probe for PCI cards. When I load PCI drivers, I get into
trouble.

When I insmod the 3c59x.o module, I can access I/O space, but my MAC
address is read as 00:00:00:00:00:00.  I can't find manuals for this
card to verify what is going wrong, but I can see data in the I/O space
when I use our ADS board and the mpc8bug program.

When I load another driver specific to this project, therefore the need
for PCI at all, I get resource conflicts.  The 3c59x.o driver actually
uses the value I set bus->resource->start to,  whereas the other PCI
driver uses 0.

I've tried various setups for the resource.  I have set
bus->resource->start to the address in the QSPAN2's Slave0 address
setting. And I also tried do this and using the arch/ppc/mbxboot/pci.c's
functions: probe_addresses and map_pci_addrs.

I really wish there was a detailed HOWTO for all this, but in the
meantime, does anyone have any idea what are the proper steps to
complete this PCI support and/or what I may be doing wrong?

Thank you,

Jeff Studer
Software Engineer
Aquila Technologies Group

jstuder@aquilagroup.com
ph:  505-828-9100
fax: 505-828-9115


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
