Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.235])
	by ozlabs.org (Postfix) with ESMTP id 3074CDDEDA
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 07:43:03 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so1854627rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 14:43:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090430234833.GI7901@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
	<20090430234833.GI7901@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 1 May 2009 15:42:47 -0600
Message-ID: <fa686aa40905011442y26ef3a50ub012e7cb2f680c91@mail.gmail.com>
Subject: Re: [spi-devel-general] [PATCH 9/9] spi_mpc8xxx: s/83xx/8xxx/g
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2009 at 5:48 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Since we renamed the file, we might want to rename the file
> internals too.
>
> Though we don't bother with changing platform driver name and
> platform module alias. The stuff is legacy and hopefully we'll
> remove it soon.
>

I'd say no personally.  Its a lot of churn for very little gain.  The
filename change alone should be sufficient to clue people into what
the driver is for.

g.

> Suggested-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> =A0drivers/spi/Kconfig =A0 =A0 =A0 | =A0 =A02 +-
> =A0drivers/spi/Makefile =A0 =A0 =A0| =A0 =A02 +-
> =A0drivers/spi/spi_mpc8xxx.c | =A0396 ++++++++++++++++++++++-------------=
---------
> =A03 files changed, 200 insertions(+), 200 deletions(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3c1845c..9e77bf1 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -139,7 +139,7 @@ config SPI_MPC52xx_PSC
> =A0 =A0 =A0 =A0 =A0This enables using the Freescale MPC52xx Programmable =
Serial
> =A0 =A0 =A0 =A0 =A0Controller in master SPI mode.
>
> -config SPI_MPC83xx
> +config SPI_MPC8xxx
> =A0 =A0 =A0 =A0tristate "Freescale MPC8xxx SPI controller"
> =A0 =A0 =A0 =A0depends on FSL_SOC
> =A0 =A0 =A0 =A0help
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index fdc7aa0..18ba6b4 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -24,7 +24,7 @@ obj-$(CONFIG_SPI_OMAP_UWIRE) =A0 =A0 =A0 =A0 =A0+=3D om=
ap_uwire.o
> =A0obj-$(CONFIG_SPI_OMAP24XX) =A0 =A0 =A0 =A0 =A0 =A0 +=3D omap2_mcspi.o
> =A0obj-$(CONFIG_SPI_ORION) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0+=3D orion_spi.o
> =A0obj-$(CONFIG_SPI_MPC52xx_PSC) =A0 =A0 =A0 =A0 =A0+=3D mpc52xx_psc_spi.=
o
> -obj-$(CONFIG_SPI_MPC83xx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_mpc8xxx.o
> +obj-$(CONFIG_SPI_MPC8xxx) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_mpc8xxx.o
> =A0obj-$(CONFIG_SPI_S3C24XX_GPIO) =A0 =A0 =A0 =A0 +=3D spi_s3c24xx_gpio.o
> =A0obj-$(CONFIG_SPI_S3C24XX) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_s3c24xx.=
o
> =A0obj-$(CONFIG_SPI_TXX9) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_txx9.o
> diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
> index 4192ce4..15d9527 100644
> --- a/drivers/spi/spi_mpc8xxx.c
> +++ b/drivers/spi/spi_mpc8xxx.c
> @@ -1,5 +1,5 @@
> =A0/*
> - * MPC83xx SPI controller driver.
> + * MPC8xxx SPI controller driver.
> =A0*
> =A0* Maintainer: Kumar Gala
> =A0*
> @@ -37,7 +37,7 @@
> =A0#include <asm/irq.h>
>
> =A0/* SPI Controller registers */
> -struct mpc83xx_spi_reg {
> +struct mpc8xxx_spi_reg {
> =A0 =A0 =A0 =A0u8 res1[0x20];
> =A0 =A0 =A0 =A0__be32 mode;
> =A0 =A0 =A0 =A0__be32 event;
> @@ -76,16 +76,16 @@ struct mpc83xx_spi_reg {
> =A0#define =A0 =A0 =A0 =A0SPIM_NF =A0 =A0 =A0 =A0 0x00000100 =A0 =A0 =A0/=
* Not full */
>
> =A0/* SPI Controller driver's private data. */
> -struct mpc83xx_spi {
> - =A0 =A0 =A0 struct mpc83xx_spi_reg __iomem *base;
> +struct mpc8xxx_spi {
> + =A0 =A0 =A0 struct mpc8xxx_spi_reg __iomem *base;
>
> =A0 =A0 =A0 =A0/* rx & tx bufs from the spi_transfer */
> =A0 =A0 =A0 =A0const void *tx;
> =A0 =A0 =A0 =A0void *rx;
>
> =A0 =A0 =A0 =A0/* functions to deal with different sized buffers */
> - =A0 =A0 =A0 void (*get_rx) (u32 rx_data, struct mpc83xx_spi *);
> - =A0 =A0 =A0 u32(*get_tx) (struct mpc83xx_spi *);
> + =A0 =A0 =A0 void (*get_rx) (u32 rx_data, struct mpc8xxx_spi *);
> + =A0 =A0 =A0 u32(*get_tx) (struct mpc8xxx_spi *);
>
> =A0 =A0 =A0 =A0unsigned int count;
> =A0 =A0 =A0 =A0unsigned int irq;
> @@ -107,44 +107,44 @@ struct mpc83xx_spi {
> =A0 =A0 =A0 =A0struct completion done;
> =A0};
>
> -struct spi_mpc83xx_cs {
> +struct spi_mpc8xxx_cs {
> =A0 =A0 =A0 =A0/* functions to deal with different sized buffers */
> - =A0 =A0 =A0 void (*get_rx) (u32 rx_data, struct mpc83xx_spi *);
> - =A0 =A0 =A0 u32 (*get_tx) (struct mpc83xx_spi *);
> + =A0 =A0 =A0 void (*get_rx) (u32 rx_data, struct mpc8xxx_spi *);
> + =A0 =A0 =A0 u32 (*get_tx) (struct mpc8xxx_spi *);
> =A0 =A0 =A0 =A0u32 rx_shift; =A0 =A0 =A0 =A0 =A0 /* RX data reg shift whe=
n in qe mode */
> =A0 =A0 =A0 =A0u32 tx_shift; =A0 =A0 =A0 =A0 =A0 /* TX data reg shift whe=
n in qe mode */
> =A0 =A0 =A0 =A0u32 hw_mode; =A0 =A0 =A0 =A0 =A0 =A0/* Holds HW mode regis=
ter settings */
> =A0};
>
> -static inline void mpc83xx_spi_write_reg(__be32 __iomem *reg, u32 val)
> +static inline void mpc8xxx_spi_write_reg(__be32 __iomem *reg, u32 val)
> =A0{
> =A0 =A0 =A0 =A0out_be32(reg, val);
> =A0}
>
> -static inline u32 mpc83xx_spi_read_reg(__be32 __iomem *reg)
> +static inline u32 mpc8xxx_spi_read_reg(__be32 __iomem *reg)
> =A0{
> =A0 =A0 =A0 =A0return in_be32(reg);
> =A0}
>
> =A0#define MPC83XX_SPI_RX_BUF(type) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0static =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> -void mpc83xx_spi_rx_buf_##type(u32 data, struct mpc83xx_spi *mpc83xx_spi=
) \
> +void mpc8xxx_spi_rx_buf_##type(u32 data, struct mpc8xxx_spi *mpc8xxx_spi=
) \
> =A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> - =A0 =A0 =A0 type *rx =3D mpc83xx_spi->rx; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 *rx++ =3D (type)(data >> mpc83xx_spi->rx_shift); =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> - =A0 =A0 =A0 mpc83xx_spi->rx =3D rx; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 type *rx =3D mpc8xxx_spi->rx; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 *rx++ =3D (type)(data >> mpc8xxx_spi->rx_shift); =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 mpc8xxx_spi->rx =3D rx; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0}
>
> =A0#define MPC83XX_SPI_TX_BUF(type) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
> =A0static =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> -u32 mpc83xx_spi_tx_buf_##type(struct mpc83xx_spi *mpc83xx_spi) \
> +u32 mpc8xxx_spi_tx_buf_##type(struct mpc8xxx_spi *mpc8xxx_spi) \
> =A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0u32 data; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 const type *tx =3D mpc83xx_spi->tx; =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 const type *tx =3D mpc8xxx_spi->tx; =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0if (!tx) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 data =3D *tx++ << mpc83xx_spi->tx_shift; =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0\
> - =A0 =A0 =A0 mpc83xx_spi->tx =3D tx; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 data =3D *tx++ << mpc8xxx_spi->tx_shift; =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 mpc8xxx_spi->tx =3D tx; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0return data; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0}
>
> @@ -155,12 +155,12 @@ MPC83XX_SPI_TX_BUF(u8)
> =A0MPC83XX_SPI_TX_BUF(u16)
> =A0MPC83XX_SPI_TX_BUF(u32)
>
> -static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
> +static void mpc8xxx_spi_chipselect(struct spi_device *spi, int value)
> =A0{
> - =A0 =A0 =A0 struct mpc83xx_spi *mpc83xx_spi =3D spi_master_get_devdata(=
spi->master);
> + =A0 =A0 =A0 struct mpc8xxx_spi *mpc8xxx_spi =3D spi_master_get_devdata(=
spi->master);
> =A0 =A0 =A0 =A0struct fsl_spi_platform_data *pdata =3D spi->dev.parent->p=
latform_data;
> =A0 =A0 =A0 =A0bool pol =3D spi->mode & SPI_CS_HIGH;
> - =A0 =A0 =A0 struct spi_mpc83xx_cs =A0 *cs =3D spi->controller_state;
> + =A0 =A0 =A0 struct spi_mpc8xxx_cs =A0 *cs =3D spi->controller_state;
>
> =A0 =A0 =A0 =A0if (value =3D=3D BITBANG_CS_INACTIVE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->cs_control)
> @@ -168,16 +168,16 @@ static void mpc83xx_spi_chipselect(struct spi_devic=
e *spi, int value)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (value =3D=3D BITBANG_CS_ACTIVE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 regval =3D mpc83xx_spi_read_reg(&mpc83x=
x_spi->base->mode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 regval =3D mpc8xxx_spi_read_reg(&mpc8xx=
x_spi->base->mode);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi->rx_shift =3D cs->rx_shift;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi->tx_shift =3D cs->tx_shift;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi->get_rx =3D cs->get_rx;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi->get_tx =3D cs->get_tx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi->rx_shift =3D cs->rx_shift;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi->tx_shift =3D cs->tx_shift;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi->get_rx =3D cs->get_rx;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi->get_tx =3D cs->get_tx;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cs->hw_mode !=3D regval) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long flags;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __be32 __iomem *mode =3D &m=
pc83xx_spi->base->mode;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __be32 __iomem *mode =3D &m=
pc8xxx_spi->base->mode;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regval =3D cs->hw_mode;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Turn off IRQs locally t=
o minimize time that
> @@ -185,8 +185,8 @@ static void mpc83xx_spi_chipselect(struct spi_device =
*spi, int value)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local_irq_save(flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Turn off SPI unit prior=
 changing mode */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi_write_reg(mode,=
 regval & ~SPMODE_ENABLE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi_write_reg(mode,=
 regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi_write_reg(mode,=
 regval & ~SPMODE_ENABLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi_write_reg(mode,=
 regval);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local_irq_restore(flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->cs_control)
> @@ -195,15 +195,15 @@ static void mpc83xx_spi_chipselect(struct spi_devic=
e *spi, int value)
> =A0}
>
> =A0static
> -int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transf=
er *t)
> +int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transf=
er *t)
> =A0{
> - =A0 =A0 =A0 struct mpc83xx_spi *mpc83xx_spi;
> + =A0 =A0 =A0 struct mpc8xxx_spi *mpc8xxx_spi;
> =A0 =A0 =A0 =A0u32 regval;
> =A0 =A0 =A0 =A0u8 bits_per_word, pm;
> =A0 =A0 =A0 =A0u32 hz;
> - =A0 =A0 =A0 struct spi_mpc83xx_cs =A0 *cs =3D spi->controller_state;
> + =A0 =A0 =A0 struct spi_mpc8xxx_cs =A0 *cs =3D spi->controller_state;
>
> - =A0 =A0 =A0 mpc83xx_spi =3D spi_master_get_devdata(spi->master);
> + =A0 =A0 =A0 mpc8xxx_spi =3D spi_master_get_devdata(spi->master);
>
> =A0 =A0 =A0 =A0if (t) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bits_per_word =3D t->bits_per_word;
> @@ -228,26 +228,26 @@ int mpc83xx_spi_setup_transfer(struct spi_device *s=
pi, struct spi_transfer *t)
> =A0 =A0 =A0 =A0cs->rx_shift =3D 0;
> =A0 =A0 =A0 =A0cs->tx_shift =3D 0;
> =A0 =A0 =A0 =A0if (bits_per_word <=3D 8) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_rx =3D mpc83xx_spi_rx_buf_u8;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_tx =3D mpc83xx_spi_tx_buf_u8;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc83xx_spi->qe_mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_rx =3D mpc8xxx_spi_rx_buf_u8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_tx =3D mpc8xxx_spi_tx_buf_u8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc8xxx_spi->qe_mode) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->rx_shift =3D 16;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->tx_shift =3D 24;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else if (bits_per_word <=3D 16) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_rx =3D mpc83xx_spi_rx_buf_u16;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_tx =3D mpc83xx_spi_tx_buf_u16;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc83xx_spi->qe_mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_rx =3D mpc8xxx_spi_rx_buf_u16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_tx =3D mpc8xxx_spi_tx_buf_u16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc8xxx_spi->qe_mode) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->rx_shift =3D 16;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->tx_shift =3D 16;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else if (bits_per_word <=3D 32) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_rx =3D mpc83xx_spi_rx_buf_u32;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_tx =3D mpc83xx_spi_tx_buf_u32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_rx =3D mpc8xxx_spi_rx_buf_u32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->get_tx =3D mpc8xxx_spi_tx_buf_u32;
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 if (mpc83xx_spi->qe_mode && spi->mode & SPI_LSB_FIRST) {
> + =A0 =A0 =A0 if (mpc8xxx_spi->qe_mode && spi->mode & SPI_LSB_FIRST) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->tx_shift =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (bits_per_word <=3D 8)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->rx_shift =3D 8;
> @@ -255,10 +255,10 @@ int mpc83xx_spi_setup_transfer(struct spi_device *s=
pi, struct spi_transfer *t)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->rx_shift =3D 0;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mpc83xx_spi->rx_shift =3D cs->rx_shift;
> - =A0 =A0 =A0 mpc83xx_spi->tx_shift =3D cs->tx_shift;
> - =A0 =A0 =A0 mpc83xx_spi->get_rx =3D cs->get_rx;
> - =A0 =A0 =A0 mpc83xx_spi->get_tx =3D cs->get_tx;
> + =A0 =A0 =A0 mpc8xxx_spi->rx_shift =3D cs->rx_shift;
> + =A0 =A0 =A0 mpc8xxx_spi->tx_shift =3D cs->tx_shift;
> + =A0 =A0 =A0 mpc8xxx_spi->get_rx =3D cs->get_rx;
> + =A0 =A0 =A0 mpc8xxx_spi->get_tx =3D cs->get_tx;
>
> =A0 =A0 =A0 =A0if (bits_per_word =3D=3D 32)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bits_per_word =3D 0;
> @@ -271,25 +271,25 @@ int mpc83xx_spi_setup_transfer(struct spi_device *s=
pi, struct spi_transfer *t)
>
> =A0 =A0 =A0 =A0cs->hw_mode |=3D SPMODE_LEN(bits_per_word);
>
> - =A0 =A0 =A0 if ((mpc83xx_spi->spibrg / hz) > 64) {
> + =A0 =A0 =A0 if ((mpc8xxx_spi->spibrg / hz) > 64) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->hw_mode |=3D SPMODE_DIV16;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D mpc83xx_spi->spibrg / (hz * 64);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D mpc8xxx_spi->spibrg / (hz * 64);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN_ONCE(pm > 16, "%s: Requested speed is=
 too low: %d Hz. "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Will use %d Hz instea=
d.\n", dev_name(&spi->dev),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hz, mpc83xx_spi->spibrg=
 / 1024);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hz, mpc8xxx_spi->spibrg=
 / 1024);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pm > 16)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm =3D 16;
> =A0 =A0 =A0 =A0} else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D mpc83xx_spi->spibrg / (hz * 4);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm =3D mpc8xxx_spi->spibrg / (hz * 4);
> =A0 =A0 =A0 =A0if (pm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm--;
>
> =A0 =A0 =A0 =A0cs->hw_mode |=3D SPMODE_PM(pm);
> - =A0 =A0 =A0 regval =3D =A0mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode=
);
> + =A0 =A0 =A0 regval =3D =A0mpc8xxx_spi_read_reg(&mpc8xxx_spi->base->mode=
);
> =A0 =A0 =A0 =A0if (cs->hw_mode !=3D regval) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long flags;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __be32 __iomem *mode =3D &mpc83xx_spi->base=
->mode;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __be32 __iomem *mode =3D &mpc8xxx_spi->base=
->mode;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regval =3D cs->hw_mode;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Turn off IRQs locally to minimize time
> @@ -297,22 +297,22 @@ int mpc83xx_spi_setup_transfer(struct spi_device *s=
pi, struct spi_transfer *t)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local_irq_save(flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Turn off SPI unit prior changing mode *=
/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi_write_reg(mode, regval & ~SPMOD=
E_ENABLE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi_write_reg(mode, regval);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi_write_reg(mode, regval & ~SPMOD=
E_ENABLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi_write_reg(mode, regval);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local_irq_restore(flags);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int mpc83xx_spi_bufs(struct spi_device *spi, struct spi_transfer =
*t)
> +static int mpc8xxx_spi_bufs(struct spi_device *spi, struct spi_transfer =
*t)
> =A0{
> - =A0 =A0 =A0 struct mpc83xx_spi *mpc83xx_spi;
> + =A0 =A0 =A0 struct mpc8xxx_spi *mpc8xxx_spi;
> =A0 =A0 =A0 =A0u32 word, len, bits_per_word;
>
> - =A0 =A0 =A0 mpc83xx_spi =3D spi_master_get_devdata(spi->master);
> + =A0 =A0 =A0 mpc8xxx_spi =3D spi_master_get_devdata(spi->master);
>
> - =A0 =A0 =A0 mpc83xx_spi->tx =3D t->tx_buf;
> - =A0 =A0 =A0 mpc83xx_spi->rx =3D t->rx_buf;
> + =A0 =A0 =A0 mpc8xxx_spi->tx =3D t->tx_buf;
> + =A0 =A0 =A0 mpc8xxx_spi->rx =3D t->rx_buf;
> =A0 =A0 =A0 =A0bits_per_word =3D spi->bits_per_word;
> =A0 =A0 =A0 =A0if (t->bits_per_word)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bits_per_word =3D t->bits_per_word;
> @@ -329,26 +329,26 @@ static int mpc83xx_spi_bufs(struct spi_device *spi,=
 struct spi_transfer *t)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len /=3D 2;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 mpc83xx_spi->count =3D len;
> + =A0 =A0 =A0 mpc8xxx_spi->count =3D len;
>
> - =A0 =A0 =A0 INIT_COMPLETION(mpc83xx_spi->done);
> + =A0 =A0 =A0 INIT_COMPLETION(mpc8xxx_spi->done);
>
> =A0 =A0 =A0 =A0/* enable rx ints */
> - =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, SPIM_NE);
> + =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->mask, SPIM_NE);
>
> =A0 =A0 =A0 =A0/* transmit word */
> - =A0 =A0 =A0 word =3D mpc83xx_spi->get_tx(mpc83xx_spi);
> - =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->transmit, word);
> + =A0 =A0 =A0 word =3D mpc8xxx_spi->get_tx(mpc8xxx_spi);
> + =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->transmit, word);
>
> - =A0 =A0 =A0 wait_for_completion(&mpc83xx_spi->done);
> + =A0 =A0 =A0 wait_for_completion(&mpc8xxx_spi->done);
>
> =A0 =A0 =A0 =A0/* disable rx ints */
> - =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, 0);
> + =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->mask, 0);
>
> - =A0 =A0 =A0 return mpc83xx_spi->count;
> + =A0 =A0 =A0 return mpc8xxx_spi->count;
> =A0}
>
> -static void mpc83xx_spi_do_one_msg(struct spi_message *m)
> +static void mpc8xxx_spi_do_one_msg(struct spi_message *m)
> =A0{
> =A0 =A0 =A0 =A0struct spi_device *spi =3D m->spi;
> =A0 =A0 =A0 =A0struct spi_transfer *t;
> @@ -364,18 +364,18 @@ static void mpc83xx_spi_do_one_msg(struct spi_messa=
ge *m)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EINVAL;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cs_change)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
mpc83xx_spi_setup_transfer(spi, t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
mpc8xxx_spi_setup_transfer(spi, t);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (status < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cs_change) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi_chipselect(spi,=
 BITBANG_CS_ACTIVE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi_chipselect(spi,=
 BITBANG_CS_ACTIVE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ndelay(nsecs);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs_change =3D t->cs_change;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (t->len)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D mpc83xx_spi_bufs=
(spi, t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D mpc8xxx_spi_bufs=
(spi, t);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (status) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -EMSGSIZE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -387,7 +387,7 @@ static void mpc83xx_spi_do_one_msg(struct spi_message=
 *m)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cs_change) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ndelay(nsecs);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi_chipselect(spi,=
 BITBANG_CS_INACTIVE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi_chipselect(spi,=
 BITBANG_CS_INACTIVE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ndelay(nsecs);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> @@ -397,42 +397,42 @@ static void mpc83xx_spi_do_one_msg(struct spi_messa=
ge *m)
>
> =A0 =A0 =A0 =A0if (status || !cs_change) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ndelay(nsecs);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi_chipselect(spi, BITBANG_CS_INAC=
TIVE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi_chipselect(spi, BITBANG_CS_INAC=
TIVE);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mpc83xx_spi_setup_transfer(spi, NULL);
> + =A0 =A0 =A0 mpc8xxx_spi_setup_transfer(spi, NULL);
> =A0}
>
> -static void mpc83xx_spi_work(struct work_struct *work)
> +static void mpc8xxx_spi_work(struct work_struct *work)
> =A0{
> - =A0 =A0 =A0 struct mpc83xx_spi *mpc83xx_spi =3D container_of(work, stru=
ct mpc83xx_spi,
> + =A0 =A0 =A0 struct mpc8xxx_spi *mpc8xxx_spi =3D container_of(work, stru=
ct mpc8xxx_spi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 work);
>
> - =A0 =A0 =A0 spin_lock_irq(&mpc83xx_spi->lock);
> - =A0 =A0 =A0 while (!list_empty(&mpc83xx_spi->queue)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_message *m =3D container_of(mpc8=
3xx_spi->queue.next,
> + =A0 =A0 =A0 spin_lock_irq(&mpc8xxx_spi->lock);
> + =A0 =A0 =A0 while (!list_empty(&mpc8xxx_spi->queue)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_message *m =3D container_of(mpc8=
xxx_spi->queue.next,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_message, queue);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_del_init(&m->queue);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&mpc83xx_spi->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&mpc8xxx_spi->lock);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi_do_one_msg(m);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi_do_one_msg(m);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&mpc83xx_spi->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&mpc8xxx_spi->lock);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 spin_unlock_irq(&mpc83xx_spi->lock);
> + =A0 =A0 =A0 spin_unlock_irq(&mpc8xxx_spi->lock);
> =A0}
>
> =A0/* the spi->mode bits understood by this driver: */
> =A0#define MODEBITS =A0 =A0 =A0 (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| SPI_LSB_FIRST | SPI_LOOP=
)
>
> -static int mpc83xx_spi_setup(struct spi_device *spi)
> +static int mpc8xxx_spi_setup(struct spi_device *spi)
> =A0{
> - =A0 =A0 =A0 struct mpc83xx_spi *mpc83xx_spi;
> + =A0 =A0 =A0 struct mpc8xxx_spi *mpc8xxx_spi;
> =A0 =A0 =A0 =A0int retval;
> =A0 =A0 =A0 =A0u32 hw_mode;
> - =A0 =A0 =A0 struct spi_mpc83xx_cs =A0 *cs =3D spi->controller_state;
> + =A0 =A0 =A0 struct spi_mpc8xxx_cs =A0 *cs =3D spi->controller_state;
>
> =A0 =A0 =A0 =A0if (spi->mode & ~MODEBITS) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&spi->dev, "setup: unsupported mod=
e bits %x\n",
> @@ -449,13 +449,13 @@ static int mpc83xx_spi_setup(struct spi_device *spi=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi->controller_state =3D cs;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 mpc83xx_spi =3D spi_master_get_devdata(spi->master);
> + =A0 =A0 =A0 mpc8xxx_spi =3D spi_master_get_devdata(spi->master);
>
> =A0 =A0 =A0 =A0if (!spi->bits_per_word)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi->bits_per_word =3D 8;
>
> =A0 =A0 =A0 =A0hw_mode =3D cs->hw_mode; /* Save orginal settings */
> - =A0 =A0 =A0 cs->hw_mode =3D mpc83xx_spi_read_reg(&mpc83xx_spi->base->mo=
de);
> + =A0 =A0 =A0 cs->hw_mode =3D mpc8xxx_spi_read_reg(&mpc8xxx_spi->base->mo=
de);
> =A0 =A0 =A0 =A0/* mask out bits we are going to set */
> =A0 =A0 =A0 =A0cs->hw_mode &=3D ~(SPMODE_CP_BEGIN_EDGECLK | SPMODE_CI_INA=
CTIVEHIGH
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPMODE_REV | SPMODE_LOO=
P);
> @@ -469,7 +469,7 @@ static int mpc83xx_spi_setup(struct spi_device *spi)
> =A0 =A0 =A0 =A0if (spi->mode & SPI_LOOP)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->hw_mode |=3D SPMODE_LOOP;
>
> - =A0 =A0 =A0 retval =3D mpc83xx_spi_setup_transfer(spi, NULL);
> + =A0 =A0 =A0 retval =3D mpc8xxx_spi_setup_transfer(spi, NULL);
> =A0 =A0 =A0 =A0if (retval < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->hw_mode =3D hw_mode; /* Restore settin=
gs */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return retval;
> @@ -481,21 +481,21 @@ static int mpc83xx_spi_setup(struct spi_device *spi=
)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static irqreturn_t mpc83xx_spi_irq(s32 irq, void *context_data)
> +static irqreturn_t mpc8xxx_spi_irq(s32 irq, void *context_data)
> =A0{
> - =A0 =A0 =A0 struct mpc83xx_spi *mpc83xx_spi =3D context_data;
> + =A0 =A0 =A0 struct mpc8xxx_spi *mpc8xxx_spi =3D context_data;
> =A0 =A0 =A0 =A0u32 event;
> =A0 =A0 =A0 =A0irqreturn_t ret =3D IRQ_NONE;
>
> =A0 =A0 =A0 =A0/* Get interrupt events(tx/rx) */
> - =A0 =A0 =A0 event =3D mpc83xx_spi_read_reg(&mpc83xx_spi->base->event);
> + =A0 =A0 =A0 event =3D mpc8xxx_spi_read_reg(&mpc8xxx_spi->base->event);
>
> =A0 =A0 =A0 =A0/* We need handle RX first */
> =A0 =A0 =A0 =A0if (event & SPIE_NE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 rx_data =3D mpc83xx_spi_read_reg(&mpc83=
xx_spi->base->receive);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 rx_data =3D mpc8xxx_spi_read_reg(&mpc8x=
xx_spi->base->receive);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc83xx_spi->rx)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi->get_rx(rx_data=
, mpc83xx_spi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mpc8xxx_spi->rx)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi->get_rx(rx_data=
, mpc8xxx_spi);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D IRQ_HANDLED;
> =A0 =A0 =A0 =A0}
> @@ -503,56 +503,56 @@ static irqreturn_t mpc83xx_spi_irq(s32 irq, void *c=
ontext_data)
> =A0 =A0 =A0 =A0if ((event & SPIE_NF) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* spin until TX is done */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (((event =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc83xx_spi_read_reg(&mp=
c83xx_spi->base->event)) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc8xxx_spi_read_reg(&mp=
c8xxx_spi->base->event)) &
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0SPIE_NF) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
>
> - =A0 =A0 =A0 mpc83xx_spi->count -=3D 1;
> - =A0 =A0 =A0 if (mpc83xx_spi->count) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 word =3D mpc83xx_spi->get_tx(mpc83xx_sp=
i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->t=
ransmit, word);
> + =A0 =A0 =A0 mpc8xxx_spi->count -=3D 1;
> + =A0 =A0 =A0 if (mpc8xxx_spi->count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 word =3D mpc8xxx_spi->get_tx(mpc8xxx_sp=
i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->t=
ransmit, word);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&mpc83xx_spi->done);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&mpc8xxx_spi->done);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Clear the events */
> - =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->event, event);
> + =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->event, event);
>
> =A0 =A0 =A0 =A0return ret;
> =A0}
> -static int mpc83xx_spi_transfer(struct spi_device *spi,
> +static int mpc8xxx_spi_transfer(struct spi_device *spi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct spi=
_message *m)
> =A0{
> - =A0 =A0 =A0 struct mpc83xx_spi *mpc83xx_spi =3D spi_master_get_devdata(=
spi->master);
> + =A0 =A0 =A0 struct mpc8xxx_spi *mpc8xxx_spi =3D spi_master_get_devdata(=
spi->master);
> =A0 =A0 =A0 =A0unsigned long flags;
>
> =A0 =A0 =A0 =A0m->actual_length =3D 0;
> =A0 =A0 =A0 =A0m->status =3D -EINPROGRESS;
>
> - =A0 =A0 =A0 spin_lock_irqsave(&mpc83xx_spi->lock, flags);
> - =A0 =A0 =A0 list_add_tail(&m->queue, &mpc83xx_spi->queue);
> - =A0 =A0 =A0 queue_work(mpc83xx_spi->workqueue, &mpc83xx_spi->work);
> - =A0 =A0 =A0 spin_unlock_irqrestore(&mpc83xx_spi->lock, flags);
> + =A0 =A0 =A0 spin_lock_irqsave(&mpc8xxx_spi->lock, flags);
> + =A0 =A0 =A0 list_add_tail(&m->queue, &mpc8xxx_spi->queue);
> + =A0 =A0 =A0 queue_work(mpc8xxx_spi->workqueue, &mpc8xxx_spi->work);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&mpc8xxx_spi->lock, flags);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
>
> -static void mpc83xx_spi_cleanup(struct spi_device *spi)
> +static void mpc8xxx_spi_cleanup(struct spi_device *spi)
> =A0{
> =A0 =A0 =A0 =A0kfree(spi->controller_state);
> =A0}
>
> =A0static struct spi_master * __devinit
> -mpc83xx_spi_probe(struct device *dev, struct resource *mem, unsigned int=
 irq)
> +mpc8xxx_spi_probe(struct device *dev, struct resource *mem, unsigned int=
 irq)
> =A0{
> =A0 =A0 =A0 =A0struct fsl_spi_platform_data *pdata =3D dev->platform_data=
;
> =A0 =A0 =A0 =A0struct spi_master *master;
> - =A0 =A0 =A0 struct mpc83xx_spi *mpc83xx_spi;
> + =A0 =A0 =A0 struct mpc8xxx_spi *mpc8xxx_spi;
> =A0 =A0 =A0 =A0u32 regval;
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> - =A0 =A0 =A0 master =3D spi_alloc_master(dev, sizeof(struct mpc83xx_spi)=
);
> + =A0 =A0 =A0 master =3D spi_alloc_master(dev, sizeof(struct mpc8xxx_spi)=
);
> =A0 =A0 =A0 =A0if (master =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> @@ -560,36 +560,36 @@ mpc83xx_spi_probe(struct device *dev, struct resour=
ce *mem, unsigned int irq)
>
> =A0 =A0 =A0 =A0dev_set_drvdata(dev, master);
>
> - =A0 =A0 =A0 master->setup =3D mpc83xx_spi_setup;
> - =A0 =A0 =A0 master->transfer =3D mpc83xx_spi_transfer;
> - =A0 =A0 =A0 master->cleanup =3D mpc83xx_spi_cleanup;
> -
> - =A0 =A0 =A0 mpc83xx_spi =3D spi_master_get_devdata(master);
> - =A0 =A0 =A0 mpc83xx_spi->qe_mode =3D pdata->qe_mode;
> - =A0 =A0 =A0 mpc83xx_spi->get_rx =3D mpc83xx_spi_rx_buf_u8;
> - =A0 =A0 =A0 mpc83xx_spi->get_tx =3D mpc83xx_spi_tx_buf_u8;
> - =A0 =A0 =A0 mpc83xx_spi->spibrg =3D pdata->sysclk;
> -
> - =A0 =A0 =A0 mpc83xx_spi->rx_shift =3D 0;
> - =A0 =A0 =A0 mpc83xx_spi->tx_shift =3D 0;
> - =A0 =A0 =A0 if (mpc83xx_spi->qe_mode) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi->rx_shift =3D 16;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc83xx_spi->tx_shift =3D 24;
> + =A0 =A0 =A0 master->setup =3D mpc8xxx_spi_setup;
> + =A0 =A0 =A0 master->transfer =3D mpc8xxx_spi_transfer;
> + =A0 =A0 =A0 master->cleanup =3D mpc8xxx_spi_cleanup;
> +
> + =A0 =A0 =A0 mpc8xxx_spi =3D spi_master_get_devdata(master);
> + =A0 =A0 =A0 mpc8xxx_spi->qe_mode =3D pdata->qe_mode;
> + =A0 =A0 =A0 mpc8xxx_spi->get_rx =3D mpc8xxx_spi_rx_buf_u8;
> + =A0 =A0 =A0 mpc8xxx_spi->get_tx =3D mpc8xxx_spi_tx_buf_u8;
> + =A0 =A0 =A0 mpc8xxx_spi->spibrg =3D pdata->sysclk;
> +
> + =A0 =A0 =A0 mpc8xxx_spi->rx_shift =3D 0;
> + =A0 =A0 =A0 mpc8xxx_spi->tx_shift =3D 0;
> + =A0 =A0 =A0 if (mpc8xxx_spi->qe_mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi->rx_shift =3D 16;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_spi->tx_shift =3D 24;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 init_completion(&mpc83xx_spi->done);
> + =A0 =A0 =A0 init_completion(&mpc8xxx_spi->done);
>
> - =A0 =A0 =A0 mpc83xx_spi->base =3D ioremap(mem->start, mem->end - mem->s=
tart + 1);
> - =A0 =A0 =A0 if (mpc83xx_spi->base =3D=3D NULL) {
> + =A0 =A0 =A0 mpc8xxx_spi->base =3D ioremap(mem->start, mem->end - mem->s=
tart + 1);
> + =A0 =A0 =A0 if (mpc8xxx_spi->base =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto put_master;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mpc83xx_spi->irq =3D irq;
> + =A0 =A0 =A0 mpc8xxx_spi->irq =3D irq;
>
> =A0 =A0 =A0 =A0/* Register for SPI Interrupt */
> - =A0 =A0 =A0 ret =3D request_irq(mpc83xx_spi->irq, mpc83xx_spi_irq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, "mpc83xx_spi", mpc83=
xx_spi);
> + =A0 =A0 =A0 ret =3D request_irq(mpc8xxx_spi->irq, mpc8xxx_spi_irq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, "mpc8xxx_spi", mpc8x=
xx_spi);
>
> =A0 =A0 =A0 =A0if (ret !=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unmap_io;
> @@ -598,25 +598,25 @@ mpc83xx_spi_probe(struct device *dev, struct resour=
ce *mem, unsigned int irq)
> =A0 =A0 =A0 =A0master->num_chipselect =3D pdata->max_chipselect;
>
> =A0 =A0 =A0 =A0/* SPI controller initializations */
> - =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, 0);
> - =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, 0);
> - =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->command, 0);
> - =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->event, 0xffffffff=
);
> + =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->mode, 0);
> + =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->mask, 0);
> + =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->command, 0);
> + =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->event, 0xffffffff=
);
>
> =A0 =A0 =A0 =A0/* Enable SPI interface */
> =A0 =A0 =A0 =A0regval =3D pdata->initial_spmode | SPMODE_INIT_VAL | SPMOD=
E_ENABLE;
> =A0 =A0 =A0 =A0if (pdata->qe_mode)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regval |=3D SPMODE_OP;
>
> - =A0 =A0 =A0 mpc83xx_spi_write_reg(&mpc83xx_spi->base->mode, regval);
> - =A0 =A0 =A0 spin_lock_init(&mpc83xx_spi->lock);
> - =A0 =A0 =A0 init_completion(&mpc83xx_spi->done);
> - =A0 =A0 =A0 INIT_WORK(&mpc83xx_spi->work, mpc83xx_spi_work);
> - =A0 =A0 =A0 INIT_LIST_HEAD(&mpc83xx_spi->queue);
> + =A0 =A0 =A0 mpc8xxx_spi_write_reg(&mpc8xxx_spi->base->mode, regval);
> + =A0 =A0 =A0 spin_lock_init(&mpc8xxx_spi->lock);
> + =A0 =A0 =A0 init_completion(&mpc8xxx_spi->done);
> + =A0 =A0 =A0 INIT_WORK(&mpc8xxx_spi->work, mpc8xxx_spi_work);
> + =A0 =A0 =A0 INIT_LIST_HEAD(&mpc8xxx_spi->queue);
>
> - =A0 =A0 =A0 mpc83xx_spi->workqueue =3D create_singlethread_workqueue(
> + =A0 =A0 =A0 mpc8xxx_spi->workqueue =3D create_singlethread_workqueue(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(master->dev.parent));
> - =A0 =A0 =A0 if (mpc83xx_spi->workqueue =3D=3D NULL) {
> + =A0 =A0 =A0 if (mpc8xxx_spi->workqueue =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EBUSY;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_irq;
> =A0 =A0 =A0 =A0}
> @@ -626,57 +626,57 @@ mpc83xx_spi_probe(struct device *dev, struct resour=
ce *mem, unsigned int irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto unreg_master;
>
> =A0 =A0 =A0 =A0printk(KERN_INFO
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: MPC83xx SPI Controller driver at 0x%p (=
irq =3D %d)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(dev), mpc83xx_spi->base, mpc83xx_sp=
i->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s: MPC8xxx SPI Controller driver at 0x%p (=
irq =3D %d)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(dev), mpc8xxx_spi->base, mpc8xxx_sp=
i->irq);
>
> =A0 =A0 =A0 =A0return master;
>
> =A0unreg_master:
> - =A0 =A0 =A0 destroy_workqueue(mpc83xx_spi->workqueue);
> + =A0 =A0 =A0 destroy_workqueue(mpc8xxx_spi->workqueue);
> =A0free_irq:
> - =A0 =A0 =A0 free_irq(mpc83xx_spi->irq, mpc83xx_spi);
> + =A0 =A0 =A0 free_irq(mpc8xxx_spi->irq, mpc8xxx_spi);
> =A0unmap_io:
> - =A0 =A0 =A0 iounmap(mpc83xx_spi->base);
> + =A0 =A0 =A0 iounmap(mpc8xxx_spi->base);
> =A0put_master:
> =A0 =A0 =A0 =A0spi_master_put(master);
> =A0err:
> =A0 =A0 =A0 =A0return ERR_PTR(ret);
> =A0}
>
> -static int __devexit mpc83xx_spi_remove(struct device *dev)
> +static int __devexit mpc8xxx_spi_remove(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct mpc83xx_spi *mpc83xx_spi;
> + =A0 =A0 =A0 struct mpc8xxx_spi *mpc8xxx_spi;
> =A0 =A0 =A0 =A0struct spi_master *master;
>
> =A0 =A0 =A0 =A0master =3D dev_get_drvdata(dev);
> - =A0 =A0 =A0 mpc83xx_spi =3D spi_master_get_devdata(master);
> + =A0 =A0 =A0 mpc8xxx_spi =3D spi_master_get_devdata(master);
>
> - =A0 =A0 =A0 flush_workqueue(mpc83xx_spi->workqueue);
> - =A0 =A0 =A0 destroy_workqueue(mpc83xx_spi->workqueue);
> + =A0 =A0 =A0 flush_workqueue(mpc8xxx_spi->workqueue);
> + =A0 =A0 =A0 destroy_workqueue(mpc8xxx_spi->workqueue);
> =A0 =A0 =A0 =A0spi_unregister_master(master);
>
> - =A0 =A0 =A0 free_irq(mpc83xx_spi->irq, mpc83xx_spi);
> - =A0 =A0 =A0 iounmap(mpc83xx_spi->base);
> + =A0 =A0 =A0 free_irq(mpc8xxx_spi->irq, mpc8xxx_spi);
> + =A0 =A0 =A0 iounmap(mpc8xxx_spi->base);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -struct mpc83xx_spi_probe_info {
> +struct mpc8xxx_spi_probe_info {
> =A0 =A0 =A0 =A0struct fsl_spi_platform_data pdata;
> =A0 =A0 =A0 =A0int *gpios;
> =A0 =A0 =A0 =A0bool *alow_flags;
> =A0};
>
> -static struct mpc83xx_spi_probe_info *
> +static struct mpc8xxx_spi_probe_info *
> =A0to_of_pinfo(struct fsl_spi_platform_data *pdata)
> =A0{
> - =A0 =A0 =A0 return container_of(pdata, struct mpc83xx_spi_probe_info, p=
data);
> + =A0 =A0 =A0 return container_of(pdata, struct mpc8xxx_spi_probe_info, p=
data);
> =A0}
>
> -static void mpc83xx_spi_cs_control(struct spi_device *spi, bool on)
> +static void mpc8xxx_spi_cs_control(struct spi_device *spi, bool on)
> =A0{
> =A0 =A0 =A0 =A0struct device *dev =3D spi->dev.parent;
> - =A0 =A0 =A0 struct mpc83xx_spi_probe_info *pinfo =3D to_of_pinfo(dev->p=
latform_data);
> + =A0 =A0 =A0 struct mpc8xxx_spi_probe_info *pinfo =3D to_of_pinfo(dev->p=
latform_data);
> =A0 =A0 =A0 =A0u16 cs =3D spi->chip_select;
> =A0 =A0 =A0 =A0int gpio =3D pinfo->gpios[cs];
> =A0 =A0 =A0 =A0bool alow =3D pinfo->alow_flags[cs];
> @@ -684,11 +684,11 @@ static void mpc83xx_spi_cs_control(struct spi_devic=
e *spi, bool on)
> =A0 =A0 =A0 =A0gpio_set_value(gpio, on ^ alow);
> =A0}
>
> -static int of_mpc83xx_spi_get_chipselects(struct device *dev)
> +static int of_mpc8xxx_spi_get_chipselects(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *np =3D dev_archdata_get_node(&dev->arc=
hdata);
> =A0 =A0 =A0 =A0struct fsl_spi_platform_data *pdata =3D dev->platform_data=
;
> - =A0 =A0 =A0 struct mpc83xx_spi_probe_info *pinfo =3D to_of_pinfo(pdata)=
;
> + =A0 =A0 =A0 struct mpc8xxx_spi_probe_info *pinfo =3D to_of_pinfo(pdata)=
;
> =A0 =A0 =A0 =A0unsigned int ngpios;
> =A0 =A0 =A0 =A0int i =3D 0;
> =A0 =A0 =A0 =A0int ret;
> @@ -744,7 +744,7 @@ static int of_mpc83xx_spi_get_chipselects(struct devi=
ce *dev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0pdata->max_chipselect =3D ngpios;
> - =A0 =A0 =A0 pdata->cs_control =3D mpc83xx_spi_cs_control;
> + =A0 =A0 =A0 pdata->cs_control =3D mpc8xxx_spi_cs_control;
>
> =A0 =A0 =A0 =A0return 0;
>
> @@ -763,10 +763,10 @@ err_alloc_flags:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static int of_mpc83xx_spi_free_chipselects(struct device *dev)
> +static int of_mpc8xxx_spi_free_chipselects(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct fsl_spi_platform_data *pdata =3D dev->platform_data=
;
> - =A0 =A0 =A0 struct mpc83xx_spi_probe_info *pinfo =3D to_of_pinfo(pdata)=
;
> + =A0 =A0 =A0 struct mpc8xxx_spi_probe_info *pinfo =3D to_of_pinfo(pdata)=
;
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0if (!pinfo->gpios)
> @@ -782,12 +782,12 @@ static int of_mpc83xx_spi_free_chipselects(struct d=
evice *dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int __devinit of_mpc83xx_spi_probe(struct of_device *ofdev,
> +static int __devinit of_mpc8xxx_spi_probe(struct of_device *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0const struct of_device_id *ofid)
> =A0{
> =A0 =A0 =A0 =A0struct device *dev =3D &ofdev->dev;
> =A0 =A0 =A0 =A0struct device_node *np =3D ofdev->node;
> - =A0 =A0 =A0 struct mpc83xx_spi_probe_info *pinfo;
> + =A0 =A0 =A0 struct mpc8xxx_spi_probe_info *pinfo;
> =A0 =A0 =A0 =A0struct fsl_spi_platform_data *pdata;
> =A0 =A0 =A0 =A0struct spi_master *master;
> =A0 =A0 =A0 =A0struct resource mem;
> @@ -819,7 +819,7 @@ static int __devinit of_mpc83xx_spi_probe(struct of_d=
evice *ofdev,
> =A0 =A0 =A0 =A0if (prop && !strcmp(prop, "cpu-qe"))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->qe_mode =3D 1;
>
> - =A0 =A0 =A0 ret =3D of_mpc83xx_spi_get_chipselects(dev);
> + =A0 =A0 =A0 ret =3D of_mpc8xxx_spi_get_chipselects(dev);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
>
> @@ -833,7 +833,7 @@ static int __devinit of_mpc83xx_spi_probe(struct of_d=
evice *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 master =3D mpc83xx_spi_probe(dev, &mem, irq.start);
> + =A0 =A0 =A0 master =3D mpc8xxx_spi_probe(dev, &mem, irq.start);
> =A0 =A0 =A0 =A0if (IS_ERR(master)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(master);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> @@ -844,34 +844,34 @@ static int __devinit of_mpc83xx_spi_probe(struct of=
_device *ofdev,
> =A0 =A0 =A0 =A0return 0;
>
> =A0err:
> - =A0 =A0 =A0 of_mpc83xx_spi_free_chipselects(dev);
> + =A0 =A0 =A0 of_mpc8xxx_spi_free_chipselects(dev);
> =A0err_clk:
> =A0 =A0 =A0 =A0kfree(pinfo);
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static int __devexit of_mpc83xx_spi_remove(struct of_device *ofdev)
> +static int __devexit of_mpc8xxx_spi_remove(struct of_device *ofdev)
> =A0{
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 ret =3D mpc83xx_spi_remove(&ofdev->dev);
> + =A0 =A0 =A0 ret =3D mpc8xxx_spi_remove(&ofdev->dev);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> - =A0 =A0 =A0 of_mpc83xx_spi_free_chipselects(&ofdev->dev);
> + =A0 =A0 =A0 of_mpc8xxx_spi_free_chipselects(&ofdev->dev);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static const struct of_device_id of_mpc83xx_spi_match[] =3D {
> +static const struct of_device_id of_mpc8xxx_spi_match[] =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,spi" },
> =A0 =A0 =A0 =A0{},
> =A0};
> -MODULE_DEVICE_TABLE(of, of_mpc83xx_spi_match);
> +MODULE_DEVICE_TABLE(of, of_mpc8xxx_spi_match);
>
> -static struct of_platform_driver of_mpc83xx_spi_driver =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mpc83xx_spi",
> - =A0 =A0 =A0 .match_table =A0 =A0=3D of_mpc83xx_spi_match,
> - =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D of_mpc83xx_spi_probe,
> - =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(of_mpc83xx_spi_remo=
ve),
> +static struct of_platform_driver of_mpc8xxx_spi_driver =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mpc8xxx_spi",
> + =A0 =A0 =A0 .match_table =A0 =A0=3D of_mpc8xxx_spi_match,
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D of_mpc8xxx_spi_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(of_mpc8xxx_spi_remo=
ve),
> =A0};
>
> =A0#ifdef CONFIG_MPC832x_RDB
> @@ -882,7 +882,7 @@ static struct of_platform_driver of_mpc83xx_spi_drive=
r =3D {
> =A0* tree can work with OpenFirmware driver. But for now we support old t=
rees
> =A0* as well.
> =A0*/
> -static int __devinit plat_mpc83xx_spi_probe(struct platform_device *pdev=
)
> +static int __devinit plat_mpc8xxx_spi_probe(struct platform_device *pdev=
)
> =A0{
> =A0 =A0 =A0 =A0struct resource *mem;
> =A0 =A0 =A0 =A0unsigned int irq;
> @@ -899,21 +899,21 @@ static int __devinit plat_mpc83xx_spi_probe(struct =
platform_device *pdev)
> =A0 =A0 =A0 =A0if (!irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 master =3D mpc83xx_spi_probe(&pdev->dev, mem, irq);
> + =A0 =A0 =A0 master =3D mpc8xxx_spi_probe(&pdev->dev, mem, irq);
> =A0 =A0 =A0 =A0if (IS_ERR(master))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(master);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int __devexit plat_mpc83xx_spi_remove(struct platform_device *pde=
v)
> +static int __devexit plat_mpc8xxx_spi_remove(struct platform_device *pde=
v)
> =A0{
> - =A0 =A0 =A0 return mpc83xx_spi_remove(&pdev->dev);
> + =A0 =A0 =A0 return mpc8xxx_spi_remove(&pdev->dev);
> =A0}
>
> =A0MODULE_ALIAS("platform:mpc83xx_spi");
> -static struct platform_driver mpc83xx_spi_driver =3D {
> - =A0 =A0 =A0 .probe =3D plat_mpc83xx_spi_probe,
> - =A0 =A0 =A0 .remove =3D __exit_p(plat_mpc83xx_spi_remove),
> +static struct platform_driver mpc8xxx_spi_driver =3D {
> + =A0 =A0 =A0 .probe =3D plat_mpc8xxx_spi_probe,
> + =A0 =A0 =A0 .remove =3D __exit_p(plat_mpc8xxx_spi_remove),
> =A0 =A0 =A0 =A0.driver =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "mpc83xx_spi",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> @@ -924,35 +924,35 @@ static bool legacy_driver_failed;
>
> =A0static void __init legacy_driver_register(void)
> =A0{
> - =A0 =A0 =A0 legacy_driver_failed =3D platform_driver_register(&mpc83xx_=
spi_driver);
> + =A0 =A0 =A0 legacy_driver_failed =3D platform_driver_register(&mpc8xxx_=
spi_driver);
> =A0}
>
> =A0static void __exit legacy_driver_unregister(void)
> =A0{
> =A0 =A0 =A0 =A0if (legacy_driver_failed)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> - =A0 =A0 =A0 platform_driver_unregister(&mpc83xx_spi_driver);
> + =A0 =A0 =A0 platform_driver_unregister(&mpc8xxx_spi_driver);
> =A0}
> =A0#else
> =A0static void __init legacy_driver_register(void) {}
> =A0static void __exit legacy_driver_unregister(void) {}
> =A0#endif /* CONFIG_MPC832x_RDB */
>
> -static int __init mpc83xx_spi_init(void)
> +static int __init mpc8xxx_spi_init(void)
> =A0{
> =A0 =A0 =A0 =A0legacy_driver_register();
> - =A0 =A0 =A0 return of_register_platform_driver(&of_mpc83xx_spi_driver);
> + =A0 =A0 =A0 return of_register_platform_driver(&of_mpc8xxx_spi_driver);
> =A0}
>
> -static void __exit mpc83xx_spi_exit(void)
> +static void __exit mpc8xxx_spi_exit(void)
> =A0{
> - =A0 =A0 =A0 of_unregister_platform_driver(&of_mpc83xx_spi_driver);
> + =A0 =A0 =A0 of_unregister_platform_driver(&of_mpc8xxx_spi_driver);
> =A0 =A0 =A0 =A0legacy_driver_unregister();
> =A0}
>
> -module_init(mpc83xx_spi_init);
> -module_exit(mpc83xx_spi_exit);
> +module_init(mpc8xxx_spi_init);
> +module_exit(mpc8xxx_spi_exit);
>
> =A0MODULE_AUTHOR("Kumar Gala");
> -MODULE_DESCRIPTION("Simple MPC83xx SPI Driver");
> +MODULE_DESCRIPTION("Simple MPC8xxx SPI Driver");
> =A0MODULE_LICENSE("GPL");
> --
> 1.6.2.2
>
> -------------------------------------------------------------------------=
-----
> Register Now & Save for Velocity, the Web Performance & Operations
> Conference from O'Reilly Media. Velocity features a full day of
> expert-led, hands-on workshops and two days of sessions from industry
> leaders in dedicated Performance & Operations tracks. Use code vel09scf
> and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
