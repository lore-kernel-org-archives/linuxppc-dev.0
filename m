Return-Path: <hans.schillstrom@commet.se>
Received: from proxy.commet.se (unknown [213.204.187.35])
	by ozlabs.org (Postfix) with ESMTP id 4D435679F0
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2006 23:22:29 +1100 (EST)
Received: from skalman.commet.se (unknown [172.23.1.1])
	by proxy.commet.se (Postfix) with ESMTP id 8FF851F2AB
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2006 12:56:32 +0100 (CET)
Subject: Broken pcmcia on m8xx.
From: Hans Schillstrom <hans@commet.se>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 12:24:40 +0100
Message-Id: <1140434681.2801.45.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello
I'm trying to get a flash disk working with 2.6.15 kernel 
on a TQM860L board.( With 2.4.25 it works perfect.)

I added a printk in ide-probe.c to see the result from IDE_SELECT_REG
and it was 0xff ...
Does any one has an idea where to start searching or knows what is
wrong ? 

Added some printouts from u-boot, linux 2.4.25 and 2.6.15

/Hans

U-BOOT Startup message:
=======================
PCMCIA: 3.3V card found: SanDisk SDP 5/3 0.6
            Fixed Disk Card
            IDE interface
            [silicon] [unique] [single] [sleep] [standby] [idle] [low
power]
Bus 0: OK
  Device 0: Model: SanDisk SDCFB-1024 Firm: Rev 0.00 Ser#: X0406
20050813225551
            Type: Removable Hard Disk
            Capacity: 977.4 MB = 0.9 GB (2001888 x 512)

Kernel 2.4.25 Startup:
======================
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)
Card ID: SanDisk SDP 5/3 0.6
 Fixed Disk Card
 IDE interface
 [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
Probing IDE interface ide0...
hda: probing with STATUS(0x50) instead of ALTSTATUS(0xf6)
hda: SanDisk SDCFB-1024, CFA DISK drive
hdb: probing with STATUS(0x50) instead of ALTSTATUS(0xf6)
hdb: probing with STATUS(0x50) instead of ALTSTATUS(0xf6)
hdb: probing with STATUS(0x50) instead of ALTSTATUS(0xf6)
hdb: probing with STATUS(0x50) instead of ALTSTATUS(0xf6)
ide0 at 0x460df320-0x460df327,0x420df106 on irq 13
hda: attached ide-disk driver.
hda: 2001888 sectors (1025 MB) w/1KiB Cache, CHS=1986/16/63
Partition check:
 hda: [PTBL] [993/32/63] hda1
TQM8xxL Bank 0: Found 2 x16 devices at 0x400000 in 32-bit mode


Kernel 2.6.15 startup:
========================
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
init_hwif_default()
PCMCIA slot B: phys mem e0000000...ec000000 (size 0c000000)
Card ID: SanDisk SDP 5/3 0.6
 Fixed Disk Card
 IDE interface
 [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
probing for hda: present=0, media=32, probetype=ATA
do_probe(ret:255)


Here is the my small modification of do_probe.


static int do_probe (ide_drive_t *drive, u8 cmd)
{
...
	/* needed for some systems
	 * (e.g. crw9624 as drive0 with disk as slave)
	 */
	ide_delay_50ms();
	SELECT_DRIVE(drive);
	ide_delay_50ms();
	printk("do_probe(inb:%d)\n",hwif->INB(IDE_SELECT_REG));
	if (hwif->INB(IDE_SELECT_REG) != drive->select.all && !drive->present)
{
		if (drive->select.b.unit != 0) {
			/* exit with drive0 selected */
			SELECT_DRIVE(&hwif->drives[0]);
			/* allow BUSY_STAT to assert & clear */
			ide_delay_50ms();
		}
		/* no i/f present: mmm.. this should be a 4 -ml */
		return 3;
	}
...
