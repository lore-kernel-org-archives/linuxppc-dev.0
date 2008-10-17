Return-Path: <david-b@pacbell.net>
Received: from smtp126.sbc.mail.sp1.yahoo.com (smtp126.sbc.mail.sp1.yahoo.com
	[69.147.65.185]) by ozlabs.org (Postfix) with SMTP id 07963DE0DF
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 07:38:27 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/7] gpiolib: implement dev_gpiochip_{add,remove} calls
Date: Fri, 17 Oct 2008 13:24:42 -0700
References: <20081016171222.GA24812@oksana.dev.rtsoft.ru>
	<20081016171259.GD5515@oksana.dev.rtsoft.ru>
In-Reply-To: <20081016171259.GD5515@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810171324.42650.david-b@pacbell.net>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, Jean Delvare <khali@linux-fr.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 16 October 2008, Anton Vorontsov wrote:
> +/*
> + * Platforms can define their own __dev_ versions to glue gpio_chips with the
> + * architecture-specific code.
> + */
> +#ifndef __dev_gpiochip_add
> +#define __dev_gpiochip_add __dev_gpiochip_add
> +static inline int __dev_gpiochip_add(struct device *dev,
> +                                    struct gpio_chip *chip)
> +{
> +       chip->dev = dev;
> +       return gpiochip_add(chip);
> +}
> +#endif /* __dev_gpiochip_add */

This is pretty ugly, especially the implication that *EVERY* gpio_chip
provider needs modification to use these calls.

Surely it would be a lot simpler to just add platform-specific hooks
to gpiochip_{add,remove}(), so that no providers need to be changed??


> +#ifndef __dev_gpiochip_remove
> +#define __dev_gpiochip_remove __dev_gpiochip_remove
> +static inline int __dev_gpiochip_remove(struct device *dev,
> +                                       struct gpio_chip *chip)
> +{
> +       return gpiochip_remove(chip);
> +}
> +#endif /* __dev_gpiochip_remove */
