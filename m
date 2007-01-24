Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8DA5DDF29
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 17:35:44 +1100 (EST)
Subject: Re: [PATCH 3/3] powerpc: fix comment in kernel/irq.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <20061213123945.859071000@sipsolutions.net>>
References: <20061213123819.403286000@sipsolutions.net> >
	<20061213123945.859071000@sipsolutions.net>>
Content-Type: text/plain
Date: Wed, 24 Jan 2007 17:35:38 +1100
Message-Id: <1169620538.18754.68.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-13 at 13:38 +0100, Johannes Berg wrote:
> plain text document attachment (irq-comment.patch)
> kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
> numbers, but this is actually dependent on configuration options now.
> Replace by NO_IRQ and NO_IRQ_ENABLED.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- linux-2.6-git.orig/arch/powerpc/kernel/irq.c	2006-12-13 12:03:44.406144791 +0100
> +++ linux-2.6-git/arch/powerpc/kernel/irq.c	2006-12-13 12:04:05.727144791 +0100
> @@ -281,10 +281,10 @@ void do_IRQ(struct pt_regs *regs)
>  
>  	/*
>  	 * Every platform is required to implement ppc_md.get_irq.
> -	 * This function will either return an irq number or -1 to
> +	 * This function will either return an irq number or NO_IRQ to
>  	 * indicate there are no more pending.
> -	 * The value -2 is for buggy hardware and means that this IRQ
> -	 * has already been handled. -- Tom
> +	 * The value NO_IRQ_IGNORE is for buggy hardware and means that this
> +	 * IRQ has already been handled. -- Tom
>  	 */
>  	irq = ppc_md.get_irq();
>  
> 
> --
