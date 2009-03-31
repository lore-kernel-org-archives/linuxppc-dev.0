Return-Path: <ypelletier@haivision.com>
Received: from mx11.exchange.telus.com (mx11.exchange.telus.com
	[216.123.224.145]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "mx11.exchange.telus.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2BF6DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 07:36:23 +1100 (EST)
From: Yann Pelletier <ypelletier@haivision.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Tue, 31 Mar 2009 14:36:20 -0600
Subject: RE: [PATCH 4/6] powerpc: Add mmc-spi-slot bindings
Message-ID: <9A8B45DD4DE17F4783430D784DA0B68811C429F962@HEXMBVS12.hostedmsx.local>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Original post:

Anton Vorontsov avorontsov at ru.mvista.com
Sat Jan 24 06:50:37 EST 2009

Sorry if this looks crappy, it's paste from web archive since I was not on =
the list at that time.

I've applied this patch set [1 to 6] to enable SPI device to be listed in t=
he device tree instead of platform kernel file.

It is working fine but ...

> The bindings describes a case where MMC/SD/SDIO slot directly connected
> to a SPI bus. Such setups are widely used on embedded PowerPC boards.
>
> The patch also adds the mmc-spi-slot entry to the OpenFirmware modalias
> table.
>
> Signed-off-by: Anton Vorontsov <avorontsov at ru.mvista.com>
> ---
>  .../powerpc/dts-bindings/mmc-spi-slot.txt          |   23
> ++++++++++++++++++++
>  drivers/of/base.c                                  |    1 +
>  2 files changed, 24 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
>
> diff --git a/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt=20
> b/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
> new file mode 100644
> index 0000000..c39ac28
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
> @@ -0,0 +1,23 @@
> +MMC/SD/SDIO slot directly connected to a SPI bus
> +
> +Required properties:
> +- compatible : should be "mmc-spi-slot".
> +- reg : should specify SPI address (chip-select number).
> +- spi-max-frequency : maximum frequency for this device (Hz).
> +- voltage-ranges : two cells are required, first cell specifies minimum
> +  slot voltage (mV), second cell specifies maximum slot voltage (mV).
> +  Several ranges could be specified.
> +- gpios : (optional) may specify GPIOs in this order: Card-Detect GPIO,
> +  Write-Protect GPIO.
> +
> +Example:
> +
> +	mmc-slot at 0 {
> +		compatible =3D "fsl,mpc8323rdb-mmc-slot",
> +			     "mmc-spi-slot";
> +		reg =3D <0>;
> +		gpios =3D <&qe_pio_d 14 1
> +			 &qe_pio_d 15 0>;
> +		voltage-ranges =3D <3300 3300>;
> +		spi-max-frequency =3D <50000000>;
> +	};
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index cd17092..41c5dfd 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -446,6 +446,7 @@ struct of_modalias_table {
>  };
>  static struct of_modalias_table of_modalias_table[] =3D {
>  	{ "fsl,mcu-mpc8349emitx", "mcu-mpc8349emitx" },
> +	{ "mmc-spi-slot", "mmc_spi" },


Here I had to add=20

  { "gs2970", "gs2970" },
  { "spidev", "spidev" },

>  };

To make my device get probed.  Otherwise I receive error

spi_master spi32766: cannot find modalias for /soc8313@e0000000/spi@7000/gs=
2970@0=20
spi_master spi32766: cannot find modalias for /soc8313@e0000000/spi@7000/sp=
idev@4


I wonder if those modalias are absolutely required.  I would prefer not to =
add platform specific stuff to the kernel as this was my motivation to appl=
y the patch.  Would there be a way to get around this ?




Also, from patch 3/6 in the same patch set

+static int __devinit of_mpc83xx_spi_probe(struct of_device *ofdev,
+					  const struct of_device_id *ofid)
.....
+	/* SPI controller is either clocked from QE or SoC clock. */
+	pdata->sysclk =3D get_brgfreq();
+	if (pdata->sysclk =3D=3D -1) {
+		pdata->sysclk =3D fsl_get_sys_freq();
+		if (pdata->sysclk =3D=3D -1) {
+			ret =3D -ENODEV;
+			goto err_clk;
+		}
+	}

get_brgfreq() in not defined in my system as I do not use QUICK_ENGINE


Thanks for support.
