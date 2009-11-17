Return-Path: <l.fu@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 14CF31007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 01:43:06 +1100 (EST)
Date: Tue, 17 Nov 2009 15:43:00 +0100
From: Luotao Fu <l.fu@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] spi/mpc52xx-spi: cleanups
Message-ID: <20091117144300.GB4850@pengutronix.de>
References: <1258468268-9911-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
In-Reply-To: <1258468268-9911-1-git-send-email-w.sang@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net, Luotao Fu <l.fu@pengutronix.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2009 at 03:31:08PM +0100, Wolfram Sang wrote:
> - drop own, obsolete include-file
> - drop IRQF_SAMPLE_RANDOM (deprecated feature)
> - drop 'if' above kfree()
> - typos, braces & whitespaces
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Luotao Fu <l.fu@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>

acked-by: Luotao Fu <l.fu@pengutronix.de>

minor comments see below,

> ---
>=20
> This goes ontop of Grant's test-branch.
>=20
>  drivers/spi/mpc52xx_spi.c       |   24 ++++++++++--------------
>  include/linux/spi/mpc52xx_spi.h |   10 ----------
>  2 files changed, 10 insertions(+), 24 deletions(-)
>  delete mode 100644 include/linux/spi/mpc52xx_spi.h
>=20
> diff --git a/drivers/spi/mpc52xx_spi.c b/drivers/spi/mpc52xx_spi.c
> index 97beba2..7f4089c 100644
> --- a/drivers/spi/mpc52xx_spi.c
> +++ b/drivers/spi/mpc52xx_spi.c
> @@ -18,7 +18,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/spi/spi.h>
> -#include <linux/spi/mpc52xx_spi.h>
>  #include <linux/of_spi.h>
>  #include <linux/io.h>
>  #include <linux/of_gpio.h>
> @@ -54,7 +53,7 @@ MODULE_LICENSE("GPL");
>  /* FSM state return values */
>  #define FSM_STOP	0	/* Nothing more for the state machine to */
>  				/* do.  If something interesting happens */
> -				/* then and IRQ will be received */
> +				/* then an IRQ will be received */
>  #define FSM_POLL	1	/* need to poll for completion, an IRQ is */
>  				/* not expected */
>  #define FSM_CONTINUE	2	/* Keep iterating the state machine */
> @@ -62,13 +61,12 @@ MODULE_LICENSE("GPL");
>  /* Driver internal data */
>  struct mpc52xx_spi {
>  	struct spi_master *master;
> -	u32 sysclk;
>  	void __iomem *regs;
>  	int irq0;	/* MODF irq */
>  	int irq1;	/* SPIF irq */
> -	int ipb_freq;
> +	unsigned int ipb_freq;
> =20
> -	/* Statistics */
> +	/* Statistics; not used now, but will be reintroduced for debugfs */
>  	int msg_count;
>  	int wcol_count;
>  	int wcol_ticks;
> @@ -229,7 +227,7 @@ static int mpc52xx_spi_fsmstate_transfer(int irq, str=
uct mpc52xx_spi *ms,
>  		ms->wcol_tx_timestamp =3D get_tbl();
>  		data =3D 0;
>  		if (ms->tx_buf)
> -			data =3D *(ms->tx_buf-1);
> +			data =3D *(ms->tx_buf - 1);
>  		out_8(ms->regs + SPI_DATA, data); /* try again */
>  		return FSM_CONTINUE;
>  	} else if (status & SPI_STATUS_MODF) {
> @@ -481,8 +479,9 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
>  			gpio_direction_output(gpio_cs, 1);
>  			ms->gpio_cs[i] =3D gpio_cs;
>  		}
> -	} else
> +	} else {
>  		master->num_chipselect =3D 1;
> +	}
> =20
>  	spin_lock_init(&ms->lock);
>  	INIT_LIST_HEAD(&ms->queue);
> @@ -490,9 +489,9 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
> =20
>  	/* Decide if interrupts can be used */
>  	if (ms->irq0 && ms->irq1) {
> -		rc =3D request_irq(ms->irq0, mpc52xx_spi_irq, IRQF_SAMPLE_RANDOM,
> +		rc =3D request_irq(ms->irq0, mpc52xx_spi_irq, 0,
>  				  "mpc5200-spi-modf", ms);
> -		rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, IRQF_SAMPLE_RANDOM,
> +		rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, 0,
>  				  "mpc5200-spi-spiF", ms);

The "spiF" here is probably also a typo.

>  		if (rc) {
>  			free_irq(ms->irq0, ms);
> @@ -524,8 +523,7 @@ static int __devinit mpc52xx_spi_probe(struct of_devi=
ce *op,
>  	while (i-- > 0)
>  		gpio_free(ms->gpio_cs[i]);
> =20
> -	if (ms->gpio_cs !=3D NULL)
> -		kfree(ms->gpio_cs);
> +	kfree(ms->gpio_cs);
>   err_alloc:
>   err_init:
>  	iounmap(regs);
> @@ -544,9 +542,7 @@ static int __devexit mpc52xx_spi_remove(struct of_dev=
ice *op)
>  	for (i =3D 0; i < ms->gpio_cs_count; i++)
>  		gpio_free(ms->gpio_cs[i]);
> =20
> -	if (ms->gpio_cs !=3D NULL)
> -		kfree(ms->gpio_cs);
> -
> +	kfree(ms->gpio_cs);
>  	spi_unregister_master(master);
>  	spi_master_put(master);
>  	iounmap(ms->regs);
> diff --git a/include/linux/spi/mpc52xx_spi.h b/include/linux/spi/mpc52xx_=
spi.h
> deleted file mode 100644
> index d1004cf..0000000
> --- a/include/linux/spi/mpc52xx_spi.h
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -
> -#ifndef INCLUDE_MPC5200_SPI_H
> -#define INCLUDE_MPC5200_SPI_H
> -
> -extern void mpc52xx_spi_set_premessage_hook(struct spi_master *master,
> -					    void (*hook)(struct spi_message *m,
> -							 void *context),
> -					    void *hook_context);
> -
> -#endif
> --=20
> 1.6.3.3
>=20

cheers
Luotao Fu
--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksCtnQACgkQkLuxfMCkDTbtigCbBXVeiLfkv0vLLPPkGnR2gcXG
5nUAn3WIgxAgCpdurdc/uIM7MeGKqFf3
=5+aS
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
