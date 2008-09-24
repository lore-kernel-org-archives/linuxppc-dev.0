Return-Path: <david-b@pacbell.net>
Received: from smtp119.sbc.mail.sp1.yahoo.com (smtp119.sbc.mail.sp1.yahoo.com
	[69.147.64.92]) by ozlabs.org (Postfix) with SMTP id 6A175DDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 07:40:47 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/4] gpiolib: make gpio_to_chip() public
Date: Wed, 24 Sep 2008 14:40:43 -0700
References: <20080924182027.GA11180@oksana.dev.rtsoft.ru>
	<20080924182113.GA25744@oksana.dev.rtsoft.ru>
In-Reply-To: <20080924182113.GA25744@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809241440.43978.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 24 September 2008, Anton Vorontsov wrote:
> We'll need this function to write platform-specific hooks to deal
> with pin's dedicated functions. Quite obviously this will work only
> for the platforms with 1-to-1 GPIO to PIN mapping.
> 
> This is stopgap solution till we think out and implement a proper
> api (pinlib?).
> 
> p.s. This patch actually exports gpio_desc and places gpio_to_chip
> into the asm-generic/gpio.h as `static inline'. This is needed
> to not cause function calls for this trivial translation.
> 
> Also, the patch does not export FLAG_*s... the names are too
> generic, and nobody is using them outside of gpiolib.c.

For the record:  NAK, still.  The concept has problems,
there is no "need" for this.  I sketched a cleaner way
to address the issues of the QE USB driver; I'm sure it
would only take an hour or two to code, using what's
already present.

And if I were to approve something like this it would
be a lot simpler, not exposing internals, and with
appropriate kerneldoc.  Simpler such as

	struct gpio_chip *gpio_to_gpiochip(unsigned gpio)
	{
		return gpio_to_chip(gpio);
	}
	EXPORT_SYMBOL_NOTREALLY(gpio_to_gpiochip);

with a declaration in a header.  It's not like THIS
version would be performance-critical (unlike the one
inside gpiolib).

- Dave
