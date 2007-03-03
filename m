Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F1480DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  4 Mar 2007 06:58:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Endianness versus too many byte swaps??
Date: Sat, 3 Mar 2007 11:58:45 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B0C@MERCURY.inside.istor.com>
References: <20070301075323.GP4397@moe.telargo.com><45E89887.1070604@246tNt.com>
	<20070303073336.GC3276@nd47.coderock.org>
From: "Charles Krinke" <ckrinke@istor.com>
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

This is probably a Timur question, but any enlightment is appreciated. =
This concerns Linux-2.6.17.11 from kernel.org with some modifications =
for our custom 8541 board. The original BSP was evolved from =
mpc85xx_cds.
=20
Down in the guts of arch/ppc/syslib/ppc85xx_seteup.c is a routine called =
mpc85xx_setup_pci1(). In this routine we do an assignment of some =
outbound window registers and I am most interested in POTAR2, POWAR2 & =
POWBAR2 right now.
=20
This routine uses a ccsr_pci struct to assign potar2, powar2, powbar2 =
and others like this:
=20
pci->potar2     =3D 0x00100000;
pci->powar2   =3D 0x8004401a;
pci->powbar2 =3D 0x00888000;
=20
Where I have changed the constants for our board. The issue is that when =
I call readl to read back these same registers at the end of this same =
subroutine, I get into endianess issues. That is, I read back
=20
POTAR2     =3D=3D 0x00001000
POWAR2   =3D=3D 0x1A400480
POWBAR2 =3D=3D 0x00800800
=20
Where the four bytes in each 32bit word are now exchanged so that =
80_04_40_1A became 1A_40_04_80.
=20
I understand big versus little endian, that isn't the question. The =
question is "What is really in the POTAR2, POWAR2 & POWBAR2 registers =
and how can I prove that what is in the registers is really what I wish =
to be in the registers?"
=20
It may be that one or more endian swap things are going on within Linux =
and I have inherited some source from others, so actually proving what =
is in the registers is becoming important.
=20
Charles
