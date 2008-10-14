Return-Path: <mike.dyer@provision-comm.com>
Received: from smtp1.betherenow.co.uk (smtp1.betherenow.co.uk [87.194.0.68])
	by ozlabs.org (Postfix) with SMTP id 0B37FDE071
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Oct 2008 00:56:50 +1100 (EST)
Received: from [192.168.121.104] (unknown [78.86.206.139])
	by smtp1.betherenow.co.uk (Postfix) with ESMTP id A12229800D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Oct 2008 14:24:16 +0100 (BST)
Message-ID: <48F49D7D.5070107@provision-comm.com>
Date: Tue, 14 Oct 2008 14:24:13 +0100
From: Mike Dyer <mike.dyer@provision-comm.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC8313E RDB: Badness at fs/sysfs/dir.c:463
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I've just pulled the 2.6.27 kernel from git and am trying it out on my=20
MPC8313E RDB dev kit.  I get the following badness during boot (the=20
complete boot record is attached later) :

------------[ cut here=20
]------------                                                            =
                                                                         =
     =20

Badness at=20
fs/sysfs/dir.c:463                                                       =
                                                                         =
                 =20

NIP: c00c5b54 LR: c00c5b3c CTR:=20
00000000                                                                 =
                                                                     =20

REGS: c7827d90 TRAP: 0700   Not tainted =20
(2.6.27)                                                                 =
                                                            =20

MSR: 00029032 <EE,ME,IR,DR>  CR: 22022042  XER:=20
20000000                                                                 =
                                                     =20

TASK =3D c7816400[1] 'swapper' THREAD:=20
c7826000                                                                 =
                                                                =20

GPR00: c00c5b3c c7827e40 c7816400 ffffffef c7800e5c c7800b7c c7811570=20
00000000                                                                 =
                               =20

GPR08: 000001a0 c0370000 00000048 00000000 82044048 100b224c 07ffb000=20
00000000                                                                 =
                               =20

GPR16: 07ff09e0 07ff94c8 00000000 00000000 00000000 c035c76c c035c740=20
c7ace610                                                                 =
                               =20

GPR24: 00000000 00000000 00000000 00000001 c7811570 fffffffe c7acdc00=20
c7827e58                                                                 =
                               =20

Call=20
Trace:                                                                   =
                                                                         =
                       =20

[c7827e40] [c00c5b3c] 0xc00c5b3c=20
(unreliable)                                                             =
                                                                    =20

[c7827e50] [c00c6dc4]=20
0xc00c6dc4                                                               =
                                                                         =
      =20

[c7827e80] [c0182d94]=20
0xc0182d94                                                               =
                                                                         =
      =20

[c7827ea0] [c0181590]=20
0xc0181590                                                               =
                                                                         =
      =20

[c7827ef0] [c0213a6c]=20
0xc0213a6c                                                               =
                                                                         =
      =20

[c7827f00] [c0009818]=20
0xc0009818                                                               =
                                                                         =
      =20

[c7827f10] [c00098c0]=20
0xc00098c0                                                               =
                                                                         =
      =20

[c7827f30] [c0009a30]=20
0xc0009a30                                                               =
                                                                         =
      =20

[c7827f50] [c032a1d4]=20
0xc032a1d4                                                               =
                                                                         =
      =20

[c7827f60] [c0003874]=20
0xc0003874                                                               =
                                                                         =
      =20

[c7827fd0] [c031517c]=20
0xc031517c                                                               =
                                                                         =
      =20

[c7827ff0] [c001216c]=20
0xc001216c                                                               =
                                                                         =
      =20

Instruction=20
dump:                                                                    =
                                                                         =
                =20

912b0028 4bffffbc 9421fff0 7c0802a6 90010014 4bffff2d 2f83ffef=20
419e0014                                                                 =
                                      =20

80010014 38210010 7c0803a6 4e800020 <0fe00000> 4bffffec 9421ffe0=20
7c0802a6                 =20

I used the mpc8313e_rdb_defconfig, with the exception of enabling more=20
debug.

Any help - not sure where to start... ?

Cheers,
Mike


Complete boot sequence:

Using MPC831x RDB machine=20
description                                                              =
                                                                         =
  =20

Linux version 2.6.27 (mike@mike-linux.provision-comm.com) (gcc version=20
4.2.4) #2 Tue Oct 14 14:04:03 BST=20
2008                                                                =20
Found initrd at=20
0xc7cf0000:0xc7f2e337                                                    =
                                                                         =
            =20

console [udbg0]=20
enabled                                                                  =
                                                                         =
            =20

setup_arch:=20
bootmem                                                                  =
                                                                         =
                =20

mpc831x_rdb_setup_arch()                                                 =
                                                                         =
                            =20

Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus=20
number:=20
0->0                                                                     =
                           =20

PCI host bridge /sleep-nexus/pci@e0008500 (primary)=20
ranges:                                                                  =
                                                 =20

 MEM 0x0000000090000000..0x000000009fffffff ->=20
0x0000000090000000                                                       =
                                                      =20

 MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000=20
Prefetch                                                                 =
                                   =20

  IO 0x00000000e2000000..0x00000000e20fffff ->=20
0x0000000000000000                                                       =
                                                      =20

arch:=20
exit                                                                     =
                                                                         =
                      =20

Zone PFN=20
ranges:                                                                  =
                                                                         =
                   =20

  DMA      0x00000000 ->=20
0x00008000                                                               =
                                                                         =
   =20

  Normal   0x00008000 ->=20
0x00008000                                                               =
                                                                         =
   =20

Movable zone start PFN for each=20
node                                                                     =
                                                                     =20

early_node_map[1] active PFN=20
ranges                                                                   =
                                                                        =20

    0: 0x00000000 ->=20
0x00008000                                                               =
                                                                         =
       =20

Built 1 zonelists in Zone order, mobility grouping on.  Total pages:=20
32512                                                                    =
                                =20

Kernel command line: root=3D/dev/ram0 rw console=3DttyS0,115200=20
mtdparts=3De2800000.flash:560k(u-boot),80k(u-boot-env),2m(kernel),16k(dtb=
),-(root)                                  =20

IPIC (128 IRQ sources) at=20
fdefa700                                                                 =
                                                                         =
  =20

PID hash table entries: 512 (order: 9, 2048=20
bytes)                                                                   =
                                                         =20

clocksource: timebase mult[6000002] shift[22]=20
registered                                                               =
                                                       =20

Dentry cache hash table entries: 16384 (order: 4, 65536=20
bytes)                                                                   =
                                             =20

Inode-cache hash table entries: 8192 (order: 3, 32768=20
bytes)                                                                   =
                                               =20

Memory: 123844k/131072k available (3364k kernel code, 7080k reserved,=20
132k data, 98k bss, 208k=20
init)                                                                    =
      =20

SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
=20
Nodes=3D1                                                                =
                                       =20

Calibrating delay loop... 83.20 BogoMIPS=20
(lpj=3D166400)                                                           =
                                                              =20

Mount-cache hash table entries:=20
512                                                                      =
                                                                     =20

net_namespace: 288=20
bytes                                                                    =
                                                                         =
         =20

NET: Registered protocol family=20
16                                                                       =
                                                                     =20

                                                                         =
                                                                         =
                            =20

PCI: Probing PCI=20
hardware                                                                 =
                                                                         =
           =20

pci 0000:00:00.0: PME# supported from D0 D1 D2=20
D3hot                                                                    =
                                                      =20

pci 0000:00:00.0: PME#=20
disabled                                                                 =
                                                                         =
     =20

bus: 00 index 0 io port: [0,=20
fffff]                                                                   =
                                                                        =20

bus: 00 index 1 mmio: [90000000,=20
9fffffff]                                                                =
                                                                    =20

bus: 00 index 2 mmio: [80000000,=20
8fffffff]                                                                =
                                                                    =20

SCSI subsystem=20
initialized                                                              =
                                                                         =
             =20

usbcore: registered new interface driver=20
usbfs                                                                    =
                                                            =20

usbcore: registered new interface driver=20
hub                                                                      =
                                                            =20

usbcore: registered new device driver=20
usb                                                                      =
                                                               =20

NET: Registered protocol family=20
2                                                                        =
                                                                     =20

IP route cache hash table entries: 1024 (order: 0, 4096=20
bytes)                                                                   =
                                             =20

TCP established hash table entries: 4096 (order: 3, 32768=20
bytes)                                                                   =
                                           =20

TCP bind hash table entries: 4096 (order: 2, 16384=20
bytes)                                                                   =
                                                  =20

TCP: Hash tables configured (established 4096 bind=20
4096)                                                                    =
                                                  =20

TCP reno=20
registered                                                               =
                                                                         =
                   =20

NET: Registered protocol family=20
1                                                                        =
                                                                     =20

checking if image is initramfs...it isn't (no cpio magic); looks like an=20
initrd                                                                   =
                            =20

Freeing initrd memory: 2296k=20
freed                                                                    =
                                                                        =20

------------[ cut here=20
]------------                                                            =
                                                                         =
     =20

Badness at=20
fs/sysfs/dir.c:463                                                       =
                                                                         =
                 =20

NIP: c00c5b54 LR: c00c5b3c CTR:=20
00000000                                                                 =
                                                                     =20

REGS: c7827d90 TRAP: 0700   Not tainted =20
(2.6.27)                                                                 =
                                                            =20

MSR: 00029032 <EE,ME,IR,DR>  CR: 22022042  XER:=20
20000000                                                                 =
                                                     =20

TASK =3D c7816400[1] 'swapper' THREAD:=20
c7826000                                                                 =
                                                                =20

GPR00: c00c5b3c c7827e40 c7816400 ffffffef c7800e5c c7800b7c c7811570=20
00000000                                                                 =
                               =20

GPR08: 000001a0 c0370000 00000048 00000000 82044048 100b224c 07ffb000=20
00000000                                                                 =
                               =20

GPR16: 07ff09e0 07ff94c8 00000000 00000000 00000000 c035c76c c035c740=20
c7ace610                                                                 =
                               =20

GPR24: 00000000 00000000 00000000 00000001 c7811570 fffffffe c7acdc00=20
c7827e58                                                                 =
                               =20

Call=20
Trace:                                                                   =
                                                                         =
                       =20

[c7827e40] [c00c5b3c] 0xc00c5b3c=20
(unreliable)                                                             =
                                                                    =20

[c7827e50] [c00c6dc4]=20
0xc00c6dc4                                                               =
                                                                         =
      =20

[c7827e80] [c0182d94]=20
0xc0182d94                                                               =
                                                                         =
      =20

[c7827ea0] [c0181590]=20
0xc0181590                                                               =
                                                                         =
      =20

[c7827ef0] [c0213a6c]=20
0xc0213a6c                                                               =
                                                                         =
      =20

[c7827f00] [c0009818]=20
0xc0009818                                                               =
                                                                         =
      =20

[c7827f10] [c00098c0]=20
0xc00098c0                                                               =
                                                                         =
      =20

[c7827f30] [c0009a30]=20
0xc0009a30                                                               =
                                                                         =
      =20

[c7827f50] [c032a1d4]=20
0xc032a1d4                                                               =
                                                                         =
      =20

[c7827f60] [c0003874]=20
0xc0003874                                                               =
                                                                         =
      =20

[c7827fd0] [c031517c]=20
0xc031517c                                                               =
                                                                         =
      =20

[c7827ff0] [c001216c]=20
0xc001216c                                                               =
                                                                         =
      =20

Instruction=20
dump:                                                                    =
                                                                         =
                =20

912b0028 4bffffbc 9421fff0 7c0802a6 90010014 4bffff2d 2f83ffef=20
419e0014                                                                 =
                                      =20

80010014 38210010 7c0803a6 4e800020 <0fe00000> 4bffffec 9421ffe0=20
7c0802a6                                                                 =
                                    =20

JFFS2 version 2.2. (NAND) \ufffd=A9 2001-2006 Red Hat,=20
Inc.                                                                     =
                                                     =20

msgmni has been set to=20
246                                                                      =
                                                                         =
     =20

io scheduler noop=20
registered                                                               =
                                                                         =
          =20

io scheduler anticipatory registered=20
(default)                                                                =
                                                                =20

io scheduler deadline=20
registered                                                               =
                                                                         =
      =20

io scheduler cfq=20
registered                                                               =
                                                                         =
           =20

Serial: 8250/16550 driver4 ports, IRQ sharing=20
disabled                                                                 =
                                                       =20

serial8250.0: ttyS0 at MMIO 0xe0004500 (irq =3D 16) is a=20
16550A                                                                   =
                                              =20

console handover: boot [udbg0] -> real=20
[ttyS0]                                                                  =
                                                              =20

serial8250.0: ttyS1 at MMIO 0xe0004600 (irq =3D 17) is a=20
16550A                                                                   =
                                              =20

brd: module=20
loaded                                                                   =
                                                                         =
                =20

loop: module=20
loaded                                                                   =
                                                                         =
               =20

Gianfar MII Bus:=20
probed                                                                   =
                                                                         =
           =20

eth0: Gianfar Ethernet Controller Version 1.2,=20
00:e0:0c:00:95:01                                                        =
                                                      =20

eth0: Running with NAPI=20
enabled                                                                  =
                                                                         =
    =20

eth0: 256/256 RX/TX BD ring=20
size                                                                     =
                                                                         =
=20

eth1: Gianfar Ethernet Controller Version 1.2,=20
00:e0:0c:00:95:02                                                        =
                                                      =20

eth1: Running with NAPI=20
enabled                                                                  =
                                                                         =
    =20

eth1: 256/256 RX/TX BD ring=20
size                                                                     =
                                                                         =
=20

e100: Intel(R) PRO/100 Network Driver,=20
3.5.23-k4-NAPI                                                           =
                                                              =20

e100: Copyright(c) 1999-2006 Intel=20
Corporation                                                              =
                                                                  =20

fe000000.flash: Found 1 x16 devices at 0x0 in 16-bit=20
bank                                                                     =
                                                =20

 Amd/Fujitsu Extended Query Table at=20
0x0040                                                                   =
                                                                =20

fe000000.flash: Swapping erase regions for broken CFI=20
table.                                                                   =
                                               =20

number of CFI chips:=20
1                                                                        =
                                                                         =
       =20

cfi_cmdset_0002: Disabling erase-suspend-program due to code=20
brokenness.                                                              =
                                        =20

cmdlinepart partition parsing not=20
available                                                                =
                                                                   =20

RedBoot partition parsing not=20
available                                                                =
                                                                       =20

NAND device: Manufacturer ID: 0xec, Chip ID: 0x75 (Samsung NAND 32MiB=20
3,3V=20
8-bit)                                                                   =
                          =20

cmdlinepart partition parsing not=20
available                                                                =
                                                                   =20

RedBoot partition parsing not=20
available                                                                =
                                                                       =20

Creating 3 MTD partitions on=20
"e2800000.flash":                                                        =
                                                                        =20

0x00000000-0x00100000 :=20
"u-boot"                                                                 =
                                                                         =
    =20

0x00100000-0x00400000 :=20
"kernel"                                                                 =
                                                                         =
    =20

0x00400000-0x02000000 :=20
"fs"                                                                     =
                                                                         =
    =20

eLBC NAND device at 0xe2800000, bank=20
0                                                                        =
                                                                =20

usbmon: debugfs is not=20
available                                                                =
                                                                         =
     =20

fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host=20
Controller                                                               =
                                                    =20

fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number=20
1                                                                        =
                                    =20

fsl-ehci fsl-ehci.0: irq 38, io base=20
0xe0023000                                                               =
                                                                =20

fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00, driver 10 Dec=20
2004                                                                     =
                                      =20

usb usb1: configuration #1 chosen from 1=20
choice                                                                   =
                                                            =20

hub 1-0:1.0: USB hub=20
found                                                                    =
                                                                         =
       =20

hub 1-0:1.0: 1 port=20
detected                                                                 =
                                                                         =
        =20

USB Universal Host Controller Interface driver=20
v3.0                                                                     =
                                                      =20

Initializing USB Mass Storage=20
driver...                                                                =
                                                                       =20

usbcore: registered new interface driver=20
usb-storage                                                              =
                                                            =20

USB Mass Storage support=20
registered.                                                              =
                                                                         =
   =20

i2c /dev entries=20
driver                                                                   =
                                                                         =
           =20

rtc-ds1307 0-0068: rtc core: registered ds1339 as=20
rtc0                                                                     =
                                                   =20

md: linear personality registered for level=20
-1                                                                       =
                                                         =20

md: raid0 personality registered for level=20
0                                                                        =
                                                          =20

md: raid1 personality registered for level=20
1                                                                        =
                                                          =20

TCP cubic=20
registered                                                               =
                                                                         =
                  =20

NET: Registered protocol family=20
17                                                                       =
                                                                     =20

RPC: Registered udp transport=20
module.                                                                  =
                                                                       =20

RPC: Registered tcp transport=20
module.                                                                  =
                                                                       =20

rtc-ds1307 0-0068: setting system clock to 2000-01-04 22:45:49 UTC=20
(947025949)                                                              =
                                  =20

md: Autodetecting RAID=20
arrays.                                                                  =
                                                                         =
     =20

md: Scanned 0 and added 0=20
devices.                                                                 =
                                                                         =
  =20

md: autorun=20
...                                                                      =
                                                                         =
                =20

md: ... autorun=20
DONE.                                                                    =
                                                                         =
            =20

RAMDISK: Compressed image found at block=20
0                                                                        =
                                                            =20

VFS: Mounted root (ext2=20
filesystem).                                                             =
                                                                         =
    =20

Freeing unused kernel memory: 208k init
