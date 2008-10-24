Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 413D9DDDF8
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 08:10:59 +1100 (EST)
Date: Sat, 25 Oct 2008 01:10:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Ocker <weo@reccoware.de>
Subject: Re: [PATCH] Added gpios property for SPI slaves
Message-ID: <20081024211056.GA7309@oksana.dev.rtsoft.ru>
References: <1224878939.4039.22.camel@galileo.recco.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1224878939.4039.22.camel@galileo.recco.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 24, 2008 at 10:08:59PM +0200, Wolfgang Ocker wrote:
> SPI slave devices require the specification of a chip select address.
> This patch allows that specification using the gpios property. The reg
> property remains supported.
> 
> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> ---
> 
> --- linux-2.6.27.3/drivers/of/of_spi.c.of_spi_gpio	2008-10-22 23:38:01.000000000 +0200
> +++ linux-2.6.27.3/drivers/of/of_spi.c.of_spi_cshigh	2008-10-24 21:36:39.000000000 +0200
[...]
> --- linux-2.6.27.3/Documentation/powerpc/booting-without-of.txt.of_spi_gpio	2008-10-22 23:38:01.000000000 +0200
> +++ linux-2.6.27.3/Documentation/powerpc/booting-without-of.txt.of_spi_cshigh	2008-10-24 21:57:16.000000000 +0200
> @@ -1909,7 +1909,9 @@ platforms are moved over to use the flat
>  
>      SPI slave nodes must be children of the SPI master node and can
>      contain the following properties.
> -    - reg             - (required) chip select address of device.
> +    - reg             - chip select address of device.
> +    - gpios           - chip select address of device (alternatively).
> +			one of reg and gpios is required.
>      - compatible      - (required) name of SPI device following generic names
>  			recommended practice
>      - spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz
> @@ -1936,7 +1938,7 @@ platforms are moved over to use the flat
>  			codec@1 {
>  				compatible = "ti,tlv320aic26";
>  				spi-max-frequency = <100000>;
> -				reg = <1>;
> +				gpios = <&GPIO1 3>;
>  			};
>  		};

Close, but no cigar. Sorry. ;-) The bindings are fine as is, you don't
need to change them.

The scheme should look like this:

spi-controller {
        #address-cells = <1>;
        #size-cells = <0>;

        /* two GPIOs, representing two chip selects: 0 and 1 */
        gpios = <&pio 5 0 &pio 16 0>;

        mmc-slot@0 {
                reg = <0>;
        };

        touchscreen@1 {
                reg = <1>;
        };
}

Notice that "gpios" is spi-controller's property, not spi devices'.
It is truly as hardware works, SPI controllers consists of two units:
I/O, and chip-select machine. Most spi controllers don't have
dedicated chip-select machines, so they use GPIOs.

The spi controller driver should request all the specified gpios,
and then work with chip select numbers. Something like this:

struct spi_controller {
	int *gpios;
	unsigned int num_gpios;
	...
}

int spi_set_chipselect(struct spi_controller *spi, int cs, int active)
{
	/* 
	 * chip-select is not necessary if there is just one device on
	 * the bus, so gpios = <> are not necessary either */
	 */
	if (!spi->num_gpios)
		return 0;

	if (cs > spi->num_gpios)
		return -EINVAL;

	gpio_set_value(spi->gpios[cs], active);
}

...

unsigned int of_num_gpios(struct device_node *node)
{
	unsigned int num = 0;

	while (gpio_is_valid(of_get_gpio(node, num)))
		num++;
	return num;
}

int spi_controller_probe(...)
{
	spi_controller *spi;
...
	spi->num_gpios = of_num_gpios(node);
	if (spi->num_gpios) {
		int i = spi->num_gpios;

		spi->gpios = kzalloc(sizeof(int) * i, GFP_KERNEL);
		if (!spi->gpios)
			return -ENOMEM;

		do
			spi->gpios[i] = of_get_gpio(node, i);
		while (!(i--));
	}
...
}

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
