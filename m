Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id A66B9B7093
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 21:50:58 +1100 (EST)
Date: Wed, 11 Nov 2009 11:50:38 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Luotao Fu <l.fu@pengutronix.de>
Subject: Re: [spi-devel-general] [PATCH 3/3] mpc52xx_spi: add gpio chipselect
Message-ID: <20091111105038.GC4234@pengutronix.de>
References: <1257844329-20687-1-git-send-email-l.fu@pengutronix.de>
	<1257844329-20687-2-git-send-email-l.fu@pengutronix.de>
	<1257844329-20687-3-git-send-email-l.fu@pengutronix.de>
	<1257844329-20687-4-git-send-email-l.fu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
In-Reply-To: <1257844329-20687-4-git-send-email-l.fu@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2009 at 10:12:09AM +0100, Luotao Fu wrote:
> This one enables the mpc52xx_spi driver for usage of user defined gpio li=
nes
> as chipselect. This way we can control some more spi devices than only one
>=20
> Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
> ---
>  drivers/spi/mpc52xx_spi.c |   57 +++++++++++++++++++++++++++++++++++++++=
++---
>  1 files changed, 53 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
> index 79ba678..58c2ce5 100644
> --- a/drivers/spi/mpc52xx_spi.c
> +++ b/drivers/spi/mpc52xx_spi.c
> @@ -21,6 +21,7 @@
>  #include <linux/spi/mpc52xx_spi.h>
>  #include <linux/of_spi.h>
>  #include <linux/io.h>
> +#include <linux/of_gpio.h>
>  #include <asm/time.h>
>  #include <asm/mpc52xx.h>
> =20
> @@ -79,7 +80,6 @@ struct mpc52xx_spi {
>  	spinlock_t lock;
>  	struct work_struct work;
> =20
> -
>  	/* Details of current transfer (length, and buffer pointers) */
>  	struct spi_message *message;	/* current message */
>  	struct spi_transfer *transfer;	/* current transfer */
> @@ -89,6 +89,8 @@ struct mpc52xx_spi {
>  	u8 *rx_buf;
>  	const u8 *tx_buf;
>  	int cs_change;
> +	int gpio_cs_count;
> +	unsigned int *gpio_cs;
>  };
> =20
>  /*
> @@ -96,7 +98,13 @@ struct mpc52xx_spi {
>   */
>  static void mpc52xx_spi_chipsel(struct mpc52xx_spi *ms, int value)
>  {
> -	out_8(ms->regs + SPI_PORTDATA, value ? 0 : 0x08);
> +	int cs;
> +
> +	if (ms->gpio_cs_count > 0) {
> +		cs =3D ms->message->spi->chip_select;
> +		gpio_direction_output(ms->gpio_cs[cs], value);

Use gpio_set_value() in combination with...

> +	} else
> +		out_8(ms->regs + SPI_PORTDATA, value ? 0 : 0x08);
>  }
> =20
>  /*
> @@ -390,8 +398,9 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
>  	struct spi_master *master;
>  	struct mpc52xx_spi *ms;
>  	void __iomem *regs;
> -	int rc;
>  	int ctrl1;
> +	int rc, i =3D 0;
> +	int gpio_cs;
> =20
>  	/* MMIO registers */
>  	dev_dbg(&op->dev, "probing mpc5200 SPI device\n");
> @@ -426,8 +435,8 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
>  		rc =3D -ENOMEM;
>  		goto err_alloc;
>  	}
> +
>  	master->bus_num =3D -1;
> -	master->num_chipselect =3D 1;
>  	master->setup =3D mpc52xx_spi_setup;
>  	master->transfer =3D mpc52xx_spi_transfer;
>  	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
> @@ -441,6 +450,39 @@ static int __devinit mpc52xx_spi_probe(struct of_dev=
ice *op,
>  	ms->irq1 =3D irq_of_parse_and_map(op->node, 1);
>  	ms->state =3D mpc52xx_spi_fsmstate_idle;
>  	ms->ipb_freq =3D mpc5xxx_get_bus_frequency(op->node);
> +	ms->gpio_cs_count =3D of_gpio_count(op->node);
> +	if (ms->gpio_cs_count > 0) {
> +		master->num_chipselect =3D ms->gpio_cs_count;
> +		ms->gpio_cs =3D kmalloc(ms->gpio_cs_count * sizeof(unsigned int),
> +				GFP_KERNEL);
> +		if (!ms->gpio_cs) {
> +			rc =3D -ENOMEM;
> +			goto err_alloc;
> +		}
> +
> +		for (i =3D 0; i < ms->gpio_cs_count; i++) {
> +			gpio_cs =3D of_get_gpio(op->node, i);

=2E.. with of_get_gpio_flags() to avoid initialisation jitter?

> +			if (gpio_cs < 0) {
> +				dev_err(&op->dev,
> +					"could not parse the gpio field "
> +					"in oftree\n");
> +				rc =3D -ENODEV;
> +				goto err_alloc;

That should go to err_gpio and unregister the previous allocated ones.

> +			}
> +
> +			ms->gpio_cs[i] =3D gpio_cs;
> +			rc =3D gpio_request(ms->gpio_cs[i], dev_name(&op->dev));
> +			if (rc) {
> +				dev_err(&op->dev,
> +					"can't request spi cs gpio #%d "
> +					"on gpio line %d\n",
> +					i, gpio_cs);

Last two lines could become one.

> +				goto err_gpio;
> +			}
> +		}
> +	} else
> +		master->num_chipselect =3D 1;
> +
>  	spin_lock_init(&ms->lock);
>  	INIT_LIST_HEAD(&ms->queue);
>  	INIT_WORK(&ms->work, mpc52xx_spi_wq);
> @@ -477,6 +519,9 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
>   err_register:
>  	dev_err(&ms->master->dev, "initialization failed\n");
>  	spi_master_put(master);
> + err_gpio:
> +	while (i-- > 0)
> +		gpio_free(ms->gpio_cs[i]);
>   err_alloc:
>   err_init:
>  	iounmap(regs);
> @@ -487,10 +532,14 @@ static int __devexit mpc52xx_spi_remove(struct of_d=
evice *op)
>  {
>  	struct spi_master *master =3D dev_get_drvdata(&op->dev);
>  	struct mpc52xx_spi *ms =3D spi_master_get_devdata(master);
> +	int i;
> =20
>  	free_irq(ms->irq0, ms);
>  	free_irq(ms->irq1, ms);
> =20
> +	for (i =3D 0; i < ms->gpio_cs_count; i++)
> +		gpio_free(ms->gpio_cs[i]);
> +
>  	spi_unregister_master(master);
>  	spi_master_put(master);
>  	iounmap(ms->regs);
> --=20
> 1.6.5.2
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-D=
ay=20
> trial. Simplify your report design, integration and deployment - and focu=
s on=20
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkr6lv4ACgkQD27XaX1/VRvx+ACghBuRjou+tqT+RkS9WDevZYQc
+1IAoLJJk8WpsaUyZpRGrrgfXrtmi4IX
=UWDP
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
