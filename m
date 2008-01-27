Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B5A14DDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 00:40:40 +1100 (EST)
Message-ID: <479C8A34.2000701@scram.de>
Date: Sun, 27 Jan 2008 14:42:12 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/3] [POWERPC] QE: implement GPIO LIB API
References: <20080108184341.GA29753@localhost.localdomain>
	<20080108184525.GC18445@localhost.localdomain>
In-Reply-To: <20080108184525.GC18445@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

> +static void qe_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct port_regs *regs = mm_gc->regs;
> +	u32 pin_mask;
> +	u32 tmp_val;
> +
> +	/* calculate pin location */
> +	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - gpio));
> +
> +	tmp_val = in_be32(&regs->cpdata);
> +
> +	if (val == 0)
> +		out_be32(&regs->cpdata, ~pin_mask & tmp_val);
> +	else
> +		out_be32(&regs->cpdata, pin_mask | tmp_val);
> +}

I see a possible problem with this (and in the corresponding call in CPM1, as well):

if there is a pin configured as open drain, you might accidently switch this pin to 0
while switching a different pin, if an external device is pulling the pin to 0.

i2c-gpio.c and w1-gpio.c (in -mm) are examples of drivers which use open drain pins
and which would fail if another pin on the same port would be set during a transfer.

Thanks,
Jochen
