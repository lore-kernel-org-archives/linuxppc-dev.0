Date: Thu, 21 Sep 2000 21:44:47 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: PCI bridge bases, IDE on the B&W G3
Message-ID: <20000921214446.A865@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I recently installed an ACARD 6260 IDE card in my B&W G3.
While trying to get it working with the 2.4 kernel, I found
three problems:

- The B&W G3 has two PCI-buses. The second one is
accessed through a DEC,21154 controller. The expension
slots as well as the internal CMD646 IDE-controller is on
the second bus. The problem is that the bridge reports
zero in the both baseregisters (the new PCI resource
allocation scheme then fails miserably). This problem
is simply fixed by (arch/ppc/kernel/pci.c):

 void __init pcibios_fixup_bus(struct pci_bus *bus)
 {
+       pci_read_bridge_bases(bus);
+
        if ( ppc_md.pcibios_fixup_bus )
                ppc_md.pcibios_fixup_bus(bus);
 }

(i386 does it this way too).

- The pci card was never enabled. I solved this by calling
pci_enable_device(dev) by hand. But... shouldn't this really
be done automatically by the generic ide layer?

- If yaboot loads the kernel (or the yaboot config file?)
from the ACARD IDE-bus, then the card will not work (lost
interrupts). The same problem (lost interrupts) occurs if
one tries to boot from the built-in CMD646 controller.
Possibly, IDE devices are not left in a good state by the
firmware/yaboot on the B&W G3?

The ACARD card works great if the kernel is loaded from
a CMD-controlled device.


Cheers,

/Samuel



----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
