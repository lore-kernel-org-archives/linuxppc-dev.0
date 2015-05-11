Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A68C1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 19:18:47 +1000 (AEST)
In-Reply-To: <1430968578-23527-5-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,
 5/8] powernv/opal: Convert opal message events to opal irq domain
Message-Id: <20150511091847.4D40314029C@ozlabs.org>
Date: Mon, 11 May 2015 19:18:47 +1000 (AEST)
Cc: Alistair Popple <alistair@popple.id.au>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-05 at 03:16:15 UTC, Alistair Popple wrote:
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 4399ff2..0196220 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -362,33 +362,34 @@ static void opal_handle_message(void)
>  	opal_message_do_notify(type, (void *)&msg);
>  }
>  
> -static int opal_message_notify(struct notifier_block *nb,
> -			  unsigned long events, void *change)
> +static irqreturn_t opal_message_notify(int irq, void *data)
>  {
> -	if (events & OPAL_EVENT_MSG_PENDING)
> -		opal_handle_message();
> -	return 0;
> +	opal_handle_message();
> +	return IRQ_HANDLED;
>  }
>  
> -static struct notifier_block opal_message_nb = {
> -	.notifier_call	= opal_message_notify,
> -	.next		= NULL,
> -	.priority	= 0,
> -};
> -
>  static int __init opal_message_init(void)
>  {
> -	int ret, i;
> +	int ret, i, irq;
>  
>  	for (i = 0; i < OPAL_MSG_TYPE_MAX; i++)
>  		ATOMIC_INIT_NOTIFIER_HEAD(&opal_msg_notifier_head[i]);
>  
> -	ret = opal_notifier_register(&opal_message_nb);
> +	irq = opal_event_request(ilog2(OPAL_EVENT_MSG_PENDING));
> +	if (!irq) {
> +		pr_err("%s: Can't register OPAL event irq (%d)\n",
> +		       __func__, irq);
> +		return irq;
> +	}


On mambo this is giving me:

  irq: XICS didn't like hwirq-0xb to VIRQ17 mapping (rc=-22)
  opal: opal_message_init: Can't register OPAL event irq (0)


Which suggests your irq domain is NULL and it's falling back to XICS?

And it never gets to userspace, which I guess is related, but might not be.

cheers
