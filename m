Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80E4667C63
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 11:26:00 +1100 (EST)
Subject: Re: [PATCH 7/15] celleb: supporting interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200612120333.kBC3Xc9L010941@toshiba.co.jp>
References: <200612120333.kBC3Xc9L010941@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 11:25:46 +1100
Message-Id: <1166055946.11914.244.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think there's a problem with interrupt handling...

> +static void beatic_end_irq(unsigned int irq_plug)
> +{
> +	int64_t err;
> +
> +	if ((err = beat_downcount_of_interrupt(irq_plug)) != 0) {
> +		if ((err & 0xFFFFFFFF) != 0xFFFFFFF5) /* -11: wrong state */
> +			panic("Failed to downcount IRQ! Error = %16lx", err);
> +
> +		printk(KERN_ERR "IRQ over-downcounted, plug %d\n", irq_plug);
> +	}
> +	beatic_unmask_irq(irq_plug);
> +}

 .../...

> +unsigned int beatic_get_irq(void)
> +{
> +	unsigned int ret;
> +
> +	ret = beatic_get_irq_plug();
> +	if (ret != NO_IRQ)
> +		beatic_mask_irq(ret);
> +	return ret;
> +}
> +

So you are masking the irq upon reception and unmasking it in eoi()...
This is not quite correct and I was hoping this wouldn't be necessary,
but it seems we are hitting a similar issues with Sony lv1...

The problem with the above approach is that the unconditional unmask in
eoi() is incorrect as the interrupt can have been disabled by software
between get_irq() and eoi().

In general, that means that the fasteoi handler isn't the right choice
for you as it assumes "smart" interrupt controllers that will not
re-emit an interrupt that has been already emited until EOI is called.

I can understand that there is a design issue with the hypervisor here,
as you have no way to "ack" an irq (so that the HV knows you actuall got
it, since a given 0x500 can be called for more than one interrupt). It's
generally done with other HV as part of get_irq() by an H-call to obtain
the next pending irq number, but your bitmask mecanism makes that
impossible.

Thus you need something which is pretty much a "bastard" of fasteoi and
level handlers... It's annoying as no existing handler matches exactly
what you need here. You can either write your own handler, possibly
based on the level one, but adding an eoi call to it, or use the eoi
one, add an empty ack() callback, and have unmask do an eoi
unconditionally if that isn't a problem for you.

Ben.
