Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD008DDF35
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 17:38:46 +1000 (EST)
Subject: Re: [patch 4/4] powerpc 2.6.21-rt1: reduce scheduling latency by
	changing tlb flush size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
In-Reply-To: <yyips5261pt.wl@toshiba.co.jp>
References: <yyi3b1zapqa.wl@toshiba.co.jp>
	<1179125506.22481.297.camel@localhost.localdomain>
	<yyitzuf9857.wl@toshiba.co.jp> <200705141640.02561.arnd@arndb.de>
	<yyips5261pt.wl@toshiba.co.jp>
Content-Type: text/plain
Date: Tue, 15 May 2007 17:38:27 +1000
Message-Id: <1179214707.32247.177.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	mingo@elte.hu, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +
> +#ifdef CONFIG_PREEMPT_RT
> +	/*
> +	 * Since flushing tlb needs expensive hypervisor call(s) on celleb,
> +	 * always flush it on RT to reduce scheduling latency.
> +	 */
> +	if (machine_is(celleb)) {
> +		flush_tlb_pending();
> +		return;
> +	}
> +#endif /* CONFIG_PREEMPT_RT */
> +
>  	if (i >= PPC64_TLB_BATCH_NR)
>  		flush_tlb_pending();
>  }

Any reason to do that only on celleb ? :-)

Also, we might want to still batch, though in smaller amount. Have you measured
the time it takes ? We might want to modulate the amount based on wether we
are using native hash tables or an hypervisor.

Ben.
