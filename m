Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B83A3B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 08:23:39 +1100 (EST)
In-Reply-To: <1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8E6E11A2-25F1-4AB8-B42E-58C269018CD2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
Date: Tue, 24 Nov 2009 22:30:22 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>  config GAMECUBE_COMMON
>  	bool
>  	select NOT_COHERENT_CACHE
> +	select FLIPPER_PIC

Maybe using FLIPPER (or GAMECUBE_FLIPPER) instead of GAMECUBE_COMMON
is a good name?

> +#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt

Unused

> +/*
> + * Each interrupt has a corresponding bit in both
> + * the Interrupt Cause (ICR) and Interrupt Mask (IMR) registers.
> + *
> + * Enabling/disabling an interrupt line involves asserting/clearing
> + * the corresponding bit in IMR. ACK'ing a request simply involves
> + * asserting the corresponding bit in ICR.
> + */

> +static void flipper_pic_ack(unsigned int virq)
> +{
> +	int irq = virq_to_hw(virq);
> +	void __iomem *io_base = get_irq_chip_data(virq);
> +
> +	set_bit(irq, io_base + FLIPPER_ICR);
> +}

So it should be a simple write instead of an RMW here, right?
As it is you are ACKing _all_ IRQs as far as I can see.

> +unsigned int flipper_pic_get_irq(void)
> +{
> +	void __iomem *io_base = flipper_irq_host->host_data;
> +	int irq;
> +	u32 irq_status;
> +
> +	irq_status = in_be32(io_base + FLIPPER_ICR) &
> +		     in_be32(io_base + FLIPPER_IMR);
> +	if (irq_status == 0)
> +		return -1;	/* no more IRQs pending */
> +
> +	__asm__ __volatile__("cntlzw %0,%1" : "=r"(irq) : "r"(irq_status));
> +	return irq_linear_revmap(flipper_irq_host, 31 - irq);
> +}

There are generic macros for this kind of thing, no need for asm.  ffs()
or something.


Segher
