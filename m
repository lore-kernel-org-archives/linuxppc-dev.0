Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 890F5DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 06:32:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH4/4] [POWERPC] Fix cpm_uart driver
Date: Wed, 26 Sep 2007 15:32:29 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0368C44B@ismail.innsys.innovsys.com>
In-Reply-To: <46F8101E.1050000@freescale.com>
References: <46F6C9DC.90008@scram.de>
	<46F7DE85.7000401@freescale.com><46F7EE95.1040509@scram.de>
	<46F80049.2030509@freescale.com><FF1A2486-BE77-49F8-99F3-B09B4EEAF50D@embeddedalley.com>
	<46F8101E.1050000@freescale.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>, "Dan Malek" <dan@embeddedalley.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: Scott Wood
> Maybe that's how it was, but the current code initializes it (more or
> less) directly with IMAP_ADDR, which also gets fed into ioremap.
>=20
> One of the two has got to be wrong.

arch/ppc maps the immr area 1:1 into kernel memory, so ioremap and
physical are the same.
See arch/ppc/syslib/m8260_setup.c, line 208 (function m8260_map_io)

Here quoted:
arch/ppc/syslib/m8260_setup.c
196 /* Map the IMMR, plus anything else we can cover
197  * in that upper space according to the memory controller
198  * chip select mapping.  Grab another bunch of space
199  * below that for stuff we can't cover in the upper.
200  */
201 static void __init
202 m8260_map_io(void)
203 {
204         uint addr;
205
206         /* Map IMMR region to a 256MB BAT */
207         addr =3D (cpm2_immr !=3D NULL) ? (uint)cpm2_immr : =
CPM_MAP_ADDR;
208         io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
209
210         /* Map I/O region to a 256MB BAT */
211         io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000,
_PAGE_IO);
212 }
