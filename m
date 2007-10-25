Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B546DDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 04:01:16 +1000 (EST)
Date: Thu, 25 Oct 2007 13:01:29 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
Message-ID: <20071025180129.GA4582@loki.buserror.net>
References: <20071023212404.GA30942@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023212404.GA30942@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 04:24:04PM -0500, Scott Wood wrote:
> +#ifdef CONFIG_SUSPEND
> +void generic_suspend_disable_irqs(void)
> +{
> +	preempt_disable();
> +
> +	/* Disable the decrementer, so that it doesn't interfere
> +	 * with suspending.
> +	 */
> +
> +	set_dec(0x7fffffff);
> +	hard_irq_disable();
> +	set_dec(0x7fffffff);
> +}
> +
> +void generic_suspend_enable_irqs(void)
> +{
> +	wakeup_decrementer();
> +
> +	local_irq_enable();
> +	preempt_enable();
> +}

Doh, that should be hard_irq_enable().

-Scott
