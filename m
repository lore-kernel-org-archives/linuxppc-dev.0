Return-Path: <fixed-term.Thomas.Seeh@de.bosch.com>
Received: from imta2.fe.bosch.de (imta2.fe.bosch.de [139.15.238.165])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D1DECB7B78
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 18:09:16 +1000 (EST)
Received: from smtp2-v.fe.bosch.de (smtp2-v.fe.bosch.de [139.15.237.6])
	by imta2.fe.bosch.de (Postfix) with ESMTP id 47703D0333
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 10:01:24 +0200 (CEST)
Received: from vsmta2.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta5.fe.bosch.de (Postfix) with ESMTP id 8F6FC14008D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 10:01:08 +0200 (CEST)
Received: from fe-imc01.de.bosch.com (vsgw1.fe.internet.bosch.com [10.4.98.15])
	by vsmta2.fe.internet.bosch.com (Postfix) with ESMTP id AED7B22368D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 10:01:19 +0200 (CEST)
From: "FIXED-TERM Seeh Thomas (BEG/EMS1)" <fixed-term.Thomas.Seeh@de.bosch.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 27 Aug 2009 10:01:15 +0200
Subject: LITE5200 configuration
Message-ID: <6E9D235B18CE694399D781F05D9C42E79F0C2C12@SI-MBX11.de.bosch.com>
Content-Type: multipart/alternative;
	boundary="_000_6E9D235B18CE694399D781F05D9C42E79F0C2C12SIMBX11deboschc_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_6E9D235B18CE694399D781F05D9C42E79F0C2C12SIMBX11deboschc_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'll try to run a 2.6.31-rc7 kernel on my Lite5200 board.
For the device tree I use lite5200.dts and compiled it simply with

        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- lite5200.dtb

But I'm not sure what configuration for the kernel I should choose. There i=
s no
lite5200_defconfig only one for the lite5200b.
I tried it with mpc5200_defconfig and lite5200b_defconfig, but I'm not sure=
 which
is the right way.
For compiling the kernel I use:

        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- "CONFIG_FILE"
        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- uImage
        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- modules
        make ARCH=3Dpowerpc CROSS_COMPILE=3Dppc_6xx- modules_install

Can anyone tell me?

I use U-Boot 2009.06, with the following settings for bootup:

=3D> print kernel_addr fdt_addr dtbfile bootfile bootargs
kernel_addr=3D900000
fdt_addr=3Db00000
dtbfile=3D/tftpboot/lite5200.dtb
bootfile=3D/tftpboot/uImage
bootargs=3Dconsole=3DttyPSC0,115200 root=3D/dev/nfs rw nfsroot=3D10.10.0.2:=
/opt/eldk/ppc
_82xx ip=3D10.10.0.99:10.10.0.2::255.255.255.0:icecube::off panic=3D1
=3D> tftp ${kernel_addr} ${boofile}; tftp ${fdt_addr} ${dtbfile}
=3D> bootm ${kernel_addr} - ${fdt_addr}

With lite5200b_defconfig config the last message I see is:

=3D> tftp ${kernel_addr} ${boofile}; tftp ${fdt_addr} ${dtbfile}
Using FEC ETHERNET device
TFTP from server 10.10.0.2; our IP address is 10.10.0.99
Filename '/tftpboot/uImage'.
Load address: 0x900000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         ###################################
done
Bytes transferred =3D 1507908 (170244 hex)
Using FEC ETHERNET device
TFTP from server 10.10.0.2; our IP address is 10.10.0.99
Filename '/tftpboot/lite5200.dtb'.
Load address: 0xb00000
Loading: ##
done
Bytes transferred =3D 5375 (14ff hex)
=3D> bootm ${kernel_addr} - ${fdt_addr}
## Booting kernel from Legacy Image at 00900000 ...
   Image Name:   Linux-2.6.31-rc7-01406-g83e0360-
   Created:      2009-08-27   7:58:32 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1507844 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 00b00000
   Booting using the fdt blob at 0xb00000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 007fb000, end 007ff4fe ... OK
[    0.000000] Using lite5200 machine description
[    0.000000] Linux version 2.6.31-rc7-01406-g83e0360-dirty (root@user-lap=
top)
(gcc version 4.2.2) #6 Thu Aug 27 09:58:17 CEST 2009
[    0.000000] PCI host bridge /pci@f0000d00 (primary) ranges:
[    0.000000]  MEM 0x0000000080000000..0x000000009fffffff -> 0x00000000800=
00000
 Prefetch
[    0.000000]  MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a00=
00000

[    0.000000]   IO 0x00000000b0000000..0x00000000b0ffffff -> 0x00000000000=
00000

[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00004000
[    0.000000]   Normal   0x00004000 -> 0x00004000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00004000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pag
es: 16256
[    0.000000] Kernel command line: console=3DttyPSC0,115200 root=3D/dev/nf=
s rw nfsr
oot=3D10.10.0.2:/opt/eldk/ppc_82xx ip=3D10.10.0.99:10.10.0.2::255.255.255.0=
:icecube:
:off panic=3D1
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes=
)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 61612k/65536k available (2972k kernel code, 3864k re=
serve
d, 144k data, 108k bss, 160k init)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xffffe000..0xfffff000  : fixmap
[    0.000000]   * 0xfcffa000..0xfe000000  : early ioremap
[    0.000000]   * 0xc5000000..0xfcffa000  : vmalloc & ioremap
[    0.000000] SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=
=3D0, CPUs=3D1, N
odes=3D1
[    0.000000] NR_IRQS:512
[    0.000000] MPC52xx PIC is up and running!
[    0.000000] clocksource: timebase mult[f26c9b2] shift[22] registered
[    0.000738] console [ttyPSC0] enabled
[    0.169172] Mount-cache hash table entries: 512
[    0.184911] NET: Registered protocol family 16
[    0.240784] PCI: Probing PCI hardware
[    0.248600] DMA: MPC52xx BestComm driver
[    0.253306] DMA: MPC52xx BestComm engine @f0001200 ok !
[    0.309563] bio: create slab <bio-0> at 0
[    0.320464] SCSI subsystem initialized
[    0.345661] NET: Registered protocol family 2
[    0.350793] IP route cache hash table entries: 1024 (order: 0, 4096 byte=
s)
[    0.359384] TCP established hash table entries: 2048 (order: 2, 16384 by=
tes)
[    0.367176] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.374059] TCP: Hash tables configured (established 2048 bind 2048)
[    0.380734] TCP reno registered
[    0.384910] NET: Registered protocol family 1
[    0.498050] msgmni has been set to 120
[    0.506553] alg: No test for stdrng (krng)
[    0.511415] io scheduler noop registered
[    0.515636] io scheduler anticipatory registered (default)
[    0.521491] io scheduler deadline registered
[    0.526513] io scheduler cfq registered
[    1.706240] Generic RTC Driver v1.07
[    1.712363] Serial: MPC52xx PSC UART driver
[    1.717645] f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq =3D 129) is=
 a MPC5
2xx PSC
[    1.779407] brd: module loaded
[    1.808029] loop: module loaded
[    1.814012] ata: MPC52xx IDE/ATA libata driver
[    1.821144] scsi0 : mpc52xx_ata
[    1.826559] ata1: PATA max PIO4 ata_regs 0xf0003a00 irq 135
[    1.838948] mpc52xx MII bus: probed
[    1.864150] i2c /dev entries driver
[    1.883715] TCP cubic registered
[    1.887261] NET: Registered protocol family 17
[    1.895154] RPC: Registered udp transport module.
[    1.900177] RPC: Registered tcp transport module.
[    3.450019] IP-Config: Complete:
[    3.453333]      device=3Deth0, addr=3D10.10.0.99, mask=3D255.255.255.0,=
 gw=3D255.255
.255.255,
[    3.461661]      host=3Dicecube, domain=3D, nis-domain=3D(none),
[    3.467407]      bootserver=3D10.10.0.2, rootserver=3D10.10.0.2, rootpat=
h=3D
[    3.489436] Looking up port of RPC 100003/2 on 10.10.0.2
[    3.530495] Looking up port of RPC 100005/1 on 10.10.0.2
[    3.667558] VFS: Mounted root (nfs filesystem) on device 0:11.
[    3.674123] Freeing unused kernel memory: 160k init
[    4.085086] net eth0: FEC_IEVENT_RFIFO_ERROR
[    4.091135] ------------[ cut here ]------------
[    4.095874] Kernel BUG at c01b7d4c [verbose debug info unavailable]
[    4.102285] Oops: Exception in kernel mode, sig: 5 [#1]
[    4.107615] lite5200
[    4.109842] Modules linked in:
[    4.112965] NIP: c01b7d4c LR: c01b900c CTR: c0011220
[    4.118035] REGS: c030da20 TRAP: 0700   Not tainted  (2.6.31-rc7-01406-g=
83e03
60-dirty)
[    4.126106] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22000024  XER: 00000000
[    4.132907] TASK =3D c02e93e8[0] 'swapper' THREAD: c030c000
[    4.138235] GPR00: 00010200 c030dad0 c02e93e8 c391fe00 00000001 00000000=
 0000
8000 00000000
[    4.146798] GPR08: 00000006 c030c000 c0335000 000734e0 22000022 ffcf5fff=
 03fb
8000 03fa8878
[    4.155357] GPR16: 03f81ae8 03fa8854 03f45dcc 03f45ccc 03f45bee c0328428=
 c386
fe00 0a0a0063
[    4.163920] GPR24: 0000106c 00008000 00000000 00000001 00000000 c391fe00=
 c387
7c00 c3877ec0
[    4.172666] Call Trace:
[    4.175165] [c030dad0] [c01b8ec0] 0xc01b8ec0 (unreliable)
[    4.180677] [c030db00] [c01b900c] 0xc01b900c
[    4.185034] [c030db20] [c01b9310] 0xc01b9310
[    4.189394] [c030db40] [c004fd08] 0xc004fd08
[    4.193753] [c030db60] [c0051f14] 0xc0051f14
[    4.198113] [c030db70] [c0006590] 0xc0006590
[    4.202473] [c030db90] [c0012084] 0xc0012084
[    4.206833] --- Exception: 501 at 0xc023d1a4
[    4.206846]     LR =3D 0xc023dcac
[    4.214387] [c030dc50] [c02395e4] 0xc02395e4 (unreliable)
[    4.219904] [c030dc80] [c023dcac] 0xc023dcac
[    4.224262] [c030dc90] [c0237e2c] 0xc0237e2c
[    4.228622] [c030dcb0] [c023c120] 0xc023c120
[    4.232982] [c030dce0] [c01c5514] 0xc01c5514
[    4.237341] [c030dd00] [c020ea08] 0xc020ea08
[    4.241701] [c030dd20] [c0210008] 0xc0210008
[    4.246059] [c030dd70] [c01eda24] 0xc01eda24
[    4.250418] [c030dd90] [c01ede54] 0xc01ede54
[    4.254775] --- Exception: c at 0xc030de50
[    4.254789]     LR =3D 0x00000a
[    4.261973] [c030ddc0] [c01d18ec] 0xc01d18ec (unreliable)
[    4.267490] [c030ddf0] [c01d4454] 0xc01d4454
[    4.271850] [c030de20] [c01d47fc] 0xc01d47fc
[    4.276209] [c030de50] [c0029c48] 0xc0029c48
[    4.280570] [c030de90] [c00064f4] 0xc00064f4
[    4.284929] [c030dea0] [c0029a98] 0xc0029a98
[    4.289288] [c030deb0] [c0006594] 0xc0006594
[    4.293645] [c030ded0] [c0012084] 0xc0012084
[    4.298004] --- Exception: 501 at 0xc0009398
[    4.298020]     LR =3D 0xc0009398
[    4.305561] [c030df90] [c0009348] 0xc0009348 (unreliable)
[    4.311077] [c030dfb0] [c0003e40] 0xc0003e40
[    4.315436] [c030dfc0] [c02bf850] 0xc02bf850
[    4.319795] [c030dff0] [00003438] 0x003438
[    4.323972] Instruction dump:
[    4.326999] 4e800020 9421ffd0 7c0802a6 bf210014 54290024 7c7d1b78 900100=
34 7c
9b2378
[    4.334947] 7cba2b78 7cd93378 8009000c 5400016e <0f000000> 3b830028 7f83=
e378
4809e8dd
[    4.343083] Kernel panic - not syncing: Fatal exception in interrupt
[    4.349564] Rebooting in 1 seconds.

And with mpc5200_defconfig config it is:

Using FEC ETHERNET device
TFTP from server 10.10.0.2; our IP address is 10.10.0.99
Filename '/tftpboot/uImage'.
Load address: 0x900000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #######################################################
done
Bytes transferred =3D 1945203 (1dae73 hex)
Using FEC ETHERNET device
TFTP from server 10.10.0.2; our IP address is 10.10.0.99
Filename '/tftpboot/lite5200.dtb'.
Load address: 0xb00000
Loading: ##
done
Bytes transferred =3D 5375 (14ff hex)
=3D> bootm ${kernel_addr} - ${fdt_addr}
## Booting kernel from Legacy Image at 00900000 ...
   Image Name:   Linux-2.6.31-rc7-01406-g83e0360
   Created:      2009-08-27   6:51:07 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1945139 Bytes =3D  1.9 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 00b00000
   Booting using the fdt blob at 0xb00000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 007fb000, end 007ff4fe ... OK
[    0.000000] Using lite5200 machine description
[    0.000000] Linux version 2.6.31-rc7-01406-g83e0360 (root@user-laptop) (=
gcc v
ersion 4.2.2) #3 Thu Aug 27 08:50:54 CEST 2009
[    0.000000] PCI host bridge /pci@f0000d00 (primary) ranges:
[    0.000000]  MEM 0x0000000080000000..0x000000009fffffff -> 0x00000000800=
00000
 Prefetch
[    0.000000]  MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a00=
00000

[    0.000000]   IO 0x00000000b0000000..0x00000000b0ffffff -> 0x00000000000=
00000

[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00004000
[    0.000000]   Normal   0x00004000 -> 0x00004000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00004000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pag
es: 16256
[    0.000000] Kernel command line: console=3DttyPSC0,115200 root=3D/dev/nf=
s rw nfsr
oot=3D10.10.0.2:/opt/eldk/ppc_82xx ip=3D10.10.0.99:10.10.0.2::255.255.255.0=
:icecube:
:off panic=3D1
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes=
)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Memory: 60588k/65536k available (3888k kernel code, 4884k re=
serve
d, 188k data, 164k bss, 188k init)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xffffe000..0xfffff000  : fixmap
[    0.000000]   * 0xfcffa000..0xfe000000  : early ioremap
[    0.000000]   * 0xc5000000..0xfcffa000  : vmalloc & ioremap
[    0.000000] SLUB: Genslabs=3D13, HWalign=3D32, Order=3D0-3, MinObjects=
=3D0, CPUs=3D1, N
odes=3D1
[    0.000000] NR_IRQS:512
[    0.000000] MPC52xx PIC is up and running!
[    0.000000] clocksource: timebase mult[f26c9b2] shift[22] registered
[    0.000467] Console: colour dummy device 80x25
[    0.001126] console [ttyPSC0] enabled
[    0.173540] Mount-cache hash table entries: 512
[    0.188342] NET: Registered protocol family 16
[    0.251292] PCI: Probing PCI hardware
[    0.259136] DMA: MPC52xx BestComm driver
[    0.263847] DMA: MPC52xx BestComm engine @f0001200 ok !
[    0.356705] bio: create slab <bio-0> at 0
[    0.368969] SCSI subsystem initialized
[    0.380298] usbcore: registered new interface driver usbfs
[    0.387488] usbcore: registered new interface driver hub
[    0.394699] usbcore: registered new device driver usb
[    0.420014] NET: Registered protocol family 2
[    0.425101] IP route cache hash table entries: 1024 (order: 0, 4096 byte=
s)
[    0.433699] TCP established hash table entries: 2048 (order: 2, 16384 by=
tes)
[    0.441486] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.448407] TCP: Hash tables configured (established 2048 bind 2048)
[    0.455022] TCP reno registered
[    0.459100] NET: Registered protocol family 1
[    0.574734] JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.589702] msgmni has been set to 118
[    0.598135] alg: No test for stdrng (krng)
[    0.602904] io scheduler noop registered
[    0.607201] io scheduler anticipatory registered (default)
[    0.612979] io scheduler deadline registered
[    0.618008] io scheduler cfq registered
[    2.034926] [drm] Initialized drm 1.1.0 20060810
[    2.039933] Serial: MPC52xx PSC UART driver
[    2.045071] f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq =3D 129) is=
 a MPC5
2xx PSC
[    2.107178] brd: module loaded
[    2.135950] loop: module loaded
[    2.149599] ata: MPC52xx IDE/ATA libata driver
[    2.156669] scsi0 : mpc52xx_ata
[    2.162242] ata1: PATA max PIO4 ata_regs 0xf0003a00 irq 135
[    2.175746] mpc52xx MII bus: probed
[    2.203297] usbmon: debugfs is not available
[    2.207880] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.216515] ppc-of-ohci f0001000.usb: OF OHCI
[    2.221581] ppc-of-ohci f0001000.usb: new USB bus registered, assigned b=
us nu
mber 1
[    2.229777] ppc-of-ohci f0001000.usb: irq 134, io mem 0xf0001000
[    2.295284] usb usb1: configuration #1 chosen from 1 choice
[    2.303126] hub 1-0:1.0: USB hub found
[    2.307386] hub 1-0:1.0: 2 ports detected
[    2.315260] Initializing USB Mass Storage driver...
[    2.321842] usbcore: registered new interface driver usb-storage
[    2.328414] USB Mass Storage support registered.
[    2.349763] mice: PS/2 mouse device common for all mice
[    2.356703] i2c /dev entries driver
[    2.384164] usbcore: registered new interface driver usbhid
[    2.390132] usbhid: v2.6:USB HID core driver
[    2.397686] TCP cubic registered
[    2.401412] NET: Registered protocol family 17
[    2.409581] RPC: Registered udp transport module.
[    2.414646] RPC: Registered tcp transport module.
[    2.427827] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    3.969764] IP-Config: Complete:
[    3.973082]      device=3Deth0, addr=3D10.10.0.99, mask=3D255.255.255.0,=
 gw=3D255.255
.255.255,
[    3.981401]      host=3Dicecube, domain=3D, nis-domain=3D(none),
[    3.987140]      bootserver=3D10.10.0.2, rootserver=3D10.10.0.2, rootpat=
h=3D
[    4.009033] Looking up port of RPC 100003/2 on 10.10.0.2
[    4.055286] Looking up port of RPC 100005/1 on 10.10.0.2
[    4.226838] VFS: Mounted root (nfs filesystem) on device 0:12.
[    4.233384] Freeing unused kernel memory: 188k init
[    4.351275] net eth0: FEC_IEVENT_RFIFO_ERROR
[    4.357356] ------------[ cut here ]------------
[    4.362100] Kernel BUG at c0229440 [verbose debug info unavailable]
[    4.368517] Oops: Exception in kernel mode, sig: 5 [#1]
[    4.373853] lite5200
[    4.376085] Modules linked in:
[    4.379219] NIP: c0229440 LR: c022a700 CTR: c0013720
[    4.384300] REGS: c03fd980 TRAP: 0700   Not tainted  (2.6.31-rc7-01406-g=
83e03
60)
[    4.391848] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22000024  XER: 00000000
[    4.398659] TASK =3D c03ce3e8[0] 'swapper' THREAD: c03fc000
[    4.403993] GPR00: 00010100 c03fda30 c03ce3e8 c397ec00 00000001 00000000=
 0000
8000 00000000
[    4.412574] GPR08: 00000021 c03fc000 c0434000 00073d80 82000022 ffcf5fff=
 03fb
8000 03fa8878
[    4.421148] GPR16: 03f81ae8 03fa8854 03f45dcc 03f45ccc c03f9e54 c39b2d80=
 0000
0000 c03c2b24
[    4.429718] GPR24: 00000064 00008000 00000000 00000001 00000000 c397ec00=
 c39a
2000 c39a22c0
[    4.438468] Call Trace:
[    4.440977] [c03fda30] [c022a5b4] 0xc022a5b4 (unreliable)
[    4.446497] [c03fda60] [c022a700] 0xc022a700
[    4.450863] [c03fda80] [c022aa04] 0xc022aa04
[    4.455227] [c03fdaa0] [c00528b4] 0xc00528b4
[    4.459593] [c03fdac0] [c0054ac0] 0xc0054ac0
[    4.463960] [c03fdad0] [c0006590] 0xc0006590
[    4.468326] [c03fdaf0] [c0014584] 0xc0014584
[    4.472690] --- Exception: 501 at 0xc0018b84
[    4.472708]     LR =3D 0xc027e5ac
[    4.480252] [c03fdbb0] [c39a2000] 0xc39a2000 (unreliable)
[    4.485772] [c03fdbf0] [c027e748] 0xc027e748
[    4.490139] [c03fdc30] [c02ef9e8] 0xc02ef9e8
[    4.494505] [c03fdc50] [c02ef620] 0xc02ef620
[    4.498871] [c03fdc90] [c02ef820] 0xc02ef820
[    4.503237] [c03fdcb0] [c02f20a8] 0xc02f20a8
[    4.507601] [c03fdce0] [c027b550] 0xc027b550
[    4.511968] [c03fdd00] [c02c4a44] 0xc02c4a44
[    4.516334] [c03fdd20] [c02c6044] 0xc02c6044
[    4.520700] [c03fdd70] [c02a3a60] 0xc02a3a60
[    4.525066] [c03fdd90] [c02a3e90] 0xc02a3e90
[    4.529433] [c03fddc0] [c0287928] 0xc0287928
[    4.533798] [c03fddf0] [c028a490] 0xc028a490
[    4.538164] [c03fde20] [c028a838] 0xc028a838
[    4.542527] [c03fde50] [c002c91c] 0xc002c91c
[    4.546894] [c03fde90] [c00064f4] 0xc00064f4
[    4.551257] [c03fdea0] [c002c76c] 0xc002c76c
[    4.555623] [c03fdeb0] [c0006594] 0xc0006594
[    4.559989] [c03fded0] [c0014584] 0xc0014584
[    4.564356] --- Exception: 501 at 0xc0009398
[    4.564375]     LR =3D 0xc0009398
[    4.571919] [c03fdf90] [c0009348] 0xc0009348 (unreliable)
[    4.577439] [c03fdfb0] [c0003e40] 0xc0003e40
[    4.581802] [c03fdfc0] [c039d850] 0xc039d850
[    4.586168] [c03fdff0] [00003438] 0x003438
[    4.590352] Instruction dump:
[    4.593390] 4e800020 9421ffd0 7c0802a6 bf210014 54290024 7c7d1b78 900100=
34 7c
9b2378
[    4.601358] 7cba2b78 7cd93378 8009000c 5400016e <0f000000> 3b830028 7f83=
e378
480e3221
[    4.609519] Kernel panic - not syncing: Fatal exception in interrupt
[    4.616013] Rebooting in 1 seconds..



Best regards

Thomas


--_000_6E9D235B18CE694399D781F05D9C42E79F0C2C12SIMBX11deboschc_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>Hello everyone,</div>
<div>&nbsp;</div>
<div>I'll try to run a 2.6.31-rc7 kernel on my Lite5200 board.</div>
<div>For the device tree I use lite5200.dts and compiled it simply with</di=
v>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make ARCH=3Dpowerpc CROSS_C=
OMPILE=3Dppc_6xx- lite5200.dtb</div>
<div>&nbsp;</div>
<div>But I'm not sure what configuration for the kernel I should choose. Th=
ere is no </div>
<div>lite5200_defconfig only one for the lite5200b. </div>
<div>I tried it with mpc5200_defconfig and lite5200b_defconfig, but I'm not=
 sure which</div>
<div>is the right way.</div>
<div>For compiling the kernel I use:</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make ARCH=3Dpowerpc CROSS_C=
OMPILE=3Dppc_6xx- &quot;CONFIG_FILE&quot;</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make ARCH=3Dpowerpc CROSS_C=
OMPILE=3Dppc_6xx- uImage</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make ARCH=3Dpowerpc CROSS_C=
OMPILE=3Dppc_6xx- modules</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; make ARCH=3Dpowerpc CROSS_C=
OMPILE=3Dppc_6xx- modules_install</div>
<div>&nbsp;</div>
<div>Can anyone tell me?</div>
<div>&nbsp;</div>
<div>I use U-Boot 2009.06, with the following settings for bootup:</div>
<div>&nbsp;</div>
<div>=3D&gt; print kernel_addr fdt_addr dtbfile bootfile bootargs</div>
<div>kernel_addr=3D900000</div>
<div>fdt_addr=3Db00000</div>
<div>dtbfile=3D/tftpboot/lite5200.dtb</div>
<div>bootfile=3D/tftpboot/uImage</div>
<div>bootargs=3Dconsole=3DttyPSC0,115200 root=3D/dev/nfs rw nfsroot=3D10.10=
.0.2:/opt/eldk/ppc</div>
<div>_82xx ip=3D10.10.0.99:10.10.0.2::255.255.255.0:icecube::off panic=3D1<=
/div>
<div>=3D&gt; tftp ${kernel_addr} ${boofile}; tftp ${fdt_addr} ${dtbfile}</d=
iv>
<div>=3D&gt; bootm ${kernel_addr} - ${fdt_addr}</div>
<div>&nbsp;</div>
<div>With lite5200b_defconfig config the last message I see is:</div>
<div>&nbsp;</div>
<div>=3D&gt; tftp ${kernel_addr} ${boofile}; tftp ${fdt_addr} ${dtbfile}</d=
iv>
<div>Using FEC ETHERNET device</div>
<div>TFTP from server 10.10.0.2; our IP address is 10.10.0.99</div>
<div>Filename '/tftpboot/uImage'.</div>
<div>Load address: 0x900000</div>
<div>Loading: #############################################################=
####</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #####################=
############################################</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #####################=
############################################</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #####################=
############################################</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #####################=
##############</div>
<div>done</div>
<div>Bytes transferred =3D 1507908 (170244 hex)</div>
<div>Using FEC ETHERNET device</div>
<div>TFTP from server 10.10.0.2; our IP address is 10.10.0.99</div>
<div>Filename '/tftpboot/lite5200.dtb'.</div>
<div>Load address: 0xb00000</div>
<div>Loading: ##</div>
<div>done</div>
<div>Bytes transferred =3D 5375 (14ff hex)</div>
<div>=3D&gt; bootm ${kernel_addr} - ${fdt_addr}</div>
<div>## Booting kernel from Legacy Image at 00900000 ...</div>
<div>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.31-rc7-01406-g83e0360-<=
/div>
<div>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2009-08-27&nbsp;&n=
bsp; 7:58:32 UTC</div>
<div>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)</div>
<div>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1507844 Bytes =3D&nbsp; 1.4 =
MB</div>
<div>&nbsp;&nbsp; Load Address: 00000000</div>
<div>&nbsp;&nbsp; Entry Point:&nbsp; 00000000</div>
<div>&nbsp;&nbsp; Verifying Checksum ... OK</div>
<div>## Flattened Device Tree blob at 00b00000</div>
<div>&nbsp;&nbsp; Booting using the fdt blob at 0xb00000</div>
<div>&nbsp;&nbsp; Uncompressing Kernel Image ... OK</div>
<div>&nbsp;&nbsp; Loading Device Tree to 007fb000, end 007ff4fe ... OK</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Using lite5200 machine description</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.31-rc7-01406-g83e0360-=
dirty (root@user-laptop)</div>
<div>(gcc version 4.2.2) #6 Thu Aug 27 09:58:17 CEST 2009</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] PCI host bridge /pci@f0000d00 (primary) =
ranges:</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; MEM 0x0000000080000000..0x00000000=
9fffffff -&gt; 0x0000000080000000</div>
<div> Prefetch</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; MEM 0x00000000a0000000..0x00000000=
afffffff -&gt; 0x00000000a0000000</div>
<div>&nbsp;</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; IO 0x00000000b0000000..0x000=
00000b0ffffff -&gt; 0x0000000000000000</div>
<div>&nbsp;</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Zone PFN ranges:</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00000000 -&gt; 0x00004000</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; Normal&nbsp;&nbsp; 0x0000400=
0 -&gt; 0x00004000</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Movable zone start PFN for each node</di=
v>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] early_node_map[1] active PFN ranges</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; 0: 0x00000000 -&=
gt; 0x00004000</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists in Zone order, mobilit=
y grouping on.&nbsp; Total pag</div>
<div>es: 16256</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: console=3DttyPSC0,1=
15200 root=3D/dev/nfs rw nfsr</div>
<div>oot=3D10.10.0.2:/opt/eldk/ppc_82xx ip=3D10.10.0.99:10.10.0.2::255.255.=
255.0:icecube:</div>
<div>:off panic=3D1</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 256 (order: 8, 1=
024 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Dentry cache hash table entries: 8192 (o=
rder: 3, 32768 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Inode-cache hash table entries: 4096 (or=
der: 2, 16384 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Memory: 61612k/65536k available (2972k k=
ernel code, 3864k reserve</div>
<div>d, 144k data, 108k bss, 160k init)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel virtual memory layout:</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; * 0xffffe000..0xfffff000&nbs=
p; : fixmap</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; * 0xfcffa000..0xfe000000&nbs=
p; : early ioremap</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; * 0xc5000000..0xfcffa000&nbs=
p; : vmalloc &amp; ioremap</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] SLUB: Genslabs=3D13, HWalign=3D32, Order=
=3D0-3, MinObjects=3D0, CPUs=3D1, N</div>
<div>odes=3D1</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] NR_IRQS:512</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] MPC52xx PIC is up and running!</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] clocksource: timebase mult[f26c9b2] shif=
t[22] registered</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000738] console [ttyPSC0] enabled</div>
<div>[&nbsp;&nbsp;&nbsp; 0.169172] Mount-cache hash table entries: 512</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.184911] NET: Registered protocol family 16</div>
<div>[&nbsp;&nbsp;&nbsp; 0.240784] PCI: Probing PCI hardware</div>
<div>[&nbsp;&nbsp;&nbsp; 0.248600] DMA: MPC52xx BestComm driver</div>
<div>[&nbsp;&nbsp;&nbsp; 0.253306] DMA: MPC52xx BestComm engine @f0001200 o=
k !</div>
<div>[&nbsp;&nbsp;&nbsp; 0.309563] bio: create slab &lt;bio-0&gt; at 0</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.320464] SCSI subsystem initialized</div>
<div>[&nbsp;&nbsp;&nbsp; 0.345661] NET: Registered protocol family 2</div>
<div>[&nbsp;&nbsp;&nbsp; 0.350793] IP route cache hash table entries: 1024 =
(order: 0, 4096 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.359384] TCP established hash table entries: 2048=
 (order: 2, 16384 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.367176] TCP bind hash table entries: 2048 (order=
: 1, 8192 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.374059] TCP: Hash tables configured (established=
 2048 bind 2048)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.380734] TCP reno registered</div>
<div>[&nbsp;&nbsp;&nbsp; 0.384910] NET: Registered protocol family 1</div>
<div>[&nbsp;&nbsp;&nbsp; 0.498050] msgmni has been set to 120</div>
<div>[&nbsp;&nbsp;&nbsp; 0.506553] alg: No test for stdrng (krng)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.511415] io scheduler noop registered</div>
<div>[&nbsp;&nbsp;&nbsp; 0.515636] io scheduler anticipatory registered (de=
fault)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.521491] io scheduler deadline registered</div>
<div>[&nbsp;&nbsp;&nbsp; 0.526513] io scheduler cfq registered</div>
<div>[&nbsp;&nbsp;&nbsp; 1.706240] Generic RTC Driver v1.07</div>
<div>[&nbsp;&nbsp;&nbsp; 1.712363] Serial: MPC52xx PSC UART driver</div>
<div>[&nbsp;&nbsp;&nbsp; 1.717645] f0002000.serial: ttyPSC0 at MMIO 0xf0002=
000 (irq =3D 129) is a MPC5</div>
<div>2xx PSC</div>
<div>[&nbsp;&nbsp;&nbsp; 1.779407] brd: module loaded</div>
<div>[&nbsp;&nbsp;&nbsp; 1.808029] loop: module loaded</div>
<div>[&nbsp;&nbsp;&nbsp; 1.814012] ata: MPC52xx IDE/ATA libata driver</div>
<div>[&nbsp;&nbsp;&nbsp; 1.821144] scsi0 : mpc52xx_ata</div>
<div>[&nbsp;&nbsp;&nbsp; 1.826559] ata1: PATA max PIO4 ata_regs 0xf0003a00 =
irq 135</div>
<div>[&nbsp;&nbsp;&nbsp; 1.838948] mpc52xx MII bus: probed</div>
<div>[&nbsp;&nbsp;&nbsp; 1.864150] i2c /dev entries driver</div>
<div>[&nbsp;&nbsp;&nbsp; 1.883715] TCP cubic registered</div>
<div>[&nbsp;&nbsp;&nbsp; 1.887261] NET: Registered protocol family 17</div>
<div>[&nbsp;&nbsp;&nbsp; 1.895154] RPC: Registered udp transport module.</d=
iv>
<div>[&nbsp;&nbsp;&nbsp; 1.900177] RPC: Registered tcp transport module.</d=
iv>
<div>[&nbsp;&nbsp;&nbsp; 3.450019] IP-Config: Complete:</div>
<div>[&nbsp;&nbsp;&nbsp; 3.453333]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3De=
th0, addr=3D10.10.0.99, mask=3D255.255.255.0, gw=3D255.255</div>
<div>.255.255,</div>
<div>[&nbsp;&nbsp;&nbsp; 3.461661]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; host=3Dice=
cube, domain=3D, nis-domain=3D(none),</div>
<div>[&nbsp;&nbsp;&nbsp; 3.467407]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bootserver=
=3D10.10.0.2, rootserver=3D10.10.0.2, rootpath=3D</div>
<div>[&nbsp;&nbsp;&nbsp; 3.489436] Looking up port of RPC 100003/2 on 10.10=
.0.2</div>
<div>[&nbsp;&nbsp;&nbsp; 3.530495] Looking up port of RPC 100005/1 on 10.10=
.0.2</div>
<div>[&nbsp;&nbsp;&nbsp; 3.667558] VFS: Mounted root (nfs filesystem) on de=
vice 0:11.</div>
<div>[&nbsp;&nbsp;&nbsp; 3.674123] Freeing unused kernel memory: 160k init<=
/div>
<div>[&nbsp;&nbsp;&nbsp; 4.085086] net eth0: FEC_IEVENT_RFIFO_ERROR</div>
<div>[&nbsp;&nbsp;&nbsp; 4.091135] ------------[ cut here ]------------</di=
v>
<div>[&nbsp;&nbsp;&nbsp; 4.095874] Kernel BUG at c01b7d4c [verbose debug in=
fo unavailable]</div>
<div>[&nbsp;&nbsp;&nbsp; 4.102285] Oops: Exception in kernel mode, sig: 5 [=
#1]</div>
<div>[&nbsp;&nbsp;&nbsp; 4.107615] lite5200</div>
<div>[&nbsp;&nbsp;&nbsp; 4.109842] Modules linked in:</div>
<div>[&nbsp;&nbsp;&nbsp; 4.112965] NIP: c01b7d4c LR: c01b900c CTR: c0011220=
</div>
<div>[&nbsp;&nbsp;&nbsp; 4.118035] REGS: c030da20 TRAP: 0700&nbsp;&nbsp; No=
t tainted&nbsp; (2.6.31-rc7-01406-g83e03</div>
<div>60-dirty)</div>
<div>[&nbsp;&nbsp;&nbsp; 4.126106] MSR: 00029032 &lt;EE,ME,CE,IR,DR&gt;&nbs=
p; CR: 22000024&nbsp; XER: 00000000</div>
<div>[&nbsp;&nbsp;&nbsp; 4.132907] TASK =3D c02e93e8[0] 'swapper' THREAD: c=
030c000</div>
<div>[&nbsp;&nbsp;&nbsp; 4.138235] GPR00: 00010200 c030dad0 c02e93e8 c391fe=
00 00000001 00000000 0000</div>
<div>8000 00000000</div>
<div>[&nbsp;&nbsp;&nbsp; 4.146798] GPR08: 00000006 c030c000 c0335000 000734=
e0 22000022 ffcf5fff 03fb</div>
<div>8000 03fa8878</div>
<div>[&nbsp;&nbsp;&nbsp; 4.155357] GPR16: 03f81ae8 03fa8854 03f45dcc 03f45c=
cc 03f45bee c0328428 c386</div>
<div>fe00 0a0a0063</div>
<div>[&nbsp;&nbsp;&nbsp; 4.163920] GPR24: 0000106c 00008000 00000000 000000=
01 00000000 c391fe00 c387</div>
<div>7c00 c3877ec0</div>
<div>[&nbsp;&nbsp;&nbsp; 4.172666] Call Trace:</div>
<div>[&nbsp;&nbsp;&nbsp; 4.175165] [c030dad0] [c01b8ec0] 0xc01b8ec0 (unreli=
able)</div>
<div>[&nbsp;&nbsp;&nbsp; 4.180677] [c030db00] [c01b900c] 0xc01b900c</div>
<div>[&nbsp;&nbsp;&nbsp; 4.185034] [c030db20] [c01b9310] 0xc01b9310</div>
<div>[&nbsp;&nbsp;&nbsp; 4.189394] [c030db40] [c004fd08] 0xc004fd08</div>
<div>[&nbsp;&nbsp;&nbsp; 4.193753] [c030db60] [c0051f14] 0xc0051f14</div>
<div>[&nbsp;&nbsp;&nbsp; 4.198113] [c030db70] [c0006590] 0xc0006590</div>
<div>[&nbsp;&nbsp;&nbsp; 4.202473] [c030db90] [c0012084] 0xc0012084</div>
<div>[&nbsp;&nbsp;&nbsp; 4.206833] --- Exception: 501 at 0xc023d1a4</div>
<div>[&nbsp;&nbsp;&nbsp; 4.206846]&nbsp;&nbsp;&nbsp;&nbsp; LR =3D 0xc023dca=
c</div>
<div>[&nbsp;&nbsp;&nbsp; 4.214387] [c030dc50] [c02395e4] 0xc02395e4 (unreli=
able)</div>
<div>[&nbsp;&nbsp;&nbsp; 4.219904] [c030dc80] [c023dcac] 0xc023dcac</div>
<div>[&nbsp;&nbsp;&nbsp; 4.224262] [c030dc90] [c0237e2c] 0xc0237e2c</div>
<div>[&nbsp;&nbsp;&nbsp; 4.228622] [c030dcb0] [c023c120] 0xc023c120</div>
<div>[&nbsp;&nbsp;&nbsp; 4.232982] [c030dce0] [c01c5514] 0xc01c5514</div>
<div>[&nbsp;&nbsp;&nbsp; 4.237341] [c030dd00] [c020ea08] 0xc020ea08</div>
<div>[&nbsp;&nbsp;&nbsp; 4.241701] [c030dd20] [c0210008] 0xc0210008</div>
<div>[&nbsp;&nbsp;&nbsp; 4.246059] [c030dd70] [c01eda24] 0xc01eda24</div>
<div>[&nbsp;&nbsp;&nbsp; 4.250418] [c030dd90] [c01ede54] 0xc01ede54</div>
<div>[&nbsp;&nbsp;&nbsp; 4.254775] --- Exception: c at 0xc030de50</div>
<div>[&nbsp;&nbsp;&nbsp; 4.254789]&nbsp;&nbsp;&nbsp;&nbsp; LR =3D 0x00000a<=
/div>
<div>[&nbsp;&nbsp;&nbsp; 4.261973] [c030ddc0] [c01d18ec] 0xc01d18ec (unreli=
able)</div>
<div>[&nbsp;&nbsp;&nbsp; 4.267490] [c030ddf0] [c01d4454] 0xc01d4454</div>
<div>[&nbsp;&nbsp;&nbsp; 4.271850] [c030de20] [c01d47fc] 0xc01d47fc</div>
<div>[&nbsp;&nbsp;&nbsp; 4.276209] [c030de50] [c0029c48] 0xc0029c48</div>
<div>[&nbsp;&nbsp;&nbsp; 4.280570] [c030de90] [c00064f4] 0xc00064f4</div>
<div>[&nbsp;&nbsp;&nbsp; 4.284929] [c030dea0] [c0029a98] 0xc0029a98</div>
<div>[&nbsp;&nbsp;&nbsp; 4.289288] [c030deb0] [c0006594] 0xc0006594</div>
<div>[&nbsp;&nbsp;&nbsp; 4.293645] [c030ded0] [c0012084] 0xc0012084</div>
<div>[&nbsp;&nbsp;&nbsp; 4.298004] --- Exception: 501 at 0xc0009398</div>
<div>[&nbsp;&nbsp;&nbsp; 4.298020]&nbsp;&nbsp;&nbsp;&nbsp; LR =3D 0xc000939=
8</div>
<div>[&nbsp;&nbsp;&nbsp; 4.305561] [c030df90] [c0009348] 0xc0009348 (unreli=
able)</div>
<div>[&nbsp;&nbsp;&nbsp; 4.311077] [c030dfb0] [c0003e40] 0xc0003e40</div>
<div>[&nbsp;&nbsp;&nbsp; 4.315436] [c030dfc0] [c02bf850] 0xc02bf850</div>
<div>[&nbsp;&nbsp;&nbsp; 4.319795] [c030dff0] [00003438] 0x003438</div>
<div>[&nbsp;&nbsp;&nbsp; 4.323972] Instruction dump:</div>
<div>[&nbsp;&nbsp;&nbsp; 4.326999] 4e800020 9421ffd0 7c0802a6 bf210014 5429=
0024 7c7d1b78 90010034 7c</div>
<div>9b2378</div>
<div>[&nbsp;&nbsp;&nbsp; 4.334947] 7cba2b78 7cd93378 8009000c 5400016e &lt;=
0f000000&gt; 3b830028 7f83e378</div>
<div>4809e8dd</div>
<div>[&nbsp;&nbsp;&nbsp; 4.343083] Kernel panic - not syncing: Fatal except=
ion in interrupt</div>
<div>[&nbsp;&nbsp;&nbsp; 4.349564] Rebooting in 1 seconds.</div>
<div>&nbsp;</div>
<div>And with mpc5200_defconfig config it is:</div>
<div>&nbsp;</div>
<div>Using FEC ETHERNET device</div>
<div>TFTP from server 10.10.0.2; our IP address is 10.10.0.99</div>
<div>Filename '/tftpboot/uImage'.</div>
<div>Load address: 0x900000</div>
<div>Loading: #############################################################=
####</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #####################=
############################################</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #####################=
############################################</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #####################=
############################################</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #####################=
############################################</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #####################=
##################################</div>
<div>done</div>
<div>Bytes transferred =3D 1945203 (1dae73 hex)</div>
<div>Using FEC ETHERNET device</div>
<div>TFTP from server 10.10.0.2; our IP address is 10.10.0.99</div>
<div>Filename '/tftpboot/lite5200.dtb'.</div>
<div>Load address: 0xb00000</div>
<div>Loading: ##</div>
<div>done</div>
<div>Bytes transferred =3D 5375 (14ff hex)</div>
<div>=3D&gt; bootm ${kernel_addr} - ${fdt_addr}</div>
<div>## Booting kernel from Legacy Image at 00900000 ...</div>
<div>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.31-rc7-01406-g83e0360</=
div>
<div>&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2009-08-27&nbsp;&n=
bsp; 6:51:07 UTC</div>
<div>&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)</div>
<div>&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1945139 Bytes =3D&nbsp; 1.9 =
MB</div>
<div>&nbsp;&nbsp; Load Address: 00000000</div>
<div>&nbsp;&nbsp; Entry Point:&nbsp; 00000000</div>
<div>&nbsp;&nbsp; Verifying Checksum ... OK</div>
<div>## Flattened Device Tree blob at 00b00000</div>
<div>&nbsp;&nbsp; Booting using the fdt blob at 0xb00000</div>
<div>&nbsp;&nbsp; Uncompressing Kernel Image ... OK</div>
<div>&nbsp;&nbsp; Loading Device Tree to 007fb000, end 007ff4fe ... OK</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Using lite5200 machine description</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Linux version 2.6.31-rc7-01406-g83e0360 =
(root@user-laptop) (gcc v</div>
<div>ersion 4.2.2) #3 Thu Aug 27 08:50:54 CEST 2009</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] PCI host bridge /pci@f0000d00 (primary) =
ranges:</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; MEM 0x0000000080000000..0x00000000=
9fffffff -&gt; 0x0000000080000000</div>
<div> Prefetch</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; MEM 0x00000000a0000000..0x00000000=
afffffff -&gt; 0x00000000a0000000</div>
<div>&nbsp;</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; IO 0x00000000b0000000..0x000=
00000b0ffffff -&gt; 0x0000000000000000</div>
<div>&nbsp;</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Zone PFN ranges:</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x00000000 -&gt; 0x00004000</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; Normal&nbsp;&nbsp; 0x0000400=
0 -&gt; 0x00004000</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Movable zone start PFN for each node</di=
v>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] early_node_map[1] active PFN ranges</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; 0: 0x00000000 -&=
gt; 0x00004000</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists in Zone order, mobilit=
y grouping on.&nbsp; Total pag</div>
<div>es: 16256</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel command line: console=3DttyPSC0,1=
15200 root=3D/dev/nfs rw nfsr</div>
<div>oot=3D10.10.0.2:/opt/eldk/ppc_82xx ip=3D10.10.0.99:10.10.0.2::255.255.=
255.0:icecube:</div>
<div>:off panic=3D1</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] PID hash table entries: 256 (order: 8, 1=
024 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Dentry cache hash table entries: 8192 (o=
rder: 3, 32768 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Inode-cache hash table entries: 4096 (or=
der: 2, 16384 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Memory: 60588k/65536k available (3888k k=
ernel code, 4884k reserve</div>
<div>d, 188k data, 164k bss, 188k init)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] Kernel virtual memory layout:</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; * 0xffffe000..0xfffff000&nbs=
p; : fixmap</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; * 0xfcffa000..0xfe000000&nbs=
p; : early ioremap</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; * 0xc5000000..0xfcffa000&nbs=
p; : vmalloc &amp; ioremap</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] SLUB: Genslabs=3D13, HWalign=3D32, Order=
=3D0-3, MinObjects=3D0, CPUs=3D1, N</div>
<div>odes=3D1</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] NR_IRQS:512</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] MPC52xx PIC is up and running!</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000000] clocksource: timebase mult[f26c9b2] shif=
t[22] registered</div>
<div>[&nbsp;&nbsp;&nbsp; 0.000467] Console: colour dummy device 80x25</div>
<div>[&nbsp;&nbsp;&nbsp; 0.001126] console [ttyPSC0] enabled</div>
<div>[&nbsp;&nbsp;&nbsp; 0.173540] Mount-cache hash table entries: 512</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.188342] NET: Registered protocol family 16</div>
<div>[&nbsp;&nbsp;&nbsp; 0.251292] PCI: Probing PCI hardware</div>
<div>[&nbsp;&nbsp;&nbsp; 0.259136] DMA: MPC52xx BestComm driver</div>
<div>[&nbsp;&nbsp;&nbsp; 0.263847] DMA: MPC52xx BestComm engine @f0001200 o=
k !</div>
<div>[&nbsp;&nbsp;&nbsp; 0.356705] bio: create slab &lt;bio-0&gt; at 0</div=
>
<div>[&nbsp;&nbsp;&nbsp; 0.368969] SCSI subsystem initialized</div>
<div>[&nbsp;&nbsp;&nbsp; 0.380298] usbcore: registered new interface driver=
 usbfs</div>
<div>[&nbsp;&nbsp;&nbsp; 0.387488] usbcore: registered new interface driver=
 hub</div>
<div>[&nbsp;&nbsp;&nbsp; 0.394699] usbcore: registered new device driver us=
b</div>
<div>[&nbsp;&nbsp;&nbsp; 0.420014] NET: Registered protocol family 2</div>
<div>[&nbsp;&nbsp;&nbsp; 0.425101] IP route cache hash table entries: 1024 =
(order: 0, 4096 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.433699] TCP established hash table entries: 2048=
 (order: 2, 16384 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.441486] TCP bind hash table entries: 2048 (order=
: 1, 8192 bytes)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.448407] TCP: Hash tables configured (established=
 2048 bind 2048)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.455022] TCP reno registered</div>
<div>[&nbsp;&nbsp;&nbsp; 0.459100] NET: Registered protocol family 1</div>
<div>[&nbsp;&nbsp;&nbsp; 0.574734] JFFS2 version 2.2. (NAND) =C2=A9 2001-20=
06 Red Hat, Inc.</div>
<div>[&nbsp;&nbsp;&nbsp; 0.589702] msgmni has been set to 118</div>
<div>[&nbsp;&nbsp;&nbsp; 0.598135] alg: No test for stdrng (krng)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.602904] io scheduler noop registered</div>
<div>[&nbsp;&nbsp;&nbsp; 0.607201] io scheduler anticipatory registered (de=
fault)</div>
<div>[&nbsp;&nbsp;&nbsp; 0.612979] io scheduler deadline registered</div>
<div>[&nbsp;&nbsp;&nbsp; 0.618008] io scheduler cfq registered</div>
<div>[&nbsp;&nbsp;&nbsp; 2.034926] [drm] Initialized drm 1.1.0 20060810</di=
v>
<div>[&nbsp;&nbsp;&nbsp; 2.039933] Serial: MPC52xx PSC UART driver</div>
<div>[&nbsp;&nbsp;&nbsp; 2.045071] f0002000.serial: ttyPSC0 at MMIO 0xf0002=
000 (irq =3D 129) is a MPC5</div>
<div>2xx PSC</div>
<div>[&nbsp;&nbsp;&nbsp; 2.107178] brd: module loaded</div>
<div>[&nbsp;&nbsp;&nbsp; 2.135950] loop: module loaded</div>
<div>[&nbsp;&nbsp;&nbsp; 2.149599] ata: MPC52xx IDE/ATA libata driver</div>
<div>[&nbsp;&nbsp;&nbsp; 2.156669] scsi0 : mpc52xx_ata</div>
<div>[&nbsp;&nbsp;&nbsp; 2.162242] ata1: PATA max PIO4 ata_regs 0xf0003a00 =
irq 135</div>
<div>[&nbsp;&nbsp;&nbsp; 2.175746] mpc52xx MII bus: probed</div>
<div>[&nbsp;&nbsp;&nbsp; 2.203297] usbmon: debugfs is not available</div>
<div>[&nbsp;&nbsp;&nbsp; 2.207880] ohci_hcd: USB 1.1 'Open' Host Controller=
 (OHCI) Driver</div>
<div>[&nbsp;&nbsp;&nbsp; 2.216515] ppc-of-ohci f0001000.usb: OF OHCI</div>
<div>[&nbsp;&nbsp;&nbsp; 2.221581] ppc-of-ohci f0001000.usb: new USB bus re=
gistered, assigned bus nu</div>
<div>mber 1</div>
<div>[&nbsp;&nbsp;&nbsp; 2.229777] ppc-of-ohci f0001000.usb: irq 134, io me=
m 0xf0001000</div>
<div>[&nbsp;&nbsp;&nbsp; 2.295284] usb usb1: configuration #1 chosen from 1=
 choice</div>
<div>[&nbsp;&nbsp;&nbsp; 2.303126] hub 1-0:1.0: USB hub found</div>
<div>[&nbsp;&nbsp;&nbsp; 2.307386] hub 1-0:1.0: 2 ports detected</div>
<div>[&nbsp;&nbsp;&nbsp; 2.315260] Initializing USB Mass Storage driver...<=
/div>
<div>[&nbsp;&nbsp;&nbsp; 2.321842] usbcore: registered new interface driver=
 usb-storage</div>
<div>[&nbsp;&nbsp;&nbsp; 2.328414] USB Mass Storage support registered.</di=
v>
<div>[&nbsp;&nbsp;&nbsp; 2.349763] mice: PS/2 mouse device common for all m=
ice</div>
<div>[&nbsp;&nbsp;&nbsp; 2.356703] i2c /dev entries driver</div>
<div>[&nbsp;&nbsp;&nbsp; 2.384164] usbcore: registered new interface driver=
 usbhid</div>
<div>[&nbsp;&nbsp;&nbsp; 2.390132] usbhid: v2.6:USB HID core driver</div>
<div>[&nbsp;&nbsp;&nbsp; 2.397686] TCP cubic registered</div>
<div>[&nbsp;&nbsp;&nbsp; 2.401412] NET: Registered protocol family 17</div>
<div>[&nbsp;&nbsp;&nbsp; 2.409581] RPC: Registered udp transport module.</d=
iv>
<div>[&nbsp;&nbsp;&nbsp; 2.414646] RPC: Registered tcp transport module.</d=
iv>
<div>[&nbsp;&nbsp;&nbsp; 2.427827] drivers/rtc/hctosys.c: unable to open rt=
c device (rtc0)</div>
<div>[&nbsp;&nbsp;&nbsp; 3.969764] IP-Config: Complete:</div>
<div>[&nbsp;&nbsp;&nbsp; 3.973082]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=3De=
th0, addr=3D10.10.0.99, mask=3D255.255.255.0, gw=3D255.255</div>
<div>.255.255,</div>
<div>[&nbsp;&nbsp;&nbsp; 3.981401]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; host=3Dice=
cube, domain=3D, nis-domain=3D(none),</div>
<div>[&nbsp;&nbsp;&nbsp; 3.987140]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bootserver=
=3D10.10.0.2, rootserver=3D10.10.0.2, rootpath=3D</div>
<div>[&nbsp;&nbsp;&nbsp; 4.009033] Looking up port of RPC 100003/2 on 10.10=
.0.2</div>
<div>[&nbsp;&nbsp;&nbsp; 4.055286] Looking up port of RPC 100005/1 on 10.10=
.0.2</div>
<div>[&nbsp;&nbsp;&nbsp; 4.226838] VFS: Mounted root (nfs filesystem) on de=
vice 0:12.</div>
<div>[&nbsp;&nbsp;&nbsp; 4.233384] Freeing unused kernel memory: 188k init<=
/div>
<div>[&nbsp;&nbsp;&nbsp; 4.351275] net eth0: FEC_IEVENT_RFIFO_ERROR</div>
<div>[&nbsp;&nbsp;&nbsp; 4.357356] ------------[ cut here ]------------</di=
v>
<div>[&nbsp;&nbsp;&nbsp; 4.362100] Kernel BUG at c0229440 [verbose debug in=
fo unavailable]</div>
<div>[&nbsp;&nbsp;&nbsp; 4.368517] Oops: Exception in kernel mode, sig: 5 [=
#1]</div>
<div>[&nbsp;&nbsp;&nbsp; 4.373853] lite5200</div>
<div>[&nbsp;&nbsp;&nbsp; 4.376085] Modules linked in:</div>
<div>[&nbsp;&nbsp;&nbsp; 4.379219] NIP: c0229440 LR: c022a700 CTR: c0013720=
</div>
<div>[&nbsp;&nbsp;&nbsp; 4.384300] REGS: c03fd980 TRAP: 0700&nbsp;&nbsp; No=
t tainted&nbsp; (2.6.31-rc7-01406-g83e03</div>
<div>60)</div>
<div>[&nbsp;&nbsp;&nbsp; 4.391848] MSR: 00029032 &lt;EE,ME,CE,IR,DR&gt;&nbs=
p; CR: 22000024&nbsp; XER: 00000000</div>
<div>[&nbsp;&nbsp;&nbsp; 4.398659] TASK =3D c03ce3e8[0] 'swapper' THREAD: c=
03fc000</div>
<div>[&nbsp;&nbsp;&nbsp; 4.403993] GPR00: 00010100 c03fda30 c03ce3e8 c397ec=
00 00000001 00000000 0000</div>
<div>8000 00000000</div>
<div>[&nbsp;&nbsp;&nbsp; 4.412574] GPR08: 00000021 c03fc000 c0434000 00073d=
80 82000022 ffcf5fff 03fb</div>
<div>8000 03fa8878</div>
<div>[&nbsp;&nbsp;&nbsp; 4.421148] GPR16: 03f81ae8 03fa8854 03f45dcc 03f45c=
cc c03f9e54 c39b2d80 0000</div>
<div>0000 c03c2b24</div>
<div>[&nbsp;&nbsp;&nbsp; 4.429718] GPR24: 00000064 00008000 00000000 000000=
01 00000000 c397ec00 c39a</div>
<div>2000 c39a22c0</div>
<div>[&nbsp;&nbsp;&nbsp; 4.438468] Call Trace:</div>
<div>[&nbsp;&nbsp;&nbsp; 4.440977] [c03fda30] [c022a5b4] 0xc022a5b4 (unreli=
able)</div>
<div>[&nbsp;&nbsp;&nbsp; 4.446497] [c03fda60] [c022a700] 0xc022a700</div>
<div>[&nbsp;&nbsp;&nbsp; 4.450863] [c03fda80] [c022aa04] 0xc022aa04</div>
<div>[&nbsp;&nbsp;&nbsp; 4.455227] [c03fdaa0] [c00528b4] 0xc00528b4</div>
<div>[&nbsp;&nbsp;&nbsp; 4.459593] [c03fdac0] [c0054ac0] 0xc0054ac0</div>
<div>[&nbsp;&nbsp;&nbsp; 4.463960] [c03fdad0] [c0006590] 0xc0006590</div>
<div>[&nbsp;&nbsp;&nbsp; 4.468326] [c03fdaf0] [c0014584] 0xc0014584</div>
<div>[&nbsp;&nbsp;&nbsp; 4.472690] --- Exception: 501 at 0xc0018b84</div>
<div>[&nbsp;&nbsp;&nbsp; 4.472708]&nbsp;&nbsp;&nbsp;&nbsp; LR =3D 0xc027e5a=
c</div>
<div>[&nbsp;&nbsp;&nbsp; 4.480252] [c03fdbb0] [c39a2000] 0xc39a2000 (unreli=
able)</div>
<div>[&nbsp;&nbsp;&nbsp; 4.485772] [c03fdbf0] [c027e748] 0xc027e748</div>
<div>[&nbsp;&nbsp;&nbsp; 4.490139] [c03fdc30] [c02ef9e8] 0xc02ef9e8</div>
<div>[&nbsp;&nbsp;&nbsp; 4.494505] [c03fdc50] [c02ef620] 0xc02ef620</div>
<div>[&nbsp;&nbsp;&nbsp; 4.498871] [c03fdc90] [c02ef820] 0xc02ef820</div>
<div>[&nbsp;&nbsp;&nbsp; 4.503237] [c03fdcb0] [c02f20a8] 0xc02f20a8</div>
<div>[&nbsp;&nbsp;&nbsp; 4.507601] [c03fdce0] [c027b550] 0xc027b550</div>
<div>[&nbsp;&nbsp;&nbsp; 4.511968] [c03fdd00] [c02c4a44] 0xc02c4a44</div>
<div>[&nbsp;&nbsp;&nbsp; 4.516334] [c03fdd20] [c02c6044] 0xc02c6044</div>
<div>[&nbsp;&nbsp;&nbsp; 4.520700] [c03fdd70] [c02a3a60] 0xc02a3a60</div>
<div>[&nbsp;&nbsp;&nbsp; 4.525066] [c03fdd90] [c02a3e90] 0xc02a3e90</div>
<div>[&nbsp;&nbsp;&nbsp; 4.529433] [c03fddc0] [c0287928] 0xc0287928</div>
<div>[&nbsp;&nbsp;&nbsp; 4.533798] [c03fddf0] [c028a490] 0xc028a490</div>
<div>[&nbsp;&nbsp;&nbsp; 4.538164] [c03fde20] [c028a838] 0xc028a838</div>
<div>[&nbsp;&nbsp;&nbsp; 4.542527] [c03fde50] [c002c91c] 0xc002c91c</div>
<div>[&nbsp;&nbsp;&nbsp; 4.546894] [c03fde90] [c00064f4] 0xc00064f4</div>
<div>[&nbsp;&nbsp;&nbsp; 4.551257] [c03fdea0] [c002c76c] 0xc002c76c</div>
<div>[&nbsp;&nbsp;&nbsp; 4.555623] [c03fdeb0] [c0006594] 0xc0006594</div>
<div>[&nbsp;&nbsp;&nbsp; 4.559989] [c03fded0] [c0014584] 0xc0014584</div>
<div>[&nbsp;&nbsp;&nbsp; 4.564356] --- Exception: 501 at 0xc0009398</div>
<div>[&nbsp;&nbsp;&nbsp; 4.564375]&nbsp;&nbsp;&nbsp;&nbsp; LR =3D 0xc000939=
8</div>
<div>[&nbsp;&nbsp;&nbsp; 4.571919] [c03fdf90] [c0009348] 0xc0009348 (unreli=
able)</div>
<div>[&nbsp;&nbsp;&nbsp; 4.577439] [c03fdfb0] [c0003e40] 0xc0003e40</div>
<div>[&nbsp;&nbsp;&nbsp; 4.581802] [c03fdfc0] [c039d850] 0xc039d850</div>
<div>[&nbsp;&nbsp;&nbsp; 4.586168] [c03fdff0] [00003438] 0x003438</div>
<div>[&nbsp;&nbsp;&nbsp; 4.590352] Instruction dump:</div>
<div>[&nbsp;&nbsp;&nbsp; 4.593390] 4e800020 9421ffd0 7c0802a6 bf210014 5429=
0024 7c7d1b78 90010034 7c</div>
<div>9b2378</div>
<div>[&nbsp;&nbsp;&nbsp; 4.601358] 7cba2b78 7cd93378 8009000c 5400016e &lt;=
0f000000&gt; 3b830028 7f83e378</div>
<div>480e3221</div>
<div>[&nbsp;&nbsp;&nbsp; 4.609519] Kernel panic - not syncing: Fatal except=
ion in interrupt</div>
<div>[&nbsp;&nbsp;&nbsp; 4.616013] Rebooting in 1 seconds..</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Best regards </div>
<div>&nbsp;</div>
<div><b>Thomas </b></div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_6E9D235B18CE694399D781F05D9C42E79F0C2C12SIMBX11deboschc_--
