Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C71867CE2
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 09:36:49 +1100 (EST)
Subject: Re: [PATCH] PowerPC: clockevents and HRT support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <200611080005.08633.sshtylyov@ru.mvista.com>
References: <200611080005.08633.sshtylyov@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 09:36:37 +1100
Message-Id: <1162938997.28571.534.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, greg.weeks@timesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +#ifdef CONFIG_PPC_MULTIPLATFORM
> +	/*
> +	 * We must write a positive value to the decrementer to clear
> +	 * the interrupt on the IBM 970 CPU series.  In periodic mode,
> +	 * this happens when the decrementer gets reloaded later, but
> +	 * in one-shot mode, we have to do it here since an event handler
> +	 * may skip loading the new value...
> +	 */
> +	if (per_cpu(decrementers, cpu).mode != CLOCK_EVT_PERIODIC)
> +		set_dec(DECREMENTER_MAX);
> +#endif

PPC_MULTIPLATFORM is going away soon (or will be set for all CPU types
in arch/powerpc). Just make up a macro at the top of the file around the
lines of

#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
#define PPC_BOOKE_DECREMENTER
#endif

And use #if(n)def PPC_BOOKE_DECREMENTER in the rest of the code.

Also, what's the problem with ppc64 deterministic accounting that you
can't fix it ?

Ben.
