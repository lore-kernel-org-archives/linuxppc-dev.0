Date: Fri, 30 Jul 2004 09:55:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] I2C driver for MPC107/824x/85xx/52xx
Message-ID: <20040730165550.GO16468@smtp.west.cox.net>
References: <1091201612.987.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091201612.987.25.camel@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 30, 2004 at 04:33:32PM +0100, Adrian Cox wrote:

> This is the latest version of my driver for the I2C controller in the
> MPC107 and related chips.
>
> Since last posting the driver has been tested on MPC5200, where it works
> only when interrupts are disabled. I have positive results for MPC107
> and MPC8540. There's also a bug fix in error detection on I2C reads,
> updated timer handling, and clock initialisation is now done only once.
>
> I plan to send this version to Greg KH unless I hear objections in the
> next few days.

I'll throw in a nit:

> diff -Nru a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
[snip]
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
...

This can be condensed down to:
 * <YEAR> (c) <COMPANY>. This file is licensed under
 * the terms of the GNU General Public License version 2. This program
 * is licensed "as is" without any warranty of any kind, whether express
 * or implied.

Or so our lawyers claim.

[snip]
> +#include <linux/kernel.h>
[snip]
> +#ifdef CONFIG_I2C_DEBUG_BUS
> +#define DPRINTK(args...) printk(KERN_DEBUG __FILE__": " args)
> +#else
> +#define DPRINTK(args...)
> +#endif

<linux/kernel> provides pr_debug (and a few others) that just depend on
DEBUG, fwiw.

And maybe Lindent the sources? :)

But as I said, merely nits.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
