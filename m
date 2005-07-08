Return-Path: <d.grab@hima.com>
Received: from hima.com (mail.hima.com [80.146.244.10])
	by ozlabs.org (Postfix) with SMTP id 130B167B79
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 21:16:26 +1000 (EST)
Received: from SN7606 ([192.168.100.10])
	by hima.com (mail.hima.com [212.116.4.129]) (MDaemon.PRO.v8.0.3.R)
	with ESMTP id md50000039262.msg
	for <linuxppc-embedded@ozlabs.org>; Fri, 08 Jul 2005 13:16:25 +0200
From: "David Grab" <d.grab@hima.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Fri, 8 Jul 2005 13:14:54 +0200
Message-ID: <001501c583ae$44cc3930$f201a8c0@SN7606>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: PPC440GX IBM EMAC2/3 RGMII mode selection
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I solved the PHY assertion with my board specific function. Thanks to Travis
B. Sawyer for this hint.

		if (i < 2) {
			emacdata->phy_map = 0xffffffff;
			emacdata->phy_mode = PHY_MODE_NA;
		}
		else {
			emacdata->phy_map = 0x00000001;
			emacdata->phy_mode = PHY_MODE_RGMII;
		}

But now i have a new problem. As you can see my PHY is detected and working
properly. It respond on link down and link up by (un)connecting ethernet
cable. Also i get RX Stuff from ethernet. But if i ping after setting
network, then it results in No response and even i can´t measure an TX
Enable or TX Clock signal from PPC440 to my PHY. I debugged a litte bit and
i think it´s becaus my ethernet is set up with zmii0: input 0 in SMII mode
and rgmii0: input 0 in RGMII mode. Is it possible that eth0 uses SMII mode
instead of RGMII so that no TX CLK / Enable is generated from PPC?

bootd
## Booting image at ff000000 ...
   Image Name:   Linux-2.6.11.6
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    891020 Bytes = 870.1 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x1FF9D898 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF25
bd address  = 0x1FF9DF54
memstart    = 0x00000000
memsize     = 0x20000000
flashstart  = 0xFF000000
flashsize   = 0x01000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0xC01D2260
intfreq     =    500 MHz
busfreq     = 166.666 MHz
ethaddr     = 00:04:AC:E3:28:8A
eth1addr    = 00:04:AC:E3:28:8B
eth2addr    = 00:04:AC:E3:28:8C
eth3addr    = 00:04:AC:E3:28:8D
IP addr     = 192.168.0.116
baudrate    = 115200 bps
## Loading RAMDisk Image at ff800000 ...
   Image Name:   Test Ramdisk
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1629365 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0xFF800040 ... 0xFF98DCF4 (len=1629365=0x18DCB5)
   Loading Ramdisk to 1fe0f000, end 1ff9ccb5 ... OK
## Transferring control to Linux (at address 00000000) ...
## Transferring control to Linux (at address 00000000) ...
Adresse: 7ffe50
Linux version 2.6.11.6 (david@FedoraDG) (gcc-Version 3.3.3 (DENX ELDK 3.1
3.3.3-8)) #12 Fri Jul 8 00:54:21 CEST 2005

IBM
Built 1 zonelists
Kernel command line: console=ttyS1,115200 root=/dev/ram rw
PID hash table entries: 4096 (order: 12, 65536 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515712k available (1372k kernel code, 464k data, 108k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 1591k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: bridge rsrc 0..ffff (100), parent c0195018
PCI: bridge rsrc 80000000..ffffefff (200), parent c0195034
SCSI subsystem initialized
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
mal0: Initialized, 4 tx channels, 4 rx channels
emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
zmii0: input 0 in SMII mode
emac0: Can't find PHY.
zmii0: input 1 in SMII mode
emac1: Can't find PHY.
zmii0: input 2 in SMII mode
rgmii0: input 0 in RGMII mode
eth0: IBM emac, MAC 00:04:ac:e3:28:8c
eth0: Found Generic MII PHY (0x05)
zmii0: input 3 in SMII mode
rgmii0: input 1 in RGMII mode
eth1: IBM emac, MAC 00:04:ac:e3:28:8d
eth1: Found Generic MII PHY (0x06)
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (-28 != 1024) 4194304
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 108k init
eth0: Link is Up
eth0: Speed: 100, Full duplex.
### Application running ...


BusyBox v0.60.5 (2004.11.10-15:02+0000) Built-in shell (msh)
Enter 'help' for a list of built-in commands.

# ifconfig eth0 192.168.0.116 netmask 255.255.252.0
# eth0: Link is Up
eth0: Speed: 100, Full duplex.

# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:04:AC:E3:28:8C
          inet addr:192.168.0.116  Bcast:192.168.0.255  Mask:255.255.252.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:134 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:9225 (9.0 kiB)  TX bytes:0 (0.0 iB)
          Interrupt:64

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 iB)  TX bytes:0 (0.0 iB)

# ping 192.168.121
emac_start_xmit()
exitn
emac_start_xmit()
exitn
emac_start_xmit()
exitn
No response from 192.168.0.121
#
