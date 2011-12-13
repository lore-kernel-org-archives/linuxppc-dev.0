Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id 998591007D3
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 20:52:52 +1100 (EST)
Date: Tue, 13 Dec 2011 10:52:43 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH RESEND] gpio: mpc8xxx: don't allow input-only pins to be
 output for MPC5121
Message-ID: <20111213105243.101ced70@wker>
In-Reply-To: <1323767568-9565-1-git-send-email-w.sang@pengutronix.de>
References: <1323767568-9565-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Linus Walleij <linus.walleij@stericsson.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

Looks mostly good to me. Please see minor comments below.

On Tue, 13 Dec 2011 10:12:48 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:
...
> diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
> index ec3fcf0..25dc736 100644
> --- a/drivers/gpio/gpio-mpc8xxx.c
> +++ b/drivers/gpio/gpio-mpc8xxx.c
> @@ -115,6 +115,14 @@ static int mpc8xxx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
>  	return 0;
>  }
>  
> +static int mpc5121_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)

Line over 80 chars.

> +{
> +	/* GPIO 28..31 are input only on MPC5121 */
> +	if (gpio >= 28)
> +		return -EINVAL;
> +
> +	return mpc8xxx_gpio_dir_out(gc, gpio, val);
> +}
>  static int mpc8xxx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)

Please separate by an empty line. Thanks.

Anatolij
