Return-Path: <nzeitler@osii.com>
Received: from OSIMAIL.osii.com (mail.osii.com [208.42.8.142])
	by ozlabs.org (Postfix) with ESMTP id 69A1C2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 09:10:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 13 Dec 2004 16:09:58 -0600
Message-ID: <01C22B6B78D52B46BE3C38FB525617EF909AC7@osimail.osii.com>
From: "Zeitler, Nathan" <nzeitler@osii.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Lite5200 and PCI1520 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Wolfgang,=20

>Now what? Is it a custom board, or a Lite5200?=20

My apologies.  It is a custom board based closely on the design of the
Lite5200.  Thus we are able to put a PCI1520 chip on the same PCB and
connect it to the MPC5200 PCI bus.

>U-Boot 1.1.1 is old. You better use current code (top of CVS).
>
>ELDK 2.1 is extremely old. You better use a current version (3.1).

Agreed, they are old, although I was hoping to be more certain that the
age of the toolchain was a problem first.  I have tried top-of-CVS
UBOOT, but reverted when no evident improvement occurred.=20
 =20
>What's you PCMCIA config file looking like?

Under /etc/sysconfig/pcmcia:
PCMCIA=3Dyes
PCIC=3Dyenta_socket
PCIC_OPTS=3D
CORE_OPTS=3D
CARDMGR_OPTS=3D

Under /etc/pcmcia/config.opts...=20
(This is as how I found it, although I added the 4th port address and
changed the memory range in an attempt to get it to cooperate.  I/O
resources aren't even being detected, so I tried adding 0x50000000 to
each I/O port address in yenta.c and adding the same value to each I/O
here to no avail):
include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff, port
0x1000-0x10ff
include memory 0x40000000-0x40001fff
include port 0xa00-0xaff
exclude irq 4
exclude irq 7
module "ray_cs" opts "essid=3DADHOC_ESSID hop_dwell=3D128 =
beacon_period=3D256
translate=3D1"

Help with respect to getting the interrupts and anything further
(configuration files and more) is appreciated, although for the sake of
keeping on topic, I can send any Card Services-based queries to the
pcmcia-cs mailing list if so desired :-)
