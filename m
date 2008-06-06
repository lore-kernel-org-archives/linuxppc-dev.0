Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F4015DDF3C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:55:18 +1000 (EST)
Date: Thu, 5 Jun 2008 21:55:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: 2.6.26-rc5 DOA on mac g5
Message-Id: <20080605215511.85660cdf.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Might be a platform thing, might be an ATA thing:



irq 18: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[c0000000006cf770] [c0000000000120dc] .show_stack+0x58/0x1dc (unreliable)
[c0000000006cf820] [c0000000000a2d64] .__report_bad_irq+0x3c/0xac
[c0000000006cf8a0] [c0000000000a31f4] .note_interrupt+0x420/0x48c
[c0000000006cf9b0] [c0000000000a4398] .handle_fasteoi_irq+0x19c/0x20c
[c0000000006cfa50] [c00000000000ce30] .do_IRQ+0x98/0x12c
[c0000000006cfad0] [c000000000004790] hardware_interrupt_entry+0x18/0x1c
--- Exception: 501 at .cpu_idle+0x14c/0x154
    LR = .cpu_idle+0x14c/0x154
[c0000000006cfdc0] [c000000000013c68] .cpu_idle+0x118/0x154 (unreliable)
[c0000000006cfe60] [c000000000442074] .rest_init+0x74/0x8c
[c0000000006cfee0] [c0000000005b49b8] .start_kernel+0x3c0/0x464
[c0000000006cff90] [c00000000000857c] .start_here_common+0x3c/0x40
handlers:
[<c0000000006b8b50>] (ata_sff_interrupt+0x0/0x10)


config: http://userweb.kernel.org/~akpm/config-g5.txt



Linux version 2.6.26-rc5 (akpm@g5) (gcc version 3.4.4 20050721 (Yellow Dog 3.4.4-2.ydl.2)) #42 SMP Thu Jun 5 22:40:20 MDT 2008
[boot]0012 Setup Arch
Found U4-PCIE PCI host bridge.  Firmware bus number: 0->255
PCI host bridge /pci@0,f0000000  ranges:
 MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
  IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
 MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000090000000 
Can't get bus-range for /ht@0,f2000000, assume bus 0
Found U3-HT PCI host bridge.  Firmware bus number: 0->239
PCI host bridge /ht@0,f2000000 (primary) ranges:
SMU: Driver 0.7 (c) 2005 Benjamin Herrenschmidt, IBM Corp.
nvram: Checking bank 0...
nvram: gen0=136, gen1=137
nvram: Active bank is: 1
nvram: OF partition at 0x410
nvram: XP partition at 0x1020
nvram: NR partition at 0x1120
Zone PFN ranges:
  DMA             0 ->  1572864
  Normal    1572864 ->  1572864
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->   524288
    0:  1048576 ->  1572864
[boot]0015 Setup Done
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1027072
Kernel command line: root=/dev/sdb6 ro rhgb netconsole=4444@192.168.2.35/eth0,5146@192.168.2.111/00:19:D1:04:8F:42 pause_on_oops=1000 
mpic: Setting up MPIC " MPIC 1   " version 1.2 at f8040000, max 4 CPUs
mpic: ISU size: 124, shift: 7, mask: 7f
mpic: Initializing for 124 sources
mpic: Setting up HT PICs workarounds for U3/U4
mpic:   - HT:07.0 [0x90] vendor 106b device 0053 has 86 irqs
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: timebase mult[7800001] shift[22] registered
Console: colour dummy device 80x25
console handover: boot [udbg0] -> real [tty0]
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 4010472k/4194304k available (6140k kernel code, 2280364k reserved, 820k data, 230k bss, 300k init)
Mount-cache hash table entries: 256
device-tree: Duplicate name in /ht@0,f2000000/pci@8/mac-io@7/i2c@18000, renamed to "i2c-bus@0#1"
PowerMac SMP probe found 4 cpus
KeyWest i2c @0xf8001003 irq 16 /u4@0,f8000000/i2c@f8001000
 channel 1 bus /u4@0,f8000000/i2c@f8001000/i2c-bus@1
KeyWest i2c @0x80018000 irq 27 /ht@0,f2000000/pci@8/mac-io@7/i2c@18000
 channel 0 bus /ht@0,f2000000/pci@8/mac-io@7/i2c@18000/i2c-bus@0
 channel 0 bus /ht@0,f2000000/pci@8/mac-io@7/i2c@18000/i2c-bus@0
SMU i2c /smu@0,0/smu-i2c-control@0
 channel b bus /smu@0,0/smu-i2c-control@0/i2c-bus@b
 channel e bus /smu@0,0/smu-i2c-control@0/i2c-bus@e
Processor timebase sync using platform function
mpic: requesting IPIs ... 
Processor 1 found.
Processor 2 found.
Processor 3 found.
Brought up 4 CPUs
net_namespace: 568 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
IOMMU table initialized, virtual merging disabled
PCI: Closing bogus Apple Firmware region 2 on bus 0x0a
PCI: Closing bogus Apple Firmware region 2 on bus 0x02
PCI: Closing bogus Apple Firmware region 2 on bus 0x01
PCI: Closing bogus Apple Firmware region 2 on bus 0x03
PCI: Cannot allocate resource region 0 of device 0000:0a:00.0, will remap
PCI: Cannot allocate resource region 1 of device 0000:0a:00.0, will remap
PCI: Cannot allocate resource region 3 of device 0000:0a:00.0, will remap
PCI: Bridge: 0000:00:0b.0
  IO window: 0000-ffff
  MEM window: 0xa8000000-0xa9ffffff
  PREFETCH window: 0x0000000090000000-0x00000000a7ffffff
PCI: Bridge: 0001:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0001:00:02.0
  IO window: disabled.
  MEM window: 0xfa500000-0xfa5fffff
  PREFETCH window: disabled.
PCI: Bridge: 0001:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0001:00:04.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0001:00:05.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0001:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0001:00:07.0
  IO window: disabled.
  MEM window: 0xfa000000-0xfa3fffff
  PREFETCH window: disabled.
PCI: Bridge: 0001:00:08.0
  IO window: disabled.
  MEM window: 0x80000000-0x800fffff
  PREFETCH window: disabled.
PCI: Bridge: 0001:00:09.0
  IO window: disabled.
  MEM window: 0xfa400000-0xfa4fffff
  PREFETCH window: disabled.
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs... it is
Freeing initrd memory: 1326k freed
nvram_init: Could not find nvram partition for nvram buffered error logging.
audit: initializing netlink socket (disabled)
type=2000 audit(1212705716.403:1): initialized
msgmni has been set to 7836
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
proc_dir_entry '00' already registered
Call Trace:
[c00000017a0fbb70] [c0000000000120dc] .show_stack+0x58/0x1dc (unreliable)
[c00000017a0fbc20] [c00000000013e9c4] .proc_register+0x218/0x260
[c00000017a0fbcd0] [c00000000013edf0] .proc_mkdir_mode+0x40/0x74
[c00000017a0fbd50] [c0000000001e2454] .pci_proc_attach_device+0x90/0x134
[c00000017a0fbdf0] [c0000000005d8fd0] .pci_proc_init+0x68/0xa0
[c00000017a0fbe70] [c0000000005b4c94] .kernel_init+0x1e8/0x45c
[c00000017a0fbf90] [c000000000027034] .kernel_thread+0x4c/0x68
nvidiafb: Device ID: 10de0141 
nvidiafb: CRTC0 analog not found
nvidiafb: CRTC1 analog found
nvidiafb: EDID found from BUS1
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
i2c-adapter i2c-1: unable to read EDID block.
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 1appears to have a CRT attached
nvidiafb: Using CRT on CRTC 1
Attempt to iounmap early bolted mapping at 0xd0000800800c1000
Console: switching to colour frame buffer device 160x64
nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0x90000000)
Generic RTC Driver v1.07
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyPZ0 at MMIO 0x80013020 (irq = 23) is a Z85c30 ESCC - Serial port
ttyPZ1 at MMIO 0x80013000 (irq = 24) is a Z85c30 ESCC - Serial port
brd: module loaded
loop: module loaded
tg3.c:v3.92 (May 2, 2008)
eth0: Tigon3 [partno(BCM95780) rev 8003 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000Base-T Ethernet 00:14:51:67:55:ef
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
eth0: dma_rwctrl[76144000] dma_mask[40-bit]
eth1: Tigon3 [partno(BCM95780) rev 8003 PHY(5780)] (PCIX:133MHz:64-bit) 10/100/1000Base-T Ethernet 00:14:51:67:55:f0
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] WireSpeed[1] TSOcap[1]
eth1: dma_rwctrl[76144000] dma_mask[40-bit]
netconsole: local port 4444
netconsole: local IP 192.168.2.35
netconsole: interface eth0
netconsole: remote port 5146
netconsole: remote IP 192.168.2.111
netconsole: remote ethernet address 00:19:d1:04:8f:42
netconsole: device eth0 not up yet, forcing it
tg3: eth0: Link is up at 1000 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
console [netcon0] enabled
netconsole: network logging started
MacIO PCI driver attached to Shasta chipset
windfarm: initializing for dual-core desktop G5
windfarm: Failed to create SMU RPM fan fan
Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide-pmac 0001:03:0d.0: enabling device (0004 -> 0006)
ide0: Found Apple Shasta ATA-6 controller, bus ID 3, irq 38
hda: HL-DT-ST DVD-RW GWA-4165B, ATAPI CD/DVD-ROM drive
hda: UDMA/66 mode selected
ide0 at 0xd00008008247a000-0xd00008008247a070,0xd00008008247a160 on irq 38
hda: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
st: Version 20080224, fixed bufsize 32768, s/g segs 256
Driver 'st' needs updating - please use bus_type methods
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
scsi0 : sata_svw
scsi1 : sata_svw
scsi2 : sata_svw
scsi3 : sata_svw
ata1: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402000 irq 18
ata2: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402100 irq 18
ata3: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402200 irq 18
ata4: SATA max UDMA/133 mmio m8192@0xfa402000 port 0xfa402300 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: Hitachi HDS725050KLA360, K2ABC20A, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: Hitachi HDS725050KLA360, K2ABC20A, max UDMA/133
ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72505 K2AB PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: [mac] sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDS72505 K2AB PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: [mac] sdb1 sdb2 sdb3 sdb4 sdb5 sdb6 sdb7
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg1 type 0
ohci1394 0001:03:0e.0: enabling device (0000 -> 0002)
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[39]  MMIO=[fa400000-fa4007ff]  Max Packet=[4096]  IR/IT contexts=[8/8]
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
PowerMac i2c bus smu 14 registered
PowerMac i2c bus smu 11 registered
PowerMac i2c bus mac-io 0 registered
PowerMac i2c bus mac-io 0 registered
found max6690, loc=BACKSIDE addr=0x98
found max6690, loc=TUNNEL addr=0x9c
PowerMac i2c bus u4 1 registered
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
IPv4 over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
tunl0: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
sit0: Disabled Privacy Extensions
NET: Registered protocol family 17
registered taskstats version 1
Freeing unused kernel memory: 300k freed
irq 18: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[c0000000006cf770] [c0000000000120dc] .show_stack+0x58/0x1dc (unreliable)
[c0000000006cf820] [c0000000000a2d64] .__report_bad_irq+0x3c/0xac
[c0000000006cf8a0] [c0000000000a31f4] .note_interrupt+0x420/0x48c
[c0000000006cf9b0] [c0000000000a4398] .handle_fasteoi_irq+0x19c/0x20c
[c0000000006cfa50] [c00000000000ce30] .do_IRQ+0x98/0x12c
[c0000000006cfad0] [c000000000004790] hardware_interrupt_entry+0x18/0x1c
--- Exception: 501 at .cpu_idle+0x14c/0x154
    LR = .cpu_idle+0x14c/0x154
[c0000000006cfdc0] [c000000000013c68] .cpu_idle+0x118/0x154 (unreliable)
[c0000000006cfe60] [c000000000442074] .rest_init+0x74/0x8c
[c0000000006cfee0] [c0000000005b49b8] .start_kernel+0x3c0/0x464
[c0000000006cff90] [c00000000000857c] .start_here_common+0x3c/0x40
handlers:
[<c0000000006b8b50>] (ata_sff_interrupt+0x0/0x10)
Disabling IRQ #18
windfarm: CPUs control loops started.
windfarm: Backside control loop started.
windfarm: Slots control loop started.
windfarm: Drive bay control loop started.
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x10000000 action 0x6 frozen
ata2: SError: { }
ata2.00: cmd c8/00:02:42:28:43/00:00:00:00:00/e0 tag 0 dma 1024 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: qc timeout (cmd 0x27)
ata2.00: failed to read native max address (err_mask=0x4)
ata2.00: HPA support seems broken, skipping HPA handling
ata2.00: revalidation failed (errno=-5)
ata2: failed to recover some devices, retrying in 5 secs
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x10000000 action 0x6 frozen
ata2: SError: { }
ata2.00: cmd c8/00:02:42:28:43/00:00:00:00:00/e0 tag 0 dma 1024 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x10000000 action 0x6 frozen
ata2: SError: { }
ata2.00: cmd c8/00:02:42:28:43/00:00:00:00:00/e0 tag 0 dma 1024 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
INFO: task init:1 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
init          D 000000001001d8c0     0     1      0
Call Trace:
[c00000017a0fb060] [c00000017a0fb110] 0xc00000017a0fb110 (unreliable)
[c00000017a0fb230] [c000000000011680] .__switch_to+0x10c/0x17c
[c00000017a0fb2d0] [c00000000043d43c] .schedule+0x264/0x7fc
[c00000017a0fb3d0] [c00000000043e018] .io_schedule+0xf4/0x120
[c00000017a0fb460] [c00000000010efe4] .sync_buffer+0x8c/0xa4
[c00000017a0fb4e0] [c00000000043e3bc] .__wait_on_bit+0xd8/0x14c
[c00000017a0fb590] [c00000000043e4d4] .out_of_line_wait_on_bit+0xa4/0xc8
[c00000017a0fb6b0] [c00000000010eec0] .__wait_on_buffer+0x44/0x5c
[c00000017a0fb730] [c0000000001151e0] .__bread+0xdc/0x140
[c00000017a0fb7b0] [c00000000015ca50] .ext3_fill_super+0x12c/0x1a3c
[c00000017a0fb8e0] [c0000000000e0084] .get_sb_bdev+0x1cc/0x20c
[c00000017a0fb9c0] [c00000000015ecbc] .ext3_get_sb+0x20/0x38
[c00000017a0fba40] [c0000000000e0410] .vfs_kern_mount+0x80/0x114
[c00000017a0fbae0] [c0000000000e0500] .do_kern_mount+0x5c/0x15c
[c00000017a0fbb80] [c00000000010034c] .do_new_mount+0xc0/0x114
[c00000017a0fbc30] [c000000000100dc8] .do_mount+0x238/0x24c
[c00000017a0fbd70] [c000000000123f18] .compat_sys_mount+0xe0/0x2a4
[c00000017a0fbe30] [c0000000000086ac] syscall_exit+0x0/0x40
ata2: limiting SATA link speed to 1.5 Gbps
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x10000000 action 0x6 frozen
ata2: SError: { }
ata2.00: cmd c8/00:02:42:28:43/00:00:00:00:00/e0 tag 0 dma 1024 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/133
ata2: EH complete
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x10000000 action 0x6 frozen
ata2: SError: { }
ata2.00: cmd c8/00:02:42:28:43/00:00:00:00:00/e0 tag 0 dma 1024 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata2.00: status: { DRDY }
ata2: hard resetting link
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: configured for UDMA/133
ata2: EH complete
INFO: task ata_aux:125 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
ata_aux       D 0000000000000000     0   125      2
Call Trace:
[c00000017a463280] [90be00004bfffce0] 0x90be00004bfffce0 (unreliable)
[c00000017a463450] [c000000000011680] .__switch_to+0x10c/0x17c
[c00000017a4634f0] [c00000000043d43c] .schedule+0x264/0x7fc
[c00000017a4635f0] [c00000000043e2ac] .schedule_timeout+0xfc/0x104
[c00000017a4636c0] [c00000000043dcac] .wait_for_common+0x12c/0x254
[c00000017a4637d0] [c0000000001bb39c] .blk_execute_rq+0xac/0xe4
[c00000017a4638e0] [c0000000002bc4ac] .scsi_execute+0x11c/0x16c
[c00000017a4639a0] [c0000000002bc5b8] .scsi_execute_req+0xbc/0x130
[c00000017a463a70] [c0000000002dad0c] .sd_revalidate_disk+0x114/0x178c
[c00000017a463bb0] [c0000000002dc604] .sd_rescan+0x28/0x5c
[c00000017a463c40] [c0000000002c17a4] .scsi_rescan_device+0xac/0xb4
[c00000017a463cc0] [c0000000002f39d4] .ata_scsi_dev_rescan+0x1a0/0x1f4
[c00000017a463d60] [c000000000075ed4] .run_workqueue+0x10c/0x230
[c00000017a463e10] [c0000000000760a8] .worker_thread+0xb0/0x134
[c00000017a463f00] [c00000000007afd8] .kthread+0xb4/0x100
[c00000017a463f90] [c000000000027034] .kernel_thread+0x4c/0x68
