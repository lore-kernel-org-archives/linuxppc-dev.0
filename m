Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id E0BF6DDD06
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Feb 2007 16:44:52 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Linux doesn't boot on Vertex4 based board.
Date: Sun, 18 Feb 2007 21:44:49 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3CF9DD19@ehost011-3.exch011.intermedia.net>
In-Reply-To: <3f51063f7e86.3f7e863f5106@compuserve.de>
References: <3f51063f7e86.3f7e863f5106@compuserve.de>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

I'm trying to port Linux on Vertex4 board, similar to Xilinx ML403
(PPC405 hard core). The main differences between my board and ML403 are:

- I'm using UARTLITE, not UART16550 core.
- I have only 32M of PLB_SDRAM (ML403 got 64M of DDR).
- Flash is not in the end of the address space (see boot snapshot
below).
- I have TEMAC instead of EMAC.
- On my board PPC405 is running on 100MHz vs ML403 300MHz.

I can be somewhat confused regarding ML403 characteristics since I don't
have actual ML403 yet - will be getting it in several days.

I successfully ported ML403 u-boot to my board, but couldn't get kernel
to boot. I tried linux-xilinx-26 from Monta Vista server, 2.6.19.2 from
DENX and last 2.6.20 from kernel.org. Latest one already has uartlite
ported, for previous two I tried to port myself. Below please find
typical u-boot output (I enabled DEBUG in cmd_boot file):

U-Boot> run akanfs
TFTP from server 192.168.0.141; our IP address is 192.168.0.213
Filename 'LM200/rel/1.0.1-20/uImage'.
Load address: 0x1000000
Loading:
#################################################################
=20
#################################################################
         #######################################
done
Bytes transferred =3D 862398 (d28be hex)
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.20
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    862334 Bytes =3D 842.1 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x01F966A0 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF9C
memstart    =3D 0x00000000
memsize     =3D 0x02000000
flashstart  =3D 0x22000000
flashsize   =3D 0x00400000
flashoffset =3D 0x00000000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
bootflags   =3D 0x00000000
procfreq    =3D    100 MHz
plb_busfreq =3D    100 MHz
ethaddr     =3D 00:01:02:03:FD:71
IP addr     =3D 192.168.0.213
baudrate    =3D 115200 bps
No initrd
## Transferring control to Linux (at address 00000000) ...

I realize that can be 1001 reasons for such behavior, yet I'd appreciate
any ideas you can share with me. I tried use early serial output... no
success.

Thanks,

Leonid.
