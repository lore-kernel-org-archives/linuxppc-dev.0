Date: Sat, 1 Feb 2003 12:47:27 +0100 (CET)
From: Krzysiek Taraszka <dzimi@pld.org.pl>
To: linuxppc-dev@lists.linuxppc.org
Subject: Multiple problems with RS/6000 (2.4.18 and probably 2.4.20 too)
Message-ID: <Pine.LNX.4.53L.0302011229270.24882@cyborg.kernel.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2075572684-1044100047=:24882"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-2075572684-1044100047=:24882
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,
I've got multiple problems with my RS/6000 and some devices witch should
work on ppc platworm.

My machine is:
# uname -a
Linux pldmachine 2.4.18 #1 Sun Sep 29 23:53:08 UTC 2002 ppc
CHRP_IBM,7046-B50 PLD Linux

first problem exist when i need get cpuinfo, its look like this:

cpu    : 604r
clock  : 374MHz
revision  : 49.2 (pvr 0009 3102)
bogomips  : 373.55
machine   : CHRP IBM,7046-B50

should be:

processor       : 0
cpu             : 604r
clock           : 374MHz
revision        : 49.2 (pvr 0009 3102)
bogomips        : 373.55
machine         : CHRP IBM,7046-B50

here My fix:

[dzimi@cyborg SOURCES]$ cat linux-2.4-ppc-procesor.patch | less
--- linux-2.4.20/arch/ppc/kernel/setup.c.org    Sat Feb  1 09:59:25 2003
+++ linux-2.4.20/arch/ppc/kernel/setup.c        Sat Feb  1 10:08:58 2003
@@ -158,6 +158,7 @@
 #else
        pvr = mfspr(PVR);
        lpj = loops_per_jiffy;
+       seq_printf(m, "processor\t: %lu\n", i);
 #endif

        seq_printf(m, "cpu\t\t: ");
(END)

without this small fix top won't work.


second problem exist when i want to load advansys driver :

[root@pldmachine /root]# modprobe advansys
\/lib/modules/2.4.18-8/kernel/drivers/scsi/advansys.o: init_module: No
such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.18-8/kernel/drivers/scsi/advansys.o: insmod
/lib/modules/2.4.18-8/kernel/drivers/scsi/advansys.o failed
/lib/modules/2.4.18-8/kernel/drivers/scsi/advansys.o: insmod advansys
failed
[root@pldmachine /root]#

here is output from dmesg:

Memory BAT mapping: BAT2=256Mb, BAT3=0Mb, residual: 0Mb
Total memory = 256MB; using 1024kB for hash table (at c0300000)
Linux version 2.4.18 (builder@an2) (gcc version 2.95.4 20010319
(prerelease)) #1 Sun Sep 29 23:53:08 UTC 2002
PCI bus 0 controlled by pci at 80000000
Warning: no mac-io found
OpenPIC addrs: fcec0000 c0283f7c d
RTAS Event Scan Rate: 1 (2999 jiffies)
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda2 ro console=ttyS0,9600
OpenPIC Version 1.0 (4 CPUs and 16 IRQ sources) at f73be000
time_init: decrementer frequency = 20.781946 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 373.55 BogoMIPS
Memory: 253852k available (1484k kernel code, 812k data, 312k init, 0k
highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of PCI bridge 0
PCI: resource is 0..bfffff (100), parent c01bcf2c
PCI:00:0d.0: Resource 0: fcec0000-fcefffff (f=200)
PCI:00:0b.1: Resource 0: 00bfe400-00bfe407 (f=101)
PCI:00:0b.1: Resource 1: 00bfdc00-00bfdc03 (f=101)
PCI:00:0b.1: Resource 2: 00bfe800-00bfe807 (f=101)
PCI:00:0b.1: Resource 3: 00bfe000-00bfe003 (f=101)
PCI:00:0b.1: Resource 4: 00bfec00-00bfec0f (f=101)
PCI:00:0b.1: Resource 5: 00bff000-00bff00f (f=101)
PCI:00:0c.0: Resource 0: 00bff400-00bff41f (f=101)
PCI:00:0c.0: Resource 1: fce9c000-fce9c01f (f=200)
PCI:00:0c.0: Resource 1: fce9c000-fce9c01f (f=200)
PCI:00:10.0: Resource 0: 00bff800-00bff8ff (f=101)
PCI:00:10.0: Resource 1: fce9d000-fce9d0ff (f=200)
PCI:00:10.0: Resource 2: fce9f000-fce9ffff (f=200)
PCI:00:12.0: Resource 0: 00bffc00-00bffcff (f=101)
PCI:00:12.0: Resource 1: fce9e000-fce9e0ff (f=200)
PCI:00:16.0: Resource 0: fceb0000-fcebffff (f=200)
Don't know how to access NVRAM with 4 addresses
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Thermal assist unit not available
Starting kswapd
VFS: Diskquotas version dquot_6.5.1 initialized
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
initialize_kbd: Keyboard reset failed, no ACK
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT
SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Enabling device 00:16.0 (0000 -> 0002)
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
W82C105: IDE controller on PCI bus 00 dev 59
PCI: Enabling device 00:0b.1 (0140 -> 0141)
W82C105: chipset revision 5
W82C105: 100% native mode on irq 255
    ide0: BM-DMA at 0xbfec00-0xbfec07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfec08-0xbfec0f, BIOS settings: hdc:DMA, hdd:DMA
Macintosh non-volatile memory driver v1.0
Warning: no ADB interface detected
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 148k freed
VFS: Mounted root (romfs filesystem) readonly.
SCSI subsystem driver Revision: 1.00
PCI: Enabling device 00:10.0 (0140 -> 0143)
sym.0.16.0: setting PCI_COMMAND_MASTER...
sym.0.16.0: setting PCI_COMMAND_INVALIDATE.
sym0: <875> rev 0x4 on pci bus 0 device 16 function 0 irq 23
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
sym0:2: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 16)
  Vendor: IBM       Model: DNES-309170W      Rev: SAGU
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:2:0: tagged command queuing enabled, command queue depth 16.
Attached scsi disk sda at scsi0, channel 0, id 2, lun 0
SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
Partition check:
 /dev/scsi/host0/bus0/target2/lun0: p1 p2 p3 p4 < p5 >
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=2
Trying to unmount old root ... okay
Freeing unused kernel memory: 312k init 56k pmac 8k prep
Real Time Clock Driver v1.10e
Adding Swap: 525304k swap-space (priority -1)
pcnet32_probe_pci: found device 0x001022.0x002000
PCI: Enabling device 00:0c.0 (0140 -> 0143)
    ioaddr=0xbff400  resource_flags=0x000101
eth%d: PCnet/FAST 79C971 at 0xbff400, warning PROM address does not match
CSR address

eth%d: using PROM address: 00 04 ac 97 66 a6
    tx_start_pt(0x0c00):~220 bytes, BCR18(6821):BurstWrEn NoUFlow
    SRAMSIZE=0x7f00, SRAM_BND=0x4000,
pcnet32: pcnet32_private lp=cf944000 lp_dma_addr=0xf944000 assigned IRQ
22.
pcnet32.c:v1.25kf 17.11.2001 tsbogend@alpha.franken.de
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
eth0: no IPv6 routers present
PCI: Enabling device 00:12.0 (0140 -> 0143)
advansys: AscInitGetConfig: board 0 error: init_state 0x1, err_code 0x200

this two lines :

PCI: Enabling device 00:12.0 (0140 -> 0143)
advansys: AscInitGetConfig: board 0 error: init_state 0x1, err_code 0x200

come from advansys.o, when i try to load driver.
I looked into driver, IMHO he is ppc specyfic, so where is problem ?


and the latest problem exist when i want to get access to equinox serial
card, well, hmm, anyone get it work ? Seems to i need to rewrote they
driver ...

Oh, lspci, and output messages from uname -a, dmesg and modprobe
advansys are attachment :)

Krzysiek Taraszka			(dzimi@pld.org.pl)
--8323328-2075572684-1044100047=:24882
Content-Type: APPLICATION/x-bzip2; name="linuxppc-dev.tar.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53L.0302011247271.24882@cyborg.kernel.pl>
Content-Description: dmesg, lspci and others
Content-Disposition: attachment; filename="linuxppc-dev.tar.bz2"

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
ckU4UJCwN8a3

--8323328-2075572684-1044100047=:24882--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
