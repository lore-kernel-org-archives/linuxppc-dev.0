Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F258DDE08
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 13:49:35 +1100 (EST)
In-Reply-To: <20071221203115.GA4633@localhost.localdomain>
References: <20071221202824.GA4607@localhost.localdomain>
	<20071221203115.GA4633@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b632798b4f5523653160b6a7156266e1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] [POWERPC] Implement GPIO API embryo
Date: Sun, 23 Dec 2007 03:49:30 +0100
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +int __of_parse_gpio_bank_pin(struct device_node *np, int index,
> +			     int bank_width, int max_bank)
> +{
> +	int bank;
> +	int pin;
> +	const u32 *gpios;
> +
> +	/*
> +	 * We can get there only if of_get_gpio() succeeded, thus
> +	 * no need checking for "gpios" existence.
> +	 */
> +	gpios = of_get_property(np, "gpios", NULL);
> +	bank = gpios[index * 2];
> +	pin = gpios[index * 2 + 1];

If you stick with the #gpio-cells plan, here is where you should use it.


Segher
