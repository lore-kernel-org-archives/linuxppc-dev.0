Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id D4CF2DE1F2
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 15:07:32 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so780287ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 22:07:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090430223114.GA12571@oksana.dev.rtsoft.ru>
References: <20090430223114.GA12571@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 May 2009 23:07:10 -0600
Message-ID: <fa686aa40905212207r56e27c2k2536950f9280d80e@mail.gmail.com>
Subject: Re: [PATCH] mpc52xx_psc_spi: Convert to cs_control callback
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2009 at 4:31 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> mpc52xx_psc_spi driver is the last user of the legacy activate_cs
> and deactivate_cs callbacks, so convert the driver to the cs_control
> hook and remove the legacy callbacks from fsl_spi_platform_data
> struct.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

David, will you pick this one up, or can I put it into Ben's powerpc
-next tree (since it is a powerpc-only device driver).

g.

> ---
> =A0drivers/spi/mpc52xx_psc_spi.c | =A0 22 +++++++++-------------
> =A0include/linux/fsl_devices.h =A0 | =A0 =A04 ----
> =A02 files changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.=
c
> index 68c77a9..e1901fd 100644
> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -13,6 +13,7 @@
>
> =A0#include <linux/module.h>
> =A0#include <linux/init.h>
> +#include <linux/types.h>
> =A0#include <linux/errno.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/of_platform.h>
> @@ -30,8 +31,7 @@
>
> =A0struct mpc52xx_psc_spi {
> =A0 =A0 =A0 =A0/* fsl_spi_platform data */
> - =A0 =A0 =A0 void (*activate_cs)(u8, u8);
> - =A0 =A0 =A0 void (*deactivate_cs)(u8, u8);
> + =A0 =A0 =A0 void (*cs_control)(struct spi_device *spi, bool on);
> =A0 =A0 =A0 =A0u32 sysclk;
>
> =A0 =A0 =A0 =A0/* driver internal data */
> @@ -111,18 +111,16 @@ static void mpc52xx_psc_spi_activate_cs(struct spi_=
device *spi)
> =A0 =A0 =A0 =A0out_be16((u16 __iomem *)&psc->ccr, ccr);
> =A0 =A0 =A0 =A0mps->bits_per_word =3D cs->bits_per_word;
>
> - =A0 =A0 =A0 if (mps->activate_cs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->activate_cs(spi->chip_select,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (spi->mode =
& SPI_CS_HIGH) ? 1 : 0);
> + =A0 =A0 =A0 if (mps->cs_control)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->cs_control(spi, (spi->mode & SPI_CS_HI=
GH) ? 1 : 0);
> =A0}
>
> =A0static void mpc52xx_psc_spi_deactivate_cs(struct spi_device *spi)
> =A0{
> =A0 =A0 =A0 =A0struct mpc52xx_psc_spi *mps =3D spi_master_get_devdata(spi=
->master);
>
> - =A0 =A0 =A0 if (mps->deactivate_cs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->deactivate_cs(spi->chip_select,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (spi->mode =
& SPI_CS_HIGH) ? 1 : 0);
> + =A0 =A0 =A0 if (mps->cs_control)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->cs_control(spi, (spi->mode & SPI_CS_HI=
GH) ? 0 : 1);
> =A0}
>
> =A0#define MPC52xx_PSC_BUFSIZE (MPC52xx_PSC_RFNUM_MASK + 1)
> @@ -388,15 +386,13 @@ static int __init mpc52xx_psc_spi_do_probe(struct d=
evice *dev, u32 regaddr,
> =A0 =A0 =A0 =A0mps->irq =3D irq;
> =A0 =A0 =A0 =A0if (pdata =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(dev, "probe called without platfo=
rm data, no "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(de)activa=
te_cs function will be called\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->activate_cs =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->deactivate_cs =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cs_control=
 function will be called\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->cs_control =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mps->sysclk =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->bus_num =3D bus_num;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->num_chipselect =3D 255;
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->activate_cs =3D pdata->activate_cs;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->deactivate_cs =3D pdata->deactivate_cs=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mps->cs_control =3D pdata->cs_control;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mps->sysclk =3D pdata->sysclk;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->bus_num =3D pdata->bus_num;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->num_chipselect =3D pdata->max_chip=
select;
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> index 244677c..43fc95d 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -79,10 +79,6 @@ struct fsl_spi_platform_data {
> =A0 =A0 =A0 =A0u16 =A0 =A0 max_chipselect;
> =A0 =A0 =A0 =A0void =A0 =A0(*cs_control)(struct spi_device *spi, bool on)=
;
> =A0 =A0 =A0 =A0u32 =A0 =A0 sysclk;
> -
> - =A0 =A0 =A0 /* Legacy hooks, used by mpc52xx_psc_spi driver. */
> - =A0 =A0 =A0 void =A0 =A0(*activate_cs)(u8 cs, u8 polarity);
> - =A0 =A0 =A0 void =A0 =A0(*deactivate_cs)(u8 cs, u8 polarity);
> =A0};
>
> =A0struct mpc8xx_pcmcia_ops {
> --
> 1.6.2.2
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
