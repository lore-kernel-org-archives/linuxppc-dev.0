Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B4687DDE33
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:55:38 +1000 (EST)
Subject: Re: [PATCH v2 5/6] Sysace: Move IRQ handler registration to occur
	after FSM is initialized
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20070930225726.2476.44211.stgit@trillian.cg.shawcable.net>
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
	<20070930225726.2476.44211.stgit@trillian.cg.shawcable.net>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:55:21 +1000
Message-Id: <1191304521.6310.94.camel@pasglop>
Mime-Version: 1.0
Cc: axboe@kernel.dk, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2007-09-30 at 16:57 -0600, Grant Likely wrote:
>         val |= ACE_CTRL_DATABUFRDYIRQ | ACE_CTRL_ERRORIRQ;
>         ace_out(ace, ACE_CTRL, val);
>  
> +       /* Now we can hook up the irq handler */
> +       if (ace->irq != NO_IRQ) {
> +               rc = request_irq(ace->irq, ace_interrupt, 0,
> "systemace", ace);
> +               if (rc) {
> +                       /* Failure - fall back to polled mode */
> +                       dev_err(ace->dev, "request_irq failed\n");
> +                       ace->irq = NO_IRQ;
> +               }
> +       }
> +

I don't know the HW but from the above, it looks like you enable
interrupt emission on the HW before you register the handler, which is
wrong. You should make sure on the contrary that IRQs on the HW are
disabled until after you have registered a handler.

Only really a problem if you have shared interrupts but still...

Ben.
