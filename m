Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 848F3DE17B
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 04:19:50 +1000 (EST)
Subject: Re: [PATCH v3 4/4] powerpc/mpc5200: Add mpc5200-spi (non-PSC)
	device driver
From: Daniel Walker <dwalker@mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080725073326.8485.99210.stgit@trillian.secretlab.ca>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<20080725073326.8485.99210.stgit@trillian.secretlab.ca>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 14:19:14 -0400
Message-Id: <1217009954.13539.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-25 at 03:33 -0400, Grant Likely wrote:

> +	if (status && (irq != NO_IRQ))
> +		dev_err(&ms->master->dev, "spurious irq, status=0x%.2x\n",
> +			status);
> +
> +	/* Check if there is another transfer waiting */
> +	if (list_empty(&ms->queue))
> +		return FSM_STOP;

I don't think doing list_empty outside the critical section is totally
safe.. You might want to move it down inside the spin_lock() section.

> +	/* Get the next message */
> +	spin_lock(&ms->lock);

The part that's a little confusing here is that the interrupt can
actually activate the workqueue .. So I'm wondering if maybe you could
have this interrupt driven any workqueue driven at the same time? If you
could then you would need the above to be 
spin_lock_irq/spin_lock_irqsave ..

Daniel
