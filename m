Return-Path: <johnpol@2ka.mipt.ru>
Received: from 2ka.mipt.ru (relay.2ka.mipt.ru [194.85.82.65])
	by ozlabs.org (Postfix) with ESMTP id B702CDE3F0
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 04:14:34 +1000 (EST)
Date: Fri, 30 May 2008 22:09:04 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 2/2] talitos: Freescale integrated security engine (SEC)
	driver
Message-ID: <20080530180904.GA18945@2ka.mipt.ru>
References: <20080529141250.0946b02c.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080529141250.0946b02c.kim.phillips@freescale.com>
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

Hi.

On Thu, May 29, 2008 at 02:12:50PM -0500, Kim Phillips (kim.phillips@freescale.com) wrote:

> +static irqreturn_t talitos_interrupt(int irq, void *data)
> +{
> +	struct device *dev = data;
> +	struct talitos_private *priv = dev_get_drvdata(dev);
> +
> +	priv->status = in_be32(priv->reg + TALITOS_ISR);
> +	priv->status_lo = in_be32(priv->reg + TALITOS_ISR_LO);
> +
> +	if (unlikely(priv->status & ~TALITOS_ISR_CHDONE)) {
> +		talitos_error((unsigned long)data);
> +		/* ack */
> +		out_be32(priv->reg + TALITOS_ICR, priv->status);
> +		out_be32(priv->reg + TALITOS_ICR_LO, priv->status_lo);
> +	}
> +	else
> +	{
> +		/* ack */
> +		out_be32(priv->reg + TALITOS_ICR, priv->status);
> +		out_be32(priv->reg + TALITOS_ICR_LO, priv->status_lo);
> +
> +		if (likely(priv->status & TALITOS_ISR_CHDONE))
> +			tasklet_schedule(&priv->done_task);
> +	}
> +
> +	return (priv->status || priv->status_lo) ? IRQ_HANDLED : IRQ_NONE;
> +}

Don't you want to protect against simultaneous access to register space
from different CPUs? Or it is single processor board only?

-- 
	Evgeniy Polyakov
