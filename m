Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 58C31DDF44
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:16:23 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/13] powerpc: Add arch/powerpc mv64x60 MPSC platform data
	setup
Date: Thu, 26 Apr 2007 02:14:07 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235939.GI4046@mag.az.mvista.com>
In-Reply-To: <20070425235939.GI4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260214.08329.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Mark A. Greer wrote:
> +static int __init mv64x60_mpsc_platform_device_init(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0struct device_node *np =3D NULL;
> +=A0=A0=A0=A0=A0=A0=A0unsigned int i;
> +=A0=A0=A0=A0=A0=A0=A0struct platform_device *pdev;
> +=A0=A0=A0=A0=A0=A0=A0int err;
> +
> +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; (np =3D of_find_compatible_node(np, "=
serial", "mpsc")); i++) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct resource r[5];
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct mpsc_pdata pdata;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0const unsigned int *prop;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0const phandle *ph;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct device_node *sdma, *=
brg;

This looks wrong to me. See drivers/serial/of_serial.c to find how we do it=
 for
8250 compatible serial ports. You should probably just add your serial port
stuff in there as well, instead of doing your own scanning of the device tr=
ee.

> +               pdev =3D platform_device_register_simple(MPSC_CTLR_NAME, =
i, r, 5);
> +               if (IS_ERR(pdev)) {
> +                       err =3D PTR_ERR(pdev);
> +                       goto ret_node_put;
> +               }

Now this really needs some explanation.

Why the heck do you have a platform device that gets its resources from
nonstandard properties of a serial port?

	Arnd <><
