Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8725D1007D2
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jul 2010 05:41:15 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o62JfBwL018593
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jul 2010 12:41:11 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o62JfHJA028751
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jul 2010 14:41:17 -0500 (CDT)
Date: Fri, 2 Jul 2010 14:41:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
Message-ID: <20100702144110.4a7ebd1d@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTimX7G59glJ9CQZpT-Zlb3EUsJ1Lil4_80BOi1Nk@mail.gmail.com>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
	<20100629185617.GA24285@schlenkerla.am.freescale.net>
	<AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>
	<4C2B6DF5.7030403@freescale.com>
	<AANLkTinYnoqfZAJWlYg633VbVyjWXhvFk2p406eP3o0c@mail.gmail.com>
	<AANLkTilZm-TRkjgYBc0xj9iFYUJl7bb19Zvrcj2R-wJd@mail.gmail.com>
	<4C2CD395.90409@freescale.com>
	<AANLkTikuI49rzT6j9glIB-Vmp6kZSTVT5ri3Hb-JHgKO@mail.gmail.com>
	<4C2CF9A7.7010801@freescale.com>
	<AANLkTikELusybzh2uTh3KJ6QwelgSHW6HWWPLh-4Zc0b@mail.gmail.com>
	<20100702124713.2e2d300c@schlenkerla.am.freescale.net>
	<AANLkTimX7G59glJ9CQZpT-Zlb3EUsJ1Lil4_80BOi1Nk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2 Jul 2010 12:16:11 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> >> The chipselect? Isn't it just the child-bus-addr? BTW, do we have
> >> to define the #address-cells to 2? 1 is not enough?
> >
> > The first cell of the child bus address is the chip select, the
> > second cell is the offset into the chip select.
>=20
> I see. So the #address-sells of 2 doesn't necessarily indicate the
> address is 64 bits?

Well, there's 64 bits of data, but it doesn't mean that it's one 64-bit
integer.

> Different processors can interpret it differently?

Different device tree bus types can -- though in this case it translates
to an ordinary CPU address using the standand ranges property.

> Where can I find such info? Is there any doc on this?

Documentation/powerpc/dts-bindings/fsl/lbc.txt

> I have a question on the serial settings. Why does it locate at 0xa80?
> According to MPC885RM.pdf, the SMC1's registers start from 0xa82.=20

I suppose the interpretation was that the register block starts at
0xa80, and the first register within that block is at 0xa82 -- though
the manual seems to actually lump those two reserved bytes in with the
previous section.

> What does the reg property specify here for SMC1, the first set of <0xa80
> 0x10> and the 2nd <0x3e80 0x40>?

=46rom Documentation/powerpc/dts-bindings/fsl/cpm.txt:
> - reg : Unless otherwise specified, the first resource represents the =20
>         scc/fcc/ucc registers, and the second represents the device's
>         parameter RAM region (if it has one).

-Scott
