Date: Mon, 29 May 2000 14:16:49 +0200 (MET DST)
From: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_dmaproc - YaBoot
In-Reply-To: <200005281535.RAA03544@piglet.grunz.lu>
Message-ID: <Pine.OSF.4.02.10005291409200.26038-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
ok I applied your 2.3.99-pre9 patches to 2.4.0.test1-ac4 sources and at
least the drive is recognized again. dmesg reads:
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
AEC6260R: IDE controller on PCI bus 00 dev 68
AEC6260R: chipset revision 1
AEC6260R: not 100% native mode: will probe irqs later
AEC6260R: ROM enabled at 0x80810000
AEC6260: reg49h=0x00 ATA-66 Cable Port0
    ide0: BM-DMA at 0xf2000800-0xf2000807, BIOS settings: hda:pio, hdb:pio
AEC6260: reg49h=0x00 ATA-66 Cable Port1
    ide1: BM-DMA at 0xf2000808-0xf200080f, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DJNA-352030, ATA DISK drive
ide0 at 0xf2000840-0xf2000847,0x000 on irq 23
hda: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=39560/16/63,
UDMA(66)

but I'm back at the lost interrupt :-(

Partition check:
 hda:hda: lost interrupt
hda: lost interrupt
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
 hda1ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
 hda2 hda3ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
 hda4 hda5ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
 hda6 hda7ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
 hda8 hda9

I was wondering after Ben's commend if OF sets the bummaster correct for
the card. Or if I should do something like:
      pci_read_config_word( pdev, PCI_COMMAND, &cmd );
      cmd |= (PCI_COMMAND_MEMORY | PCI_COMMAND_IO);
      pci_write_config_word( pdev, PCI_COMMAND, cmd );

How do I verify the busmaster operation is set up cerrectly ?

Henning

--------------------------------------------------------------------------
Henning Loeser					      Fachbereich Physik
email: henning.loeser@physik.uni-marburg.de	      AG Oberflaechen
						      Philipps-Uni Marburg


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
