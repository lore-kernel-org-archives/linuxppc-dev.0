Return-Path: <spamreceptor@yahoo.com>
Received: from web30107.mail.mud.yahoo.com (web30107.mail.mud.yahoo.com
	[209.191.69.39]) by ozlabs.org (Postfix) with SMTP id 3DF0CDDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Nov 2008 09:12:21 +1100 (EST)
Date: Wed, 26 Nov 2008 14:05:40 -0800 (PST)
From: Joe Shmo <spamreceptor@yahoo.com>
Subject: MPC8313erdb uboot1.3.0 kernel2.6.21 dp83848 NFS problem
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <325160.99617.qm@web30107.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have the 8313erdb board but with a custome phy, the
national semiconductor DP83848 on it instead of the
vitesse parts.  Also our NOR part is smaller and the
NAND part is different but I've changed the kernel to
see it.  I had to eliminate a few blocks from the NOR
memory map to get it to fit. 

One way it is different is that we have different
phys.  Our phys do not go up to Gigabit like the
development board does.

With uboot 1.3.0, I managed to write driver code for
our phy (national semi dp83848) and it worked well
enough to do TFTP and ping.  I had to change the Reset
Configuration Word to do MII instead of GMII or any of
the other xMII interfaces.  That was a key difference
that made it work.

However, the kernel (we use the same version of the
kernel as the development board) reprograms the PHY
and we cannot get it to load the filesystem over NFS. 
Our PHY appears to be working and the LEDs are
blinking.   Also, the kernel appears to notice if we
plug and unplug the first PHY and reports the speed
and duplexity correctly.  

We do not see any ethernet data come out of our board
(using packet sniffer) after the kernel starts.  

We know the hardware is capable since uboot works, but
somehow not configured right when the kernel runs.  We
know the NFS servers work (we don't see traffic out of
the board anyway).

So I think the gianfar driver is somehow not setup
right.  Also, the Device Tree Source file the becomes
the Device Tree Blob, calls out the phys but I don't
understand the syntax or what it means.  I have made a
couple of guess but I still don't understand.  I've
modified gianfar.c to make sure it does MII instead of
GMII or whatever but it still won't go.

I added some of my own logging to show that we picked
the right MII interface (zero) in gianfar.c after I
messed with it.  The "IP-Config: Complete:" log seems
to show that everything is fine and looks just like
how our development board does when it successfully
loads the filesystem over NFS.

Note, I have carefully verified that the NFS server
works, is on the same network, etc.  I have booted a
unmodified 8313 board to that server with out trouble.

Any help with the NFS or Gianfar is greatly
appreciated.  Also, is there some interaction between
uboot 1.3.0 and this kernel that might be different?

Note that printks with "^^^" are what I added.

CPU:   e300c3, Rev: Unknown revision number:80b10020
Warning: Unsupported cpu revision!
Board: Freescale MPC8313ERDB
I2C:   ready
DRAM:  64 MB
FLASH:  2 MB
In:    serial
Out:   serial
Err:   serial
Net:   TSEC0, TSEC1 [PRIME]
=> run nfsboot
Waiting for PHY auto negotiation to complete. done
 phy reg contents is 13
Speed: 10, half duplex
Using TSEC1 device
TFTP from server 192.168.1.21; our IP address is
192.168.1.35
Filename 'uImage'.
Load address: 0x200000
Loading:
#################################################################
        
######################################################
done
Bytes transferred = 1734150 (1a7606 hex)
 phy reg contents is 13
Speed: 10, half duplex
Using TSEC1 device
TFTP from server 192.168.1.21; our IP address is
192.168.1.35
Filename 'dtb'.
Load address: 0x400000
Loading: #
done
Bytes transferred = 12288 (3000 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.21.7-hrt1-WR2.0bl_stan
   Created:      2008-11-19  19:30:47 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    1734086 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0x400000
Using MPC8313 RDB machine description
Linux version 2.6.21.7-hrt1-WR2.0bl_standard
(root@vbox-kuhlp) (gcc version 4.1.2 (Wind River Linux
Sourcery G++ 4.1-91)) #33 PREEMPT Wed Nov 19 13:30:30
CST 2008
setup_arch: bootmem
mpc8313_rdb_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000e0008500.
Firmware bus number: 0->0
phy_mode =3
arch: exit
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Built 1 zonelists.  Total pages: 16256
Kernel command line:
nfsroot=192.168.1.21:/home/developer/export
ip=192.168.1.35:192.168.1.21:192.168.1.1:255.255.255.0:mpc8313erdb-0:eth1:off
root=/dev/nfs rw console=ttyS0,115200
IPIC (128 IRQ sources) at fdefa700
PID hash table entries: 256 (order: 8, 1024 bytes)

, set: devices
WDT driver for MPC83xx initialized. mode:reset
timeout=65535 (32 seconds)
i8042.c: No controller found.
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports,
IRQ sharing disabled
serial8250.0: ttyS0 at MMIO map 0xe0004500 mem
0xc5000500 (irq = 16) is a 16550A
serial8250.0: ttyS1 at MMIO map 0xe0004600 mem
0xc5002600 (irq = 17) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2,
00:e0:0c:00:95:01
eth0: Running with NAPI disabled
eth0: 64/64 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2,
00:e0:0c:00:95:02
eth1: Running with NAPI disabled
eth1: 64/64 RX/TX BD ring size
National Semiconductor dp83848: Registered new driver
netconsole: not configured, aborting
i2c /dev entries driver
MPC8313RDB flash device: 200000 at fe000000 Partition
number 2
MPC8313RDB Flash Map Info: Found 1 x16 devices at 0x0
in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
MPC8313RDB Flash Map Info: JEDEC Device ID is 0x22C4.
Assuming broken CFI table.
MPC8313RDB Flash Map Info: Swapping erase regions for
broken CFI table.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due
to code brokenness.
Creating 2 MTD partitions on "MPC8313RDB Flash Map
Info":
0x00000000-0x00100000 : "U-Boot"
mtd: Giving out device 0 to U-Boot
0x00100000-0x00180000 : "dtb"
mtd: Giving out device 1 to dtb
MPC8313RDB flash device (MPC8313RDB Flash Map Info)
initialized
Freescale eLBC NAND Driver (C) 2006 Freescale
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xb1
(Micron NAND 128MiB 1,8V 8-bit)
Scanning device for bad blocks
Bad eraseblock 122 at 0x00f40000
Bad eraseblock 452 at 0x03880000
Bad eraseblock 481 at 0x03c20000
Bad eraseblock 703 at 0x057e0000
mtd: Giving out device 2 to nand0
mice: PS/2 mouse device common for all mice
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12)
initialised: dm-devel@redhat.com
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device
(rtc0)
^^^ Returning correct MII value !
^^^ Interface = 0
^^^ MII Control register contents =     3100
^^^ MII Status register contents =     7849
IP-Config: Complete:
      device=eth1, addr=192.168.1.35,
mask=255.255.255.0, gw=192.168.1.1,
     host=mpc8313erdb-0, domain=, nis-domain=(none),
     bootserver=192.168.1.21, rootserver=192.168.1.21,
rootpath=
Looking up port of RPC 100003/2 on 192.168.1.21
PHY: e0024520:03 - Link is Up - 10/Half




      
