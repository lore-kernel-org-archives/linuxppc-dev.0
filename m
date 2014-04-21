Return-Path: <B48286@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 614211400E5
 for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2014 20:37:44 +1000 (EST)
From: "B48286@freescale.com" <B48286@freescale.com>
To: 'Brian Norris' <computersforpeace@gmail.com>
Subject: RE: [PATCH] mtd: m25p80: Modify the name of mtd_info
Date: Mon, 21 Apr 2014 10:21:36 +0000
Message-ID: <2196d56b0aba46b789f0092b73ca077b@DM2PR03MB301.namprd03.prod.outlook.com>
References: <1395400578-5637-1-git-send-email-B48286@freescale.com>
 <20140416064800.GO3131@norris-Latitude-E6410>
In-Reply-To: <20140416064800.GO3131@norris-Latitude-E6410>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Mingkai.Hu@freescale.com" <Mingkai.Hu@freescale.com>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace@gmail.com]
> Sent: Wednesday, April 16, 2014 2:48 PM
> To: Hou Zhiqiang-B48286
> Cc: linux-mtd@lists.infradead.org; linuxppc-dev@ozlabs.org; Wood Scott-
> B07421; Hu Mingkai-B21284; dwmw2@infradead.org
> Subject: Re: [PATCH] mtd: m25p80: Modify the name of mtd_info
>=20
> On Fri, Mar 21, 2014 at 07:16:18PM +0800, Hou Zhiqiang wrote:
> > To specify spi flash layouts by "mtdparts=3D..." in cmdline, we must
> > give mtd_info a fixed name,because the cmdlinepart's parser will match
> > the name of mtd_info given in cmdline.
> > Now, if use DT, the mtd_info's name will be spi->dev->name. It
> > consists of spi_master->bus_num, and the spi_master->bus_num maybe
> > dynamically fetched. So, in this case, replace the component bus_num
> > with thei physical address of spi master.
> >
> > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > ---
> >  drivers/mtd/devices/m25p80.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mtd/devices/m25p80.c
> > b/drivers/mtd/devices/m25p80.c index 7eda71d..64450a2 100644
> > --- a/drivers/mtd/devices/m25p80.c
> > +++ b/drivers/mtd/devices/m25p80.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/mtd/cfi.h>
> >  #include <linux/mtd/mtd.h>
> >  #include <linux/mtd/partitions.h>
> > +#include <linux/of_address.h>
> >  #include <linux/of_platform.h>
> >
> >  #include <linux/spi/spi.h>
> > @@ -934,9 +935,11 @@ static int m25p_probe(struct spi_device *spi)
> >  	struct flash_platform_data	*data;
> >  	struct m25p			*flash;
> >  	struct flash_info		*info;
> > -	unsigned			i;
> > +	unsigned			i, ret;
> >  	struct mtd_part_parser_data	ppdata;
> >  	struct device_node *np =3D spi->dev.of_node;
> > +	struct resource res;
> > +	struct device_node *mnp =3D spi->master->dev.of_node;
> >
> >  	/* Platform data helps sort out which chip type we have, as
> >  	 * well as how this board partitions it.  If we don't have @@
> > -1009,8 +1012,17 @@ static int m25p_probe(struct spi_device *spi)
> >
> >  	if (data && data->name)
> >  		flash->mtd.name =3D data->name;
> > -	else
> > -		flash->mtd.name =3D dev_name(&spi->dev);
> > +	else{
> > +		ret =3D of_address_to_resource(mnp, 0, &res);
>=20
> You're making a lot assumptions about the SPI master/device relationship
> -- that the master has a device-node; that the first resource of the
> master is its physical address (this is not guaranteed by DT semantics).
> Please do not do this.

Thank you for your tips, but I think it is right to get the physical addres=
s
of master using the API of_address_to_resource, because of_address_to_resou=
rce
just parse address-resource from device tree.

>=20
> > +		if (ret) {
> > +			dev_err(&spi->dev, "failed to get spi master
> resource\n");
> > +			return ret;
>=20
> This is wrong. It breaks all !CONFIG_OF cases which didn't specify a name
> via platform data.
>=20

I will resend a patch to fix it.

> > +		}
> > +		flash->mtd.name =3D kasprintf(GFP_KERNEL, "spi%x.%d",
> > +				(unsigned)res.start, spi->chip_select);
> > +		if (!flash->mtd.name)
> > +			return -ENOMEM;
> > +	}
> >
> >  	flash->mtd.type =3D MTD_NORFLASH;
> >  	flash->mtd.writesize =3D 1;
>=20
> Brian
>=20

Thanks,
Zhiqiang
