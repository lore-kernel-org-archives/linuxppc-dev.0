Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9285ADDF44
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 02:50:10 +1100 (EST)
Message-ID: <4760031A.6020005@scram.de>
Date: Wed, 12 Dec 2007 16:49:46 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 3/7] [POWERPC] CPM2: implement GPIO API
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204845.GC32278@localhost.localdomain>
In-Reply-To: <20071210204845.GC32278@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

> +int gpio_direction_input(unsigned int gpio)
> +{
> +	unsigned long flags;
> +	int port = gpio / 32;
> +	int pin = gpio % 32;
> +
> +	spin_lock_irqsave(&cpm2_port_locks[port], flags);
> +
> +	cpm2_set_pin(port, pin, CPM_PIN_INPUT | CPM_PIN_GPIO);

> +int gpio_direction_output(unsigned int gpio, int value)
> +{
> +	struct cpm2_ioports __iomem *iop =
> +		(struct cpm2_ioports __iomem *)&cpm2_immr->im_ioport;
> +	int port = gpio / 32;
> +	int pin = gpio % 32;
> +	unsigned long flags;
> +
> +	pin = 1 << (31 - pin);
> +
> +	spin_lock_irqsave(&cpm2_port_locks[port], flags);
> +
> +	cpm2_set_pin(port, pin, CPM_PIN_OUTPUT | CPM_PIN_GPIO);

You seem to do the pin -> bitmask conversation twice in gpio_direction_output().

cpm2_set_pin() must be executed before pin = 1 << (31 - pin);

Thanks,
Jochen
