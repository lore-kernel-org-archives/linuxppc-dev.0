Return-Path: <david-b@pacbell.net>
Received: from smtp118.sbc.mail.sp1.yahoo.com (smtp118.sbc.mail.sp1.yahoo.com
	[69.147.64.91]) by ozlabs.org (Postfix) with SMTP id B0EF4DDDEF
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 08:22:12 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 01/11] [POWERPC] Implement support for the GPIO LIB API
Date: Sun, 3 Feb 2008 13:17:43 -0800
References: <20080203170820.GA18520@localhost.localdomain>
	<20080203170951.GA28024@localhost.localdomain>
In-Reply-To: <20080203170951.GA28024@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200802031317.43858.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 03 February 2008, Anton Vorontsov wrote:
> This patch implements support for the GPIO LIB API. Two calls
> unimplemented though: irq_to_gpio and gpio_to_irq.

Also gpio_cansleep().


> +Example of two SOC GPIO banks defined as gpio-controller nodes:
> +
> +	qe_pio_a: gpio-controller@1400 {
> +		#gpio-cells = <2>;
> +		compatible = "fsl,qe-pario-bank";
> +		reg = <0x1400 0x18>;
> +		gpio-controller;
> +	};
> +
> +	qe_pio_e: gpio-controller@1460 {
> +		#gpio-cells = <2>;
> +		compatible = "fsl,qe-pario-bank";
> +		reg = <0x1460 0x18>;
> +		gpio-controller;
> +	};

Let me suggest another example to provide:   an I2C GPIO expander
such as a pcf8574 or pca9354 (both eight bit expanders).  The SOC
case is probably the easiest to cover.


> +#define ARCH_OF_GPIOS_PER_CHIP 32

Well, ARCH_OF_* is clearly not the now-removed ARCH_GPIOS_PER_CHIP,
but I still suggest moving away from that concept.  


> +static inline int gpio_get_value(unsigned int gpio)
> +{
> +	return __gpio_get_value(gpio);
> +}
> +
> +static inline void gpio_set_value(unsigned int gpio, int value)
> +{
> +	__gpio_set_value(gpio, value);
> +}

static inline int gpio_cansleep(unsigned int gpio)
{
	return __gpio_cansleep(gpio);
}


> +static inline int irq_to_gpio(unsigned int irq)
> +{
> +	return -ENOSYS;

Minor nit:  "-EINVAL" would be better here, since the argument
is constrained to have been returned from gpio_to_irq(), and
as you wrote that call there can be no such values.
