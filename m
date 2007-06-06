Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id D798ADDE05
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:11:52 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: MPC8349ea Random Device Generator driver
Date: Thu, 7 Jun 2007 00:11:42 +0200
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<20070606220913.GA27820@lixom.net> <46673009.6000109@freescale.com>
In-Reply-To: <46673009.6000109@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706070011.43347.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, sl@powerlinux.fr,
	Timur Tabi <timur@freescale.com>,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 07 June 2007, Timur Tabi wrote:
> >> =A0=A0=A0=A0=A0u64 v;
> >> =A0=A0=A0=A0=A0v =3D rng->rngisr;
> >>
> >> or something like that. =A0Try to use the built-in support for 64-bit =
data types when possible.
> >=20
> > ...this. NO! Don't reference ioremapped memory from regular code like
> > that. The way he's doing it is the preferred way.
>=20
> Can you explain that better? =A0What is "regular code"?

The only code that is allowed to dereference an __iomem pointer is the
implementation of readl/writel and similar functions.
The code you gave as an example gives you a warning when building with
make C=3D1 using sparse, and missed barriers.

	Arnd <><
