Message-ID: <38CACF9C.EFE8DDBD@ncal.verio.com>
Date: Sat, 11 Mar 2000 14:58:36 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Progress report on PB2000
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Ben,

I've got the cross-compiler working and hacked the interrupt dispatcher to
to call most of the handlers on every rupt. So I have a somewhat functional
system driven by the spurious interrupts (with BootX, yaboot also boots to ramdisk,
but no interrupts). I'll be trying an ftp install next and then try debugging the
lsprop seg faults. I've also hacked the device-tree proc fs routine so the three
PCI busses have unique names and thus their own directories. Is there any special
syntax for lsprop that I may be missing that is causing the seg faults?

Once I have the lsprop output I'll cross check it against the OF
device-tree.

I've enabled and added some debug messages and also changed the get_irq_list
routine to print the interrupts recieving spurious interrupts.

One thing I've noticed is that the use_of_interrupt_tree flag is not set as
boot_infos is set. I assume that is because I'm booting from BootX?

If I force use_of_interrupt_tree to be set, the boot hangs at the booting...
message for both BootX and yaboot. Under what circumstances do you
expect use_of_interrupt_tree to be set?

Thanks,
Henry


/proc/interrupts

           CPU0
 19:          0   OpenPIC       ide0
 22:          0   OpenPIC       SCC
 23:          0   OpenPIC       SCC
 25:          0   OpenPIC       VIA-PMU
 27:          0   OpenPIC       usb-ohci
 28:       8532   OpenPIC       usb-ohci
 41:          0   OpenPIC       GMAC
 47:          0   OpenPIC       GPIO1/ADB
BAD:     109630
  6:     640314   OpenPIC       <no-action>
 12:      16746   OpenPIC       <no-action>
 14:        516   OpenPIC       <no-action>    <-- media-bay IDE bus


/proc/kmsg

<6>finish_device_tree -- model:PowerBook3,1, boot_infos:0xc025b000, use_of_interrupt_tree:0
<6>device tree used 3050696 bytes
<4>Total memory = 256MB; using 1024kB for hash table (at c0600000)
<4>Linux version 2.2.15pre7 (henry@singletrack.home.net) (gcc version 2.95.2 19991024 (release)) #29 Sat Mar 11 13:31:08 PST 2000
<6>PCI bus 0 controlled by pci at f0000000
<6>PCI buses 0..1 controlled by pci at f2000000
<6>PCI bus 0 controlled by pci at f4000000
<6>Registered 1 feature controller(s)
<4>feature: <mac-io> clearing feature 20 in controller @0x80000000
<4>feature: <mac-io> clearing feature 21 in controller @0x80000000
<6>PMU driver initialized for Core99 (iBook/iMac/G4)
<4>PowerMac using OpenPIC irq controller
<4>OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at 80040000
<4>openpic_init.
<4>openpic_init pmac - use_of_interrupt_tree:0.
<6>via_calibrate_decr: decrementer_count = 249666 (1497997 ticks)
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 996.15 BogoMIPS
<4>Memory: 252816k available (1460k kernel code, 4820k data, 144k init) [c0000000,d0000000]
<4>Dentry hash table entries: 32768 (order 6, 256k)
<4>Buffer cache hash table entries: 262144 (order 8, 1024k)
<4>Page cache hash table entries: 65536 (order 6, 256k)
<5>VFS: Diskquotas version dquot_6.4.0 initialized
<4>POSIX conformance testing by UNIFIX
<4>PCI: Probing PCI hardware
<4>pci_scan_bus for bus 0
<4>PCI: 00:58 [106b/0020]
<4>PCI: 00:70 [106b/0018]
<4>PCI: 00:78 [106b/0021]
<4>PCI: 00:80 [1002/4c46]
<4>PCI: 00:b8 [106b/0022]
<4>PCI: 00:c0 [106b/0019]
<4>PCI: 00:c8 [106b/0019]
<4>PCI: 00:d0 [104c/ac1e]
<4>PCI: pci_scan_bus returning with max=00
<7>request_irq: VIA-PMU requests interrupt 0x19. handler: 0xc01ff938, flags: 0xc01d0000, dev_id: 0x0
<7>request_irq: GPIO1/ADB requests interrupt 0x2f. handler: 0xc01ffac8, flags: 0xc0262bc0, dev_id: 0x0
<7>adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
<4>feature: <media-bay> clearing feature 15 in controller @0x80000000
<4>feature: <media-bay> clearing feature 13 in controller @0x80000000
<4>feature: <media-bay> clearing feature 12 in controller @0x80000000
<4>feature: <media-bay> clearing feature 5 in controller @0x80000000
<4>feature: <media-bay> clearing feature 11 in controller @0x80000000
<6>mediabay0: powering down
<6>mediabay0: switching to 1
<4>feature: <media-bay> setting feature 11 in controller @0x80000000
<4>feature: <media-bay> setting feature 10 in controller @0x80000000
<6>mediabay0: powering up
<4>feature: <media-bay> setting feature 15 in controller @0x80000000
<4>feature: <media-bay> setting feature 5 in controller @0x80000000
<6>media bay 0 contains a floppy disk drive
<6>mediabay0: enabling (kind:1)
<4>feature: <media-bay> clearing feature 10 in controller @0x80000000
<6>mediabay0: waiting reset (kind:1)
<6>mediabay0: bay is up (kind:1)
<6>Registered 1 media-bay(s)
<6>Linux NET4.0 for Linux 2.2
<6>Based upon Swansea University Computer Society NET3.039
<6>NET4: Unix domain sockets 1.0 for Linux NET4.0.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>TCP: Hash tables configured (ehash 262144 bhash 65536)
<4>Starting kswapd v 1.5
<6>OHCI USB Driver loading
<7>usb-ohci: 2 root hub ports found
<7>request_irq: usb-ohci requests interrupt 0x1b. handler: 0xc0168028, flags: 0xfffffff0, dev_id: 0xc05a7020
<7>usb-ohci: 2 root hub ports found
<7>request_irq: usb-ohci requests interrupt 0x1c. handler: 0xc0168028, flags: 0xfffffff0, dev_id: 0xc05a70e0
<4>usbcore: Registered new driver mouse
<6>USB HID boot protocol mouse driver registered.
<4>usbcore: Registered new driver keyboard
<4>usbcore: Registered new driver hub
<6>Using unsupported 1024x768 MacOS display at a6008000, depth=32, pitch=4096
<4>Console: switching to colour frame buffer device 128x48
<4>fb0: Open Firmware frame buffer device on MacOS display
<4>ADB keyboard at 2, try handler 5 retuns 0
<4>ADB keyboard at 2, handler 1
<4>ADB mouse at 3, handler set to 4 (trackpad)
<7>request_irq: SCC requests interrupt 0x16. handler: 0xc0140060, flags: 0x0, dev_id: 0xc024272c
<7>request_irq: SCC requests interrupt 0x17. handler: 0xc0140060, flags: 0x184, dev_id: 0xc02428b0
<4>PowerMac Z8530 serial driver version 2.0
<4>tty00 at 0x80013020 (irq = 22) is a Z8530 ESCC (cobalt modem)
<4>feature: <ch-a> clearing feature 2 in controller @0x80000000
<4>feature: <ch-a> clearing feature 18 in controller @0x80000000
<4>feature: <ch-a> clearing feature 3 in controller @0x80000000
<4>feature: <ch-a> clearing feature 3 in controller @0x80000000
<4>tty01 at 0x80013000 (irq = 23) is a Z8530 ESCC (powerbook IR)
<4>feature: <ch-b> clearing feature 2 in controller @0x80000000
<4>feature: <ch-b> clearing feature 4 in controller @0x80000000
<4>feature: <ch-b> clearing feature 3 in controller @0x80000000
<4>pty: 256 Unix98 ptys configured
<6>Macintosh ADB mouse driver installed.
<6>Macintosh non-volatile memory driver v1.0
<4>RAM disk driver initialized:  16 RAM disks of 8192K size
<4>pmac_ide: enabling IDE bus ID 2
<4>pmac_ide:    name ata-4 - base: 0x8e01f000, irq: 0x13, i: 0x0
<4>feature: <ata-4> setting feature 23 in controller @0x80000000
<4>feature: <ata-4> clearing feature 23 in controller @0x80000000
<4>pmac_ide:
<4>      hwif->io_ports: 0x8e01f000, 0x8e01f010, 0x8e01f020, 0x8e01f030,
<4>                      0x8e01f040, 0x8e01f050, 0x8e01f060, 0x8e01f070,
<4>      base: 0x8e01f000, hwif->irq: 0x13
<4>pmac_ide: enabling IDE bus ID 1
<4>pmac_ide:    name ata-3 - base: 0x8e021000, irq: 0x15, i: 0x1
<4>feature: <ata-3> setting feature 14 in controller @0x80000000
<4>feature: <ata-3> setting feature 9 in controller @0x80000000
<4>feature: <ata-3> setting feature 13 in controller @0x80000000
<4>feature: <ata-3> clearing feature 14 in controller @0x80000000
<4>pmac_ide:
<4>      hwif->io_ports: 0x8e021000, 0x8e021010, 0x8e021020, 0x8e021030,
<4>                      0x8e021040, 0x8e021050, 0x8e021060, 0x8e021070,
<4>      base: 0x8e021000, hwif->irq: 0x15
<4>media_bay_set_ide_infos for media-bay, base: 0x8e020000, irq: 0x14, index: 0x
<4>    media bay 0 content_id: 0x1 , state: 0x6
<4>pmac_ide: setting media-bay ide infos for ata-3:
<4>           rc= 0, base: 0x8e020000, irq: 0x14, i: 0x2
<4>pmac_ide:
<4>      hwif->io_ports: 0x00000000, 0x00000000, 0x00000000, 0x00000000,
<4>                      0x00000000, 0x00000000, 0x00000000, 0x00000000,
<4>      base: 0x8e020000, hwif->irq: 0x0
<4>hda: TOSHIBA MK1214GAP, ATA DISK drive
<7>request_irq: ide0 requests interrupt 0x13. handler: 0xc00c892c, flags: 0xc0241579, dev_id: 0xc05b5aa0
<4>ide0 at 0x8e01f000-0x8e01f007,0x8e01f160 on irq 19
<4>hda: Enabling Ultra DMA 4
<6>hda: TOSHIBA MK1214GAP, 11513MB w/0kB Cache, CHS=23392/16/63, (U)DMA
<4>md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
<4>scsi : 0 hosts.
<4>scsi : detected total.
<6>eth0: GMAC at 00:30:65:4c:a8:58
<7>request_irq: GMAC requests interrupt 0x29. handler: 0xc0106d14, flags: 0xc026a1e8, dev_id: 0xc01c0b3c
<4>Partition check:
<4> hda:<7>ohci-control thread code for 0xc05a70e0 code at 0xc016885c
<4>New USB bus registered, assigned bus number 1
<7>ohci-control thread code for 0xc05a7020 code at 0xc016885c
<4>New USB bus registered, assigned bus number 2
<7>usb-ohci: HC c05a70e0 reset.
<7>usb-ohci: HC c05a7020 reset.
<6>usb-ohci: host controller operational
<6>usb-ohci: host controller operational
<7>ohci-control thread sleeping
<6>USB new device connect, assigned device number 1
<7>Failed control msg - r:05 rt:00 v:0001 i:0000 s:0000 - ret: -101
<7>  00 05 01 00 00 00 00 00
<3>usbcore: USB device not accepting new address (error=-101)
<7>ohci-control thread sleeping
<4> hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 hda16 hda17
<5>RAMDISK: Compressed image found at block 0
<4>EXT2-fs warning: maximal mount count reached, running e2fsck is recommended
<4>VFS: Mounted root (ext2 filesystem).
<4>Freeing unused kernel memory: 144k init 32k prep

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
