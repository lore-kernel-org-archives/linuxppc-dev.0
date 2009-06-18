Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AE8EFB720D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 22:42:36 +1000 (EST)
Message-Id: <8F68BE27-E845-47EF-AA1E-B19224FBE557@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <4A39DC80.7030906@arvoo.nl>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH -mm][POWERPC] mpc8xxx : allow SPI without cs.
Date: Thu, 18 Jun 2009 07:42:23 -0500
References: <4A39DC80.7030906@arvoo.nl>
Cc: spi-devel-general@lists.sourceforge.net, Rini van Zetten <rini@arvoo.nl>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 18, 2009, at 1:19 AM, Rini van Zetten wrote:

> This patch adds the possibility to have a spi device without a cs.
>
> For example, the dts file should look something like this:
>
> spi-controller {
>       gpios = <&pio1 1 0      /* cs0 */
>                0              /* cs1, no GPIO */
>                &pio2 2 0>;    /* cs2 */
>
>
>
> Signed-off-by: Rini van Zetten <rini@arvoo.nl>
> ---
> Changes :
> 	patch against 2.6.30-rc8-mm1

Anton,

Can you review and ack this if you are ok with it.

- k

>
>
> --- drivers/spi/spi_mpc8xxx.c.org	2009-06-12 10:45:21.000000000 +0200
> +++ drivers/spi/spi_mpc8xxx.c	2009-06-12 10:54:48.000000000 +0200
> @@ -666,9 +666,10 @@ static void mpc8xxx_spi_cs_control(struc
> 	struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev- 
> >platform_data);
> 	u16 cs = spi->chip_select;
> 	int gpio = pinfo->gpios[cs];
> -	bool alow = pinfo->alow_flags[cs];
> -
> -	gpio_set_value(gpio, on ^ alow);
> +	if (gpio != -EEXIST) {
> +		bool alow = pinfo->alow_flags[cs];
> +		gpio_set_value(gpio, on ^ alow);
> +	}
> }
>
> static int of_mpc8xxx_spi_get_chipselects(struct device *dev)
> @@ -707,27 +708,29 @@ static int of_mpc8xxx_spi_get_chipselect
> 		enum of_gpio_flags flags;
>
> 		gpio = of_get_gpio_flags(np, i, &flags);
> -		if (!gpio_is_valid(gpio)) {
> +		if (gpio_is_valid(gpio)) {
> +			ret = gpio_request(gpio, dev_name(dev));
> +			if (ret) {
> +				dev_err(dev, "can't request gpio #%d: %d\n", i, ret);
> +				goto err_loop;
> +			}
> +
> +			pinfo->gpios[i] = gpio;
> +			pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
> +
> +			ret = gpio_direction_output(pinfo->gpios[i],
> +					pinfo->alow_flags[i]);
> +			if (ret) {
> +				dev_err(dev, "can't set output direction for gpio "
> +						"#%d: %d\n", i, ret);
> +				goto err_loop;
> +			}
> +		} else if (gpio == -EEXIST) {
> +			pinfo->gpios[i] = -EEXIST;
> +		} else {
> 			dev_err(dev, "invalid gpio #%d: %d\n", i, gpio);
> 			goto err_loop;
> 		}
> -
> -		ret = gpio_request(gpio, dev_name(dev));
> -		if (ret) {
> -			dev_err(dev, "can't request gpio #%d: %d\n", i, ret);
> -			goto err_loop;
> -		}
> -
> -		pinfo->gpios[i] = gpio;
> -		pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;
> -
> -		ret = gpio_direction_output(pinfo->gpios[i],
> -					    pinfo->alow_flags[i]);
> -		if (ret) {
> -			dev_err(dev, "can't set output direction for gpio "
> -				"#%d: %d\n", i, ret);
> -			goto err_loop;
> -		}
> 	}
>
> 	pdata->max_chipselect = ngpios;
> --
>
>
> -- 
> Rini van Zetten
> Senior Software Engineer
>
> -------------------------
> ARVOO Engineering B.V.
> Tasveld 13
> 3417 XS Montfoort
> The Netherlands
>
> E-mail : <mailto:rini@arvoo.com> Rini van Zetten
>
> Web : www.arvoo.com
>
>
