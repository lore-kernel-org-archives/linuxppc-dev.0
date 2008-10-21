Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E3E8DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 18:32:54 +1100 (EST)
Subject: Re: Bug in "genirq: record trigger type"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20081021072857.GA333@elte.hu>
References: <200810202205.m9KM5une024759@hera.kernel.org>
	<1224570730.7654.242.camel@pasglop>
	<86802c440810210022i75d3c081r8fc979386cdda9ce@mail.gmail.com>
	<20081021072857.GA333@elte.hu>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 18:32:23 +1100
Message-Id: <1224574343.7654.244.camel@pasglop>
Mime-Version: 1.0
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Yinghai Lu <yinghai@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-21 at 09:28 +0200, Ingo Molnar wrote:

> From: Chris Friesen <cfriesen@nortel.com>
> Date: Mon, 20 Oct 2008 12:41:58 -0600
> Subject: [PATCH] genirq: fix set_irq_type() when recording trigger type
> 
> In set_irq_type() we want to pass the type rather than the current
> interrupt state.
> 
> Signed-off-by: Chris Friesen <cfriesen@nortel.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  kernel/irq/chip.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 4895fde..3de6ea3 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -127,7 +127,7 @@ int set_irq_type(unsigned int irq, unsigned int type)
>  		return 0;
>  
>  	spin_lock_irqsave(&desc->lock, flags);
> -	ret = __irq_set_trigger(desc, irq, flags);
> +	ret = __irq_set_trigger(desc, irq, type);
>  	spin_unlock_irqrestore(&desc->lock, flags);
>  	return ret;
>  }
