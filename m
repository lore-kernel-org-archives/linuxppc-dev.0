Return-Path: <acrux_it@libero.it>
Received: from outrelay08.libero.it (outrelay08.libero.it [212.52.84.112])
 by ozlabs.org (Postfix) with ESMTP id BE06B1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 06:31:45 +1100 (EST)
Date: Wed, 7 Dec 2011 20:30:48 +0100
From: acrux <acrux_it@libero.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pata_sl82c105 is unable to properly handle dma (indeed it try
 to use mwdma2)
Message-Id: <20111207203048.e0a1f143.acrux_it@libero.it>
In-Reply-To: <1323224488.660.33.camel@pasglop>
References: <28546010.491181323220500482.JavaMail.defaultUser@defaultHost>
 <1323224488.660.33.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 07 Dec 2011 13:21:28 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2011-12-07 at 02:15 +0100, acrux_it@libero.it wrote:
> > New pata_sl82c105 is unable to properly handle dma (indeed it try to use 
> > mwdma2).
> > Old ide driver instead worked fine.
> > 
> > Tested on IBM 9114-275 where to use it i must boot with dma disabled i.e. with 
> > libata.dma=0
> 
> Adding the linux-ide list on CC. Can you also send a dmesg with the old
> IDE driver ? It might be useful to compare the values programmed by the
> 2 versions of the driver in the timing registers.
> 

hi Ben,
booting with a CRUX PPC (64bit) 2.6  with kernel linux-2.6.32.3 with old sl82c105 ide driver.

Here topic section from lspci -vvv

0000:00:03.0 ISA bridge: Symphony Labs W83C553F/W83C554F (rev 10)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0

0000:00:03.1 IDE interface: Symphony Labs SL82c105 (rev 05) (prog-if 8f [Master SecP SecO PriP PriO])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 72 (500ns min, 10000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 165
        Region 0: I/O ports at f000 [size=8]
        Region 1: I/O ports at f010 [size=4]
        Region 2: I/O ports at f020 [size=8]
        Region 3: I/O ports at f030 [size=4]
        Region 4: I/O ports at f040 [size=16]
        Region 5: I/O ports at <unassigned>
        Kernel driver in use: W82C105_IDE



An here it is the dmesg:


[...]
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00100000
[boot]0015 Setup Done
PERCPU: Embedded 12 pages/cpu @c000000000a00000 s17480 r0 d31672 u524288
pcpu-alloc: s17480 r0 d31672 u524288 alloc=1*1048576
pcpu-alloc: [0] 0 1
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1034240
Policy zone: DMA
Kernel command line: root=/dev/hda ro console=ttyS0,9600
PID hash table entries: 4096 (order: 3, 32768 bytes)
freeing bootmem node 0
Memory: 4033656k/4194304k available (7844k kernel code, 160648k reserved, 1308k)
SLUB: Genslabs=14, HWalign=128, Order=0-3, MinObjects=0, CPUs=2, Nodes=256
Hierarchical RCU implementation.
NR_IRQS:512
[boot]0020 XICS Init
[boot]0021 XICS Done
i8259 legacy interrupt controller initialized
clocksource: timebase mult[160a04b] shift[22] registered
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
Processor 1 found.
Brought up 2 CPUs
NET: Registered protocol family 16
IBM eBus Device Driver
PCI: Probing PCI hardware
pci 0000:00:02.0: PME# supported from D1 D2 D3hot
pci 0000:00:02.0: PME# disabled
pci 0000:00:02.2: PME# supported from D1 D2 D3hot
pci 0000:00:02.2: PME# disabled
pci 0000:00:02.4: PME# supported from D1 D2 D3hot
pci 0000:00:02.4: PME# disabled
pci 0000:00:02.6: PME# supported from D1 D2 D3hot
pci 0000:00:02.6: PME# disabled
Using INTC for W82c105 IDE controller.
IOMMU table initialized, virtual merging enabled
pci 0000:01:01.0: PME# supported from D1 D2 D3hot D3cold
pci 0000:01:01.0: PME# disabled
pci 0000:21:01.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:21:01.0: PME# disabled
pci 0001:00:02.0: PME# supported from D1 D2 D3hot
pci 0001:00:02.0: PME# disabled
pci 0001:00:02.2: PME# supported from D1 D2 D3hot
pci 0001:00:02.2: PME# disabled
pci 0001:00:02.3: PME# supported from D1 D2 D3hot
pci 0001:00:02.3: PME# disabled
pci 0001:00:02.4: PME# supported from D1 D2 D3hot
pci 0001:00:02.4: PME# disabled
pci 0001:00:02.6: PME# supported from D1 D2 D3hot
pci 0001:00:02.6: PME# disabled
pci 0001:21:01.0: PME# supported from D0 D1 D2 D3hot
pci 0001:21:01.0: PME# disabled
pci 0001:31:01.0: PME# supported from D0 D1 D2 D3hot
pci 0001:31:01.0: PME# disabled
pci 0001:31:01.1: PME# supported from D0 D1 D2 D3hot
pci 0001:31:01.1: PME# disabled
pci 0001:41:01.0: PME# supported from D0 D3hot D3cold
pci 0001:41:01.0: PME# disabled
PCI: Cannot allocate resource region 2 of PCI bridge 1, will remap
PCI: Cannot allocate resource region 2 of PCI bridge 33, will remap
PCI: Cannot allocate resource region 2 of PCI bridge 65, will remap
PCI: Cannot allocate resource region 2 of PCI bridge 97, will remap
PCI: Cannot allocate resource region 2 of PCI bridge 1, will remap
PCI: Cannot allocate resource region 2 of PCI bridge 33, will remap
PCI: Cannot allocate resource region 2 of PCI bridge 49, will remap
PCI: Cannot allocate resource region 2 of PCI bridge 65, will remap
PCI: Cannot allocate resource region 2 of PCI bridge 97, will remap
PCI: Cannot allocate resource region 0 of device 0000:00:02.2, will remap
PCI: Cannot allocate resource region 0 of device 0000:00:02.4, will remap
PCI: Cannot allocate resource region 0 of device 0000:00:02.6, will remap
PCI: Cannot allocate resource region 0 of device 0001:00:02.2, will remap
PCI: Cannot allocate resource region 0 of device 0001:00:02.3, will remap
PCI: Cannot allocate resource region 0 of device 0001:00:02.4, will remap
PCI: Cannot allocate resource region 0 of device 0001:00:02.6, will remap
bio: create slab <bio-0> at 0
vgaarb: device added: PCI:0000:02:00.0,decodes=io+mem,owns=none,locks=none
vgaarb: device added: PCI:0001:61:01.0,decodes=io+mem,owns=none,locks=none
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switching to clocksource timebase
NET: Registered protocol family 2
Switched to NOHz mode on CPU #1
Switched to NOHz mode on CPU #0
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with security attributes, large block/inode numbers, no debug enabled
msgmni has been set to 7878
alg: No test for cipher_null (cipher_null-generic)
alg: No test for ecb(cipher_null) (ecb-cipher_null)
alg: No test for digest_null (digest_null-generic)
alg: No test for compress_null (compress_null-generic)
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler cfq registered (default)
matroxfb: Matrox G450 detected
PInS data found at offset 31168
PInS memtype = 5
matroxfb: 640x480x8bpp (virtual: 640x26214)
matroxfb: framebuffer at 0x3FD80000000, mapped to 0xd000080080080000, size 16776
Console: switching to colour frame buffer device 80x30
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
fb2: IBM GXT6500P frame buffer device
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x103f8 (irq = 4) is a 16550A
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
serial8250.0: ttyS1 at I/O 0x102f8 (irq = 3) is a 16550A
serial8250.0: ttyS2 at I/O 0x10898 (irq = 10) is a 16550A
Floppy drive(s): fd0 is 2.88M
FDC 0 is a National Semiconductor PC87306
brd: module loaded
loop: module loaded
nbd: registered device at major 43
Uniform Multi-Platform E-IDE driver
sl82c105 0000:00:03.1: IDE controller (0x10ad:0x0105 rev 0x05)
pci 0000:00:03.1: enabling device (0144 -> 0145)
sl82c105 0000:00:03.1: 100% native mode on irq 165
    ide0: BM-DMA at 0x1f040-0x1f047
    ide1: BM-DMA at 0x1f048-0x1f04f
hda: IBM DROM00205, ATAPI CD/DVD-ROM drive
hda: MWDMA2 mode selected
ide0 at 0x1f000-0x1f007,0x1f012 on irq 165 (serialized)
ide1 at 0x1f020-0x1f027,0x1f032 on irq 165 (serialized)
ide-gd driver 1.18
ide-cd driver 5.00
ide-cd: hda: ATAPI 24X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.20
megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
megasas: 00.00.04.01 Thu July 24 11:41:51 PST 2008
3ware 9000 Storage Controller device driver for Linux v2.26.02.012.
ipr: IBM Power RAID SCSI Device Driver version: 2.4.3 (June 10, 2009)
ipr 0000:41:01.0: Found IOA with IRQ: 167
ipr 0000:41:01.0: Starting IOA initialization sequence.
ipr 0000:41:01.0: Adapter firmware version: 070A0011
ipr 0000:41:01.0: IOA initialized.
scsi0 : IBM 570B Storage Adapter
scsi 0:0:3:0: Direct-Access     IBM      IC35L073UCDY10-0 S2AA PQ: 0 ANSI: 3
scsi 0:0:15:0: Enclosure         IBM      VSBPD4E1  U4SCSI 4610 PQ: 0 ANSI: 2
scsi: unknown device type 31
scsi 0:255:255:255: No Device         IBM      570B001          0150 PQ: 0 ANSI0
st: Version 20081215, fixed bufsize 32768, s/g segs 256
sd 0:0:3:0: Attached scsi generic sg0 type 0
scsi 0:0:15:0: Attached scsi generic sg1 type 13
sd 0:0:3:0: [sda] 143374650 512-byte logical blocks: (73.4 GB/68.3 GiB)
scsi 0:255:255:255: Attached scsi generic sg2 type 31
sd 0:0:3:0: [sda] Write Protect is off
sd 0:0:3:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DA
console [netcon0] enabled
netconsole: network logging started
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd 0001:31:01.0: OHCI Host Controller
ohci_hcd 0001:31:01.0: new USB bus registered, assigned bus number 1
ohci_hcd 0001:31:01.0: irq 182, io mem 0x3fdd5001000
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
ohci_hcd 0001:31:01.1: OHCI Host Controller
ohci_hcd 0001:31:01.1: new USB bus registered, assigned bus number 2
sd 0:0:3:0: [sda] Attached SCSI disk
ohci_hcd 0001:31:01.1: irq 182, io mem 0x3fdd5000000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
uhci_hcd: USB Universal Host Controller Interface driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
atkbd.c: keyboard reset failed on isa0060/serio0
usbcore: registered new interface driver hiddev
atkbd.c: keyboard reset failed on isa0060/serio1
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
TCP cubic registered
NET: Registered protocol family 10
NET: Registered protocol family 17
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: Scanned 0 and added 0 devices.
md: autorun ...
md: ... autorun DONE.
VFS: Mounted root (iso9660 filesystem) readonly on device 3:0.
Freeing unused kernel memory: 328k freed
INIT: version 2.86 booting
The system is coming up.  Please wait.
Intel(R) PRO/1000 Network Driver - version 7.3.21-k5-NAPI
e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
e100 0000:21:01.0: enabling device (0140 -> 0143)
e100 0000:21:01.0: PME# disabled
e100: eth0: e100_probe: addr 0x3fd88030000, irq 166, MAC addr 00:09:6b:2e:ab:53
Copyright (c) 1999-2006 Intel Corporation.
e1000 0001:41:01.0: enabling device (0140 -> 0143)
e1000: 0001:41:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:09:6b:be:a8:77
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
INIT: Entering runlevel: 2


CRUX PPC (64bit) (ttyS0)

(none) login:




cheers,
--nico
-- 
acrux <acrux_it@libero.it>
