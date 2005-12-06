Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id BC93B6888B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 06:55:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 6 Dec 2005 13:55:43 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8594C1@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Laurent Lagrange" <lagrange@fr.oleane.com>,
	"Matt Porter" <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: PPC 32bits and big RAM mapping problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:  Rune Torgersen
> Sent: Thursday, December 01, 2005 12:43
> To: Laurent Lagrange
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: PPC 32bits and big RAM mapping problem
>=20
> > -----Original Message-----
> > From: Laurent Lagrange
> > Sent: Thursday, December 01, 2005 11:48
> > To: linuxppc-embedded@ozlabs.org
> > Subject: PPC 32bits and big RAM mapping problem
>=20
> > So I'm under the impression to be cornered in my shoes.
> > Any idea, book, article, prediction would be welcome.
>=20
> I have 2GB of ram working on my PPC32 board.
>=20
> You have to change the following in the kernel config:
> Under Advanced Setup:
> 	Set Maximum Low memory (Set to 0x40000000)
> 	Set Custom Kernel config address (Set to 0xA0000000)
>=20
> I do not remember if I had to change anything else.

Finally got enough history ripped out of my old bitkeeper repos...
All I had to do to get 2GB of RAM to work on a 8266 was:

CONFIG_ADVANCED_OPTIONS=3Dy
CONFIG_HIGHMEM_START_BOOL=3Dy
CONFIG_HIGHMEM_START=3D0xee000000
CONFIG_LOWMEM_SIZE_BOOL=3Dy
CONFIG_LOWMEM_SIZE=3D0x40000000
CONFIG_KERNEL_START_BOOL=3Dy
CONFIG_KERNEL_START=3D0xa0000000
