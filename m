From: "David W. Patmore" <dwp@bluesteelnet.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: G4 + Linux + PCI device + x86 driver = 0
Date: Sat, 13 Nov 1999 16:55:22 -0800
Message-ID: <NDBBKOPFGLPEGICBJFDIAEDMCCAA.dwp@bluesteelnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm trying to port a device driver from working x86 code over to a G4 (early
350MHz) running LinuxPPC.  The driver will load up, but the memory access
isn't working.

Linux version: 2.2.6 Sat Oct 30 1999
gcc version: egcs-2.91.66

warning sign:  I get warning message "pcidrv.o was compiled for kernel
version
2.2.6-15apmac, while this kernel is version 2.2.6".  I force the driver to
load
using "insmod -f pcidrv.o".

The original x86 (Redhat 6.0) driver uses virt_to_bus() to get the address
to write to.  In LinuxPPC, that function is not available (not in name
table).  I guess that I'm supposed to use ioremap(), but that doesn't seem
to do it for me either.

Code snip:
	ul_reg_addr = p_dev->base_address[0];

	pul_remapped =ioremap( ul_reg_addr, 32 );

	printk( "pcidrv: base addr %08X \n", ul_reg_addr );
	printk( "pcidrv: pul_remapped %08X \n", pul_remapped );
	printk( "pcidrv: remapped data: %08X \n", *pul_remapped );

	iounmap( pul_remapped );

The outcome of running this code is:  pci base address (0x80890000),
remapped (0xC8271000), data (0xFFFFFFFF).  The data is a status word which I
expect to be not
all "F"s.  Note that iounmap is "TBD" in the source, so each time the code
runs per
reboot, iomap returns a new address.

If anyone has some advice, I'd be very pleased to hear it.  I need to go on
the G4, because that is what I have on hand.

Thanks very much,

David Patmore


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
