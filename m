Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E19F22BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 22:31:14 +1100 (EST)
Message-ID: <41DA7E7A.3070901@gmx.de>
Date: Tue, 04 Jan 2005 12:31:06 +0100
From: Sebastian Heutling <sheutlin@gmx.de>
MIME-Version: 1.0
To: Marc Dietrich <marvin24@gmx.de>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200412272237.57241.marc.dietrich@ap.physik.uni-giessen.de>
	<1104625860.10369.34.camel@weizen.left.earth>
	<200501031326.34477.marvin24@gmx.de>
In-Reply-To: <200501031326.34477.marvin24@gmx.de>
Content-Type: multipart/mixed; boundary="------------080406070108060202090102"
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080406070108060202090102
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,


Marc Dietrich wrote:

>Hi Christian,
>  
>
Erm ... I'm Sebastian ;-)

>Am Sonntag, 2. Januar 2005 01:31 schrieb Sebastian Heutling:
>  
>
>>You don't really need to change any IRQ above slot 9 on a 2.6.? kernel
>>because the slot is 2 (while it was on 12 in 2.4 kernels).
>>    
>>
>
>ah yes, now I understand. You just copied all numbers from top to down. 
>  
>
Yep.

>  
>
>>>[...]
>>>PCI: Probing PCI hardware
>>>Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
>>>PCI: Cannot allocate resource region 5 of device 0000:00:01.1
>>>      
>>>
>>This is the IDE chip which gets IRQ 0 and therefore results in an error.
>>Try changing the value of Slot 1 from 0 to 4 (which is IRQ 14). I don't
>>really think it changes the SCSI timeouts maybe it helps - no one knows
>>for sure ;).
>>    
>>
>
>Ok - did that also.
>
>  
>
>>>SCSI subsystem initialized
>>>[...]
>>>PCI: Enabling device 0000:00:02.0 (0000 -> 0003)
>>>sym0: <825a> rev 0x13 at pci 0000:00:02.0 irq 15
>>>      
>>>
>
>so I guess 0000:00:02.0 is right as oposed to 0000:00:0C.0 with 2.4 kernels.
>  
>
Yes.

>  
>
>>>[...]
>>>new BADLUNTBL [ 256] @c7d9aa00.
>>>sym0: SCSI BUS has been reset.
>>>scsi0 : sym-2.1.18m
>>>elevator: using anticipatory as default io scheduler
>>>sym0:0:0:ccb @c7d9ac00 using tag 256.
>>>sym0: queuepos=2.
>>>sym0:0:0: ABORT operation started.
>>>sym0:0:0: ABORT operation timed-out.
>>>sym0:0:0: DEVICE RESET operation started.
>>>sym0:0:0: DEVICE RESET operation timed-out.
>>>sym0:0:0: BUS RESET operation started.
>>>sym0:0:0: BUS RESET operation timed-out.
>>>sym0:0:0: HOST RESET operation started.
>>>sym0:0:0:ccb @c7d9ac00 freeing tag 256.
>>>sym0: SCSI BUS has been reset.
>>>[ hangs here ]
>>>      
>>>
>>Hmmm strange ... is there anything attached on scsi?
>>    
>>
>
>Yes - a hard disk and a cdrom. Both are working under 2.4 kernels (see the 
>boot.log of the 2.4.24-pre1 kernel). I don't use net boot. My system (debian 
>sarge) is installed on sda3. Anyway - also on a netboot system, the kernel 
>should hang when trying to initialize the scsi controler.
>
>  
>
>>... wait a second ... looking at the lspci output ... you use a USB PCI
>>card? The IRQ-sharing doesn't work well and the USB PCI card is on the
>>same slot as the SCSI controller resulting in both using the same IRQ.
>>Remove the USB card and check wether it changes anything. If it does
>>work now: Did it ever work with USB using another kernel? If so maybe
>>there is something else wrong, if not it's a HW Problem.
>>I also attached a config file from my powerstack (which I use as a
>>router and runs a 2.6 kernel since june last year or so)
>>    
>>
>
>I didn't checked if the usb card is working under a 2.4 kernel, but it boots 
>without problems. I removed it now, just to eleminate possible trouble.
>
>I setup a kernel using your config file and added vga console and offb and 
>removed the nfs drivers to get an image smaller then 1.44 Mb (I'm using 
>XFree86-3.3.6 with the cirrus 5664 card). This has the same effect than 
>before: scsi not working. 
>
>It seems, that this config is not for a 2.6.10 kernel. What kernel version are 
>you using? Maybe some bad things happened in newer kernels.
>  
>
I am using a 2.6.8 (I was too lazy to patch & compile a 2.6.9 and wanted 
to test 2.6.10 when it's (the sources) in debian/unstable).

>Can you put a working zImage.prep somewhere on the web (<1.44 MB, so I can 
>write it to a floppy disk)? 
>  
>
I will do that and tell you later where you can download it.

>How does your boot.log looks like?
>  
>
Attached it.
Note that I use a Matrox MilleniumII gfx card and XFree4 runs fine 
(without any crash) since I got a 2.6 kernel running (although I am not 
using XFree because I use the Powerstack as a router/server which has no 
Monitor).


Sebastian


--------------080406070108060202090102
Content-Type: text/plain;
 name="boot.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot.log"

Total memory = 256MB; using 512kB for hash table (at c0380000)
Linux version 2.6.8 (root@sengor) (gcc version 3.3.5 (Debian 1:3.3.5-2)) #8 Tue Nov 9 15:59:40 CET 2004
PReP architecture
On node 0 totalpages: 65536
  DMA zone: 65536 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/sda2 console=ttyS0
PID hash table entries: 2048 (order 11: 16384 bytes)
time_init: decrementer frequency = 16.657680 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 255232k available (2204k kernel code, 1144k data, 160k init, 0k highmem)
Calibrating delay loop... 299.00 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
Setting PCI interrupts for a "Utah (Powerstack II Pro4000)"
PCI: Cannot allocate resource region 5 of device 0000:00:01.1
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
PCI: Enabling device 0000:00:08.0 (0080 -> 0082)
matroxfb: Matrox Millennium (PCI) detected
matroxfb: 640x480x8bpp (virtual: 640x6553)
matroxfb: framebuffer at 0xC1800000, mapped to 0xf1800000, size 4194304
fb0: MATROX frame buffer device
fb0: initializing hardware
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 80x30
Macintosh non-volatile memory driver v1.1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller at PCI slot 0000:00:01.1
PCI: Enabling device 0000:00:01.1 (0000 -> 0001)
W82C105: chipset revision 5
W82C105: 100% native mode on irq 14
W82C105: dma_base is invalid (0x0000)
ide0: W82C105 Bus-Master DMA disabled (BIOS)
W82C105: dma_base is invalid (0x0000)
ide1: W82C105 Bus-Master DMA disabled (BIOS)
Probing IDE interface ide0...
hda: ST380021A, ATA DISK drive
hdb: IBM-DTLA-305040, ATA DISK drive
hda: selected PIO 4 (120ns) (0240)
hdb: selected PIO 4 (120ns) (0240)
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63
 hda: hda1
hdb: max request size: 128KiB
hdb: 80418240 sectors (41174 MB) w/380KiB Cache, CHS=65535/16/63
 hdb: hdb1
PCI: Enabling device 0000:00:02.0 (0000 -> 0003)
sym0: <825a> rev 0x13 at pci 0000:00:02.0 irq 15
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
  Vendor: IBM       Model: DPSS-309170N      Rev: S93E
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:0:0): Beginning Domain Validation
sym0:0: wide asynchronous.
sym0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100.0 ns, offset 8)
scsi(0:0:0:0): Ending Domain Validation
st: Version 20040403, fixed bufsize 32768, s/g segs 256
SCSI device sda: 16777216 512-byte hdwr sectors (8590 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
atkbd.c: keyboard reset failed on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
atkbd.c: keyboard reset failed on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k init 36k pmac 4k chrp 4k openfirmware
Adding 262136k swap on /dev/sda3.  Priority:-1 extents:1
EXT3 FS on sda2, internal journal
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:04.0 (0000 -> 0003)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media AUI (#2) described by a 21140 non-MII (0) block.
tulip0:  Index #1 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #8 config 3100 status 786b advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0x1800, 08:00:3E:29:2E:45, IRQ 11.
de2104x PCI Ethernet driver v0.7 (Mar 17, 2004)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: Setting full-duplex based on MII#8 link partner capability of 45e1.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2048 buckets, 16384 max) - 296 bytes per conntrack
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Enabling device 0000:00:06.0 (0000 -> 0003)
eth1: 0000:00:06.0, 00:02:B3:1A:8C:72, IRQ 10.
  Board assembly 751767-003, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x8e695832).
PPP BSD Compression module registered
PPP Deflate Compression module registered
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
UDP: bad checksum. From 213.97.110.54:5889 to 83.129.181.72:4472 ulen 27
UDP: bad checksum. From 82.90.52.67:12826 to 83.129.248.97:4223 ulen 27
eth1: TX underrun, threshold adjusted.
eth1: TX underrun, threshold adjusted.
sym0:0:0: ABORT operation started.
sym0:0:0: ABORT operation timed-out.
sym0:0:0: ABORT operation started.
sym0:0:0: ABORT operation timed-out.
sym0:0:0: ABORT operation started.
sym0:0:0: ABORT operation timed-out.
sym0:0:0: ABORT operation started.
sym0:0:0: ABORT operation timed-out.
sym0:0:0: DEVICE RESET operation started.
sym0:0:0: DEVICE RESET operation timed-out.
sym0:0:0: BUS RESET operation started.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
sym0:0:0: BUS RESET operation complete.
eth1: TX underrun, threshold adjusted.
UDP: short packet: From 217.126.164.250:5676 33/27 to 83.129.160.15:11124
eth1: TX underrun, threshold adjusted.
UDP: short packet: From 82.254.199.92:1024 132/26 to 83.129.199.46:571
UDP: bad checksum. From 217.126.164.250:5676 to 83.129.174.118:5667 ulen 27
UDP: bad checksum. From 82.50.40.247:7689 to 83.129.1.186:4120 ulen 28
UDP: bad checksum. From 218.90.225.199:3357 to 83.129.16.247:3258 ulen 26
UDP: short packet: From 217.126.164.250:2960 11925/27 to 83.129.63.189:4662
UDP: short packet: From 83.129.64.153:888 0/27 to 83.129.70.178:13054
UDP: bad checksum. From 217.126.164.250:5676 to 83.129.70.178:3454 ulen 33
UDP: bad checksum. From 217.126.164.250:5676 to 83.129.70.178:12855 ulen 80

--------------080406070108060202090102--
