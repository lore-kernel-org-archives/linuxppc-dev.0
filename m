Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [88.79.252.171])
	by ozlabs.org (Postfix) with SMTP id EC969DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 20:37:05 +1100 (EST)
From: "Stepanov, Sergej" <Sergej.Stepanov@ids.de>
To: Daniel Ng <daniel.ng1234@gmail.com>
Date: Fri, 20 Mar 2009 10:37:01 +0100
Subject: AW: spidev.c driver on the ppc8247 (kernel 2.6.27.19)
Message-ID: <4206182445660643B9AEB8D4E55BBD0A02B9DDEEB4@HERMES2>
References: <547eba1b0903180036m46f6ffc0g521a5081924a2613@mail.gmail.com>
	<4206182445660643B9AEB8D4E55BBD0A02B9DDEEB3@HERMES2>
	<547eba1b0903190132pfd11ad5ld4b1bffb6dc22758@mail.gmail.com>,
	<547eba1b0903191819v5b03d38ci7a60839873e5bd66@mail.gmail.com>
In-Reply-To: <547eba1b0903191819v5b03d38ci7a60839873e5bd66@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Daniel,

sorry, my example was incomplete...

for a fast you can add in your platform file something like this:

..........................
#ifdef CONFIG_SPI_IDS8247
#include <linux/spi/spi.h>
#include <linux/spi/mmc_spi.h>
#include <linux/mmc/host.h>
#endif
........

#ifdef CONFIG_SPI_IDS8247

#define GPIO_CS (224+22)
static void ids8247_spi_activate_cs(u8 cs, u8 polarity)
{
	pr_debug("%s %d %d\n", __func__, cs, polarity);
	//gpio_set_value(GPIO_CS, (int)polarity);
}

static void ids8247_spi_deactivate_cs(u8 cs, u8 polarity)
{
	pr_debug("%s %d %d\n", __func__, cs, polarity);
	//gpio_set_value(GPIO_CS, (int)(!polarity));
}

static struct mmc_spi_platform_data ids8247_mmc_pdata =3D {
	.ocr_mask =3D MMC_VDD_32_33,
};

static struct spi_board_info ids8247_spi_boardinfo =3D {
	.bus_num =3D 0,
	.chip_select =3D 0,
	.max_speed_hz =3D 20000000,
	.modalias =3D "mmc_spi",
	.platform_data =3D &ids8247_mmc_pdata,
};
static __init int ids8247_spi_setup(void)
{
	int ret =3D 0;
	struct platform_device *spi_dev;
	struct resource r[3];
	struct device_node *np =3D NULL;
	struct fsl_spi_platform_data spi_data;

	/*if (!gpio_get_value(GPIO_CS))
		return;
	*/
	if( (np =3D of_find_compatible_node(NULL, "spi", "platform-mapped")) =3D=
=3D0 )
		return 0;

	//fsl_get_sys_freq();
	memset(&spi_data, 0, sizeof(struct fsl_spi_platform_data));
	spi_data.activate_cs =3D ids8247_spi_activate_cs;
	spi_data.deactivate_cs =3D ids8247_spi_deactivate_cs;
	spi_data.bus_num =3D 0;
	spi_data.max_chipselect =3D 1;
	memset(r, 0, sizeof(struct resource)*3);

	ret =3D of_address_to_resource(np, 0, &r[0]);
	if (ret)
		goto spi_err;

	ret =3D of_address_to_resource(np, 1, &r[1]);
	if (ret)
		goto spi_err;

	ret =3D of_irq_to_resource(np, 0, &r[2]);
	if (ret =3D=3D NO_IRQ)
		goto spi_err;

	spi_data.qe_mode =3D 0;
	spi_data.sysclk =3D 24750000;

	spi_dev =3D platform_device_register_simple("ids8247_spi", 0, &r[0], 3);
	if (IS_ERR(spi_dev)) {
		ret =3D PTR_ERR(spi_dev);
		return ret;
	}
	ret =3D platform_device_add_data(spi_dev,
				       &spi_data,
				       sizeof(struct fsl_spi_platform_data));
	if(ret) {
		platform_device_unregister(spi_dev);
		return ret;
	}
	of_node_put(np);
	return spi_register_board_info(&ids8247_spi_boardinfo, 1);
spi_err:
	of_node_put(np);
	return -1;
}
arch_initcall(ids8247_spi_setup);
#endif /* CONFIG_SPI_IDS8247 */
..........

Sorry, i know it looks very dirty...

Regards
Sergej.

________________________________________
Von: Daniel Ng [daniel.ng1234@gmail.com]
Gesendet: Freitag, 20. M=E4rz 2009 02:19
An: Stepanov, Sergej
Cc: linuxppc-dev@ozlabs.org
Betreff: Re: spidev.c driver on the ppc8247 (kernel 2.6.27.19)

On Thu, Mar 19, 2009 at 7:32 PM, Daniel Ng <daniel.ng1234@gmail.com> wrote:
>
> So, I tried to call spidev_probe() directly from the probe() function
> of my SPI Controller driver. However in this case spidev_probe()
> failed because its call to device_create_drvdata() failed with error
> code ENODEV. Why would this be?
>
> This is how I make the call from my SPI Controller driver:
>
> spidev_probe(to_spi_device(&ofdev->dev));
>
> And this is the relevant code in spidev_probe():
>
> dev =3D device_create_drvdata(spidev_class, &spi->dev, spidev->devt,
> spidev, "spidev%d.%d",
>                               /*spi->master->bus_num*/0, spi->chip_select=
);

It looks like spidev_class was uninitialised because spidev_init() had
not yet been called. To force spidev_init() to be called before my SPI
Controller's driver initialisation, I just used:

subsys_initcall(spidev_init);

This seems to do the job...
