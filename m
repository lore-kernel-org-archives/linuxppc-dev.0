Return-Path: <david-b@pacbell.net>
Received: from smtp115.sbc.mail.sp1.yahoo.com (smtp115.sbc.mail.sp1.yahoo.com
	[69.147.64.88]) by ozlabs.org (Postfix) with SMTP id D4B2BDE01F
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 06:47:46 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH] Modify sysfs gpio export so that "value" displays as 0 or
	1
Date: Thu, 16 Oct 2008 12:46:37 -0700
References: <48EF60F1.1010001@harris.com>
In-Reply-To: <48EF60F1.1010001@harris.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810161246.38091.david-b@pacbell.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 October 2008, Steven A. Falco wrote:
> gpiolib can export GPIOs to userspace via sysfs.  This patch modifies
> the gpio_value_show() so that any non-zero value is explicitly printed
> as "1", rather than whatever numerical value the lower-level driver returns.
> 
> Signed-off-by: Steve Falco <sfalco at harris.com>

I just forwarded this to Andrew (cc LKML) with my
signoff ... sorry I forgot to add you to the CC.  :(


> ---
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 8d29405..36bf72b 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -237,7 +237,7 @@ static ssize_t gpio_value_show(struct device *dev,
>  	if (!test_bit(FLAG_EXPORT, &desc->flags))
>  		status = -EIO;
>  	else
> -		status = sprintf(buf, "%d\n", gpio_get_value_cansleep(gpio));
> +		status = sprintf(buf, "%d\n", !!gpio_get_value_cansleep(gpio));
>  
>  	mutex_unlock(&sysfs_lock);
>  	return status;
> 
> 
