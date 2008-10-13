Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1031DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 19:43:42 +1100 (EST)
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions
	with callbacks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <200810130951.31733.borntraeger@de.ibm.com>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200806031445.22561.borntraeger@de.ibm.com>
	<1223875013.8157.230.camel@pasglop>
	<200810130951.31733.borntraeger@de.ibm.com>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 19:36:12 +1100
Message-Id: <1223886972.8157.241.camel@pasglop>
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  	if (--hp->count == 0) {
> -		if (hp->ops->notifier_del)
> -			hp->ops->notifier_del(hp, hp->data);
> -
>  		/* We are done with the tty pointer now. */
>  		hp->tty = NULL;
>  		spin_unlock_irqrestore(&hp->lock, flags);
>  
> +		if (hp->ops->notifier_del)
> +			hp->ops->notifier_del(hp, hp->data);
> +

I will try. Of course the risk here is that the interrupt happens
after we set hp->tty to NULL, so we probably need to check within the
interrupt handler for a NULL tty. I haven't checked if that's the case
(I'm not in front of the code right now).

Ben.
