Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 33C54DDE9E
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 08:03:22 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce pata node,
	make use pata_of_platform driver
Date: Sat, 24 Nov 2007 21:57:46 +0100
References: <20071123175229.GA27143@localhost.localdomain>
	<20071123175356.GC27338@localhost.localdomain>
In-Reply-To: <20071123175356.GC27338@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711242157.47303.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 23 November 2007, Anton Vorontsov wrote:
>=20
> +static struct of_device_id mpc834x_ids[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{ .compatible =3D "pata-platform", },
> +=A0=A0=A0=A0=A0=A0=A0{},
> +};
> +
> +static int __init mpc834x_declare_of_platform_devices(void)
> +{
> +=A0=A0=A0=A0=A0=A0=A0if (!machine_is(mpc834x_itx))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> +
> +=A0=A0=A0=A0=A0=A0=A0of_platform_bus_probe(NULL, mpc834x_ids, NULL);
> +
> +=A0=A0=A0=A0=A0=A0=A0return 0;
> +}
> +device_initcall(mpc834x_declare_of_platform_devices);

This is not really how of_platform_bus_probe was meant to be used.
Instead of listing the device you want to probe, you should list
all buses that potentially contain a device that you are probing.

Normally, an ata controller is not a top-level device but instead
the child of an SOC bus device, and then you just probe all
SOC devices, which means their children get added to the device
tree.

In your case, that would probably mean that you have to another
entry in the "ranges" of the soc8349 node, or add a second socXXXX
node that has the 0xf0000000 ranges, depending on the actual layout
of the SOC.

	Arnd <><
