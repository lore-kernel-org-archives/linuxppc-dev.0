Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC8E967D71
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 07:11:21 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061120175502.GA12733@elte.hu>
References: <1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
	<20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com>
	<20061120172642.GA8683@elte.hu>  <20061120175502.GA12733@elte.hu>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 07:11:33 +1100
Message-Id: <1164053493.8073.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Index: linux/kernel/irq/chip.c
> ===================================================================
> --- linux.orig/kernel/irq/chip.c
> +++ linux/kernel/irq/chip.c
> @@ -238,8 +238,10 @@ static inline void mask_ack_irq(struct i
>  	if (desc->chip->mask_ack)
>  		desc->chip->mask_ack(irq);
>  	else {
> -		desc->chip->mask(irq);
> -		desc->chip->ack(irq);
> +		if (desc->chip->mask)
> +			desc->chip->mask(irq);
> +		if (desc->chip->mask)
> +			desc->chip->ack(irq);

Looks like a typo to me :-)

Cheers,
Ben.
