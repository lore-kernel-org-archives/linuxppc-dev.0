Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1ADADDE9D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 08:03:58 +1100 (EST)
Subject: Re: [PATCH] ipic: change ack operation that register is accessed
	only when needed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1196684780-28408-1-git-send-email-leoli@freescale.com>
References: <1196684780-28408-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 08:02:27 +1100
Message-Id: <1196715747.13230.233.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  static void ipic_ack_irq(unsigned int virq)
>  {
> -	struct ipic *ipic = ipic_from_irq(virq);
>  	unsigned int src = ipic_irq_to_hw(virq);
> -	unsigned long flags;
> -	u32 temp;
>  
> -	spin_lock_irqsave(&ipic_lock, flags);
> +	/* Only external interrupts in edge mode support ACK */
> +	if (unlikely(ipic_info[src].ack &&
> +			((get_irq_desc(virq)->status & IRQ_TYPE_SENSE_MASK) ==
> +			IRQ_TYPE_EDGE_FALLING))) {
> +		struct ipic *ipic = ipic_from_irq(virq);
> +		unsigned long flags;
> +		u32 temp;
>  
> -	temp = ipic_read(ipic->regs, ipic_info[src].pend);
> -	temp |= (1 << (31 - ipic_info[src].bit));
> -	ipic_write(ipic->regs, ipic_info[src].pend, temp);
> +		spin_lock_irqsave(&ipic_lock, flags);
>  
> -	spin_unlock_irqrestore(&ipic_lock, flags);
> +		temp = ipic_read(ipic->regs, ipic_info[src].ack);
> +		temp |= (1 << (31 - ipic_info[src].bit));
> +		ipic_write(ipic->regs, ipic_info[src].ack, temp);
> +
> +		spin_unlock_irqrestore(&ipic_lock, flags);
> +	}
>  }

That doesn't look right... 

That should be handled by the higher level flow handler. The generic
edge one calls ack and the level one mask_and_ack. Just make them do the
right thing, no need to test for the flow type in the low level
function.

Ben.
