Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 1F067B70A4
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 05:24:40 +1000 (EST)
Received: by gxk25 with SMTP id 25so2217031gxk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 12:24:39 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <73839B4A0818E747864426270AC332C305400687@zmy16exm20.fsl.freescale.net>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<20100726002813.GB25419@angua.secretlab.ca>
	<73839B4A0818E747864426270AC332C305400637@zmy16exm20.fsl.freescale.net>
	<AANLkTimQNWOvk_Tn3yedA-TSEc3x=+QR=rynvB8PKpTp@mail.gmail.com>
	<73839B4A0818E747864426270AC332C305400687@zmy16exm20.fsl.freescale.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 27 Jul 2010 13:24:19 -0600
Message-ID: <AANLkTikt+j0_jL7Winqzyb-OhWXSgw-G7F0ix3NVNXB7@mail.gmail.com>
Subject: Re: [PATCH 3/6] of/spi: add support to parse the SPI flash's
	partitions
To: Hu Mingkai-B21284 <B21284@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	Zang Roy-R61911 <R61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[cc'ing spi-devel-general]

On Mon, Jul 26, 2010 at 2:20 AM, Hu Mingkai-B21284 <B21284@freescale.com> w=
rote:
>
>
>> -----Original Message-----
>> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On
>> Behalf Of Grant Likely
>> Sent: Monday, July 26, 2010 3:53 PM
>> To: Hu Mingkai-B21284
>> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang
>> Roy-R61911
>> Subject: Re: [PATCH 3/6] of/spi: add support to parse the SPI
>> flash's partitions
>>
>> On Mon, Jul 26, 2010 at 1:25 AM, Hu Mingkai-B21284
>> <B21284@freescale.com> wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf
>> Of Grant
>> >> Likely
>> >> Sent: Monday, July 26, 2010 8:28 AM
>> >> To: Hu Mingkai-B21284
>> >> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang
>> >> Roy-R61911
>> >> Subject: Re: [PATCH 3/6] of/spi: add support to parse the
>> SPI flash's
>> >> partitions
>> >>
>> >> On Tue, Jul 20, 2010 at 10:08:22AM +0800, Mingkai Hu wrote:
>> >> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
>> >> > ---
>> >> > =A0drivers/of/of_spi.c =A0 =A0 =A0 | =A0 11 +++++++++++
>> >> > =A0drivers/spi/spi_mpc8xxx.c | =A0 =A01 +
>> >> > =A02 files changed, 12 insertions(+), 0 deletions(-)
>> >> >
>> >> > diff --git a/drivers/of/of_spi.c b/drivers/of/of_spi.c index
>> >> > 5fed7e3..284ca0e 100644
>> >> > --- a/drivers/of/of_spi.c
>> >> > +++ b/drivers/of/of_spi.c
>> >> > @@ -10,6 +10,8 @@
>> >> > =A0#include <linux/device.h>
>> >> > =A0#include <linux/spi/spi.h>
>> >> > =A0#include <linux/of_spi.h>
>> >> > +#include <linux/spi/flash.h>
>> >> > +#include <linux/mtd/partitions.h>
>> >> >
>> >> > =A0/**
>> >> > =A0 * of_register_spi_devices - Register child devices onto
>> >> the SPI bus
>> >> > @@ -26,6 +28,7 @@ void of_register_spi_devices(struct
>> >> spi_master *master, struct device_node *np)
>> >> > =A0 =A0 const __be32 *prop;
>> >> > =A0 =A0 int rc;
>> >> > =A0 =A0 int len;
>> >> > + =A0 struct flash_platform_data *pdata;
>> >> >
>> >> > =A0 =A0 for_each_child_of_node(np, nc) {
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 /* Alloc an spi_device */ @@ -81,6 +84,14 @=
@ void
>> >> > of_register_spi_devices(struct
>> >> spi_master *master, struct device_node *np)
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 of_node_get(nc);
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 spi->dev.of_node =3D nc;
>> >> >
>> >> > + =A0 =A0 =A0 =A0 =A0 /* Parse the mtd partitions */
>> >> > + =A0 =A0 =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL)=
;
>> >> > + =A0 =A0 =A0 =A0 =A0 if (!pdata)
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> >> > + =A0 =A0 =A0 =A0 =A0 pdata->nr_parts =3D
>> of_mtd_parse_partitions(&master->dev,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nc, &pdata->p=
arts);
>> >> > + =A0 =A0 =A0 =A0 =A0 spi->dev.platform_data =3D pdata;
>> >> > +
>> >>
>> >> Nack. =A0Not all spi devices are mtd devices. =A0In fact, most are no=
t.
>> >>
>> >> The spi driver itself should call the
>> of_mtd_parse_partitions code to
>> >> get the partition map. =A0Do not use pdata in this case.
>> >>
>> >
>> > Yes, we can call of_mtd_parse_partitions to get the
>> partiton map, but
>> > how can we pass this map to spi device to register to MTD layer?
>> >
>> > The spi device is created and registered when call
>> > of_register_spi_device in the spi controller probe
>> function, then the
>> > spi device will traverse the spi device driver list to find
>> the proper
>> > driver, if matched, then call the spi device driver probe
>> code where
>> > the mtd partition info is registered to the mtd layer.
>> >
>> > so where is the proper place to put the
>> of_mtd_parse_partitions code?
>>
>> In the device driver probe code.
>>
>
> This is the way that I did at first, thus we need to add the same code
> in all the spi flash driver to get partition map info.
>
> or we add the get partition map code to of_spi.c?

No, it really does not belong in of_spi.c because the spi code has no
knowledge about MTD devices.

I only see two valid options, to either:
a) add it to each MTD driver, or
b) add a hook to the core MTD code so that if an of_node pointer is
provided, and no partition data is provided, then it will parse the
partitions when the MTD device is registered.  You'd also need to code
it in a way that becomes a no-op when CONFIG_OF is not set.

>
> +/*
> + * of_parse_flash_partition - Parse the flash partition on the SPI bus
> + * @spi: =A0 =A0 =A0 Pointer to spi_device device
> + */
> +void of_parse_flash_partition(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct mtd_partition *parts;
> + =A0 =A0 =A0 struct flash_platform_data *spi_pdata;
> + =A0 =A0 =A0 int nr_parts =3D 0;
> + =A0 =A0 =A0 static int num_flash;
> + =A0 =A0 =A0 struct device_node *np =3D spi->dev.archdata.of_node;
> +
> + =A0 =A0 =A0 nr_parts =3D of_mtd_parse_partitions(&spi->dev, np, &parts)=
;
> + =A0 =A0 =A0 if (!nr_parts)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> +
> + =A0 =A0 =A0 spi_pdata =3D kzalloc(sizeof(*spi_pdata), GFP_KERNEL);
> + =A0 =A0 =A0 if (!spi_pdata)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto end;
> + =A0 =A0 =A0 spi_pdata->name =3D kzalloc(10, GFP_KERNEL);
> + =A0 =A0 =A0 if (!spi_pdata->name)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_flash;
> + =A0 =A0 =A0 snprintf(spi_pdata->name, 10, "SPIFLASH%d", num_flash++);
> +
> + =A0 =A0 =A0 spi_pdata->parts =3D parts;
> + =A0 =A0 =A0 spi_pdata->nr_parts =3D nr_parts;
> +
> + =A0 =A0 =A0 spi->dev.platform_data =3D spi_pdata;
> +
> + =A0 =A0 =A0 return;
> +
> +free_flash:
> + =A0 =A0 =A0 kfree(spi_pdata);
> +end:
> + =A0 =A0 =A0 return;
> +}
>
>
>> >> > diff --git a/drivers/spi/spi_mpc8xxx.c
>> b/drivers/spi/spi_mpc8xxx.c
>> >> > index efed70e..0fadaeb 100644
>> >> > --- a/drivers/spi/spi_mpc8xxx.c
>> >> > +++ b/drivers/spi/spi_mpc8xxx.c
>> >> > @@ -137,6 +137,7 @@ int mpc8xxx_spi_transfer(struct spi_device
>> >> > *spi,
>> >> >
>> >> > =A0void mpc8xxx_spi_cleanup(struct spi_device *spi) =A0{
>> >> > + =A0 kfree(spi->dev.platform_data);
>> >>
>> >> Irrelevant given the above comment, but how does this even work?
>> >> What if a driver was detached and reattached to an
>> spi_device? =A0The
>> >> platform_data would be freed. =A0Not to mention that the
>> pointer isn't
>> >> cleared, so the driver would have no idea that it has a freed
>> >> pointer.
>> >>
>> >
>> > It works. If the driver detached, the spi device
>> platform_data will be
>> > released, when reattached, the of_register_spi_devices will
>> be called
>> > again, the platform_data will be allocated.
>>
>> Ah right, I wasn't looking in the right place. =A0On that note
>> however, the cleanup of spi_device allocated by the OF code
>> should also have a reciprocal helper that frees them too. =A0It
>> shouldn't be done in the individual drivers.
>>
>
> We can define a helper to free the platform_data, but where it should be =
called?
> Maybe spidev_release is a better place to call, after all the platfrom_da=
ta is allocated
> when the spi device is created, so it should be freed when released.

It would be called from the spi core code.  However, with two options
I gave above, platform_data shouldn't be needed at all.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
