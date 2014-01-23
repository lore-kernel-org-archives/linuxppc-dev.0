Return-Path: <B48286@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 16C5F2C0091
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Jan 2014 14:29:45 +1100 (EST)
From: "B48286@freescale.com" <B48286@freescale.com>
To: 'Brian Norris' <computersforpeace@gmail.com>
Subject: RE: [PATCH] mtd: m25p80: Make the name of mtd_info fixed
Date: Thu, 23 Jan 2014 03:29:41 +0000
Message-ID: <66941b677b7e4b8d9ce4cc44304b0955@DM2PR03MB301.namprd03.prod.outlook.com>
References: <1388990069-27066-1-git-send-email-b48286@freescale.com>
 <20140123021213.GZ8919@ld-irv-0074>
In-Reply-To: <20140123021213.GZ8919@ld-irv-0074>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Brian,
Thanks for your comments!

> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace@gmail.com]
> Sent: Thursday, January 23, 2014 10:12 AM
> To: Hou Zhiqiang-B48286
> Cc: linux-mtd@lists.infradead.org; linuxppc-dev@ozlabs.org; Wood Scott-
> B07421; Hu Mingkai-B21284; Ezequiel Garcia
> Subject: Re: [PATCH] mtd: m25p80: Make the name of mtd_info fixed
>=20
> Hi Hou,
>=20
> On Mon, Jan 06, 2014 at 02:34:29PM +0800, Hou Zhiqiang wrote:
> > To give spi flash layout using "mtdparts=3D..." in cmdline, we must giv=
e
> > mtd_info a fixed name,because the cmdlinepart's parser will match the
> > name given in cmdline with the mtd_info.
> >
> > Now, if use OF node, mtd_info's name will be spi->dev->name. It
> > consists of spi_master->bus_num, and the spi_master->bus_num maybe
> > dynamically fetched.
> > So, give the mtd_info a new fiexd name "name.cs", "name" is name of
> > spi_device_id and "cs" is chip-select in spi_dev.
> >
> > Signed-off-by: Hou Zhiqiang <b48286@freescale.com>
> > ---
> >  drivers/mtd/devices/m25p80.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/devices/m25p80.c
> > b/drivers/mtd/devices/m25p80.c index eb558e8..d1ed480 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -1012,7 +1012,8 @@ static int m25p_probe(struct spi_device *spi)
> >  	if (data && data->name)
> >  		flash->mtd.name =3D data->name;
> >  	else
> > -		flash->mtd.name =3D dev_name(&spi->dev);
> > +		flash->mtd.name =3D kasprintf(GFP_KERNEL, "%s.%d",
> > +				id->name, spi->chip_select);
>=20
> Changing the mtd.name may have far-reaching consequences for users who
> already have mtdparts=3D command lines. But your concern is probably vali=
d
> for dynamically-determined bus numbers. Perhaps you can edit this patch
> to only change the name when the busnum is dynamically-allocated?
>
It's a good idea, but in the case of mtd_info's name dynamically-allocated
using "mtdparts=3D..." in command lines is illegal obviously. Would you tel=
l
me what side-effect will be brought by the change of mtd_info's name.
Thanks=20
=20
> This also needs a NULL check (for OOM), and you leak memory on device
> removal.
>=20
Yes, it's necessary to check the return value of function kasprintf.

> >
> >  	flash->mtd.type =3D MTD_NORFLASH;
> >  	flash->mtd.writesize =3D 1;
>=20
> Brian
>=20
Thanks,
Hou Zhiqiang
