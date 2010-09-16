Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 9D262B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 12:38:27 +1000 (EST)
Received: by pwi4 with SMTP id 4so441121pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 19:38:26 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 15 Sep 2010 20:38:23 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/5121: pdm360ng: fix touch irq if 8xxx gpio
	driver is enabled
Message-ID: <20100916023823.GB7049@angua.secretlab.ca>
References: <1284581577-2217-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284581577-2217-1-git-send-email-agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 15, 2010 at 10:12:57PM +0200, Anatolij Gustschin wrote:
> Enabling the MPC8xxx GPIO driver with MPC512x GPIO extension
> breaks touch screen support on this board since the GPIO
> interrupt will be mapped to 8xxx GPIO irq host resulting in
> a not requestable interrupt in the touch screen driver. Fix
> it by mapping the touch interrupt on 8xxx GPIO irq host.

This looks wrong to me.  The touchscreen code should not go mucking
about in the GPIO controller registers; that is the job of the gpio
driver.  What is the reason that the touch interrupt isn't
requestable?  It looks like the 8xxx gpio driver is designed to hand
out a separate virq number for each gpio pin (I've not had time to dig
into details, so you'll need to educate me on the problem details)

g.

> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/platforms/512x/pdm360ng.c |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/512x/pdm360ng.c b/arch/powerpc/platforms/512x/pdm360ng.c
> index 0575e85..558eb9e 100644
> --- a/arch/powerpc/platforms/512x/pdm360ng.c
> +++ b/arch/powerpc/platforms/512x/pdm360ng.c
> @@ -27,6 +27,7 @@
>  #include <linux/spi/ads7846.h>
>  #include <linux/spi/spi.h>
>  #include <linux/notifier.h>
> +#include <asm/gpio.h>
>  
>  static void *pdm360ng_gpio_base;
>  
> @@ -50,7 +51,7 @@ static struct ads7846_platform_data pdm360ng_ads7846_pdata = {
>  	.irq_flags		= IRQF_TRIGGER_LOW,
>  };
>  
> -static int __init pdm360ng_penirq_init(void)
> +static int pdm360ng_penirq_init(void)
>  {
>  	struct device_node *np;
>  
> @@ -73,6 +74,9 @@ static int __init pdm360ng_penirq_init(void)
>  	return 0;
>  }
>  
> +#define GPIO_NR(x)	(ARCH_NR_GPIOS - 32 + (x))
> +#define PENDOWN_GPIO	GPIO_NR(25)
> +
>  static int pdm360ng_touchscreen_notifier_call(struct notifier_block *nb,
>  					unsigned long event, void *__dev)
>  {
> @@ -80,7 +84,24 @@ static int pdm360ng_touchscreen_notifier_call(struct notifier_block *nb,
>  
>  	if ((event == BUS_NOTIFY_ADD_DEVICE) &&
>  	    of_device_is_compatible(dev->of_node, "ti,ads7846")) {
> +		struct spi_device *spi = to_spi_device(dev);
> +		int gpio = PENDOWN_GPIO;
> +
>  		dev->platform_data = &pdm360ng_ads7846_pdata;
> +		if (pdm360ng_penirq_init())
> +			return NOTIFY_DONE;
> +
> +		if (gpio_request_one(gpio, GPIOF_IN, "ads7845_pen_down") < 0) {
> +			pr_err("Failed to request GPIO %d for "
> +				"ads7845 pen down IRQ\n", gpio);
> +			return NOTIFY_DONE;
> +		}
> +		spi->irq = gpio_to_irq(gpio);
> +		if (spi->irq < 0) {
> +			pr_err("Can't map GPIO IRQ\n");
> +			gpio_free(gpio);
> +			return NOTIFY_DONE;
> +		}
>  		return NOTIFY_OK;
>  	}
>  	return NOTIFY_DONE;
> @@ -92,9 +113,6 @@ static struct notifier_block pdm360ng_touchscreen_nb = {
>  
>  static void __init pdm360ng_touchscreen_init(void)
>  {
> -	if (pdm360ng_penirq_init())
> -		return;
> -
>  	bus_register_notifier(&spi_bus_type, &pdm360ng_touchscreen_nb);
>  }
>  #else
> -- 
> 1.7.0.4
> 
