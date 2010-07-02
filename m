Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C6401007D2
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jul 2010 03:47:18 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o62HlE1A003181
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jul 2010 10:47:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o62Hvaae023803
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Jul 2010 12:57:36 -0500 (CDT)
Date: Fri, 2 Jul 2010 12:47:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
Message-ID: <20100702124713.2e2d300c@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTikELusybzh2uTh3KJ6QwelgSHW6HWWPLh-4Zc0b@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2 Jul 2010 10:06:47 -0700
Shawn Jin <shawnxjin@gmail.com> wrote:

> > Or more generally update this section to hold whatever is connected
> > to the localbus on your board. =A0The first cell is the chipselect.
>=20
> The chipselect? Isn't it just the child-bus-addr? BTW, do we have to
> define the #address-cells to 2? 1 is not enough?

The first cell of the child bus address is the chip select, the second
cell is the offset into the chip select.

> SDRAM uses CS0/6, each 64MB. BDI2000 configuration is as follows.
> ; init memory controller
> WM32    0xFA200104      0xfe000ff6      ;;OR0: Flash 32MB
> WM32    0xFA200100      0xfc000001      ;;BR0: Flash at 0xFC000000,
> 32bit, R/W, no parity, use GPCM
> WM32    0xFA20010C      0xfc000e00      ;;OR1: SDRAM 64MB, all
> accesses WM32    0xFA200108      0x00000081      ;;BR1: SDRAM at
> 0x00000000, 32bit, R/W, no parity, use UPMA
> WM32    0xFA200134      0xfc000e00      ;;OR6: SDRAM 64MB, all
> accesses WM32    0xFA200130      0x04000081      ;;BR6: SDRAM at
> 0x04000000, 32bit, R/W, no parity, use UPMA

That looks like SDRAM is on CS1/6, not CS0/6.

We haven't been putting ordinary RAM under the localbus node, even
though it's connected through the localbus on these chips.

> When defining memory's reg property, can a single pair <0 0x08000000>
> be enough? Or must it be <0 0x04000000 0x04000000 0x04000000>?

A single pair is fine.

-Scott
