Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.206])
	by ozlabs.org (Postfix) with ESMTP id A47CF67A65
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 13:24:36 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 40so354645rnz
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 18:24:34 -0800 (PST)
Message-ID: <c3d0340b05021118241ab5eec8@mail.gmail.com>
Date: Fri, 11 Feb 2005 18:24:33 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: EMAC doesn't get ethernet mac address on Ebony?
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to load a kernel image for Ebony built with the default
configuration ebony_defconfig from 2.6.10. The image is in u-boot
format. The root filesystem is set to a remote NFS root.

Strangely I found the ethernet driver cannot detect the mac address.
The address is supposed to be transferred from bd_info struct, isn't
it?

Also I noticed that the kernel command line shown is not what I
defined on u-boot's bootargs. Are there some changes that I'm not
aware of on kernel handling command line?

Below is the kernel dumped message.

=> bootm 200000
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.10
   Created:      2005-02-11  23:20:23 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    857587 Bytes = 837.5 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x07FAA580 => set upper limit to 0x00800000
## cmdline at 0x007FFC00 ... 0x007FFC51
bd address  = 0x07FAAF90
memstart    = 0x00000000
memsize     = 0x08000000
flashstart  = 0xFF800000
flashsize   = 0x00480000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
bootflags   = 0x00000000
intfreq     =    400 MHz
busfreq     = 133.333 MHz
ethaddr     = 00:04:AC:E3:1B:BB     

/*** <---- the ethernet address here ***/

IP addr     = 130.27.85.245
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 00000000) ...
Linux version 2.6.10  (gcc version 3.3.3 (DENX ELDK 3.1 3.3.3-8)) #1 Fr
i Feb 11 15:18:50 PST 2005
IBM Ebony port (MontaVista Software, Inc. (source@mvista.com))
Built 1 zonelists
Kernel command line: ip=on   

/*** it's different from what I set in uboot's bootargs. ***/

PID hash table entries: 1024 (order: 10, 16384 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 127872k available (1324k kernel code, 452k data, 100k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
PCI: Probing PCI hardware
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing enabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
mal0: Initialized, 4 tx channels, 2 rx channels
emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
zmii0: input 0 in SMII mode
eth0: IBM emac, MAC ff:ff:ff:ff:ff:ff              

/*** <---- no mac is fetched???? ***/

eth0: Found Generic MII PHY (0x08)
zmii0: input 1 in RMII mode
eth1: IBM emac, MAC ff:ff:ff:ff:ff:ff
eth1: Found Generic MII PHY (0x09)
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
eth0: Link is Up
eth0: Speed: 100, Full duplex.
Sending BOOTP requests ..   

/*** <---- so never get networking up. ***/

Thanks,
-Shawn.
