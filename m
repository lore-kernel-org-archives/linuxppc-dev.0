Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 683802C0205
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 18:26:34 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q6A8QTk2000502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 03:26:30 -0500
Message-ID: <1341908789.2561.16.camel@pasglop>
Subject: Re: [PATCH] More fixes for lazy IRQ vs. idle
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 10 Jul 2012 18:26:29 +1000
In-Reply-To: <1341891538.2561.10.camel@pasglop>
References: <1341891538.2561.10.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -	hard_irq_disable();
> -	if (!lazy_irq_pending())
> +	if (prep_irq_for_idle()) {
>  		cede_processor();
> +#ifdef CONFIG_TRACE_IRQFLAG

this is IRQFLAGS (missing "S"). I'll fix it while I commit, the same
typo is in another place in irq.c as well, I'll commit a fix for that
too and shoot the whole thing to Linus.
 
> +		/* Ensure that H_CEDE returns with IRQs on */
> +		WARN_ON(!(mfmsr() & MSR_EE));
> +#endif
> +	}
>  }
>  
>  static int dedicated_cede_loop(struct cpuidle_device *dev,
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
