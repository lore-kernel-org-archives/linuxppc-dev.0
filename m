Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B604C67F12
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 06:17:19 +1100 (EST)
Message-ID: <4561FF9D.9040903@ru.mvista.com>
Date: Mon, 20 Nov 2006 22:18:53 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
References: <20061119202348.GA27649@elte.hu>
	<1163985380.5826.139.camel@localhost.localdomain>
	<20061120100144.GA27812@elte.hu> <4561C9EC.3020506@ru.mvista.com>
	<20061120165621.GA1504@elte.hu> <4561DFE1.4020708@ru.mvista.com>
	<20061120172642.GA8683@elte.hu>
	<20061120175502.GA12733@elte.hu> <4561F43B.40000@ru.mvista.com>
	<20061120191013.GA30828@elte.hu> <20061120191149.GA32537@elte.hu>
In-Reply-To: <20061120191149.GA32537@elte.hu>
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

>>>   Hmm, that just won't do for PPC threaded fasteoi flows! What you'll 
>>>get is a threaded IRQ with EOI *never ever* issued, unless my PPC 
>>>patch is also in...

>>ok, how about the patch below in addition?

> or rather, the one below. Untested.

    Actually, it's been tested since it's close to Daniel's original variant. 
Should do it.

> 	Ingo

> Index: linux/kernel/irq/chip.c
> ===================================================================
> --- linux.orig/kernel/irq/chip.c
> +++ linux/kernel/irq/chip.c
> @@ -392,11 +394,12 @@ handle_fasteoi_irq(unsigned int irq, str
>  	desc->status |= IRQ_INPROGRESS;
>  
>  	/*
> -	 * In the threaded case we fall back to a mask+ack sequence:
> +	 * In the threaded case we fall back to a mask+eoi sequence:
>  	 */
>  	if (redirect_hardirq(desc)) {
> -		mask_ack_irq(desc, irq);
> -		goto out_unlock;
> +		if (desc->chip->mask)
> +			desc->chip->mask(irq);
> +		goto out;
>  	}
>  
>  	desc->status &= ~IRQ_PENDING;
> 
> 

WBR, Sergei
