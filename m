Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81241B7D1D
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 08:07:31 +1100 (EST)
Date: Fri, 12 Mar 2010 13:07:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/4] of/gpio: Implement GPIOLIB notifier hooks
Message-Id: <20100312130723.43308ccd.akpm@linux-foundation.org>
In-Reply-To: <20100205203236.GC1475@oksana.dev.rtsoft.ru>
References: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
	<20100205203236.GC1475@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 5 Feb 2010 23:32:36 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> This patch implements GPIOLIB notifier hooks, and thus makes device-enabled
> GPIO chips (i.e. the ones that have gpio_chip->dev specified) automatically
> attached to the OpenFirmware subsystem. Which means that now we can handle
> I2C and SPI GPIO chips almost* transparently.
> 
> ...
>
> +static int of_gpiochip_register_simple(struct gpio_chip *chip,
> +				       struct device_node *np)

Why is this called "register_simple" but the unregistration function
isn't called "unregister_simple"?

> +{
> +	struct of_gpio_chip *of_gc;
> +
> +	if (np->data) {
> +		WARN_ON(1);
> +		return -EBUSY;
> +	}
> +
> +	of_gc = kzalloc(sizeof(*of_gc), GFP_KERNEL);
> +	if (!of_gc)
> +		return -ENOMEM;
> +
> +	of_gc->gpio_cells = 2;
> +	of_gc->xlate = of_gpio_simple_xlate;
> +	of_gc->chip = chip;
> +	np->data = of_gc;
> +	of_node_get(np);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(of_gpiochip_register_simple);

Makes no sense to export a static symbol and to provide no declaration
of it in a .h file.  I assume the export was unintended.


My plot is somewhat lost.  Grant, could you please summarise in
easy-for-akpm-to-understand terms what your issues are with this
patchset and how you think we should proceed?

Thanks.
