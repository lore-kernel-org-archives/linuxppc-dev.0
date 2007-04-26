Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 4FE8DDDEBE
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 21:24:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/13] powerpc: Add arch/powerpc mv64x60 MPSC platform data
	setup
Date: Thu, 26 Apr 2007 13:24:19 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260214.08329.arnd@arndb.de>
	<20070426055716.GB2030@xyzzy.farnsworth.org>
In-Reply-To: <20070426055716.GB2030@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704261324.20226.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Dale Farnsworth wrote:
> > This looks wrong to me. See drivers/serial/of_serial.c to find how we d=
o it for
> > 8250 compatible serial ports. You should probably just add your serial =
port
> > stuff in there as well, instead of doing your own scanning of the devic=
e tree.
>=20
> Unfortunately, this hardware is very much non-8250 compatible.

That shouldn't matter much. The driver is not 8250 specific by itself, it's=
 just
that right now it doesn't know about any other chips.

If you find that there is more code that needs to be added than what is alr=
eady
in there, you could also create a new one based on of_serial for your port.

I can understand why you want to keep using the platform_device here, and i=
n the
other places, but if you do then please use platform_device_register from an
of_platform_driver probe function instead of platform_device_register_simple
so you can set the parent to the of_device.

> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pdev =3D platform_device_register_s=
imple(MPSC_CTLR_NAME, i, r, 5);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (IS_ERR(pdev)) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D PTR=
_ERR(pdev);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto ret_no=
de_put;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >=20
> > Now this really needs some explanation.
> >=20
> > Why the heck do you have a platform device that gets its resources from
> > nonstandard properties of a serial port?
>=20
> There is an existing mpsc driver usable on both MIPS and powerpc platforms
> that requires these non-standard properties.

Ok, I see where some of the limitations come from. However, instead of
introducing the new "sdma" and "brg" properties, why not just add the
register ranges to the "reg" property, like other drivers do?

	Arnd <><
