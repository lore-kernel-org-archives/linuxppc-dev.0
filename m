Date: Sun, 14 Nov 1999 05:41:53 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: "David W. Patmore" <dwp@bluesteelnet.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 + Linux + PCI device + x86 driver = 0
In-Reply-To: <NDBBKOPFGLPEGICBJFDIAEDMCCAA.dwp@bluesteelnet.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.991114053033.20492G-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 13 Nov 1999, David W. Patmore wrote:

[...]
> The original x86 (Redhat 6.0) driver uses virt_to_bus() to get the address
> to write to.  In LinuxPPC, that function is not available (not in name
> table).  I guess that I'm supposed to use ioremap(), but that doesn't seem
> to do it for me either.
> 
> Code snip:
> 	ul_reg_addr = p_dev->base_address[0];
> 
> 	pul_remapped =ioremap( ul_reg_addr, 32 );
> 
> 	printk( "pcidrv: base addr %08X \n", ul_reg_addr );
> 	printk( "pcidrv: pul_remapped %08X \n", pul_remapped );
> 	printk( "pcidrv: remapped data: %08X \n", *pul_remapped );
> 
> 	iounmap( pul_remapped );
> 
> The outcome of running this code is:  pci base address (0x80890000),
> remapped (0xC8271000), data (0xFFFFFFFF).  The data is a status word which I
> expect to be not
> all "F"s.  Note that iounmap is "TBD" in the source, so each time the code

Most likely, you need to enable I/O or/and memory access by hand.  OF
probably didn't enable it automatically.  For example,

	(void) pci_read_config_word(p_dev, PCI_COMMAND, &command);
	if (!(command & PCI_COMMAND_IO)) {
		command |= PCI_COMMAND_IO;
		(void) pci_write_config_word(p_dev, PCI_COMMAND, command);
		(void) pci_read_config_word(p_dev, PCI_COMMAND, &command);
		if (!(command & PCI_COMMAND_IO)) {
			printk(KERN_DEBUG "IO access enable failed\n");
			return 0;
		}
	}
	if (!(command & PCI_COMMAND_MEMORY)) {
		command |= PCI_COMMAND_MEMORY;
		(void) pci_write_config_word(p_dev, PCI_COMMAND, command);
		(void) pci_read_config_word(p_dev, PCI_COMMAND, &command);
		if (!(command & PCI_COMMAND_MEMORY)) {
			printk(KERN_DEBUG "Memory access enable failed\n");
			return 0;
		}
	}

This would make *pul_remapped return something different, I'd think.  See
other ppc drivers for more details.  You may need additional PCI fixups.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
