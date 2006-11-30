Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 6F7AA67A5E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 06:52:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: 2 PCI devices behind PCI bridge on Yosemite board.
Date: Thu, 30 Nov 2006 11:52:52 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C99D6F2@ehost011-3.exch011.intermedia.net>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
Cc: Balajee Premraj <balajee@a-k-a.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

I need 2 PCI boards (ATMEL Dream Chip reference and Silicon Image 680
PCI-ATA) working simultaneously on AMCC PPC440EP Yosemite board. However
since Yosemite has only 1 PCI slot, I resorted to use PCI riser with
Intel S21152BB PCI bridge. This slot is connected to IRQ2 pin of
PPC440EP which is mapped to IRQ25 in Linux.

Both boards are identified by Linux kernel which sees 3 devices on this
slot (including bridge itself):

~ # cat /proc/bus/pci/devices
0060    8086b152        19      00000000        00000000        00000000
00000000        00000000        00000000        00000000   0
0000000 00000000        00000000        00000000        00000000
00000000        00000000
0120    14389707        19      0000fff1        00000000        00000000
00000000        00000000        00000000        00000000   0
0000010 00000000        00000000        00000000        00000000
00000000        00000000        Dreamchip
0130    10950680        19      0000ffe9        0000ffe5        0000ffd9
0000ffd5        0000ffc1        afffff00        00000000   0
0000008 00000004        00000008        00000004        00000010
00000100        00080000        SiI_IDE

There is HDD behind Silicon Image chip:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
SiI680: IDE controller at PCI slot 0000:01:06.0
SiI680: chipset revision 2
SiI680: BASE CLOCK =3D=3D 133
SiI680: 100% native mode on irq 25
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 6L100P0, ATA DISK drive
ide0 at 0xd105cf80-0xd105cf87,0xd105cf8a on irq 25
hda: max request size: 64KiB

As can be seen both devices share the same interrupt 25 (I have compiled
kernel with IDEPCI_SHARE_IRQ option though I'm not sure it's important).

If Dreamchip card does nothing, I can successfully operate with HDD
behind Silicon Image including reading/writing files:

# fdisk -ul /dev/hda

Disk /dev/hda: 100.2 GB, 100256292864 bytes
255 heads, 63 sectors/track, 12188 cylinders, total 195813072 sectors
Units =3D sectors of 1 * 512 =3D 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *          63      208844      104391   83  Linux
/dev/hda2          208845     2249099     1020127+  82  Linux swap
/dev/hda3         2249100   195800219    96775560   83  Linux

Problem starts when I work with Dreamchip. Interrupt arrives from it and
kernel doesn't know what to do with this interrupt and it gets disabled.
Looks like interrupt doesn't get acknowledged properly.

I tried to register Dreamchip PCI device by 2 ways:

1) I request interrupt and provide as interrupt handler empty function:

irqreturn_t snd_dream_interrupt(int irq, void *dev_id, struct pt_regs
*regs)
{
	return IRQ_NONE;
}

Kernel output when Dreamchip interrupts:

irq 25: nobody cared (try booting with the "irqpoll" option)
Call trace:
 [c003ac40] __report_bad_irq+0x34/0xac
 [c003af60] note_interrupt+0x2a8/0x334
 [c003a644] __do_IRQ+0x198/0x1b0
 [c0003908] do_IRQ+0x38/0x98
 [c000253c] ret_from_except+0x0/0x18
handlers:
[<c01680fc>] (ide_intr+0x0/0x308)
[<c020a948>] (snd_dream_interrupt+0x0/0x8)
Disabling IRQ #25

2) Because I don't need interrupt from Dreamchip anyway, I tried don't
request interrupt upon Dreamchip PCI driver registration. Result was the
same though kernel output different:

irq 25: nobody cared (try booting with the "irqpoll" option)
Call trace:
 [c003ac40] __report_bad_irq+0x34/0xac
 [c003af60] note_interrupt+0x2a8/0x334
 [c003a644] __do_IRQ+0x198/0x1b0
 [c0003908] do_IRQ+0x38/0x98
 [c000253c] ret_from_except+0x0/0x18
 [c007780c] vfs_ioctl+0xf8/0x45c
 [c0077bb0] sys_ioctl+0x40/0x74
 [c0001e34] ret_from_syscall+0x0/0x48
handlers:
[<c01680fc>] (ide_intr+0x0/0x308)
Disabling IRQ #25

Any ideas what I have done wrong? Can I just tell to the bridge don't
interrupt CPU if Dreamchip is interrupting?

Thanks,

Leonid.
