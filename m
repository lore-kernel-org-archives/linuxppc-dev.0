Return-Path: <glikely@secretlab.ca>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
 [209.85.215.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7AC6DB6FA6
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 05:07:45 +1100 (EST)
Received: by eaai11 with SMTP id i11so2235219eaa.15
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 10:07:41 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Tue, 13 Dec 2011 11:07:35 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH RESEND] gpio: mpc8xxx: don't allow input-only pins to be
 output for MPC5121
Message-ID: <20111213180735.GD4871@ponder.secretlab.ca>
References: <1323767568-9565-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323767568-9565-1-git-send-email-w.sang@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 13, 2011 at 10:12:48AM +0100, Wolfram Sang wrote:
> Add a 5121-custom reject if an input-only pin is requested to be output
> (see 18.3.1.1 in the refman). Also, rewrite mach-specific quirk setup to
> consume less lines which scales better.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

Applied, thanks.

g.

> ---
>  drivers/gpio/gpio-mpc8xxx.c |   17 ++++++++++++-----
>  1 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index ec3fcf0..25dc736 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -115,6 +115,14 @@ static int mpc8xxx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
>  	return 0;
>  }
>  
> +static int mpc5121_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	/* GPIO 28..31 are input only on MPC5121 */
> +	if (gpio >= 28)
> +		return -EINVAL;
> +
> +	return mpc8xxx_gpio_dir_out(gc, gpio, val);
> +}
>  static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
>  {
>  	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
> @@ -340,11 +348,10 @@ static void __init mpc8xxx_add_controller(struct device_node *np)
>  	mm_gc->save_regs = mpc8xxx_gpio_save_regs;
>  	gc->ngpio = MPC8XXX_GPIO_PINS;
>  	gc->direction_input = mpc8xxx_gpio_dir_in;
> -	gc->direction_output = mpc8xxx_gpio_dir_out;
> -	if (of_device_is_compatible(np, "fsl,mpc8572-gpio"))
> -		gc->get = mpc8572_gpio_get;
> -	else
> -		gc->get = mpc8xxx_gpio_get;
> +	gc->direction_output = of_device_is_compatible(np, "fsl,mpc5121-gpio") ?
> +		mpc5121_gpio_dir_out : mpc8xxx_gpio_dir_out;
> +	gc->get = of_device_is_compatible(np, "fsl,mpc8572-gpio") ?
> +		mpc8572_gpio_get : mpc8xxx_gpio_get;
>  	gc->set = mpc8xxx_gpio_set;
>  	gc->to_irq = mpc8xxx_gpio_to_irq;
>  
> -- 
> 1.7.7.1
> 
