Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw4.extranet.thmulti.com (dmzraw4.extranet.thmulti.com
	[141.11.234.72]) by ozlabs.org (Postfix) with ESMTP id 5788FDDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 20:42:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Endianness versus too many byte swaps??
Date: Mon, 5 Mar 2007 10:41:55 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AAFD1@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Charles Krinke" <ckrinke@istor.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Charles Krinke wrote:
>This routine uses a ccsr_pci struct to assign potar2, powar2, powbar2
and >others like this:
>
>pci->potar2     =3D 0x00100000;
>pci->powar2   =3D 0x8004401a;
>pci->powbar2 =3D 0x00888000;

This is big-endian access to the registers, right?

I tend to prefer explicit macros like the following when accessing CCSR
and=20
such. It also adds IO synchronization as a bonus.

out_be32(&pci->potar2, 0x00100000);
out_be32(&pci->powar2, 0x8004401a);
out_be32(&pci->powbar2, 0x00888000);

>Where I have changed the constants for our board. The issue is that
when I >call readl to read back these same registers at the end of this
same >subroutine, I get into endianess issues. That is, I read back
>=20
>POTAR2     =3D=3D 0x00001000
>POWAR2   =3D=3D 0x1A400480
>POWBAR2 =3D=3D 0x00800800
>
>Where the four bytes in each 32bit word are now exchanged so that
>80_04_40_1A became 1A_40_04_80.
>
>I understand big versus little endian, that isn't the question. The
>question is "What is really in the POTAR2, POWAR2 & POWBAR2 registers
and >how can I prove that what is in the registers is really what I wish
to be >in the registers?"

You do understand that readl is in fact a call to in_le32() on ppc
(cf. include/asm-ppc/io.h).
=20
The question now is, what endianness you would like in that register?

Regards
--=20
Stephane
