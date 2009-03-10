Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.241])
	by ozlabs.org (Postfix) with ESMTP id 6EB88DE0CD
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 10:42:13 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so4348379agc.0
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 16:42:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49B6F513.2090304@gmail.com>
References: <49B1469B.9030609@gmail.com>
	<1236379543.13132.10.camel@md40100b.ft> <49B6F513.2090304@gmail.com>
Date: Tue, 10 Mar 2009 17:42:11 -0600
Message-ID: <fa686aa40903101642l20d4d3e1qab1eac14493690f1@mail.gmail.com>
Subject: Re: C67x00 reset problems
From: Grant Likely <grant.likely@secretlab.ca>
To: "A. Nolson" <alohanono@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Unfortunately, the 2.6.24-rc3 stuff in my git tree is really old.
I've been getting all of my recent work into mainline.  The CF driver
is in much better shape there.  The c67x00 driver is merged into
mainline, but I haven't tested it at all in the last year so I don't
know how well it will work.

Cheers,
g.

On Tue, Mar 10, 2009 at 5:17 PM, A. Nolson <alohanono@gmail.com> wrote:
> Hi,
>
> =A0I am using 2.6.24-rc3 ( secretlabs git) in an ML403 where I want to
> use the USB c67x00 based host with Peter Kosgaard driver. I am using it
> together with the sysace device for CF access ( in the ML403 those two
> share lines, but I managed to insert some logic to multiplex both
> devices). I have been able to use the c67300 without OS, but when I try
> to boot the kernel I am getting driver reset problems (the whole log is
> at the end)
>
> [ =A0 =A06.882540] c67x00 c67x00.0: Device reset
> failed
> [ =A0 =A06.889278] c67x00: probe of c67x00.0 failed with error 65531
>
> And of course the device cannot get probed. I think this has happened to
> other people before but I can't find the solution in the archive. My
> virtex_devices.c initialization looks like this:
>
> #define XPAR_C67x00_USB(num) { \
> =A0.name =3D "c67x00", \
> =A0.id =3D num, \
> =A0.num_resources =3D 2, \
> =A0.resource =3D (struct resource[]) { \
> =A0 =A0 =A0 =A0 { \
> =A0 =A0 =A0 =A0 .start =3D XPAR_C67X00_USB_PRH##num##_BASEADDR, \
> =A0 =A0 =A0 =A0 .end =3D XPAR_C67X00_USB_PRH##num##_BASEADDR + 0xf, \
> =A0 =A0 =A0 =A0 .flags =3D IORESOURCE_MEM, \
> =A0 =A0 =A0 =A0 }, \
> =A0 =A0 =A0 =A0 { \
> =A0 =A0 =A0 =A0 .start =A0=3D XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_INTR, \
> =A0 =A0 =A0 =A0 .end =A0 =A0=3D XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_INTR, =
\
> =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_IRQ, \
> =A0 =A0 =A0 =A0 =A0}, \
> =A0}, \
> =A0.dev.platform_data =3D &(struct c67x00_platform_data) { \
> =A0.sie_config =3D C67X00_SIE1_HOST | C67X00_SIE2_PERIPHERAL_A, \
> =A0.hpi_regstep =3D 0x02, /* A0 not connected on 16bit bus */ \
> =A0}, \
> }
>
> =A0/* Cypress USB C67x00 instances */
> #if defined(XPAR_C67X00_USB_PRH0_BASEADDR)
> =A0XPAR_C67x00_USB(0),
> #endif
>
>
> and my xparameters_ml403.h like this:
>
> /* Definitions for peripheral C67X00_USB */
> #define XPAR_C67X00_USB_PRH0_BASEADDR 0xA5000000
> #define XPAR_C67X00_USB_PRH0_HIGHADDR 0xA500FFFF
> #define XPAR_C67X00_USB_PRH1_BASEADDR 0xA5010000
> #define XPAR_C67X00_USB_PRH1_HIGHADDR 0xA501FFFF
> #define XPAR_C67X00_USB_PRH2_BASEADDR 0xA5020000
> #define XPAR_C67X00_USB_PRH2_HIGHADDR 0xA502FFFF
> #define XPAR_C67X00_USB_PRH3_BASEADDR 0xA5030000
> #define XPAR_C67X00_USB_PRH3_HIGHADDR 0xA503FFFF
>
> #define XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_INTR 0
> #define XPAR_SYSTEM_USB_HPI_INT_MASK 0X000001
>
> I don't know what could be wrong here. Any clues?
>
> /Albert
>
>
>
> loaded at: =A0 =A0 00400000
> 0056419C
> board data at: 00562120
> 0056219C
> relocated to: =A00040406C
> 004040E8
> zimage at: =A0 =A0 00404E58
> 00561F12
> avail ram: =A0 =A0 00565000
> 04000000
>
>
> Linux/PPC load: console=3DttyUL0,57600 root=3D/dev/xsa2 rw
> init=3D/sbin/init
> Uncompressing
> Linux...done.
> Now booting the
> kernel
> [ =A0 =A00.000000] Linux version 2.6.24-rc3-dirty (xxx@xxx) (gcc vers
> n 4.2.2) #77 PREEMPT Mon Mar 9 18:31:59 CET
> 2009
> [ =A0 =A00.000000] Xilinx ML403 Reference System (Virtex-4
> FX)
> [ =A0 =A00.000000] Zone PFN
> ranges:
> [ =A0 =A00.000000] =A0 DMA =A0 =A0 =A0 =A0 =A0 =A0 0 ->
> 16384
> [ =A0 =A00.000000] =A0 Normal =A0 =A0 =A016384 ->
> 16384
> [ =A0 =A00.000000] =A0 HighMem =A0 =A0 16384 ->
> 16384
> [ =A0 =A00.000000] Movable zone start PFN for each
> node
> [ =A0 =A00.000000] early_node_map[1] active PFN
> ranges
> [ =A0 =A00.000000] =A0 =A0 0: =A0 =A0 =A0 =A00 ->
> 16384
> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility grouping on.
> Total p
> es:
> 16256
> [ =A0 =A00.000000] Kernel command line: console=3DttyUL0,57600 root=3D/de=
v/xsa2
> rw ini
> /sbin/init
>
> [ =A0 =A00.000000] Xilinx INTC #0 at 0x41200000 mapped to
> 0xFDFFF000
> [ =A0 =A00.000000] PID hash table entries: 256 (order: 8, 1024
> bytes)
> [ =A0 =A00.000160] Console: colour dummy device
> 80x25
> [ =A0 =A00.000569] Dentry cache hash table entries: 8192 (order: 3, 32768
> bytes)
> [ =A0 =A00.001326] Inode-cache hash table entries: 4096 (order: 2, 16384
> bytes)
> [ =A0 =A00.013549] Memory: 61628k available (2352k kernel code, 796k data=
,
> 112k in
> , 0k
> highmem)
> [ =A0 =A00.013800] SLUB: Genslabs=3D11, HWalign=3D32, Order=3D0-1, MinObj=
ects=3D4,
> CPUs=3D1,
> odes=3D1
>
> [ =A0 =A00.035282] Mount-cache hash table entries:
> 512
> [ =A0 =A00.039567] net_namespace: 64
> bytes
> [ =A0 =A00.044545] NET: Registered protocol family
> 16
> [ =A0 =A00.051781] Registering
> spi1_board_info
> [ =A0 =A00.074960] usbcore: registered new interface driver
> usbfs
> [ =A0 =A00.075863] usbcore: registered new interface driver
> hub
> [ =A0 =A00.076911] usbcore: registered new device driver
> usb
> [ =A0 =A00.090812] NET: Registered protocol family
> 2
> [ =A0 =A00.100648] IP route cache hash table entries: 1024 (order: 0, 409=
6
> bytes)
> [ =A0 =A00.103337] TCP established hash table entries: 2048 (order: 2, 16=
384
> bytes
> [ =A0 =A00.103614] TCP bind hash table entries: 2048 (order: 1, 8192
> bytes)
> [ =A0 =A00.103770] TCP: Hash tables configured (established 2048 bind
> 2048)
> [ =A0 =A00.103798] TCP reno
> registered
> [ =A0 =A00.107443] sysctl table check failed: /kernel/l2cr .1.31 Missing
> strategy
> [ =A0 =A00.107511] Call
> Trace:
> [ =A0 =A00.107530] [c3c11de0] [c0008338] show_stack+0x50/0x188
> (unreliable)
> [ =A0 =A00.107606] [c3c11e30] [c003cf88]
> set_fail+0x50/0x68
> [ =A0 =A00.107675] [c3c11e50] [c003d5f8]
> sysctl_check_table+0x658/0x6ac
> [ =A0 =A00.107730] [c3c11ec0] [c003d60c]
> sysctl_check_table+0x66c/0x6ac
> [ =A0 =A00.107785] [c3c11f30] [c002907c]
> register_sysctl_table+0x64/0xe0
> [ =A0 =A00.107851] [c3c11f50] [c02ee750]
> register_ppc_htab_sysctl+0x18/0x2c
> [ =A0 =A00.107919] [c3c11f60] [c02e8230]
> kernel_init+0x10c/0x2a4
> [ =A0 =A00.107962] [c3c11ff0] [c0004c38]
> kernel_thread+0x44/0x60
> [ =A0 =A00.165612] Installing knfsd (copyright (C) 1996
> okir@monad.swb.de).
> [ =A0 =A00.168476] io scheduler noop
> registered
> [ =A0 =A00.168515] io scheduler anticipatory
> registered
> [ =A0 =A00.168538] io scheduler deadline
> registered
> [ =A0 =A00.168885] io scheduler cfq registered
> (default)
> [ =A0 =A00.763801] Generic RTC Driver
> v1.07
> [ =A0 =A00.764606] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, I=
RQ
> sharin
> disabled
>
> [ =A0 =A00.773092] uartlite.0: ttyUL0 at MMIO 0x40600003 (irq =3D 5) is a
> uartlite
> [ =A0 =A00.773152] console [ttyUL0]
> enabled
> [ =A0 =A01.334309] RAMDISK driver initialized: 16 RAM disks of 4096K size
> 1024 blo
> size
>
> [ =A0 =A01.353807] loop: module
> loaded
> [ =A0 =A01.358480] xsysace xsysace.0: Xilinx SystemACE revision
> 1.0.12
> [ =A0 =A01.370084] xsysace xsysace.0: capacity: 7831152
> sectors
> [ =A0 =A01.380238] =A0xsa: xsa1 xsa2
> xsa3
> [ =A0 =A01.389686] Xilinx SystemACE device driver,
> major=3D254
> [ =A0 =A01.398224] nbd: registered device at major
> 43
> [ =A0 =A01.424199] XTemac: using sgDMA
> mode.
> [ =A0 =A01.429022] XTemac: using TxDRE
> mode
> [ =A0 =A01.436090] XTemac: using RxDRE
> mode
> [ =A0 =A01.443173] XTemac: buffer descriptor size: 32768
> (0x8000)
> [ =A0 =A01.454594] XTemac: (buffer_descriptor_init) phy: 0x3d20000, virt:
> 0xff1000
> , size:
> 0x8000
> [ =A0 =A01.475707] eth%d: XTemac: PHY detected at address
> 0.
> [ =A0 =A01.483329] eth0: Dropping NETIF_F_SG since no checksum
> feature.
> [ =A0 =A01.498175] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC50200=
00,
> irq=3D2
> [ =A0 =A01.509565] eth0: XTemac id 1.0f, block id 5, type
> 8
> [ =A0 =A01.522258] xilinx_spi xilinx_spi.0: at 0x40618000 mapped to
> 0xC5004000, ir
> 4
>
> [ =A0 =A06.538578] ------------[ cut here
> ]------------
> [ =A0 =A06.545188] Badness at
> drivers/usb/c67x00/c67x00-ll-hpi.c:241
> [ =A0 =A06.556588] NIP: c01a4ec0 LR: c01a4eb4 CTR:
> c00186a4
> [ =A0 =A06.566441] REGS: c3c11d80 TRAP: 0700 =A0 Not tainted
> (2.6.24-rc3-robotplatf
> m)
>
> [ =A0 =A06.580945] MSR: 00029030 <EE,ME,IR,DR> =A0CR: 35000093 =A0XER:
> e0000065
> [ =A0 =A06.593565] TASK =3D c3c0d000[1] 'swapper' THREAD:
> c3c10000
> [ =A0 =A06.603925] GPR00: 00000001 c3c11e30 c3c0d000 00000000 c02c8528
> 00000001 85
> 5751
> 00000000
> [ =A0 =A06.620512] GPR08: 00000000 00000000 c3d12384 c3c10000 35000093
> ffffffff c0
> 4040
> c0284050
> [ =A0 =A06.637100] GPR16: c0284074 c028407c c028408c c02840b8 c02840cc
> 00000000 ff
> ffff
> ffffffff
> [ =A0 =A06.653687] GPR24: c0300000 c0284038 c02c9a20 00000000 c3d12368
> 00000000 c3
> 2360
> c02c9a04
> [ =A0 =A06.670620] NIP [c01a4ec0]
> c67x00_ll_reset+0x48/0x88
> [ =A0 =A06.680468] LR [c01a4eb4]
> c67x00_ll_reset+0x3c/0x88
> [ =A0 =A06.690143] Call
> Trace:
> [ =A0 =A06.694986] [c3c11e30] [c01a4eb4] c67x00_ll_reset+0x3c/0x88
> (unreliable)
> [ =A0 =A06.708290] [c3c11e50] [c01a3b0c]
> c67x00_drv_probe+0x16c/0x2e0
> [ =A0 =A06.719866] [c3c11e80] [c017af4c]
> platform_drv_probe+0x20/0x30
> [ =A0 =A06.731442] [c3c11e90] [c0179328]
> driver_probe_device+0xec/0x194
> [ =A0 =A06.743364] [c3c11eb0] [c0179580]
> __driver_attach+0x88/0xf4
> [ =A0 =A06.754422] [c3c11ed0] [c017855c]
> bus_for_each_dev+0x54/0x94
> [ =A0 =A06.765654] [c3c11f00] [c017912c]
> driver_attach+0x24/0x34
> [ =A0 =A06.776366] [c3c11f10] [c0178998]
> bus_add_driver+0x78/0x1d4
> [ =A0 =A06.787424] [c3c11f30] [c01798b4]
> driver_register+0x88/0x9c
> [ =A0 =A06.798482] [c3c11f40] [c017b2c8]
> platform_driver_register+0x9c/0xac
> [ =A0 =A06.811095] [c3c11f50] [c02fae74]
> c67x00_init+0x18/0x28
> [ =A0 =A06.821462] [c3c11f60] [c02e8230]
> kernel_init+0x10c/0x2a4
> [ =A0 =A06.832175] [c3c11ff0] [c0004c38]
> kernel_thread+0x44/0x60
> [ =A0 =A06.842886] Instruction
> dump:
> [ =A0 =A06.848760] 90010024 480a4969 38800000 7fa3eb78 6084fa50 4bffefbd
> 387d0020
> 801388
>
> [ =A0 =A06.864136] 480a3edd 707dffff 7c000026 54001ffe <0f000000> 3c00fff=
f
> 7fbd00d
> 60000005
>
> [ =A0 =A06.882540] c67x00 c67x00.0: Device reset
> failed
> [ =A0 =A06.889278] c67x00: probe of c67x00.0 failed with error
> 65531
> [ =A0 =A06.901621] usbcore: registered new interface driver
> libusual
> [ =A0 =A06.912837] usbcore: registered new interface driver
> cypress_cy7c63
> [ =A0 =A06.925443] i8042.c: No controller
> found.
> [ =A0 =A06.934533] mice: PS/2 mouse device common for all
> mice
> [ =A0 =A06.945746] i2c /dev entries
> driver
> [ =A0 =A06.953016] i2c-parport-light: adapter type
> unspecified
> [ =A0 =A06.964041] usbcore: registered new interface driver
> usbhid
> [ =A0 =A06.972725] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core
> driver
> [ =A0 =A06.985267] TCP cubic
> registered
> [ =A0 =A06.991691] NET: Registered protocol family
> 1
> [ =A0 =A07.000260] NET: Registered protocol family
> 17
> [ =A0 =A07.011149] RPC: Registered udp transport
> module.
> [ =A0 =A07.018303] RPC: Registered tcp transport
> module.
> [ =A0 20.920617] kjournald starting. =A0Commit interval 5
> seconds
> [ =A0 20.975785] EXT3 FS on xsa2, internal
> journal
> [ =A0 20.981905] EXT3-fs: recovery
> complete.
> [ =A0 21.287791] EXT3-fs: mounted filesystem with ordered data
> mode.
> [ =A0 21.297194] VFS: Mounted root (ext3
> filesystem).
>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
