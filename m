Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 2C803DDE38
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 13:20:49 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l172KkoP006633
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 19:20:46 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l172Ki20016216
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 20:20:45 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Wed, 7 Feb 2007 10:22:01 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D4286@zch01exm26.fsl.freescale.net>
In-Reply-To: <200702061417.53446.arnd@arndb.de>
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

> > +	if ((np =3D of_find_compatible_node(np, "usb", "fsl-usb2-dr")) =
!=3D
NULL)
> > +		port0_is_dr =3D 1;
> > +	if ((np =3D of_find_compatible_node(np, "usb", "fsl-usb2-mph")) =
!=3D
NULL){
> > +		if (port0_is_dr) {
> > +			printk(KERN_WARNING
> > +				"There is only one USB port on PB board!
\n");
> > +			return -1;
> > +		} else if (!port0_is_dr)
> > +			/* No usb port enabled */
> > +			return -1;
> > +	}
>=20
> I'm not sure if scanning through the device tree to find mmio
addresses
> is still considered valid style. I would instead prefer you to provide
a
> of_platform_driver that attaches to the respective 'compatible'
property
> and does the register access in its probe() function in order to not
> conflict with other drivers.

The driver will not use of_platform_driver for it to be used through
multiple architectures.

- Leo
