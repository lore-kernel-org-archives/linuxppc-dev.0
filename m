Date: Thu, 17 Apr 2003 15:45:46 -0700
From: Fred Gray <fegray@socrates.berkeley.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Genesis2_pci_IRQ_map vs. MVME2300/MVME2600
Message-ID: <20030417224546.GG6525@socrates.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear PPC kernel hackers,

In the structure Genesis2_pci_IRQ_map in arch/ppc/platforms/prep_pci.c, the
following entries currently appear (at least in 2.4.21-pre6 from a
linuxppc_2_4_devel tree obtained via rsync):

       0,      /* Slot 10 - Ethernet */
       0,      /* Slot 11 - Universe PCI - VME Bridge */
       3,      /* Slot 12 - unused */
       0,      /* Slot 13 - unused */
       2,      /* Slot 14 - SCSI */

These numbers don't match with the Motorola MVME2300 and MVME2600 series boards
that I'm using, where the following assignments are the reality:

       0,      /* Slot 10 - unused */
       0,      /* Slot 11 - IDE */
       3,      /* Slot 12 - SCSI */
       5,      /* Slot 13 - Universe PCI - VME Bridge */
       2,      /* Slot 14 - Ethernet */

Note that nearly all of the differences here are in the comments: the kernel
works as distributed except that the Universe VME interface isn't assigned
an IRQ.  The fact that every single one of the comments is wrong just makes it
a little more interesting for someone like me to figure out what this
mapping refers to. :-)

Thanks very much,

-- Fred

-- Fred Gray / Visiting Postdoctoral Researcher                         --
-- Department of Physics / University of California, Berkeley           --
-- fegray@socrates.berkeley.edu / phone 510-642-4057 / fax 510-642-9811 --

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
