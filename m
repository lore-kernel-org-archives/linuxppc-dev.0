Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E34B71007E1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 02:53:51 +1100 (EST)
Subject: Re: Bug in arch/powerpc/sysdev/fsl_gtm.c
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <265ED5BA1B926340AF277A54E6A8341441FD6401F2@exchange.media5corp.com>
Date: Tue, 15 Mar 2011 10:53:42 -0500
Message-Id: <C7E7D214-CAB9-4260-928C-974F94C44A7C@kernel.crashing.org>
References: <265ED5BA1B926340AF277A54E6A8341441FD6401F2@exchange.media5corp.com>
To: Jean-Denis Boyer <jdboyer@media5corp.com>
Cc: 'Anton Vorontsov' <avorontsov@ru.mvista.com>,
	"'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 16, 2011, at 8:59 AM, Jean-Denis Boyer wrote:

> Hi.
> There is a bug in the function gtm_set_ref_timer16.
> When called, it correctly sets the requested timer,
> but the other timer that shares the register GTCFR is reset.
> 
> The parameter 'clear' passed to macro clrsetbits_8 should not be
> a bitwise complement, since the macro already complements it.
> 
> Here is a patch that should fix this issue.
> 
> --- linux-2.6.35.11/arch/powerpc/sysdev/fsl_gtm.c
> +++ linux/arch/powerpc/sysdev/fsl_gtm.c
> @@ -203,13 +203,10 @@
> 	spin_lock_irqsave(&gtm->lock, flags);
> 
> 	/*
> -	 * Properly reset timers: stop, reset, set up prescalers, reference
> +	 * Properly set timers: stop, set up prescalers, reference
> 	 * value and clear event register.
> 	 */
> -	clrsetbits_8(tmr->gtcfr, ~(GTCFR_STP(num) | GTCFR_RST(num)),
> -				 GTCFR_STP(num) | GTCFR_RST(num));
> -
> -	setbits8(tmr->gtcfr, GTCFR_STP(num));
> +	setbits8(tmr->gtcfr, GTCFR_STP(num) | GTCFR_RST(num));
> 
> 	if (tmr->gtpsr)
> 		out_be16(tmr->gtpsr, psr);

If you'd like this applied please re-send w/proper signed-off-by

- k
