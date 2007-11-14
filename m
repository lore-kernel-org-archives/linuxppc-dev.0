Return-Path: <robertlazarski@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id 36652DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 09:00:51 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so310646nzh
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 14:00:50 -0800 (PST)
Message-ID: <f87675ee0711141400u5de89f17jc7934f8690a9fac9@mail.gmail.com>
Date: Wed, 14 Nov 2007 17:00:49 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
Subject: Re: 85xx Device tree problems: e0024520:02 not found
Cc: linuxppc-embedded@ozlabs.org
In-Reply-To: <473B699C.5040700@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f87675ee0711131217q6bb54e06q74f7d16e79b94f19@mail.gmail.com>
	<473A0A1B.3020302@anagramm.de>
	<f87675ee0711141118h3281b79dpaa49c6da7d57d891@mail.gmail.com>
	<473B5940.2090306@anagramm.de> <473B699C.5040700@anagramm.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Nov 14, 2007 4:33 PM, Clemens Koller <clemens.koller@anagramm.de> wrote:
> Hi, Robert!
>
> Just one more short note...
> My good - vs. - bad dmesg output:
>
> good 2.6.21-rc5-git:
>  > Gianfar MII Bus: probed
>  > eth0: Gianfar Ethernet Controller Version 1.2, 00:ww:xx:yy:zz:dd
>  > eth0: Running with NAPI enabled
>  > eth0: 256/256 RX/TX BD ring size
>  > eth1: Gianfar Ethernet Controller Version 1.2, 00:ww:xx:yy:zz:dd
>  > eth1: Running with NAPI enabled
>  > eth1: 256/256 RX/TX BD ring size
>  > eth2: Gianfar Ethernet Controller Version 1.2, 00:ww:xx:yy:zz:dd
>  > eth2: Running with NAPI enabled
>  > eth2: 256/256 RX/TX BD ring size
>  > Marvell 88E1101: Registered new driver
>  > Marvell 88E1111: Registered new driver
>  > Marvell 88E1145: Registered new driver
> (I've wiped out my MAC)
>
> bad 2.6.24-rc2-git:
> < Gianfar MII Bus: probed
> < eth0: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
> < eth0: Running with NAPI enabled
> < eth0: 256/256 RX/TX BD ring size
> < eth1: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
> < eth1: Running with NAPI enabled
> < eth1: 256/256 RX/TX BD ring size
> < eth2: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:00:00
> < eth2: Running with NAPI enabled
> < eth2: 256/256 RX/TX BD ring size
>
> The MACs are all 00 here.
> The PHY drivers don't get registered.
> (What happened to CONFIG_NETDEV_1000 in the newer kernels?)
>
> How is your mileage?
> Next round... tomorrow,
>
> regards,
>
> Clemens Koller

Hmm, I'm getting my mac addresses, the same ones I set in u-boot:

=> bootm 1000000 - c00000
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.24-rc2-ge6a5c27f-dirty
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1278631 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x3FF9DD50 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF90
bd address  = 0x3FF9DFB0
memstart    = 0x00000000
memsize     = 0x40000000
flashstart  = 0xF8000000
flashsize   = 0x08000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xE0000000
bootflags   = 0xE4013F80
intfreq     = 888.888 MHz
busfreq     = 355.555 MHz
ethaddr     = 00:E0:0C:00:00:FD
eth1addr    = 00:E0:0C:00:01:FD
eth2addr    = 00:E0:0C:00:02:FD
eth3addr    = 00:E0:0C:00:03:FD
IP addr     = 10.101.43.142
baudrate    = 115200 bps
Skipping initrd
   Booting using the fdt at 0xc00000
No initrd
## device tree at 0x00C00000 ... 0x00C01B6C (len=7021=0x1B6D)
   Loading Device Tree to 007fc000, end 007fdb6c ... OK
## Transferring control to Linux (at address 00000000) ...
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 42) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: module loaded
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:00:fd
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:01:fd
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:02:fd
eth2: Running with NAPI enabled
eth2: 256/256 RX/TX BD ring size
eth3: Gianfar Ethernet Controller Version 1.2, 00:e0:0c:00:03:fd
eth3: Running with NAPI enabled
eth3: 256/256 RX/TX BD ring size
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
e0024520:02 not found
eth2: Could not attach to PHY
IP-Config: Failed to open eth2
IP-Config: Device `eth2' not found.

Tomorrow's a holiday here in Brazil, will catch up with you Friday,
Robert
