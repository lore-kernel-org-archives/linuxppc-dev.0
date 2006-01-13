Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C80C368926
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jan 2006 15:14:35 +1100 (EST)
Received: from ovro.ovro.caltech.edu
	(IDENT:U2FsdGVkX1/Ivem4aiXNYEL6UvIllWZDQzXNxNAbDLE@ovro.ovro.caltech.edu
	[192.100.16.2])
	by ovro.ovro.caltech.edu (8.13.1/8.13.1) with SMTP id k0D4EWYt011992
	for <linuxppc-embedded@ozlabs.org>; Thu, 12 Jan 2006 20:14:32 -0800
Message-ID: <43C7292B.2060003@ovro.caltech.edu>
Date: Thu, 12 Jan 2006 20:14:35 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: PPC440EP/Yosemite PCI misbehavior
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I'm getting what I believe is incorrect behavior from
the Yosemite 440EP PCI bus.

My setup is:
    - Yosemite board
    - PCI-to-cPCI adapter
    - cPCI bus analyzer (Agilent 1680A logic analyzer,
      with a FuturePlus FS3020 cPCI analyzer board)
    - custom cPCI board containing a PLX-9054 PCI
      bridge

I first built the test driver and ran tests on the PCI
peripheral boards using an x86 host (both PCI and cPCI
environments). In a cPCI crate with two cPCI peripheral
boards, I used Linux to read the PCI configuration space
and get the PCI addresses of boards, and then I performed
PCI transactions between the boards, i.e., no OS was
involved and I had full control over which PCI commands
were being issued during a read or write. The results of
those tests, and the driver source, are here:

http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz
http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-723-Hawkins.pdf

The stuff of interest in the document, is the section on PCI
drivers, and the generic PCI I/O driver is the pci_io.c
driver in the source code. I've written some Yosemite specific
build notes below for anyone who is interested.

Now for the tests on the Yosemite board....

First, the hardware. The PLX-9054 on the custom boards presents
two memory regions:

    BAR[0] 256-bytes non-prefetchable
    BAR[1] 8MB       prefetchable

Here's the observations/issues:

1. Using read()/write() to BAR[0] operates as one would expect;

    a) read uses a PCI memory read (MEM_RD) command, with FRAME#
       asserted for one clock per word, i.e., no bursting.

    b) write uses a PCI memory write (MEM_WR) command, with FRAME#
       asserted for one clock per word.

       read/write are implemented using memcpy_fromio/toio in the
       driver source


2. Using read()/write() to BAR[1] operates the same as to BAR[0].

    However, since this memory is prefetchable, it would be possible
    for the CPU to use a burst-read. The x86 architecture does
    not do it in this situation either, but the tests in the
    PDF show that both MEM_RD and MEM_WR commands are burstable.

    (This is more of an observation than a complaint)

3. Using mmap() on BAR[0] does not work correctly.

    a) a read prefetches 8 32-bits words using a memory read-line
       (MEMRDL) PCI command (FRAME# is asserted for multiple clocks)

    b) a write first prefetches 8 32-bits words (using MEMRDL), and
       then a discernable time later the data is flushed back to the
       hardware via a MEM_WR.

    BAR[0] is marked in the PCI configuration space as non-prefetchable,
    so this behaviour is wrong. Its also inconsistent with what
    happened during tests on an x86 - where read always produced single
    MEM_RDs and writes produced single MEM_WRs.

4. Using mmap() on BAR[1] exhibits the same result at BAR[1], however,
    since that region is marked as prefetchable, the use of a MEMRDL
    during read is legitimate. However, the write operation still
    appears wrong (i.e., cached).

So, it appears that for mmap() the processor considers PCI memory
both prefetchable and cacheable (regardless of its PCI configuration
space memory flag specification). I checked my mmap code and the
VMA flags VM_RESERVED and VM_IO are set prior to the call to
map the PCI memory.


5. I have another PCI device with a PLX-9054 PCI bridge in its
    default configuration, i.e., BAR[0] is 256-bytes non-prefetchable
    memory, and BAR[1] is 256-bytes I/O ports (same registers).
    Testing on an x86 works fine with the pci_io.c driver and
    the pci_debug.c or pci_transaction.c user-space tests.

    However, on the Yosemite board, access to PCI I/O space
    causes a machine check exception.

    There's a chance that the driver is at fault though.
    For example, lspci shows that the I/O ports are assigned
    to PCI I/O port address 0xFF00. When I insmod the pci_io.ko
    driver, the kernel address after ioport_map() is
    0xFDFFEF00. However, the default memory map of the 440EP
    would put this PCI I/O address in the region starting
    E800_0000, eg. E800_FF00, so I would not have been
    surprized if I saw that kernel address, or some offset
    relative to that address. But of course, I'm not sure if
    the kernel TLBs setup the PCI kernel addresses to
    match the 440EP physical addresses.

    However, the code is exercised during a test on an x86, its
    just the implementation of the ioport_map() etc that will
    be different ... so I think the 440EP port is the source
    of the error.

    I don't plan on designing hardware that uses PCI I/O
    regions, so I'm less concerned about this issue. But if
    someone wants me to send them any debug info, let me know.

Whew!! If you've read this far, thanks!!

This is the first time I have used a PowerPC, and the first
time I've really had to debug what appear to be kernel
errors (I've really just written drivers).

I'll try and debug these issues, but I wanted to see if anyone else
had run into these problems. If anyone can tell me where to start
looking, I'd appreciate it. I figure that since read()/write()
appear to work and use memcpy_fromio/toio I'd check into the
implementation of those functions first, and see how the differ
from a mmap implementation.

I've been building with the ELDK 3.1.1 kit that comes with the
Yosemite board, and I have tested with the 2.6.13 kernel that
came with the board, and the 2.6.14 kernel from Denx. I'll
test the 2.6.15 kernel as soon as the ELDK 4.0 iso's are
released and I can build a 2.6.15 kernel.

Cheers
Dave Hawkins
Caltech.



------------- Driver build notes ----------------------------------

Here's how I build the driver:

export PATH=$PATH:/opt/eldk-3.1.1/bin:/opt/eldk-3.1.1/usr/bin
export ARCH=ppc
export CROSS_COMPILE=ppc_4xxFP-
export KERNEL_DIR=/home/dwh/yosemite/linux-2.6.13-build-ppc
make

Then on the Yosemite target, I mount the build area as an NFS
mount, and then change directory into the area the driver was
built. Installing the module is:

insmod pci_io.ko
mknod /dev/pci_00\:0c.0_0 c 254 0
mknod /dev/pci_00\:0c.0_1 c 254 1
mknod /dev/pci_00\:0c.0_2 c 254 2
mknod /dev/pci_00\:0c.0_3 c 254 3
mknod /dev/pci_00\:0c.0_4 c 254 4
mknod /dev/pci_00\:0c.0_5 c 254 5

i.e., the PCI slot is at 00:0c.0 per lspci, and the device
nodes for the generic PCI I/O driver are named after that
with the BAR number as an extension.

To run tests;

1. open BAR 0 using read()/write() (memcopy_from/toio)

./pci_debug -s 00:0c.0 -b 0

2. open BAR 0 using mmap()

./pci_debug -s 00:0c.0 -b 0 -m


and so on for other BAR regions.
