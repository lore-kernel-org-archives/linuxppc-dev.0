From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15365.51839.327359.844495@gargle.gargle.HOWL>
Date: Thu, 29 Nov 2001 16:41:19 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: ide_init_hwif_ports
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have looked at all the different ide_init_hwif_ports implementations
in the linuxppc_2_4_devel tree.  They are all remarkably similar with
the exception of four: 8xx, lopec, mcpn765 and sandpoint.  The 8xx one
seems to be PCMCIA and the other three all have a PCI IDE controller
(82c105 or 82c586).

Now, ide_init_hwif_ports is really only used in two situations: when
you have IDE controllers at well-known I/O port addresses, or when you
are using the pci-ide driver.  In both cases an implementation like
this (from the prep) is fine, on any platform:

static __inline__ void ide_init_hwif_ports(hw_regs_t *hw,
					   ide_ioreg_t data_port,
					   ide_ioreg_t ctrl_port, int *irq)
{
	ide_ioreg_t reg = data_port;
	int i;

	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
		hw->io_ports[i] = reg;
		reg += 1;
	}
	if (ctrl_port) {
		hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;
	} else {
		hw->io_ports[IDE_CONTROL_OFFSET] = hw->io_ports[IDE_DATA_OFFSET] + 0x206;
	}
	if (irq != NULL)
		*irq = 0;
	hw->io_ports[IDE_IRQ_OFFSET] = 0;
}

For platforms that have weird register layouts or whatever, we should
have a probe routine that finds the device and sets up the ports.  See
drivers/ide/ide-pmac.c for an example.  IOW, it would be good if
drivers/ide/ide-m8xx.c could be converted to have an m8xx_ide_probe
routine that would work out how many 8xx-style IDE interfaces there
are, and for each one find a slot in ide_hwifs and initialize it like
m8xx_ide_init_hwif_ports now does.

Platforms with a PCI IDE controller should use the pci-ide driver
instead of trying to use ide_default_io_base and ide_init_hwif_ports
to point the IDE code at the IDE registers.  In other words, only
those platforms with an ISA IDE controller (prep, any others?) should
ever need to have their ide_default_io_base return anything other than
0.

So I am proposing to drop ppc_md.ide_init_hwif_ports and change the
definition of ide_init_hwif_ports in include/asm-ppc/ide.h to the one
above.

Comments?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
