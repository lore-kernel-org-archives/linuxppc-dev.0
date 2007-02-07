Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9D42ADDEDD
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 21:09:29 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l17A9PLQ021940
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 03:09:26 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l17A9NYo029049
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 04:09:24 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Wed, 7 Feb 2007 18:10:41 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D4339@zch01exm26.fsl.freescale.net>
In-Reply-To: <200702071102.22010.arnd@arndb.de>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Arnd Bergmann" <arnd@arndb.de>, <linuxppc-dev@ozlabs.org>
Cc: Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, February 07, 2007 6:02 PM
> To: linuxppc-dev@ozlabs.org
> Cc: Li Yang-r58472; Paul
> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
>=20
> On Wednesday 07 February 2007 10:16, Li Yang-r58472 wrote:
> > Do you mean to create an of_plarform_driver here just to do the =
platform
> > initialization? =A0The true USB driver can only takes =
platform_device as
> > it is used by multiple architectures.
> > btw: We don't access the mmio address of the device here. =A0We just =
need
> > to read some property from the device tree.
>=20
> The usb host controllers already come with an abstraction layer, e.g. =
there
> is ehci-fsl.c, ehci-au1xxx.c and some more. All powerpc bases systems =
that
> have the host controller on a local bus instead of PCI should use a =
common
> driver for that, I believe one has already been posted some time ago,
> but I'm not entirely sure about that.
>=20
> As mentioned by Kumar Gala, we should eventually migrate over the =
users
> of ehci-fsl to a new ehci-of, but getting rid of ehci-fsl means =
removing
> all its users in arch/ppc first.

How about a non-PCI ehci driver for all architectures (such as arm, =
m68k)?  Then, platform_bus is a more generic interface than of_platform.

- Leo
