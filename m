Message-ID: <32844.194.247.49.215.1013120115.squirrel@lbbrown.homeip.net>
Date: Thu, 7 Feb 2002 22:15:15 -0000 (GMT)
Subject: 2_4_devel boot problems on 7043-140 - pci fixup changes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: <paulus@samba.org>
Cc: <trini@kernel.crashing.org>, <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Current 2_4_devel won't boot on my 7043-140 despite the recent changes
you made to help.  I've been thrashing around for quite some time and
have some results that might help you fix whatever it is that isn't
quite right (maybe).

The first thing I tried was the following patch

--- prep_pci.c.orig	Thu Feb  7 20:32:10 2002
+++ prep_pci.c	Thu Feb  7 20:32:25 2002
@@ -1235,7 +1235,7 @@
 	hose->pci_mem_offset = PREP_ISA_MEM_BASE;
 	hose->io_base_phys = PREP_ISA_IO_BASE;
 	hose->io_base_virt = (void *)0x80000000; /* see prep_map_io() */
-
prep_init_resource(&hose->io_resource, 0, 0x00ffffff, IORESOURCE_IO);
+
prep_init_resource(&hose->io_resource, 0, 0x0fffffff, IORESOURCE_IO);
 	prep_init_resource(&hose->mem_resources[0], 0xc0000000, 0xfeffffff,

		   IORESOURCE_MEM);
 	hose->ops = &prep_pci_ops;

Which reset the window back to its original 256MB size.  That made it
work again.  I then tried reducing the window down until it stopped
working again.  The upshot of it is that 256, 64, 32 and 16MB + 1 byte(!)
all work, but 16MB itself does not.

Anyway, partial boot logs for a selection of cases are at:

http://www.solinno.co.uk/leigh/16mb_window
http://www.solinno.co.uk/leigh/16mbplus1_window
http://www.solinno.co.uk/leigh/32mb_window
http://www.solinno.co.uk/leigh/64mb_window

Happy to test any patches....

Cheers,

Leigh.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
