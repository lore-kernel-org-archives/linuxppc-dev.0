Return-Path: <grzegorzj@platan.pl>
Received: from mail.platan.pl (mail.platan.pl [83.12.56.147])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 341BBB6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 21:33:38 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.platan.pl (Postfix) with ESMTP id 4B4FD6FCACE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 13:06:36 +0200 (CEST)
Received: from mail.platan.pl ([127.0.0.1])
	by localhost (grab.platan [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8b50Glmnk6JZ for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 13:06:36 +0200 (CEST)
Received: from [192.168.1.144] (grzegorzj.platan [192.168.1.144])
	by mail.platan.pl (Postfix) with ESMTP id A45426FCACA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 13:06:36 +0200 (CEST)
Message-ID: <4AAA2F3C.9080806@platan.pl>
Date: Fri, 11 Sep 2009 13:06:36 +0200
From: Grzegorz Jakubowski <grzegorzj@platan.pl>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: PCI: ioread8 on MPC8323E-RDB cause kernel oops message
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,
I try to install NIC VIA-Rhine III on PCI in MPC8323E-RDB.
I have used BSP in ver. 1.0-rt (MPC8323E-RDB-20070507),
after that LTIB was build, I have marked in kernel configuration menu to 
build driver for NIC as module in PIO mode (via-rhine.ko).

lspci return:

~ # lspci -vv
00:10.0 USB Controller: NEC Corporation USB (rev 44) (prog-if 10 [OHCI])
         Subsystem: NEC Corporation Hama USB 2.0 CardBus
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128 (250ns min, 10500ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at 90000000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: NEC Corporation USB 2.0 (rev 05) (prog-if 20 [EHCI])
         Subsystem: NEC Corporation USB 2.0
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128 (4000ns min, 8500ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at 90001000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6105 [Rhine-III] 
(rev 86)
         Subsystem: VIA Technologies, Inc. Unknown device 0105
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128 (750ns min, 2000ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 20
         Region 0: I/O ports at d0000000 [size=256]
         Region 1: Memory at 90001100 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


after modprobe via-rhine I'got kernel oops message:

~ # modprobe via-rhine
via-rhine.c:v1.10-LK1.4.2 Sept-11-2006 Written by Donald Becker
drivers/net/via-rhine.c <453>: ioread8(3489660928 + 131)
Unable to handle kernel paging request for data at address 0xd00
00083
Faulting instruction address: 0xc0011b58
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT
Modules linked in: via_rhine
NIP: C0011B58 LR: C501FEAC CTR: C0011B54
REGS: c307fc80 TRAP: 0300   Not tainted  (2.6.20.6-rt8)
MSR: 00009032 <EE,ME,IR,DR>  CR: 44004422  XER: 00000000
DAR: D0000083, DSISR: 20000000
TASK = c042f030[798] 'modprobe' THREAD: c307e000
GPR00: C501FEA4 C307FD30 C042F030 D0000083 00001485 FFFFFFFF C01
6136C 00000033
GPR08: C042F030 C02E0000 00009032 C0011B54 24004422 1001C7AC 000
00000 00000000
GPR16: 00000000 00000000 000000A5 00000124 C03DBC48 00000001 C50
20000 C5022BF4
GPR24: C04E62C0 C04E6000 D0000000 00000100 D0000000 D0000083 C04
E62C0 D0000000
NIP [C0011B58] ioread8+0x4/0x18
LR [C501FEAC] rhine_power_init+0x64/0x19c [via_rhine]
Call Trace:
[C307FD30] [C501FEA4] rhine_power_init+0x5c/0x19c [via_rhine] (u
nreliable)
[C307FD50] [C50203A4] rhine_init_one+0x220/0x650 [via_rhine]
[C307FDA0] [C014A434] pci_device_probe+0x80/0xa0
[C307FDC0] [C0165794] really_probe+0x64/0x134
[C307FDE0] [C0165BB4] __driver_attach+0x84/0x88
[C307FE00] [C01647F8] bus_for_each_dev+0x54/0x90
[C307FE30] [C0165518] driver_attach+0x24/0x34
[C307FE40] [C0164E68] bus_add_driver+0x88/0x1b4
[C307FE60] [C0165E8C] driver_register+0x68/0xb0
[C307FE70] [C0149E6C] __pci_register_driver+0x84/0xe4
[C307FE90] [C502602C] rhine_init+0x2c/0x90 [via_rhine]
[C307FEA0] [C004B670] sys_init_module+0xf4/0x1624
[C307FF40] [C000F4A4] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff70fe8
     LR = 0x10002ac4
Instruction dump:
83e1001c 38210020 7c0803a6 4e800020 38800000 7c0803a6 4e800021 2
f830000
3860ffea 419eff04 4bffffac 7c0004ac <88630000> 0c030000 4c00012c
  5463063e
  Segmentation fault
~ #


failed funcftion was ioread8 called from rhine_power_init in via-rhine.c
drivers/net/via-rhine.c <453>: ioread8(d0000000 + 83)

I have no idea why this call was failed, thanks for any help.

Thanks in advance.

Best Regards, Gregory Jakubowski

ps. U-Boot and kernel boot messages:

U-Boot 1.1.6 (May  7 2007 - 14:10:46) MPC83XX

Clock configuration:
   Coherent System Bus:  133 MHz
   Core:                 333 MHz
   QE:                    99 MHz
   BRG:                   49 MHz
   Local Bus Controller: 133 MHz
   Local Bus:             66 MHz
   DDR:                  266 MHz
   SEC:                  133 MHz
   I2C1:                 133 MHz
CPU: MPC8323E, Rev: 11 at 333.333 MHz
Board: Freescale MPC8323ERDB
I2C:   ready
DRAM:
    DDR RAM: 64 MB
FLASH: 16 MB
PCI clock is 33MHz
In:    serial
Out:   serial
Err:   serial
Net:   UEC: PHY is Generic MII (2430d80)
FSL UEC0: Full Duplex
FSL UEC0: Speed 100BT
FSL UEC0: Link is up
UEC: PHY is Generic MII (2430d80)
FSL UEC1: Full Duplex
FSL UEC1: Speed 100BT
FSL UEC1: Link is up
FSL UEC0, FSL UEC1
Hit any key to stop autoboot:  6 ... 0
=> run tfpramboot
## Error: "tfpramboot" not defined
=> run tftpramboot
Using FSL UEC0 device
TFTP from server 192.168.0.119; our IP address is 192.168.0.121
Filename '832xerdb/rootfs.ext2.gz.uboot'.
Load address: 0x1000000
Loading: *.#####################################################
...
. #############
done
Bytes transferred = 9050488 (8a1978 hex)
Using FSL UEC0 device
TFTP from server 192.168.0.119; our IP address is 192.168.0.121
Filename '832xerdb/uImage'.
Load address: 0x200000
Loading: *.#####################################################
############
...
. ##########################################
done
Bytes transferred = 1545367 (179497 hex)
Using FSL UEC0 device
TFTP from server 192.168.0.119; our IP address is 192.168.0.121
Filename '832xerdb/mpc832x_rdb.dtb'.
Load address: 0x400000
Loading: *.#
done
Bytes transferred = 5070 (13ce hex)
## Booting image at 00200000 ...
    Image Name:   Linux-2.6.20.6-rt8
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    1545303 Bytes =  1.5 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 01000000 ...
    Image Name:   uboot ext2 ramdisk rootfs
    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
    Data Size:    9050424 Bytes =  8.6 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Booting using flat device tree at 0x400000
    Loading Ramdisk to 0370a000, end 03fab938 ... OK
Using MPC832x RDB machine description
Linux version 2.6.20.6-rt8 (grzegorz@matrix) (gcc version 4.0.2
20060628 (Wasabi)) #2 PREEMPT Tue Sep 8 14:41:52 CEST 2009
Found initrd at 0xc370a000:0xc3fab938
setup_arch: bootmem
mpc832x_rdb_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bu
s number: 0->0
arch: exit
Zone PFN ranges:
   DMA             0 ->    16384
   Normal      16384 ->    16384
early_node_map[1] active PFN ranges
     0:        0 ->    16384
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists.  Total pages: 16256
Kernel command line: root=/dev/ram ramdisk_size=25000 rw console
=ttyS0,115200
WARNING: experimental RCU implementation.
IPIC (128 IRQ sources) at fdefb700
QEIC (64 IRQ sources) at fdefa080
PID hash table entries: 256 (order: 8, 1024 bytes)

Using MPC832x RDB machine description
Linux version 2.6.20.6-rt8 (grzegorz@matrix) (gcc version 4.0.2
20060628 (Wasabi)) #2 PREEMPT Tue Sep 8 14:41:52 CEST 2009
Found initrd at 0xc370a000:0xc3fab938
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bu
s number: 0->0
Zone PFN ranges:
   DMA             0 ->    16384
   Normal      16384 ->    16384
early_node_map[1] active PFN ranges
     0:        0 ->    16384
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists.  Total pages: 16256
Kernel command line: root=/dev/ram ramdisk_size=25000 rw console
=ttyS0,115200
WARNING: experimental RCU implementation.
IPIC (128 IRQ sources) at fdefb700
QEIC (64 IRQ sources) at fdefa080
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 52736k/65536k available (2912k kernel code, 12740k reser
ved, 204k data, 120k bss, 136k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 4, 65536 bytes)

TCP bind hash table entries: 1024 (order: 2, 28672 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
checking if image is initramfs...it isn't (no cpio magic); looks
  like an initrd
Freeing initrd memory: 8838k freed
prom_parse: Bad cell count for /qe@e0100000/mdio@3120/ethernet-p
hy@00
prom_parse: Bad cell count for /qe@e0100000/mdio@3120/ethernet-p
hy@04
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
WDT driver for MPC83xx initialized. mode:reset timeout=65535 (32
  seconds)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
  disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 25000K size 1024 blo
cksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
Copyright (c) 1999-2006 Intel Corporation.
UCC Ethernet Controller MII Bus: probed
ucc_geth: QE UCC Gigabit Ethernet Controller
ucc_geth: UCC2 at 0xe0103000 (irq = 21)
eth0: MTU=1500 (frame size=1518,rx_buffer_size=1536,truesize=178
4,sk_buff=152)
ucc_geth: UCC3 at 0xe0102200 (irq = 34)
eth1: MTU=1500 (frame size=1518,rx_buffer_size=1536,truesize=178
4,sk_buff=152)
SKB Handler initialized(max=64)
ICPlus IP175C: Registered new driver
usbmon: debugfs is not available
ehci_hcd 0000:00:10.1: EHCI Host Controller
ehci_hcd 0000:00:10.1: new USB bus registered, assigned bus numb
er 1
ehci_hcd 0000:00:10.1: irq 19, io mem 0x90001000
ehci_hcd 0000:00:10.1: USB 2.0 started, EHCI 1.00, driver 10 Dec
  2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:10.0: OHCI Host Controller
ohci_hcd 0000:00:10.0: new USB bus registered, assigned bus numb
er 2
ohci_hcd 0000:00:10.0: irq 19, io mem 0x90000000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
Time: timebase clocksource has been installed.
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 136k init
Setting the hostname to freescale
Mounting filesystems
Setting up networking on loopback device:
Setting up networking on eth1:
udhcpc (v0.9.9-pre) started
udhcpc[725]: udhcpc (v0.9.9-pre) started
Sending discover...
udhcpc[725]: Sending discover...
PHY: e0103120:04 - Link is Up - 100/Full
Sending discover...
udhcpc[725]: Sending discover...
Sending select for 192.168.0.206...
udhcpc[725]: Sending select for 192.168.0.206...
Lease of 192.168.0.206 obtained, lease time 3600
udhcpc[725]: Lease of 192.168.0.206 obtained, lease time 3600
deleting routers
SIOCDELRT: No such process
adding dns 192.168.1.10
adding dns 192.168.1.9
adding dns 194.204.159.1
Setting up networking on eth0:
Adding static route for default gateway to 192.168.2.1:
Setting nameserver to 192.168.2.1 in /etc/resolv.conf:
Starting the boa webserver:
/sbin/ip
Starting dhcpd
Internet Systems Consortium DHCP Server V3.0.3b1
Copyright 2004-2005 Internet Systems Consortium.
All rights reserved.
For info, please visit http://www.isc.org/sw/dhcp/
Wrote 0 deleted host decls to leases file.
Wrote 0 new dynamic host decls to leases file.
Wrote 0 leases to leases file.
Listening on LPF/eth0/00:04:9f:ef:03:02/192.168.2/24
Sending on   LPF/eth0/00:04:9f:ef:03:02/192.168.2/24
Sending on   Socket/fallback/fallback-net
Done
PHY: e0103120:00 - Link is Up - 100/Full


         Welcome to Freescale Semiconductor Embedded Linux Environment 
