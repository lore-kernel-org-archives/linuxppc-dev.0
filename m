Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64E7FDDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 20:13:57 +1100 (EST)
Date: Fri, 28 Nov 2008 01:11:38 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] of/gpio: Implement of_get_gpio_flags()
In-Reply-To: <20081127204453.GA21901@oksana.dev.rtsoft.ru>
Message-ID: <Pine.LNX.4.64.0811280107380.5161@t2.domain.actdsltmp>
References: <20081127204453.GA21901@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 Nov 2008, Anton Vorontsov wrote:
> This function is alike to the simple of_get_gpio(), but accepts new
> argument: flags. This new function will be used by the drivers that
> need to retrieve additional GPIO information, such as active-low flag.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

So you want to do the clean up patch later?

> +	/*
> +	 * We're discouraging gpio_cells < 2, since that way you'll have to
> +	 * write your own xlate function (that will have to retrive the GPIO
> +	 * number and the flags from a single gpio cell -- this is possible,
> +	 * but not recommended).
> +	 */
> +	if (of_gc->gpio_cells < 2) {
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}

If you're not going to allow 1 cell anymore (which should perhaps be
mentioned in the changelog), you could just check that when the of_gpio
chip is registered.  There's no need to see if of_gc->gpio_cells has
changed each time a driver maps a GPIO.
