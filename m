Return-Path: <a.llano@ziv.es>
Received: from correo.ziv.es (correo.ziv.es [77.226.243.115])
	by ozlabs.org (Postfix) with ESMTP id E9E1BB7B80
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 03:47:22 +1100 (EST)
Subject: MPC5200B panics with high ethernet rx traffic
From: "Asier Llano Palacios" <a.llano@ziv.es>
To: <linuxppc-dev@lists.ozlabs.org>, "Grant Likely" <grant.likely@secretlab.ca>
Content-Type: multipart/mixed;
	boundary="=-c6KqqAmsnqhx4gU23WfE"
Date: Wed, 14 Oct 2009 18:35:54 +0200
Message-ID: <1255538154.26753.13.camel@allano>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--=-c6KqqAmsnqhx4gU23WfE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I've found a very simple way to create a kernel panic, that's happening
to our MPC5200B based boards. The issue was that when our boards
received a burst of ethernet packets had a kernel panic.

It does also happen to a lite5200b evaluation board, and it is really
simple to reproduce:
 Step 1: Configure the jumpers of the board as:
    CFG 4: L
    CFG 3: L
    CFG 2: H
    CFG 1: L
    CFG 0: L
    --------
    XLB:   L
    SYS:   L
    FVCO:  L
    MG:    L
    LF:    L
    HI/LO: L (but it depends on where do you have the bootloader)
    WAIT:  H
    SWAP:  L
    WIDE:  L
    MUXED: L
 Step 2: Connect an ethernet cable from the board to a 100Mbit
         ethernet switch.
 Step 3: Make a loop in the switch connecting two other ports together
         (I know this is weird but it is the simplest way I know
          to generate an intensive traffic).
 Step 4: Power up the board
 Step 5: ifconfig 192.168.0.1
 Step 6: ping 192.168.0.123

The ping generates an ARP packet (which is broadcast), then with the
loop of the switch the board will receive a storm of ARP packets
(probably near 100Mbits). Then the board configured with 266MHz core
will panic.

It happens to me in Linux versions from 2.6.22 to 2.6.28, with
bootloaders from 1.1.6 to 2009.08. It doesn't happen if you change the
jumpers (CFG 3: H, CFG 1: H) increasing the Core frequency. I'm planning
to test it with 2.6.31 but I still have another issues to test this.

I provide a log with the kernel panic.

We could assume that the CPU usage goes really high. We could also
assume that the packets that cannot be processed are dropped. We cannot
assume a kernel panic because during one second the reception traffic in
the ethernet was too high.

If you want more information or want us to perform more testing I would
gladly try to help. Maybe you can test it with your versions of software
and your board.

Your help would be greatly appreciated,
Asier=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
ZIV uses virus scanning software but excludes any liability for viruses =
contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
ZIV utiliza software antivirus, pero no se hace responsable de los virus =
contenidos en los ficheros anexos.

--=-c6KqqAmsnqhx4gU23WfE
Content-Disposition: attachment;
	filename="kernel_log.txt"
Content-Type: text/plain;
	charset="utf-8";
	name="kernel_log.txt"
Content-Transfer-Encoding: 7bit

U-Boot 2009.08 (oct 14 2009 - 13:00:56)

CPU:   MPC5200B v2.2, Core v1.4 at 330 MHz
       Bus 132 MHz, IPB 132 MHz, PCI 33 MHz
Board: Freescale Lite5200B
I2C:   85 kHz, ready
DRAM:  256 MB
FLASH: 32 MB
*** Warning - bad CRC, using default environment

PCI:   Bus Dev VenId DevId Class Int
        00  1a  1057  5809  0680  00
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
IDE:   Bus 0: OK 
  Device 0: not available
  Device 1: not available

Type "run flash_nfs" to mount root filesystem over NFS

Hit any key to stop autoboot:  0 
## Booting kernel from Legacy Image at ff042000 ...
   Image Name:   linux-2.6.28.10
   Created:      2009-10-14  11:01:27 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1045251 Bytes = 1020.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at ff040000
   Booting using the fdt blob at 0xff040000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 007fb000, end 007ff68d ... OK
Using lite5200 machine description
Linux version 2.6.28.10-uSysCom (asier@allano) (gcc version 4.3.4 (GCC) ) #7 PREEMPT Wed Oct 14 13:01:26 CEST 2009
Top of RAM: 0x1000000, Total RAM: 0x1000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00001000
  Normal   0x00001000 -> 0x00001000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00001000
On node 0 totalpages: 4096
free_area_init_node: node 0, pgdat c0231850, node_mem_map c025c000
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: console=ttyPSC0,115200 root=/dev/mtdblock3 rw irqpoll mtdparts=physmap-flash.0:192k(boot),64k(conf),1280k(linux),-(root)
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
MPC52xx PIC is up and running!
PID hash table entries: 64 (order: 6, 256 bytes)
time_init: decrementer frequency = 33.000000 MHz
time_init: processor frequency   = 330.000000 MHz
clocksource: timebase mult[79364d9] shift[22] registered
clockevent: decrementer mult[872] shift[16] cpu[0]
console [ttyPSC0] enabled
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13808k/16384k available (2136k kernel code, 2576k reserved, 116k data, 120k bss, 148k init)
Calibrating delay loop... 65.79 BogoMIPS (lpj=32896)
Mount-cache hash table entries: 512
net_namespace: 480 bytes
NET: Registered protocol family 16
DMA: MPC52xx BestComm driver
DMA: MPC52xx BestComm engine @f0001200 ok !
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
NET: Registered protocol family 1
mpc5200_gpio_legacy: Freescale MPC5200 GPIO legacy Driver
MPC5200 WKUP GPIOs mapped
MPC5200 Simple GPIOs mapped
MPC5200 GPT0 GPIO mapped
MPC5200 GPT1 GPIO mapped
MPC5200 GPT2 GPIO mapped
MPC5200 GPT3 GPIO mapped
MPC5200 GPT4 GPIO mapped
MPC5200 GPT5 GPIO mapped
MPC5200 GPT6 GPIO mapped
MPC5200 GPT7 GPIO mapped
mpc5200_gpio_legacy: got dynamic major 254
squashfs: version 3.4 (2008/08/26) Phillip Lougher
msgmni has been set to 26
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered (default)
Serial: MPC52xx PSC UART driver
f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq = 129) is a MPC52xx PSC
brd: module loaded
loop: module loaded
mpc52xx MII bus: probed
mpc52xx-fec: miibus_handle found
mpc52xx-fec: miibus_node found
net eth0: Fixed speed MII link: 100FD
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
physmap platform flash device: 01000000 at ff000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
4 cmdlinepart partitions found on MTD device physmap-flash.0
Creating 4 MTD partitions on "physmap-flash.0":
0x00000000-0x00030000 : "boot"
mtd: partition "boot" doesn't end on an erase block -- force read-only
0x00030000-0x00040000 : "conf"
mtd: partition "conf" doesn't start on an erase block boundary -- force read-only
0x00040000-0x00180000 : "linux"
0x00180000-0x01000000 : "root"
i2c /dev entries driver
Driver for 1-wire Dallas network protocol.
MC33701 Watchdog Timer Driver v0.1
i2c-adapter i2c-0: Invalid probe address 0x78
i2c-adapter i2c-1: Invalid probe address 0x78
nf_conntrack version 0.5.0 (256 buckets, 1024 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 148k init
init started: BusyBox v1.14.4 (2009-09-29 12:25:23 CEST)
starting pid 202, tty '/dev/ttyPSC0': '/etc/rcS'
+ /bin/sleep 5
+ /sbin/ifconfig eth0 192.168.0.1 up
mpc52xx-fec: Trying ot access the MDIO bus
+ /bin/ping 192.168.0.5
PING 192.168.0.5 (192.168.0.5): 56 data bytes
net eth0: FEC_IEVENT_RFIFO_ERROR
Unable to handle kernel paging request for data at address 0x000001b8
Faulting instruction address: 0xc01adfe8
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT lite5200
Modules linked in:
NIP: c01adfe8 LR: c00f7a64 CTR: c000fb88
REGS: c0235ad0 TRAP: 0300   Not tainted  (2.6.28.10-uSysCom)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22008082  XER: 20000000
DAR: 000001b8, DSISR: 20000000
TASK = c0218580[0] 'swapper' THREAD: c0234000
GPR00: c00fa928 c0235b80 c0218580 000001b8 c0d0bec0 00000000 00000002 00000000 
GPR08: 000005f8 c208a000 000000c0 c025c000 42008084 7ffffdff 0ffb9000 0ffae948 
GPR16: 0ffae96c 0ff45ccc 0ff45dcc 0ff45be9 c0246ed0 c01d24d4 c021a9cc c023c21c 
GPR24: c07ee2bc c0219598 c07ee380 c07ee000 c07ee380 c208a000 000001b8 00000000 
Call Trace:
[c0235b80] [c208a000] 0xc208a000 (unreliable)
[c0235b90] [c00fa928] 0xc00fa928
[c0235bb0] [c00fab14] 0xc00fab14
[c0235bc8] [c00436e8] 0xc00436e8
[c0235be0] [c0045694] 0xc0045694
[c0235bf8] [c0006160] 0xc0006160
[c0235c08] [c0010a34] 0xc0010a34
--- Exception: 501 at 0xc00645b8
    LR = 0xc00645a8
[c0235ce0] [c0126fdc] 0xc0126fdc
[c0235d00] [c0127a20] 0xc0127a20
[c0235d08] [c00fb630] 0xc00fb630
[c0235d50] [c00436e8] 0xc00436e8
[c0235d68] [c0045694] 0xc0045694
[c0235d80] [c0006160] 0xc0006160
[c0235d90] [c0010a34] 0xc0010a34
--- Exception: 501 at 0xc012bd50
    LR = 0xc0023104
[c0235e50] [00000102] 0x000102 (unreliable)
[c0235e70] [c0023104] 0xc0023104
[c0235ea8] [c00060d0] 0xc00060d0
[c0235eb8] [c0022d78] 0xc0022d78
[c0235ec0] [c000d63c] 0xc000d63c
[c0235ed0] [c0010a34] 0xc0010a34
--- Exception: 901 at 0xc0008f70
    LR = 0xc0008f70
[c0235f90] [c0008fb8] 0xc0008fb8 (unreliable)
[c0235fa8] [c01af91c] 0xc01af91c
[c0235fc0] [c01f177c] 0xc01f177c
[c0235ff0] [00003438] 0x003438
Instruction dump:
812b000c 3929ffff 912b000c 800b0034 70090004 41a20008 4bfff4c9 8001003c 
bb21001c 38210038 7c0803a6 4e800020 <7c001828> 3000ffff 7c00192d 40a2fff4 
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 180 seconds..


--=-c6KqqAmsnqhx4gU23WfE--
