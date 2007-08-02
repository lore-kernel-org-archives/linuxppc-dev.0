Return-Path: <dgibson@ozlabs.org>
Date: Thu, 2 Aug 2007 13:48:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [ PATCH ] PowerPC cascade UIC IRQ handler fix.
Message-ID: <20070802034848.GA837@localhost.localdomain>
References: <20070730163517.GA10087@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070730163517.GA10087@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2007 at 08:35:17PM +0400, Valentine Barshak wrote:
> PPC44x cascade UIC irq handler fix.
> 
> According to PPC44x UM, if an interrupt is configured as level-sensitive,
> and a clear is attempted on the UIC_SR, the UIC_SR field is not
> cleared if the incoming interrupt signal is at the asserted polarity.
> This causes us to enter a cascade handler twice, since we first ack
> parent UIC interrupt and ack child UIC one after that.
> The patch checks child UIC msr value and returns IRQ_HANDLED
> if there're no pending interrupts. Otherwise we get a kernel panic
> with a "Fatal exception in interrupt" (illegal vector).
> The patch also fixes status flags.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Hrm... This doesn't seem like the right fix to me.  Instead, I think
the cascaded IRQ handler should ack the interrupt on the child first.
I'm a little surprised it doesn't at the moment.

> ---
> 
> --- linux.orig/arch/powerpc/sysdev/uic.c	2007-07-27 20:37:11.000000000 +0400
> +++ linux/arch/powerpc/sysdev/uic.c	2007-07-30 20:26:48.000000000 +0400
> @@ -142,7 +142,7 @@
>  
>  	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
>  	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
> -	if (trigger)
> +	if (!trigger)
>  		desc->status |= IRQ_LEVEL;
>  
>  	spin_unlock_irqrestore(&uic->lock, flags);
> @@ -207,6 +207,9 @@
>  	int subvirq;
>  
>  	msr = mfdcr(uic->dcrbase + UIC_MSR);
> +	if (!msr)
> +		return IRQ_HANDLED;
> +
>  	src = 32 - ffs(msr);
>  
>  	subvirq = irq_linear_revmap(uic->irqhost, src);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
