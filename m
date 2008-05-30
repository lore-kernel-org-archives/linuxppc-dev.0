Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 728A2DE718
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 05:38:14 +1000 (EST)
Date: Fri, 30 May 2008 14:36:14 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 2/2] talitos: Freescale integrated security engine (SEC)
	driver
Message-Id: <20080530143614.1e675228.kim.phillips@freescale.com>
In-Reply-To: <20080530180904.GA18945@2ka.mipt.ru>
References: <20080529141250.0946b02c.kim.phillips@freescale.com>
	<20080530180904.GA18945@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, mr.scada@gmail.com, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 May 2008 22:09:04 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> Hi.
> 
> On Thu, May 29, 2008 at 02:12:50PM -0500, Kim Phillips (kim.phillips@freescale.com) wrote:
> 
> > +static irqreturn_t talitos_interrupt(int irq, void *data)
> > +{
> > +	struct device *dev = data;
> > +	struct talitos_private *priv = dev_get_drvdata(dev);
> > +
> > +	priv->status = in_be32(priv->reg + TALITOS_ISR);
> > +	priv->status_lo = in_be32(priv->reg + TALITOS_ISR_LO);
> > +
> > +	if (unlikely(priv->status & ~TALITOS_ISR_CHDONE)) {
> > +		talitos_error((unsigned long)data);
> > +		/* ack */
> > +		out_be32(priv->reg + TALITOS_ICR, priv->status);
> > +		out_be32(priv->reg + TALITOS_ICR_LO, priv->status_lo);
> > +	}
> > +	else
> > +	{
> > +		/* ack */
> > +		out_be32(priv->reg + TALITOS_ICR, priv->status);
> > +		out_be32(priv->reg + TALITOS_ICR_LO, priv->status_lo);
> > +
> > +		if (likely(priv->status & TALITOS_ISR_CHDONE))
> > +			tasklet_schedule(&priv->done_task);
> > +	}
> > +
> > +	return (priv->status || priv->status_lo) ? IRQ_HANDLED : IRQ_NONE;
> > +}
> 
> Don't you want to protect against simultaneous access to register space
> from different CPUs? Or it is single processor board only?

Doesn't linux mask the IRQ line for the interrupt currently being
serviced, and on all processors?

Kim
