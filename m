Return-Path: <mkl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD95EB70C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 02:18:43 +1000 (EST)
Message-ID: <4E4400CC.3020704@pengutronix.de>
Date: Thu, 11 Aug 2011 18:18:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH v11 5/6] flexcan: Prefer device tree clock frequency if
	available.
References: <1313078831-2511-1-git-send-email-holt@sgi.com>
	<1313078831-2511-6-git-send-email-holt@sgi.com>
In-Reply-To: <1313078831-2511-6-git-send-email-holt@sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F69796CAE2007D8F2EAC4EE"
Cc: socketcan-core@lists.berlios.de, netdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	U Bhaskar-B22300 <B22300@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F69796CAE2007D8F2EAC4EE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/11/2011 06:07 PM, Robin Holt wrote:
> If our CAN device's device tree node has a clock-frequency property,
> then use that value for the can devices clock frequency.  If not, fall
> back to asking the platform/mach code for the clock frequency associate=
d
> with the flexcan device.

nitpicking follows inline:

> Signed-off-by: Robin Holt <holt@sgi.com>
> To: Kumar Gala <galak@kernel.crashing.org>
> To: Wolfgang Grandegger <wg@grandegger.com>,
> To: Marc Kleine-Budde <mkl@pengutronix.de>,
> To: U Bhaskar-B22300 <B22300@freescale.com>
> To: Scott Wood <scottwood@freescale.com>
> To: Grant Likely <grant.likely@secretlab.ca>
> Cc: socketcan-core@lists.berlios.de,
> Cc: netdev@vger.kernel.org,
> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |    2 +
>  drivers/net/can/flexcan.c                          |   33 ++++++++++++=
+++-----
>  2 files changed, 27 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt =
b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index c78dcbb..a4382c7 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -11,6 +11,7 @@ Required properties:
> =20
>  - reg : Offset and length of the register set for this device
>  - interrupts : Interrupt tuple for this device
> +- clock-frequency : The oscillator frequency driving the flexcan devic=
e
> =20
>  Example:
> =20
> @@ -19,4 +20,5 @@ Example:
>            reg =3D <0x1c000 0x1000>;
>            interrupts =3D <48 0x2>;
>            interrupt-parent =3D <&mpic>;
> +          clock-frequency =3D <0x0bebc1fc>;

Does the device tree support dec coded integers? IMHO a frequency is
best expressed in decimal.


>    };
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 662f832..d40c38e 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -33,6 +33,7 @@
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> =20
>  #define DRV_NAME			"flexcan"
> @@ -929,12 +930,26 @@ static int __devinit flexcan_probe(struct platfor=
m_device *pdev)
>  	void __iomem *base;
>  	resource_size_t mem_size;
>  	int err, irq;
> +	u32 clock_freq =3D 0;
> =20
> -	clk =3D clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(clk)) {
> -		dev_err(&pdev->dev, "no clock defined\n");
> -		err =3D PTR_ERR(clk);
> -		goto failed_clock;
> +	if (pdev->dev.of_node) {
> +		const u32 *clock_freq_p;
> +
> +		clk =3D NULL;

Hmmm - what about moving the clk =3D NULL into the definition of clk?

> +		clock_freq_p =3D of_get_property(pdev->dev.of_node,
> +						"clock-frequency", NULL);
> +		if (clock_freq_p)
> +			clock_freq =3D *clock_freq_p;
> +	}
> +
> +	if (!clock_freq) {
> +		clk =3D clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(clk)) {
> +			dev_err(&pdev->dev, "no clock defined\n");
> +			err =3D PTR_ERR(clk);
> +			goto failed_clock;
> +		}
> +		clock_freq =3D clk_get_rate(clk);
>  	}
> =20
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -967,7 +982,7 @@ static int __devinit flexcan_probe(struct platform_=
device *pdev)
>  	dev->flags |=3D IFF_ECHO; /* we support local echo in hardware */
> =20
>  	priv =3D netdev_priv(dev);
> -	priv->can.clock.freq =3D clk_get_rate(clk);
> +	priv->can.clock.freq =3D clock_freq;
>  	priv->can.bittiming_const =3D &flexcan_bittiming_const;
>  	priv->can.do_set_mode =3D flexcan_set_mode;
>  	priv->can.do_get_berr_counter =3D flexcan_get_berr_counter;
> @@ -1002,7 +1017,8 @@ static int __devinit flexcan_probe(struct platfor=
m_device *pdev)
>   failed_map:
>  	release_mem_region(mem->start, mem_size);
>   failed_get:
> -	clk_put(clk);
> +	if (clk)
> +		clk_put(clk);
>   failed_clock:
>  	return err;
>  }
> @@ -1020,7 +1036,8 @@ static int __devexit flexcan_remove(struct platfo=
rm_device *pdev)
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(mem->start, resource_size(mem));
> =20
> -	clk_put(priv->clk);
> +	if (priv->clk)
> +		clk_put(priv->clk);
> =20
>  	free_candev(dev);
> =20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4F69796CAE2007D8F2EAC4EE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5EAM8ACgkQjTAFq1RaXHM61ACfVom0M2yBZPaGi4epL1VoeaFT
fnAAniQTRH9EfjtaniR6uuNly7YwGl/8
=yPPQ
-----END PGP SIGNATURE-----

--------------enig4F69796CAE2007D8F2EAC4EE--
