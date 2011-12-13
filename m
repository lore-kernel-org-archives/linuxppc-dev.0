Return-Path: <glikely@secretlab.ca>
Received: from mail-lpp01m010-f42.google.com (mail-lpp01m010-f42.google.com
 [209.85.215.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7B0F21007D3
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 05:17:12 +1100 (EST)
Received: by lagj5 with SMTP id j5so2408182lag.15
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 10:17:08 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Tue, 13 Dec 2011 11:16:59 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH RESEND] gpio: mpc8xxx: don't allow input-only pins to be
 output for MPC5121
Message-ID: <20111213181659.GA29243@ponder.secretlab.ca>
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

This actually caused a build failure.  mpc8xxx_gpio_dir_out() was used before
it was declared.  I moved the symbol to immediately below and applied anyway,
but how did it compile for you?  Should I drop this patch until you retest?

g.
