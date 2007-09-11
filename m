Return-Path: <eha@doredevelopment.dk>
Received: from bq8.dotserv.com (bq8.dotserv.com [193.201.35.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41216DDF16
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 00:34:16 +1000 (EST)
Received: from bq8.dotserv.com (localhost [127.0.0.1])
	by bq8.dotserv.com (8.13.1/8.13.1) with ESMTP id l8BEYBAv012463
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 16:34:11 +0200
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Problems with mii-bitbang.c on MPC8270
MIME-Version: 1.0
Date: Tue, 11 Sep 2007 16:34:11 +0200
From: Esben Haabendal <eha@doredevelopment.dk>
Message-ID: <fa1a16f246925e0db38eb3a52e51934e@127.0.0.1>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi

I am trying to get ethernet working with the current fs_enet patchset
from Scott Wood. I have added this along with the PPC_CPM_NEW_BINDING
patches to Kumars current tree.

I ma having trouble with phy_connect/phy_attach similar to what was
broken without the fs_enet patchset. It turns out that it is caused
by fs_enet_mdio_bb_exit being registered with module_init().
I guess it should have been module_exit() instead...

Also, fs_enet_mdio_bb_exit does not work, as shown in the log below.
Not that I need it, but I guess it should be working when it is there.

Here is a log showing both above described problems.

Linux/PowerPC load: root=/dev/nfs rw nfsroot=192.168.18.103:/srv/my/root ip=192.168.18.51:192.168.18.103::255.255.255.0:gb758:eth0:off console=ttyCPM0,115200
Finalizing device tree... flat tree at 0x6a33a0
[    0.000000] Using MPC8270 my machine description
[    0.000000] Linux version 2.6.23-rc5galak_my-gfd487d15-dirty (esben@esben) (gcc version 4.1.1) #15 PREEMPT Tue Sep 11 15:31:11 CEST 2007
[    0.000000] Entering add_active_range(0, 0, 16384) 0 entries of 256 used
[    0.000000] Top of RAM: 0x4000000, Total RAM: 0x4000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] On node 0 totalpages: 16384
[    0.000000]   DMA zone: 128 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 16256 pages, LIFO batch:3
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] Built 1 zonelists in Zone order.  Total pages: 16256
[    0.000000] Kernel command line: root=/dev/nfs rw nfsroot=192.168.18.103:/srv/my/root ip=192.168.18.51:192.168.18.103::255.255.255.0:gb758:eth0:off console=ttyCPM0,115200
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000000] time_init: decrementer frequency = 25.000000 MHz
[    0.000000] time_init: processor frequency   = 450.000000 MHz
[    0.000017] cpm_uart: console: compat mode
[    0.000097] console [ttyCPM0] enabled
[    0.130334] Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.136903] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.151299] Memory: 62144k/65536k available (2404k kernel code, 3328k reserved, 96k data, 227k bss, 88k init)
[    0.160215] Calibrating delay loop... 49.66 BogoMIPS (lpj=24832)
[    0.182340] Mount-cache hash table entries: 512
[    0.188222] DEV: registering device: ID = 'platform'
[    0.192159] bus type 'platform' registered
[    0.196524] NET: Registered protocol family 16
[    0.200682] bus type 'of_platform' registered
[    0.209140] bus type 'mdio_bus' registered
[    0.211794] bus mdio_bus: add driver Generic PHY
[    0.216721] Generic PHY: Registered new driver
[    0.225505] DEV: registering device: ID = 'mem'
[    0.228916] DEV: registering device: ID = 'kmem'
[    0.233556] DEV: registering device: ID = 'null'
[    0.238226] DEV: registering device: ID = 'zero'
[    0.242779] DEV: registering device: ID = 'full'
[    0.247379] DEV: registering device: ID = 'random'
[    0.252221] DEV: registering device: ID = 'urandom'
[    0.257100] DEV: registering device: ID = 'kmsg'
[    0.261759] NET: Registered protocol family 2
[    0.274174] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.279826] TCP established hash table entries: 2048 (order: 2, 16384 bytes)
[    0.286759] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.293042] TCP: Hash tables configured (established 2048 bind 2048)
[    0.299305] TCP reno registered
[    0.305221] of_platform_bus_probe()
[    0.307197]  starting at: /
[    0.309968]   match: /chipselect
[    0.313206] DEV: registering device: ID = 'chipselect.0'
[    0.318545] bus of_platform: add device chipselect.0
[    0.323900]    create child: /chipselect/flash@0,0
[    0.328310] DEV: registering device: ID = 'flash.1'
[    0.333174] bus of_platform: add device flash.1
[    0.338105]   match: /soc@f0000000
[    0.341093] DEV: registering device: ID = 'soc.2'
[    0.345791] bus of_platform: add device soc.2
[    0.350500]    create child: /soc@f0000000/chipselect@10100
[    0.355728] DEV: registering device: ID = 'f0010100.chipselect'
[    0.361659] bus of_platform: add device f0010100.chipselect
[    0.367582]    create child: /soc@f0000000/cpm@119c0
[    0.372180] DEV: registering device: ID = 'f00119c0.cpm'
[    0.377497] bus of_platform: add device f00119c0.cpm
[    0.382803]    and sub busses
[    0.385369]    create child: /soc@f0000000/cpm@119c0/brg@119f0
[    0.391247] DEV: registering device: ID = 'f00119f0.brg'
[    0.396542] bus of_platform: add device f00119f0.brg
[    0.401872]    create child: /soc@f0000000/cpm@119c0/serial@11a00
[    0.407628] DEV: registering device: ID = 'f0011a00.serial'
[    0.413193] bus of_platform: add device f0011a00.serial
[    0.418765]    create child: /soc@f0000000/cpm@119c0/serial@11a20
[    0.424498] DEV: registering device: ID = 'f0011a20.serial'
[    0.430073] bus of_platform: add device f0011a20.serial
[    0.435644]    create child: /soc@f0000000/cpm@119c0/mdio@10d40
[    0.441210] DEV: registering device: ID = 'f0010d40.mdio'
[    0.446608] bus of_platform: add device f0010d40.mdio
[    0.452074]    create child: /soc@f0000000/cpm@119c0/ethernet@11300
[    0.457925] DEV: registering device: ID = 'f0011300.ethernet'
[    0.463657] bus of_platform: add device f0011300.ethernet
[    0.469423]    create child: /soc@f0000000/interrupt-controller@10c00
[    0.475501] DEV: registering device: ID = 'f0010c00.interrupt-'
[    0.481430] bus of_platform: add device f0010c00.interrupt-
[    0.490861] JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
[    0.495553] Allocated 267964 bytes for deflate workspace
[    0.500684] Allocated 42284 bytes for inflate workspace
[    0.505862] Registering JFFS2 compressor "zlib"
[    0.510379] Registering JFFS2 compressor "rtime"
[    0.514986] JFFS2: default compression mode: priority
[    0.520262] io scheduler noop registered
[    0.523973] io scheduler anticipatory registered
[    0.528574] io scheduler deadline registered
[    0.532891] io scheduler cfq registered (default)
[    0.537612] DEV: registering device: ID = 'tty'
[    0.542470] DEV: registering device: ID = 'console'
[    0.547375] DEV: registering device: ID = 'ptmx'
[    0.552066] DEV: registering device: ID = 'ptyp0'
....
[    2.949326] DEV: registering device: ID = 'ttyee'
[    2.953952] DEV: registering device: ID = 'ttyef'
[    2.958685] Serial: CPM driver $Revision: 0.02 $
[    2.962663] cpm_uart: WARNING: no UART devices found on platform bus!
[    2.969113] cpm_uart: the driver will guess configuration, but this mode is no longer supported.
[    2.977995] ttyCPM0 at MMIO 0xfdfb3a00 (irq = 40) is a CPM UART
[    2.983828] DEV: registering device: ID = 'ttyCPM0'
[    2.989416] ttyCPM1 at MMIO 0xfdfb1a20 (irq = 41) is a CPM UART
[    2.994623] DEV: registering device: ID = 'ttyCPM1'
[    3.000197] DEV: registering device: ID = 'lo'
[    3.004616] bus of_platform: add driver fs_enet
[    3.008834] of_platform: Matched Device f0011300.ethernet with Driver fs_enet
[    3.015610] of_platform: Probing driver fs_enet with device f0011300.ethernet
[    3.023065] DEV: registering device: ID = 'eth0'
[    3.028053] eth0: fs_enet: 00:11:22:33:44:50
[    3.031576] bound device 'f0011300.ethernet' to driver 'fs_enet'
[    3.037594] of_platform: Bound Device f0011300.ethernet to Driver fs_enet
[    3.044431] fs_enet_mdio_bb_init
[    3.047602] bus of_platform: add driver fsl-bb-mdio
[    3.052865] of_platform: Matched Device f0010d40.mdio with Driver fsl-bb-mdio
[    3.059636] of_platform: Probing driver fsl-bb-mdio with device f0010d40.mdio
[    3.067314] DEV: registering device: ID = 'f0010d40:00'
[    3.072043] bus mdio_bus: add device f0010d40:00
[    3.076969] CPM2 Bitbanged MII: probed
[    3.080339] bound device 'f0010d40.mdio' to driver 'fsl-bb-mdio'
[    3.086352] of_platform: Bound Device f0010d40.mdio to Driver fsl-bb-mdio
[    3.093177] fs_enet_mdio_bb_exit
[    3.096366] bus of_platform: remove driver fsl-bb-mdio
[    3.101511] DEV: Unregistering device. ID = 'f0010d40:00'
[    3.106914] bus mdio_bus: remove device f0010d40:00
[    3.112144] Device 'f0010d40:00' does not have a release() function, it is broken and must be fixed.
[    3.120997] ------------[ cut here ]------------
[    3.125450] Badness at drivers/base/core.c:108
[    3.129889] NIP: c014cf18 LR: c014cf18 CTR: c014bdf4
[    3.134852] REGS: c3fe1da0 TRAP: 0700   Not tainted  (2.6.23-rc5galak_my-gfd487d15-dirty)
[    3.143464] MSR: 00029032 <EE,ME,IR,DR>  CR: 22088042  XER: 0000005f
[    3.149821] TASK = c06a4ba0[1] 'swapper' THREAD: c3fe0000
[    3.155040] GPR00: c014cf18 c3fe1e50 c06a4ba0 0000006b 00008f54 ffffffff 00000068 c026af48 
[    3.163396] GPR08: 00000000 00000000 00008f54 c0331880 00000001 10098388 03ffd000 00000001 
[    3.171752] GPR16: ffffffff 007fff00 c3fe1f78 c0210000 c0250000 c0250000 00000000 00000000 
[    3.180108] GPR24: c0250000 c0210000 c3fe0028 c3f22260 c3fd9a78 c026b498 c026b4e4 c3f1a070 
[    3.188638] NIP [c014cf18] device_release+0x78/0x80
[    3.193512] LR [c014cf18] device_release+0x78/0x80
[    3.198299] Call Trace:
[    3.200738] [c3fe1e50] [c014cf18] device_release+0x78/0x80 (unreliable)
[    3.207353] [c3fe1e60] [c012dfc8] kobject_cleanup+0x70/0xac
[    3.212923] [c3fe1e80] [c012f0dc] kref_put+0x54/0x6c
[    3.217884] [c3fe1e90] [c012df48] kobject_put+0x24/0x34
[    3.223107] [c3fe1ea0] [c014d0f4] put_device+0x1c/0x2c
[    3.228242] [c3fe1eb0] [c0158640] mdiobus_unregister+0x2c/0x58
[    3.234074] [c3fe1ec0] [c015b51c] fs_enet_mdio_remove+0x24/0x6c
[    3.239992] [c3fe1ee0] [c0167754] of_platform_device_remove+0x30/0x44
[    3.246433] [c3fe1ef0] [c0150698] __device_release_driver+0x84/0xc0
[    3.252700] [c3fe1f00] [c0150e98] driver_detach+0x144/0x180
[    3.258271] [c3fe1f20] [c014f770] bus_remove_driver+0xa4/0xd8
[    3.264016] [c3fe1f40] [c0150f24] driver_unregister+0x10/0x20
[    3.269760] [c3fe1f50] [c0009c10] of_unregister_platform_driver+0x14/0x24
[    3.276549] [c3fe1f60] [c015b4e4] fs_enet_mdio_bb_exit+0x24/0x38
[    3.282555] [c3fe1f70] [c02431c8] kernel_init+0xac/0x2a0
[    3.287864] [c3fe1ff0] [c0010028] kernel_thread+0x44/0x60
[    3.293260] Instruction dump:
[    3.296220] 2f800000 409effd0 8124011c 2f890000 419e0010 800900e0 2f800000 409effb8 
[    3.303966] 3c60c023 38633654 388400a4 4becf649 <0fe00000> 4bffffac 9421ffe0 7c0802a6 
[    3.313784] my flash device: 0x2000000 at 0xfe000000
[    3.320283] my onboard flash: Found 2 x16 devices at 0x0 in 32-bit bank
[    3.326403]  Amd/Fujitsu Extended Query Table at 0x0040
[    3.331603] Using buffer write method
[    3.335244] my onboard flash: CFI does not contain boot bank location. Assuming top.
[    3.343966] number of CFI chips: 1
[    3.347341] cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
[    3.355107] Creating 2 MTD partitions on "my onboard flash":
[    3.361719] 0x00000000-0x00080000 : "U-Boot"
[    3.365972] mtd: Giving out device 0 to U-Boot
[    3.371647] 0x00080000-0x02000000 : "JFFS2"
[    3.374621] mtd: Giving out device 1 to JFFS2
[    3.380226] my flash device initialized
[    3.383764] TCP cubic registered
[    3.387023] NET: Registered protocol family 1
[    3.391316] NET: Registered protocol family 17
[    3.897456] f0010d40:00 not found
[    3.899235] eth0: Could not attach to PHY
[    3.903224] IP-Config: Failed to open eth0
[    3.907315] IP-Config: Device `eth0' not found.
[    3.911877] driver_probe_done: probe_count = 0
[    3.916681] Looking up port of RPC 100003/2 on 192.168.18.103

-- 
Esben Haabendal
Embedded Software Consultant
Doré Development ApS
