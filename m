Message-ID: <38D66069.AA538C28@embeddededge.com>
Date: Mon, 20 Mar 2000 12:31:21 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question on QSPAN Driver
References: <38D64A54.D5A8E8BA@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:

> ........ I've noticed
> that there are two occurances of qspan_pci.c and pci.c - one in
> arch/ppc/kernel
> and another in /arch/ppc/mbxboot.

The PCI functions in arch/ppc/mbxboot are used by boards that don't
have a 'bios' function for the initialization and mapping of the
PCI bus (which are nearly all PowerPC boards I have ever seen, and
those that attempt it don't do it correctly).  The qspan_init function
is just the basic, minimal initialization of the QSpan to get slave
mode PCI access.  These functions may not be complete for your
environment.  You are likely to add more functions for the mapping.

The PCI functions in arch/ppc/kernel are Linux generic functions for
supporting PCI devices.

> ......the
> exception of CONFIG_RPXCLASSIC support in the version in /arch/ppc/
> kernel (seemingly indicating that its an updated version) and the lack
> of
> qspan_init in that same version.


The Embedded Planet RPX Classic just went through a major design
change, and I am updating the functions to support that now.

The qspan_init function isn't needed in the Linux kernel because that
should have been done long before the kernel was started.

> ...... When I include the QSPAN PCI support
> in the kernel configuration - it appears that during the PCI bus scan at
>
> boot time the version of  qspan_pcibios_read_config_byte() in
> arch/ppc/kernel/qspan_pci.c is called.

That is correct.


> So here are my questions:
> 1. Why doesn't qspan_init ever get called before the PCI bus is scanned?

That is the job of something during the boot process before the Linux
kernel is started.


> 2. Should the pci_scanner function in arch/ppc/mbxboot/pci.c be called
> in
> place of the normal pci_scan_bus() function in drivers/pci/pci.c?

No, those functions are very different.  The functions in 'mbxboot'
are used to initialize and map the PCI bus.  The functions in the
Linux kernel are discovery functions.



> 3. Does Linux have a table of valid memory areas for peripheral devices
> -
> I've seen this in other embedded OS's.

Take a look at one of the board configuration files in include/asm-ppc,
like 'mbx.h' or 'rpxclassic.h'.  Then look at arch/ppc/mm/init.c.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
