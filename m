Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DBAEB2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 19:22:53 +1000 (EST)
Message-ID: <1375694554.12557.40.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Mon, 05 Aug 2013 19:22:34 +1000
In-Reply-To: <1375693993.3852.143.camel@thor.local>
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
 <1375693993.3852.143.camel@thor.local>
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

On Mon, 2013-08-05 at 11:13 +0200, Michel Dänzer wrote:
> >  static struct platform_driver i2c_powermac_driver = {
> >       .probe = i2c_powermac_probe,
> >       .remove = i2c_powermac_remove,
> > +     .id_table = *i2c_powermac_id,
> 
> This fails to build:
> 
>   CC [M]  drivers/i2c/busses/i2c-powermac.o
> drivers/i2c/busses/i2c-powermac.c:469:14: error: invalid type argument
> of unary ‘*’ (have ‘const struct platform_device_id’)
> make[1]: *** [drivers/i2c/busses/i2c-powermac.o] Error 1

Yeah, obvious typo, I said it was completely untested :-)

> The version below builds, but the module still doesn't get loaded
> automagically (unless I'm missing some command I need to run between
> copying the new module to /lib/modules/$(uname -r)/ and rebooting?).

depmod -a ?

> Looking at other drivers in drivers/i2c/busses/, maybe
> i2c_powermac_driver.driver needs an of_match_table entry?

No, that would be messy, the driver is just an interface layer
on top of the low-i2c.c stuff in arch, which abstracts 3 different
i2c controllers and inconsistent device-tree representations. It's
done outside of the normal i2c framework because it's used in some
special contexts such as when running the platform functions, at early
boot or sleep/wakeup time. Also it's historical stuff I'd rather not
touch since I don't have that many different combos to test with
anymore.

However, the kernel creates platform device so the normal platform
matching mechanism should work... we might be missing something.

> diff --git a/drivers/i2c/busses/i2c-powermac.c
> b/drivers/i2c/busses/i2c-powermac.c
> index 8dc90da..74066fc 100644
> --- a/drivers/i2c/busses/i2c-powermac.c
> +++ b/drivers/i2c/busses/i2c-powermac.c
> @@ -458,9 +458,19 @@ static int i2c_powermac_probe(struct
> platform_device *dev)
>         return rc;
>  }
> 
> +static const struct platform_device_id i2c_powermac_id[] = {
> +       {
> +               .name = "i2c-powermac"
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +MODULE_DEVICE_TABLE(platform, i2c_powermac_id);
> +
>  static struct platform_driver i2c_powermac_driver = {
>         .probe = i2c_powermac_probe,
>         .remove = i2c_powermac_remove,
> +       .id_table = i2c_powermac_id,
>         .driver = {
>                 .name = "i2c-powermac",
>                 .bus = &platform_bus_type,
> @@ -468,5 +478,3 @@ static struct platform_driver i2c_powermac_driver
> =
> {
>  };
> 
>  module_platform_driver(i2c_powermac_driver);
> -
> -MODULE_ALIAS("platform:i2c-powermac");

Maybe add the module alias back ? It shouldn't be necessary...

Cheers,
Ben.
