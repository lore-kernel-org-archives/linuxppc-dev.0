In-Reply-To: <v04220801b4daa2e26f84@[10.0.0.42]>
Date: Thu, 2 Mar 2000 15:22:44 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: "Timothy A. Seufert" <tas@mindspring.com>, dledford@redhat.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Need reports about PCI I/O conflicts
Message-Id: <20000302152244.014464@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all !

I need reports about the PCI I/O space conflicts that have been mentioned
here. According to Apple, there is no known OF bug.

Please include your machine model, the dump of /proc/pci, and eventually
the result of lsprop on the offending card /proc/device-tree entries.

Note about the Adaptec problem reported earlier, this is apparently not
an OF bug, but a combination of an OF "feature" along with a bug in
Michel patches.

What I think happens is that the firmware (and I suspect this is done by
the Adaptec OF code on the card, not by OF itself) will "disable" the IO
accesses and decides that the card should use only memory-mapped
registers on PPC. It does this by writing 0 in the io space register, but
doesn't disable IO accesses to the card in the PCI config header (or
maybe they get re-enabled by the kernel fixup code). Also, I still have
to check if the bit 0 is actually 0 or 1.

However, Michel code doesn't see this and do it's fixup, causing a
remapping of the io space to fe000000 instead of leaving 0, which may let
some driver think the address was actually assigned. This is a problem
since in theory, io 0 is perfectly valid, isn't it ? In this case, it
should be considered wrong.

Anyway, I don't see at first why the driver would not work since both
cards have a valid memory base and the driver should be compiled with
MMIO enabled on PPC, and so should not use the IO address anyway.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
