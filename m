Return-Path: <niklaus.giger@member.fsf.org>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A51967A65
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Feb 2005 09:28:38 +1100 (EST)
Received: from ng (80-218-254-31.dclient.hispeed.ch [80.218.254.31])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id
	j1QMSXdX016268
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sat, 26 Feb 2005 23:28:34 +0100
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-embedded@ozlabs.org
Date: Sat, 26 Feb 2005 23:28:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502262328.24165.niklaus.giger@member.fsf.org>
Subject: Problems porting to a custom PPC405GPr board using a vanilla 2.6.10
	kernel
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

I would like to port Linux to a custom PPC405GPr board. Its hardware runs=20
vxWorks fine for more than a year.=20

Within a few days I had a working U-boot image, which allows me to download=
=20
via TFTP Linux-kernels.

I started with a vanilla 2.6.10 kernel, added the entries in the=20
arch/ppc/platforms/4xx/Makefile and Kconfig, two file hcu3.c and hcu3.h whi=
ch=20
are very minimal. The board has no PCI and I do not want to add support for=
=20
the CFI-Flashs or the onboard CAN-Chips.=20
Enabling the SERIAL_TEXT_DEBUG I got the following output
## Transferring control to Linux (at address 00000000) ...
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
hcu3_map_io
MMU:exit
setup_arch: enter ngng
setup_arch: bootmem
ocp: exit
arch: exit
If I attach a BDI, I get a lot of "- TARGET: target has entered debug mode"=
=20
lines and then
DI>i
    Target state      : debug mode
    Debug entry cause : unconditional debug event
    Current PC        : 0xfffffffc
    Current CR        : 0x00000000
    Current MSR       : 0x00000000
    Current LR        : 0xc019a15c
BDI>               =20
The corresponding line from my System.map are
c0199e20 t free_bootmem_core
c0199ecc t __alloc_bootmem_core
c019a278 t free_all_bootmem_core
c019a4c8 T init_bootmem_node

My board has no RTC. Is this a problem?=20

Should I start with another kernel? Can anybody point me to a known good=20
kernel version for a specific PPC405 board?

Any hint would be greatly appreciated.

Best regards

=2D-=20
Niklaus Giger
Wieshoschet 6
CH-8753 Mollis
Tel. ++41 55 612 20 54 (privat)
Tel. ++41 55 618 64 68 (Gesch=E4ft)
