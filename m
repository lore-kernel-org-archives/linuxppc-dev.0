From: kvsukesh@yahoo.com
Message-ID: <20010807174850.48250.qmail@web10406.mail.yahoo.com>
Date: Tue, 7 Aug 2001 10:48:50 -0700 (PDT)
Subject: Trouble getting the DMA work in IDE Driver  in kernel 2.4.2
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am having some trouble getting the drivers
for the IDE/ATA 100 ( iam using cmd 649 & and an IBM
Deskstar )work in the DMA mode running kernel 2.4.2
on a PPC405GP.
If anybody has seen this problem, or has a fix for it
please respond.
I tried to enable the DMA using hdparam -d1 /dev/hda
but it fails. I  looked into the code and put some
printk's and found that the dma_base is set to 0 in
the file ide-dma.cin the function
ide_get_or_set_dma_base where it goes to
the default case of the switch statement. Which
results  in failure of the ioctl call to set the DMA
from hdparm.
What I understood is that the cmd649 is recognised as
a simplex device because of which the dma_base is set
to zero, but could not understand why ?

thanks in advance
SUKESH



Below is the boot up message log..
-----------------------------------
CMD649: IDE controller on PCI bus 00 dev 18
> PCI: Enabling device 00:03.0 (0000 -> 0001)
> CMD649: chipset revision 2
> CMD649: not 100% native mode: will probe irqs later
> CMD649: simplex device: DMA disabled
> ide0: BM-DMA at 0x0060-0x0067, BIOS settings:
hda:pio, hdb:pio
> ide1: BM-DMA at 0x0068-0x006f, BIOS settings:
hdc:pio, hdd:pio
> hda: probing with STATUS(0x50) instead of
ALTSTATUS(0xff)
> hda: IC35L040AVER07-0, ATA DISK drive
> hda: IRQ probe failed (0x0)
> hdb: probing with STATUS(0x00) instead of
ALTSTATUS(0xff)
> hdb: IRQ probe failed (0x0)
> hdb: probing with STATUS(0x00) instead of
ALTSTATUS(0xff)
> hdb: IRQ probe failed (0x0)
> ide: Assuming 33MHz system bus speed for PIO modes;
override with
idebus=xx
> ide0 at 0x040-0x047,0x246 on irq 30
> hda: 80418240 sectors (41174 MB) w/1916KiB Cache,
CHS=79780/16/63
> Partition check:
> hda: unknown partition table


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
