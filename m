Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wFynS0XWRzDqC5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 16:48:44 +1000 (AEST)
Date: Sun, 30 Apr 2017 01:48:26 -0500
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20170430064826.fags33gcyvpqigah@home.buserror.net>
References: <20170309094204.ACF5567992@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170309094204.ACF5567992@localhost.localdomain>
Subject: Re: powerpc/8xx: Adding support of IRQ in MPC8xx GPIO
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 09, 2017 at 10:42:04AM +0100, Christophe Leroy wrote:
> This patch allows the use of IRQ to notify the change of GPIO status
> on MPC8xx CPM IO ports. This then allows to associate IRQs to GPIOs
> in the Device Tree.
> 
> Ex:
> 	CPM1_PIO_C: gpio-controller@960 {
> 		#gpio-cells = <2>;
> 		compatible = "fsl,cpm1-pario-bank-c";
> 		reg = <0x960 0x10>;
> 		interrupts = <1 2 6 9 10 11 14 15 23 24 26 31>;
> 		interrupts-mask = <0x0fff>;
> 		interrupt-parent = <&CPM_PIC>;
> 		gpio-controller;
> 	};
> 
> The property 'interrupts-mask' defines which of the 16 GPIOs have
> the associated interrupts defined in the 'interrupts' property.

Binding?  Should also be named something like "fsl,cpm1-gpio-irq-mask",

>  static int cpm1_gpio16_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  {
>  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> @@ -618,6 +633,7 @@ int cpm1_gpiochip_add16(struct device_node *np)
>  	struct cpm1_gpio16_chip *cpm1_gc;
>  	struct of_mm_gpio_chip *mm_gc;
>  	struct gpio_chip *gc;
> +	u16 mask;
>  
>  	cpm1_gc = kzalloc(sizeof(*cpm1_gc), GFP_KERNEL);
>  	if (!cpm1_gc)

> @@ -625,6 +641,14 @@ int cpm1_gpiochip_add16(struct device_node *np)
>  
>  	spin_lock_init(&cpm1_gc->lock);
>  
> +	if (!of_property_read_u16(np, "interrupts-mask", &mask)) {
> +		int i, j;
> +
> +		for (i = 0, j = 0; i < 16; i++)
> +			if (mask & (1 << (15 - i)))
> +				cpm1_gc->irq[i] = irq_of_parse_and_map(np, j++);
> +	}

Do we really need to use MSB-first bit numbering here?

-Scott
