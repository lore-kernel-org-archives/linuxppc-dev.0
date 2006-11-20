Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 6A04267F3B
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 05:28:45 +1100 (EST)
Message-ID: <4561F43B.40000@ru.mvista.com>
Date: Mon, 20 Nov 2006 21:30:19 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
References: <1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
	<20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com>
	<20061120172642.GA8683@elte.hu> <20061120175502.GA12733@elte.hu>
In-Reply-To: <20061120175502.GA12733@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: dwalker@mvista.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Ingo Molnar wrote:

>>i'm hacking up something now to see whether it makes sense to 
>>introduce a central threaded flow type, or whether it's better the 
>>branch off the current flow types (as the code does it right now).

> ok, a central flow type caused more problems than good - the main 
> complication is that the handler needs to know the true 'flow' 
> (edge/level/fasteoi, etc.) anyway, even in the threaded case.

> So i rather went on making the existing flow handlers more 
> threading-friendly, and undoing the x86_64 and i386 arch changes to make 
> sure that the default handlers all work fine. Does the patch below 
> (against -rt4) do the trick for your on PPC too?

    Not without my patch.

> 	Ingo
> 
> Index: linux/arch/i386/kernel/io_apic.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/io_apic.c
> +++ linux/arch/i386/kernel/io_apic.c
> @@ -1272,22 +1272,12 @@ static struct irq_chip ioapic_chip;
>  static void ioapic_register_intr(int irq, int vector, unsigned long trigger)
>  {
>  	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
> -			trigger == IOAPIC_LEVEL) {
> -#ifdef CONFIG_PREEMPT_HARDIRQS
> +			trigger == IOAPIC_LEVEL)
>  		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> -					    handle_level_irq, "level-threaded");
> -#else
> -		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> -					      handle_fasteoi_irq, "fasteoi");
> -#endif
> -	} else {
> -#ifdef CONFIG_PREEMPT_HARDIRQS
> +					 handle_fasteoi_irq, "fasteoi");
> +	else {
>  		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> -					      handle_edge_irq, "edge-threaded");
> -#else
> -		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> -					      handle_edge_irq, "edge");
> -#endif
> +					 handle_edge_irq, "edge");

    Hm, why force edge flow on edge-triggered IRQs?

>  	}
>  	set_intr_gate(vector, interrupt[irq]);
>  }
> Index: linux/arch/x86_64/kernel/io_apic.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/io_apic.c
> +++ linux/arch/x86_64/kernel/io_apic.c
> @@ -787,22 +787,12 @@ static struct irq_chip ioapic_chip;
>  static void ioapic_register_intr(int irq, int vector, unsigned long trigger)
>  {
>  	if ((trigger == IOAPIC_AUTO && IO_APIC_irq_trigger(irq)) ||
> -			trigger == IOAPIC_LEVEL) {
> -#ifdef CONFIG_PREEMPT_HARDIRQS
> -		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> -					    handle_level_irq, "level-threaded");
> -#else
> +			trigger == IOAPIC_LEVEL)
>  		set_irq_chip_and_handler_name(irq, &ioapic_chip,
>  					      handle_fasteoi_irq, "fasteoi");
> -#endif
> -	} else {
> -#ifdef CONFIG_PREEMPT_HARDIRQS
> -		set_irq_chip_and_handler_name(irq, &ioapic_chip,
> -					      handle_edge_irq, "edge-threaded");
> -#else
> +	else {
>  		set_irq_chip_and_handler_name(irq, &ioapic_chip,
>  					      handle_edge_irq, "edge");

     Same here...

> -#endif
>  	}
>  }
>  
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
>  	}
>  }

    Hmm, that just won't do for PPC threaded fasteoi flows! What you'll get is 
a threaded IRQ with EOI *never ever* issued, unless my PPC patch is also in...

WBR, Sergei
