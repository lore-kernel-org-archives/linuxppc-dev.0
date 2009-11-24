Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02709B6F29
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 08:47:41 +1100 (EST)
In-Reply-To: <1258927311-4340-17-git-send-email-albert_herranz@yahoo.es>
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
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-14-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-15-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-16-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-17-git-se! nd-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <97D41F17-CF79-4AA1-B9E6-1F979A11B77E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 16/19] powerpc: wii: hollywood interrupt controller
	support
Date: Tue, 24 Nov 2009 22:54:20 +0100
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

> +config HLWD_PIC

Are vowels too expensive?  :-)

> +static void hlwd_pic_ack(unsigned int virq)
> +{
> +	int irq = virq_to_hw(virq);
> +	void __iomem *io_base = get_irq_chip_data(virq);
> +
> +	set_bit(irq, io_base + HW_BROADWAY_ICR);
> +}

Same issue as with Flipper here.

> +	__asm__ __volatile__("cntlzw %0,%1" : "=r"(irq) : "r"(irq_status));
> +	return irq_linear_revmap(h, 31 - irq);

And here.

> +static void __hlwd_quiesce(void __iomem *io_base)
> +{
> +	/* mask and ack all IRQs */
> +	out_be32(io_base + HW_BROADWAY_IMR, 0);
> +	out_be32(io_base + HW_BROADWAY_ICR, ~0);
> +}

I would write 0xffffffff instead, it's clearer and slightly
more robust.

> +void hlwd_pic_probe(void)
> +{
> +	struct irq_host *host;
> +	struct device_node *np;
> +	const u32 *interrupts;
> +	int cascade_virq;
> +
> +	for_each_compatible_node(np, NULL, "nintendo,hollywood-pic") {
> +		interrupts = of_get_property(np, "interrupts", NULL);
> +		if (interrupts) {
> +			host = hlwd_pic_init(np);
> +			BUG_ON(!host);
> +			cascade_virq = irq_of_parse_and_map(np, 0);
> +			set_irq_data(cascade_virq, host);
> +			set_irq_chained_handler(cascade_virq,
> +						hlwd_pic_irq_cascade);

break;  here?  You do not handle more than one hollywood-pic elsewhere
(which of course is fine).


Segher
