Date: Tue, 27 Nov 01 09:10:13 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111271710.AA24459@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: VT82C686B IDE and Linux/PPC woes
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox <adrian@humboldt.co.uk> wrote:

> Could there be something wrong with your ppc_ide_md.ide_init_hwif
> function?

Aha, I didn't have one. I wrote one:

static void __init
adir_ide_init_hwif_ports (hw_regs_t *hw, ide_ioreg_t data_port,
		ide_ioreg_t ctrl_port, int *irq)
{
	ide_ioreg_t reg = data_port;
	int i;

	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
		hw->io_ports[i] = reg;
		reg += 1;
	}
	hw->io_ports[IDE_CONTROL_OFFSET] = ctrl_port;

	if (irq != NULL)
		*irq = hw->irq;
}

But now I get this:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 19
VP_IDE: chipset revision 6
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:03.1
VP_IDE: 100% native mode on irq 14
    ide0: BM-DMA at 0xffffd0-0xffffd7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffffd8-0xffffdf, BIOS settings: hdc:pio, hdd:pio
hda: no response (status = 0xa1), resetting drive
hda: no response (status = 0xa1)
hdb: no response (status = 0xa1), resetting drive
hdb: no response (status = 0xa1)
hdc: no response (status = 0xa1), resetting drive
hdc: no response (status = 0xa1)
hdd: no response (status = 0xa1), resetting drive
hdd: no response (status = 0xa1)

Any ideas? Again just prior to booting Linux I can poke the IDE registers and
see the drive using my firmware.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
