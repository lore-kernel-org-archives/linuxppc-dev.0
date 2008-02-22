Return-Path: <jwboyer@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 159E7DDF0B
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 07:49:46 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 25so348590wfa.15
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 12:49:45 -0800 (PST)
Date: Fri, 22 Feb 2008 14:49:19 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [RFC][PATCH] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock
	workaround
Message-ID: <20080222144919.3ded7c54@weaponx>
In-Reply-To: <20080222192817.GA26211@ru.mvista.com>
References: <1203634340.10422.203.camel@pasglop>
	<20080222192817.GA26211@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 22 Feb 2008 22:28:17 +0300
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> This patch adds ibm_newemac phy clock workaround for 440EP/440GR emacs.
> The code is based on the previous ibm_emac driver stuff. The 440EP/440GR
> allows controlling each EMAC clock spearately as opposed to global clock
> selection for 440GX.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---

[snip]

> +/* EMAC PHY clock workaround:
> + * 440EP/440GR has more sane SDR0_MFR register implementation than 440GX,
> + * which allows controlling each EMAC clock
> + */
> +static inline void emac_rx_clk_tx(struct emac_instance *dev)
> +{
> +	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX)) {
> +		unsigned long flags;
> +
> +		local_irq_save(flags);
> +		mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) |
> +					(SDR0_MFR_ECS >> dev->cell_index));
> +		local_irq_restore(flags);
> +	}
> +}
> +
> +static inline void emac_rx_clk_default(struct emac_instance *dev)
> +{
> +	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX)) {
> +		unsigned long flags;
> +
> +		local_irq_save(flags);
> +		mtdcri(SDR0, SDR0_MFR, mfdcri(SDR0, SDR0_MFR) &
> +					~(SDR0_MFR_ECS >> dev->cell_index));
> +		local_irq_restore(flags);
> +	}
> +}

Why did you do local_irq_save in these two functions?  mtdcri already
does spin_lock_irqsave...

josh
