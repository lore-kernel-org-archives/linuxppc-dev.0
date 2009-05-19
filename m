Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id F0F1BDDFFC
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 06:30:23 +1000 (EST)
Date: Tue, 19 May 2009 22:30:14 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] maps/mtd-ram: add an of-platform driver
Message-ID: <20090519203014.GC27476@pengutronix.de>
References: <1232559685-2268-1-git-send-email-w.sang@pengutronix.de>
	<1232559685-2268-3-git-send-email-w.sang@pengutronix.de>
	<fa686aa40905190757w68b35333j6f0fa84ea253a486@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
In-Reply-To: <fa686aa40905190757w68b35333j6f0fa84ea253a486@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

thanks a lot for the review!

On Tue, May 19, 2009 at 08:57:15AM -0600, Grant Likely wrote:
> On Wed, Jan 21, 2009 at 11:41 AM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
> > Create an of-aware driver using the now exported generic functions from
> > plat-ram.c. A typical oftree snipplet for it looks like this:
> >
> > sram@04e00000 {
> > =A0 =A0 =A0 =A0compatible =3D "mtd-ram";
> > =A0 =A0 =A0 =A0reg =3D <0x04e00000 0x00200000>;
> > =A0 =A0 =A0 =A0bank-width =3D <2>;
> > };
> >
> > Partitions on this device are not yet supported.
>=20
> This is a new device tree binding.  It must be documented in
> Documentation/powerpc/dts-bindings and posted to
> devicetree-discuss@ozlabs.org for review.

Yeah, noticed that myself. I wanted to start another try to mainline this
driver next week, then also asking devicetree-discuss; will do it happily t=
his
week, too :)

>=20
> > diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
> > index 6d9ba35..f8e3908 100644
> > --- a/drivers/mtd/maps/Makefile
> > +++ b/drivers/mtd/maps/Makefile
> > @@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_WRSBC8260) =A0 +=3D wr_sbc82xx_flash=
=2Eo
> > =A0obj-$(CONFIG_MTD_DMV182) =A0 =A0 =A0 +=3D dmv182.o
> > =A0obj-$(CONFIG_MTD_SHARP_SL) =A0 =A0 +=3D sharpsl-flash.o
> > =A0obj-$(CONFIG_MTD_PLATRAM) =A0 =A0 =A0+=3D plat-ram.o
> > +obj-$(CONFIG_MTD_OFRAM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D of-ram.o
> > =A0obj-$(CONFIG_MTD_OMAP_NOR) =A0 =A0 +=3D omap_nor.o
> > =A0obj-$(CONFIG_MTD_INTEL_VR_NOR) +=3D intel_vr_nor.o
> > =A0obj-$(CONFIG_MTD_BFIN_ASYNC) =A0 +=3D bfin-async-flash.o
> > diff --git a/drivers/mtd/maps/of-ram.c b/drivers/mtd/maps/of-ram.c
> > new file mode 100644
> > index 0000000..4d334a9
> > --- /dev/null
> > +++ b/drivers/mtd/maps/of-ram.c
> > @@ -0,0 +1,120 @@
> > +/*
> > + * drivers/mtd/maps/of-ram.c
> > + *
> > + * Generic of device based RAM map
> > + *
> > + * Copyright (C) 2009 Wolfram Sang, Pengutronix
> > + *
> > + * Using plat-ram.c by Ben Dooks
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License version 2 as publ=
ished by
> > + * the Free Software Foundation.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/mtd/plat-ram.h>
> > +
> > +static int of_ram_probe(struct of_device *op, const struct of_device_i=
d *match)
>=20
> __devinit

Oops, missed all of those.

>=20
> > +{
> > + =A0 =A0 =A0 struct platdata_mtd_ram *pdata;
> > + =A0 =A0 =A0 struct resource *resource;
> > + =A0 =A0 =A0 const char *name;
> > + =A0 =A0 =A0 const u32 *bankwidth;
> > + =A0 =A0 =A0 int ret =3D -ENOMEM;
> > +
> > + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> > + =A0 =A0 =A0 if (!pdata)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad0;
> > + =A0 =A0 =A0 op->dev.platform_data =3D pdata;
> > +
> > + =A0 =A0 =A0 name =3D of_get_property(op->node, "name", NULL);
> > + =A0 =A0 =A0 if (!name) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&op->dev, "could not get node nam=
e\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad1;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 resource =3D kzalloc(sizeof(struct resource), GFP_KERNEL);
> > + =A0 =A0 =A0 if (!resource)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad1;
>=20
> Why isn't resource on the stack?

Point taken.

>=20
> > +
> > + =A0 =A0 =A0 if (of_address_to_resource(op->node, 0, resource)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&op->dev, "could not create resou=
rce\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad2;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 bankwidth =3D of_get_property(op->node, "bank-width", NUL=
L);
> > + =A0 =A0 =A0 if (*bankwidth =3D=3D 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&op->dev, "bank width not set\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad2;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 pdata->bankwidth =3D *bankwidth;
> > +
> > + =A0 =A0 =A0 ret =3D __platram_probe(&op->dev, name, resource, pdata);
> > + =A0 =A0 =A0 kfree(resource);
> > +
> > + =A0 =A0 =A0 if (ret)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto bad1;
> > +
> > + =A0 =A0 =A0 return 0;
> > +
> > + bad2:
> > + =A0 =A0 =A0 kfree(resource);
> > + bad1:
> > + =A0 =A0 =A0 op->dev.platform_data =3D NULL;
> > + =A0 =A0 =A0 kfree(pdata);
> > + bad0:
> > + =A0 =A0 =A0 return ret;
>=20
> I'd rather see more meaningful labels.  ie "err_kalloc:" and
> "err_platram_probe:".

Okay.

>=20
> > +}
> > +
> > +static int of_ram_remove(struct of_device *op)
>=20
> __devexit
>=20
> > +{
> > + =A0 =A0 =A0 int ret;
> > + =A0 =A0 =A0 struct platdata_mtd_ram *pdata =3D op->dev.platform_data;
> > +
> > + =A0 =A0 =A0 ret =3D __platram_remove(&op->dev);
> > + =A0 =A0 =A0 op->dev.platform_data =3D NULL;
> > + =A0 =A0 =A0 kfree(pdata);
> > + =A0 =A0 =A0 return ret;
> > +}
> > +
> > +static struct of_device_id of_ram_match[] =3D {
> > + =A0 =A0 =A0 { .compatible =3D "mtd-ram", },
> > + =A0 =A0 =A0 {},
> > +};
> > +MODULE_DEVICE_TABLE(of, of_ram_match);
> > +
> > +static struct of_platform_driver of_ram_driver =3D {
>=20
> __devinitdata
>=20
> > + =A0 =A0 =A0 .owner =3D THIS_MODULE,
> > + =A0 =A0 =A0 .name =3D "of-ram",
>=20
> This name is too generic for an of_platform device.  'mtd' needs to be
> in there somewhere.

Will "of-mtd-ram" do? (I'd think so)

>=20
> > + =A0 =A0 =A0 .match_table =3D of_ram_match,
> > + =A0 =A0 =A0 .probe =3D of_ram_probe,
> > + =A0 =A0 =A0 .remove =3D of_ram_remove,
>=20
> __devexit_p()
>=20
> > +};
> > +
> > +static int __init of_ram_init(void)
> > +{
> > + =A0 =A0 =A0 return of_register_platform_driver(&of_ram_driver);
> > +}
> > +
> > +static void __exit of_ram_exit(void)
> > +{
> > + =A0 =A0 =A0 of_unregister_platform_driver(&of_ram_driver);
> > +}
> > +
> > +module_init(of_ram_init);
>=20
> Put the module_init() statement directly after the of_ram_init() definiti=
on.
>=20
> > +module_exit(of_ram_exit);
> > +
> > +MODULE_AUTHOR("Wolfram Sang");
> > +MODULE_DESCRIPTION("MTD OF RAM map driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 1.5.6.5
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
>=20
>=20
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.

Will send V2 after some tests tomorrow...

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoTFtYACgkQD27XaX1/VRs+BQCfaadl6LU1XCuiFMBvgnCpFSVX
h0UAnil1Dj619nR+qUxsseETdXuWocWb
=CAy8
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
