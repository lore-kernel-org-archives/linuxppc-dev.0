Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0DB9FB6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Jul 2011 03:52:51 +1000 (EST)
Received: by pwi18 with SMTP id 18so74640pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 06 Jul 2011 10:52:48 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 6 Jul 2011 11:52:45 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/5200: add GPIO functions for simple interrupt
	GPIOs
Message-ID: <20110706175245.GL5805@ponder.secretlab.ca>
References: <1306142730-7528-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306142730-7528-1-git-send-email-agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2011 at 11:25:30AM +0200, Anatolij Gustschin wrote:
> The mpc52xx_gpio driver currently supports 8 wakeup GPIOs and 32
> simple GPIOs. Extend it to also support GPIO function of 8 simple
> interrupt GPIOs controlled in the standard GPIO register module.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/platforms/52xx/mpc52xx_gpio.c |  117 ++++++++++++++++++++++++++++

I don't want to merge more open coded MMIO gpio driver code.  This whole driver really needs to be converted to use GENERIC_GPIO.

g.

>  1 files changed, 117 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> index 1757d1d..42a0759 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpio.c
> @@ -35,6 +35,9 @@ struct mpc52xx_gpiochip {
>  	unsigned int shadow_dvo;
>  	unsigned int shadow_gpioe;
>  	unsigned int shadow_ddr;
> +	unsigned char sint_shadow_dvo;
> +	unsigned char sint_shadow_gpioe;
> +	unsigned char sint_shadow_ddr;
>  };
>  
>  /*
> @@ -309,6 +312,100 @@ mpc52xx_simple_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  	return 0;
>  }
>  
> +static int mpc52xx_sint_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
> +	unsigned int ret;
> +
> +	ret = (in_8(&regs->sint_ival) >> (7 - gpio)) & 1;
> +
> +	pr_debug("%s: gpio: %d ret: %d\n", __func__, gpio, ret);
> +
> +	return ret;
> +}
> +
> +static inline void
> +__mpc52xx_sint_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
> +			struct mpc52xx_gpiochip, mmchip);
> +	struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
> +
> +	if (val)
> +		chip->sint_shadow_dvo |= 1 << (7 - gpio);
> +	else
> +		chip->sint_shadow_dvo &= ~(1 << (7 - gpio));
> +
> +	out_8(&regs->sint_dvo, chip->sint_shadow_dvo);
> +}
> +
> +static void
> +mpc52xx_sint_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpio_lock, flags);
> +
> +	__mpc52xx_sint_gpio_set(gc, gpio, val);
> +
> +	spin_unlock_irqrestore(&gpio_lock, flags);
> +
> +	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +}
> +
> +static int mpc52xx_sint_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
> +			struct mpc52xx_gpiochip, mmchip);
> +	struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpio_lock, flags);
> +
> +	/* set the direction */
> +	chip->sint_shadow_ddr &= ~(1 << (7 - gpio));
> +	out_8(&regs->sint_ddr, chip->sint_shadow_ddr);
> +
> +	/* and enable the pin */
> +	chip->sint_shadow_gpioe |= 1 << (7 - gpio);
> +	out_8(&regs->sint_gpioe, chip->sint_shadow_gpioe);
> +
> +	spin_unlock_irqrestore(&gpio_lock, flags);
> +
> +	return 0;
> +}
> +
> +static int
> +mpc52xx_sint_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct mpc52xx_gpio __iomem *regs = mm_gc->regs;
> +	struct mpc52xx_gpiochip *chip = container_of(mm_gc,
> +			struct mpc52xx_gpiochip, mmchip);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gpio_lock, flags);
> +
> +	__mpc52xx_sint_gpio_set(gc, gpio, val);
> +
> +	/* Then set direction */
> +	chip->sint_shadow_ddr |= 1 << (7 - gpio);
> +	out_8(&regs->sint_ddr, chip->sint_shadow_ddr);
> +
> +	/* Finally enable the pin */
> +	chip->sint_shadow_gpioe |= 1 << (7 - gpio);
> +	out_8(&regs->sint_gpioe, chip->sint_shadow_gpioe);
> +
> +	spin_unlock_irqrestore(&gpio_lock, flags);
> +
> +	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
> +
> +	return 0;
> +}
> +
>  static int __devinit mpc52xx_simple_gpiochip_probe(struct platform_device *ofdev)
>  {
>  	struct mpc52xx_gpiochip *chip;
> @@ -337,6 +434,26 @@ static int __devinit mpc52xx_simple_gpiochip_probe(struct platform_device *ofdev
>  	chip->shadow_ddr = in_be32(&regs->simple_ddr);
>  	chip->shadow_dvo = in_be32(&regs->simple_dvo);
>  
> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	gc = &chip->mmchip.gc;
> +
> +	gc->ngpio            = 8;
> +	gc->direction_input  = mpc52xx_sint_gpio_dir_in;
> +	gc->direction_output = mpc52xx_sint_gpio_dir_out;
> +	gc->get              = mpc52xx_sint_gpio_get;
> +	gc->set              = mpc52xx_sint_gpio_set;
> +
> +	ret = of_mm_gpiochip_add(ofdev->dev.of_node, &chip->mmchip);
> +	if (ret)
> +		return ret;
> +
> +	regs = chip->mmchip.regs;
> +	chip->sint_shadow_gpioe = in_8(&regs->sint_gpioe);
> +	chip->sint_shadow_ddr = in_8(&regs->sint_ddr);
> +	chip->sint_shadow_dvo = in_8(&regs->sint_dvo);
>  	return 0;
>  }
>  
> -- 
> 1.7.1
> 
