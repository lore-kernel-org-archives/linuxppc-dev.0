Message-ID: <38D64A54.D5A8E8BA@ccrl.mot.com>
Date: Mon, 20 Mar 2000 09:57:08 -0600
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Question on QSPAN Driver
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using the Monta Vista CDK - linux-2.2.13 kernel + tools on custom
hardware with Tundra's QSPAN II PCI bridge. I've noticed
that there are two occurances of qspan_pci.c and pci.c - one in
arch/ppc/kernel
and another in /arch/ppc/mbxboot. The functions in the two pci.c files
are
different, but the qspan_pci.c functions are essentially the same - with
the
exception of CONFIG_RPXCLASSIC support in the version in /arch/ppc/
kernel (seemingly indicating that its an updated version) and the lack
of
qspan_init in that same version. When I include the QSPAN PCI support
in the kernel configuration - it appears that during the PCI bus scan at

boot time the version of  qspan_pcibios_read_config_byte() in
arch/ppc/kernel/qspan_pci.c is called.

So here are my questions:
1. Why doesn't qspan_init ever get called before the PCI bus is scanned?

Where should it get called from? Should any of the functions in
arch/ppc/
mbxboot/qspan_pci.c get used or is it superceded by
arch/ppc/kernel/qspan_pci.c?
2. Should the pci_scanner function in arch/ppc/mbxboot/pci.c be called
in
place of the normal pci_scan_bus() function in drivers/pci/pci.c? If not

where would the pci_scanner() and other functions in
arch/ppc/mbxboot/pci.c be used?
3. Does Linux have a table of valid memory areas for peripheral devices
-
I've seen this in other embedded OS's. The kernel is crashing on the
first
qspan_pcibios_read_config_byte() with "kernel accss of bad area" - even
though chip selects are set up correctly for the area its accessing and
I
don't get machine check interrupts when I manually access that
particular
location through a debugger. But when the kernel does that access it
never even makes it out on the bus. Do I need to set something up so
the kernel knows that's a valid area? If so where do I do that? Is this
something that is supposed to happen automatically?

Thanks in advance for all of your help!
Steve

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
