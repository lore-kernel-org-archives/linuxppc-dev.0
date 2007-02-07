Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8AF26DDED8
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 20:15:41 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l179FbTT006890
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 02:15:38 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l179FZb6017698
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 03:15:36 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Wed, 7 Feb 2007 17:16:52 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D432B@zch01exm26.fsl.freescale.net>
In-Reply-To: <200702070947.03187.arnd@arndb.de>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
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
> Sent: Wednesday, February 07, 2007 4:47 PM
> To: Li Yang-r58472
> Cc: linuxppc-dev@ozlabs.org; Paul
> Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
>=20
> On Wednesday 07 February 2007 03:22, Li Yang-r58472 wrote:
> >
> > > I'm not sure if scanning through the device tree to find mmio
> > > addresses is still considered valid style. I would instead prefer
> > > you to provide a of_platform_driver that attaches to the
> > > respective 'compatible' property and does the register access
> > > in its probe() function in order to not conflict with other
drivers.
> >
> > The driver will not use of_platform_driver for it to be used through
> > multiple architectures.
>=20
> Huh? I don't understand. You currently use of_find_compatible_node(),
> which is also platform-specific.

Do you mean to create an of_plarform_driver here just to do the platform
initialization?  The true USB driver can only takes platform_device as
it is used by multiple architectures.
btw: We don't access the mmio address of the device here.  We just need
to read some property from the device tree.

- Leo
