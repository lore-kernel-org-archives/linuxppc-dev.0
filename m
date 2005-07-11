Return-Path: <BlakesleeS@embeddedplanet.com>
Received: from tag-03.ashton-group.com (tag-03.ashton-group.com [66.94.86.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BFC267C0E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Jul 2005 23:59:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 11 Jul 2005 09:59:29 -0400
Message-ID: <1628E43D99629C46988BE46087A3FBB92BB587@ep-01.EmbeddedPlanet.local>
From: "Steven Blakeslee" <BlakesleeS@embeddedplanet.com>
To: "Absolut Hunter" <absoluthunter@comcast.net>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: Linux 2.4.25 / MPC8280 / ram config vs Linux instability?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I am using U-boot to configure up the SDRAM and SRAM in our=20
> system before we launch Linux. We have 32 Mb of SDRAM and 2=20
> MB of SRAM in the system.=20
>=20

When I was working on an 8260 a while back I had to map PSDRAM at
address 0x00000000 and LSDRAM starting at the PSDRAM's end.  I found
that when I made the PSDRAM smaller than the LSDRAM then the LSDRAM was
not mapped properly.  This was due to the fact that the start address
for the memory bank needed to be a multiple of the bank size.  If the
LSDRAM was 32Meg then the start address of the bank needed to be on a
32Meg boundary.

I am not sure but if you are mapping a 2Meg SRAM at 0x00000000 followed
by a 32Meg SDRAM then the SDRAM is not on a 32Meg boundary.  This may
not be your issue but it may be worth looking in to.
