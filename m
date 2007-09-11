Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18151.1452.702936.394284@cargo.ozlabs.ibm.com>
Date: Wed, 12 Sep 2007 07:16:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3] Implement arch disable/enable irq hooks.
In-Reply-To: <20070905220607.GA11330@ld0162-tx32.am.freescale.net>
References: <20070905220607.GA11330@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> These hooks ensure that a decrementer interrupt is not pending when
> suspending; otherwise, problems may occur.  For example, with deep sleep
> on the 831x, a pending decrementer will cause a system freeze because the
> SoC thinks the decrementer interrupt would have woken the system, but the
> core must have interrupts disabled due to the setup required for deep
> sleep.

> +	set_dec(0x7fffffff);
> +	local_irq_disable();
> +	set_dec(0x7fffffff);

It might be better to use hard_irq_disable rather than
local_irq_disable here, since I think we will need that on 64-bit (and
on 32-bit if we ever do lazy irq disabling there).

> +/* Overrides the weak version in kernel/power/main.c */
> +void arch_suspend_disable_irqs(void)
> +{
> +	if (ppc_md.suspend_disable_irqs)
> +		ppc_md.suspend_disable_irqs();
> +	else
> +		generic_suspend_disable_irqs();

Any particular reason why we need a ppc_md hook here?  Do we expect
some platform to need to do something different?

Paul.
