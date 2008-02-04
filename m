Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6A94ADDEA0
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 00:19:56 +1100 (EST)
Date: Mon, 4 Feb 2008 16:19:40 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 01/11] [POWERPC] Implement support for the GPIO LIB API
Message-ID: <20080204131940.GA5298@localhost.localdomain>
References: <20080203170820.GA18520@localhost.localdomain>
	<20080203170951.GA28024@localhost.localdomain>
	<200802031317.43858.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200802031317.43858.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 03, 2008 at 01:17:43PM -0800, David Brownell wrote:
> On Sunday 03 February 2008, Anton Vorontsov wrote:
> > This patch implements support for the GPIO LIB API. Two calls
> > unimplemented though: irq_to_gpio and gpio_to_irq.
> 
> Also gpio_cansleep().
> 
> 
> > +Example of two SOC GPIO banks defined as gpio-controller nodes:
> > +
> > +	qe_pio_a: gpio-controller@1400 {
> > +		#gpio-cells = <2>;
> > +		compatible = "fsl,qe-pario-bank";
> > +		reg = <0x1400 0x18>;
> > +		gpio-controller;
> > +	};
> > +
> > +	qe_pio_e: gpio-controller@1460 {
> > +		#gpio-cells = <2>;
> > +		compatible = "fsl,qe-pario-bank";
> > +		reg = <0x1460 0x18>;
> > +		gpio-controller;
> > +	};
> 
> Let me suggest another example to provide:   an I2C GPIO expander
> such as a pcf8574 or pca9354 (both eight bit expanders).  The SOC
> case is probably the easiest to cover.

I2C expander will be easy to support via device tree too, something
like:

i2c@3000 {
	#address-cells = <1>;
	#size-cells = <0>;
	cell-index = <0>;
	compatible = "fsl-i2c";
	reg = <0x3000 0x100>;
	interrupts = <14 8>;
	interrupt-parent = <&ipic>;
	dfsrr;

	pcf_pio: gpio-controller@27 {
		#gpio-cells = <2>;
		compatible = "ti,pcf8574";
		reg = <0x27>;
		gpio-controller;
	};
};

Of course, to support this, pcf857x driver needs OF bindings.

> > +#define ARCH_OF_GPIOS_PER_CHIP 32
> 
> Well, ARCH_OF_* is clearly not the now-removed ARCH_GPIOS_PER_CHIP,
> but I still suggest moving away from that concept.  

Yes, I noticed that ARCH_GPIOS_PER_CHIP is removed from the
gpiolib. But I solely use it to assign gpio_bases to the chips:

static int of_get_gpiochip_base(struct device_node *np)
{
	struct device_node *gc = NULL;
	int gpiochip_base = 0;

	while ((gc = of_find_all_nodes(gc))) {
		if (!of_get_property(gc, "gpio-controller", NULL))
			continue;

		if (gc != np) {
			gpiochip_base += ARCH_OF_GPIOS_PER_CHIP;
			continue;
		}

		of_node_put(gc);

		if (gpiochip_base >= ARCH_OF_GPIOS_END)
			return -ENOSPC;

		return gpiochip_base;
	}

	return -ENOENT;
}

This function walks the device tree and assigns gpio_base 0 to
the first encountered gpio-controller, ARCH_OF_GPIOS_PER_CHIP * N
to the Nth controller...

Technically, I can replace

		if (gc != np) {
			gpiochip_base += ARCH_OF_GPIOS_PER_CHIP;
			continue;
		}

With

		if (gc != np) {
			struct gpio_chip *chip = gc->data;

			if (chip)
				gpiochip_base += chip->ngpio;
			continue;
		}

Here we're getting next available GPIO base. But then this code can't
handle gpio chip removal. So, we need smart "dynamic GPIO base
allocator" as described asm-generic/gpio.h, gpio_find_base(ngpios)
that will find free gpio base suitable for ngpios to place. Until
that allocator implemented, we use simple allocator with
OF_GPIOS_PER_CHIP...

> > +static inline int gpio_get_value(unsigned int gpio)
> > +{
> > +	return __gpio_get_value(gpio);
> > +}
> > +
> > +static inline void gpio_set_value(unsigned int gpio, int value)
> > +{
> > +	__gpio_set_value(gpio, value);
> > +}
> 
> static inline int gpio_cansleep(unsigned int gpio)
> {
> 	return __gpio_cansleep(gpio);
> }

Will fix.

> > +static inline int irq_to_gpio(unsigned int irq)
> > +{
> > +	return -ENOSYS;
> 
> Minor nit:  "-EINVAL" would be better here, since the argument
> is constrained to have been returned from gpio_to_irq(), and
> as you wrote that call there can be no such values.

Will change.


Thanks!

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
