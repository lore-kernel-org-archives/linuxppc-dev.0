Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 22CEA2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 19:13:33 +1000 (EST)
Message-ID: <1375693993.3852.143.camel@thor.local>
Subject: Re: therm_pm72 units, interface
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 05 Aug 2013 11:13:13 +0200
In-Reply-To: <1375477360.15999.19.camel@pasglop>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local> <1375447861.15999.1.camel@pasglop>
 <1375454871.3852.27.camel@thor.local>
 <20130802155818.GB29933@blackmetal.musicnaut.iki.fi>
 <1375462346.3852.42.camel@thor.local> <1375477360.15999.19.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Ben Hutchings <ben@decadent.org.uk>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sam, 2013-08-03 at 07:02 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-02 at 18:52 +0200, Michel D=C3=A4nzer wrote:
>=20
> > Thanks for the suggestion. The same windfarm modules were loaded in bot=
h
> > cases, but i2c_powermac wasn't loaded with the newer kernels. Loading i=
t
> > manually fixes the problem.
> >=20
> > How is i2c_powermac supposed to get loaded with current kernels?
>=20
> It's a platform driver, but it's missing a module device-table
>=20
> Can you try this completely untested patch ?
>=20
> diff --git a/drivers/i2c/busses/i2c-powermac.c b/drivers/i2c/busses/i2c-p=
owermac.c
> index 8dc90da..5af5153 100644
> --- a/drivers/i2c/busses/i2c-powermac.c
> +++ b/drivers/i2c/busses/i2c-powermac.c
> @@ -458,9 +458,15 @@ static int i2c_powermac_probe(struct platform_device=
 *dev)
>  	return rc;
>  }
> =20
> +static const struct platform_device_id i2c_powermac_id =3D {
> +	.name =3D "i2c-powermac"
> +};
> +MODULE_DEVICE_TABLE(platform, i2c_powermac_id);
> +
>  static struct platform_driver i2c_powermac_driver =3D {
>  	.probe =3D i2c_powermac_probe,
>  	.remove =3D i2c_powermac_remove,
> +	.id_table =3D *i2c_powermac_id,

This fails to build:

  CC [M]  drivers/i2c/busses/i2c-powermac.o
drivers/i2c/busses/i2c-powermac.c:469:14: error: invalid type argument of u=
nary =E2=80=98*=E2=80=99 (have =E2=80=98const struct platform_device_id=E2=
=80=99)
make[1]: *** [drivers/i2c/busses/i2c-powermac.o] Error 1

The version below builds, but the module still doesn't get loaded
automagically (unless I'm missing some command I need to run between
copying the new module to /lib/modules/$(uname -r)/ and rebooting?).

Looking at other drivers in drivers/i2c/busses/, maybe
i2c_powermac_driver.driver needs an of_match_table entry?


diff --git a/drivers/i2c/busses/i2c-powermac.c
b/drivers/i2c/busses/i2c-powermac.c
index 8dc90da..74066fc 100644
--- a/drivers/i2c/busses/i2c-powermac.c
+++ b/drivers/i2c/busses/i2c-powermac.c
@@ -458,9 +458,19 @@ static int i2c_powermac_probe(struct
platform_device *dev)
        return rc;
 }

+static const struct platform_device_id i2c_powermac_id[] =3D {
+       {
+               .name =3D "i2c-powermac"
+       }, {
+               /* sentinel */
+       }
+};
+MODULE_DEVICE_TABLE(platform, i2c_powermac_id);
+
 static struct platform_driver i2c_powermac_driver =3D {
        .probe =3D i2c_powermac_probe,
        .remove =3D i2c_powermac_remove,
+       .id_table =3D i2c_powermac_id,
        .driver =3D {
                .name =3D "i2c-powermac",
                .bus =3D &platform_bus_type,
@@ -468,5 +478,3 @@ static struct platform_driver i2c_powermac_driver =3D
{
 };

 module_platform_driver(i2c_powermac_driver);
-
-MODULE_ALIAS("platform:i2c-powermac");

--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
