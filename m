Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 7F63C67A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 04:52:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 9 Mar 2005 11:52:34 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592EE@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yay... It worked....
Had to patch m8260_setup a bit.

In m8260_map_io() I changed
	io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
into
	io_block_mapping(addr, addr, 0xffffffff - addr + 1, _PAGE_IO);=20

So that I could change the IMMR address in my config file only, and the
mappings were still correct.

I could probably submit a proper patch.

> > -----Original Message-----
> > From: Matt Porter [mailto:mporter@kernel.crashing.org]=20
> > Sent: Tuesday, March 08, 2005 17:30
> > To: Rune Torgersen
> > Cc: Kumar Gala; linuxppc-embedded@ozlabs.org
> > Subject: Re: Lots of memory on 826x
>=20
> > Ahh, but early ioremaps (before mm is inited) grow down from=20
> > PKMAP_BASE,
> > so you will be overlapping the top of lowmem with those allocations.
> > It wants to be above vmalloc space.  Set HIGHMEM_START to=20
> 0xF6000000,
> > IMMR/IO to 0xF8000000 and you then have vmalloc space between
> > 0xF1000000-0xF5FFFFFF.
>=20
> I'll try this tomorrow and see what happens.=20
> (Still need to make sure our board supports 2GB....:)
