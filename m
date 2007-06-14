Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id BFB0FDDF1D
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 08:58:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
Date: Thu, 14 Jun 2007 17:46:00 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0307485C@ismail.innsys.innovsys.com>
In-Reply-To: <1181805466.30670.352.camel@gentoo-jocke.transmode.se>
References: <1181744529.30670.298.camel@gentoo-jocke.transmode.se><1181788277.3658.1.camel@localhost.localdomain><1181804588.30670.344.camel@gentoo-jocke.transmode.se>
	<1181805466.30670.352.camel@gentoo-jocke.transmode.se>
From: "Rune Torgersen" <runet@innovsys.com>
To: <joakim.tjernlund@transmode.se>,
	"Dave Liu" <r63238@freescale.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Joakim Tjernlund
> Sent: Thursday, June 14, 2007 2:18 AM

> some comments:
>=20
> With these aligments, won't you waste alot of MURAM?
>=20
> Looking at the 2 first allocs:
>   MURAM alloc, start:1400, size:200(512), align:8(8)
>   MURAM alloc, start:1608, size:208(520), align:8(8)
> shouldn't the second alloc have 0x1600 as start address?

I've noticed (on a internal project that uses a LOT of DPRAM on a 82xx,
uses same allocator), that the current allignment stuff allocates bytes
requested + allignment and never frees the unused space.

So if you want 8 bytes with 64 bytes allignment, the allocator
allocatesd (8+64) 72 bytes. It should then return the unused 64 bytes at
the beginning and end to the pool, but doesn't.

I have an internal version of the allocator that does it correct (for us
atleast), and also does a best fit instead of first fit.

If anybody is interested, I can post it. Mine is the rheap from arch/ppc
not arch/powerpc
