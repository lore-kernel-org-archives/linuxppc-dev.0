Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8ED0FB6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 09:01:57 +1100 (EST)
Subject: Re: [RFC PATCH v2 4/6] powerpc: wii: hollywood interrupt
	controller support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <1259880447-5008-5-git-send-email-albert_herranz@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
	<1259880447-5008-5-git-send-email-albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 09:01:51 +1100
Message-ID: <1260568911.16132.364.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 23:47 +0100, Albert Herranz wrote:

> +static void hlwd_pic_irq_cascade(unsigned int cascade_virq,
> +				      struct irq_desc *desc)
> +{
> +	struct irq_host *irq_host = get_irq_data(cascade_virq);
> +	unsigned int virq;
> +
> +	spin_lock(&desc->lock);
> +	desc->chip->mask(cascade_virq); /* IRQ_LEVEL */
> +	spin_unlock(&desc->lock);
> +
> +	virq = __hlwd_pic_get_irq(irq_host);
> +	if (virq != NO_IRQ)
> +		generic_handle_irq(virq);
> +	else
> +		pr_err("spurious interrupt!\n");
> +
> +	spin_lock(&desc->lock);
> +	desc->chip->ack(cascade_virq); /* IRQ_LEVEL */
> +	if (!(desc->status & IRQ_DISABLED) && desc->chip->unmask)
> +		desc->chip->unmask(cascade_virq);
> +	spin_unlock(&desc->lock);
> +}

The above would not be necessary if instead of using a chained handler
you used a normal one, which is what I do for pmac-pic.

No big deal for now, though.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
