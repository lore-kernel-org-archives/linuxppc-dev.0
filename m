Return-Path: <sr@denx.de>
Received: from natblindhugh.rzone.de (natblindhugh.rzone.de [81.169.145.175])
	by ozlabs.org (Postfix) with ESMTP id A040F68757
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 02:05:46 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 17 Nov 2005 16:05:31 +0100
References: <20051116121846.1C1BD1FD0@smtp.263.net>
In-Reply-To: <20051116121846.1C1BD1FD0@smtp.263.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511171605.32365.sr@denx.de>
Subject: Re: 11-16-05 2.6.14 on AMCC Yosemite board(PCI-IDE card boot error)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kylong,

On Wednesday 16 November 2005 13:18, KylongMu wrote:
> Dear Denk,

BTW: It's either Wolfgang or Mr. Denk.

>      Thanks for your help; it makes my Yosemite run up! I'm try to add a
> PCI-IDE
>
> Card on it. I test my Promise-PDC20268 card and AEC6280 (ATP865-B chip
> type) card,
>
> Both of them all failed with same error, the boot message included in the
> attachment.

Sorry, but we don't have such a PCI IDE controller available. So we did test 
with a Promise SATA controller:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ata1: SATA max UDMA/133 cmd 0xD1008200 ctl 0xD1008238 bmdma 0x0 irq 25
ata2: SATA max UDMA/133 cmd 0xD1008280 ctl 0xD10082B8 bmdma 0x0 irq 25
ata3: SATA max UDMA/133 cmd 0xD1008300 ctl 0xD1008338 bmdma 0x0 irq 25
ata4: SATA max UDMA/133 cmd 0xD1008380 ctl 0xD10083B8 bmdma 0x0 irq 25
ata1: no device found (phy stat 00000000)
scsi0 : sata_promise
ata2: no device found (phy stat 00000000)
scsi1 : sata_promise
ata3: no device found (phy stat 00000000)
scsi2 : sata_promise
ata4: dev 0 ATA-7, max UDMA/133, 490234752 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_promise
  Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write back
 sda: sda1
sd 3:0:0:0: Attached scsi disk sda
...

bash-3.00# lspci -v
00:0c.0 Class 0180: 105a:3d18 (rev 02)
        Subsystem: 105a:3d18
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 25
        I/O ports at ff80 [size=128]
        I/O ports at fe00 [size=256]
        Memory at 00000000affff000 (32-bit, non-prefetchable) [size=4K]
        Memory at 00000000affc0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at 0000000000080000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2

bash-3.00# cat /proc/scsi/scsi       
Attached devices:
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: Maxtor 7Y250M0   Rev: YAR5
  Type:   Direct-Access                    ANSI SCSI revision: 05

bash-3.00# fdisk -l /dev/sda

Disk /dev/sda: 251.0 GB, 251000193024 bytes
255 heads, 63 sectors/track, 30515 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1       30515   245111706   83  Linux
bash-3.00# mke2fs -m0 -j /dev/sda1
mke2fs 1.38 (30-Jun-2005)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
30654464 inodes, 61277926 blocks
0 blocks (0.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=62914560
1871 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 
2654208, 
        4096000, 7962624, 11239424, 20480000, 23887872

Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 39 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
bash-3.00# mount /dev/sda1 /mnt
mount: unknown filesystem type 'ext3'
bash-3.00# mount -t ext2 /dev/sda1 /mnt
EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem as 
ext2

bash-3.00# df -h /mnt
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda1             231G  189M  230G   1% /mnt
bash-3.00# cd /tmp/bonnie
bash-3.00# ./Bonnie -m yosemite -s 256  -d /mnt
Bonnie 1.4: File '/mnt/Bonnie.423', size: 268435456, volumes: 1
Writing with putc()...         done:   4492 kB/s  99.5 %CPU
Rewriting...                   done:   9576 kB/s  12.4 %CPU
Writing intelligently...       done:  17375 kB/s  12.9 %CPU
Reading with getc()...         done:   4278 kB/s  95.6 %CPU
Reading intelligently...       done:  49108 kB/s  41.4 %CPU
Seeker 1...Seeker 2...Seeker 3...start 'em...done...done...done...
              ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd 
Seek-
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k 
(03)-
Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec 
%CPU
yosemi 1* 256  4492 99.5 17375 12.9  9576 12.4  4278 95.6 49108 41.4 2395.4 
27.3



Everything is working fine with this PCI board. So it can't be a Yosemite 
related problem. Sorry, can't help you here.

Best regards,
Stefan
