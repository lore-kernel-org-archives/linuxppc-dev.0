Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C97A6B6F87
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 04:44:48 +1100 (EST)
Message-ID: <4ED3C875.5050002@freescale.com>
Date: Mon, 28 Nov 2011 11:44:21 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/6] powerpc/time: Handle wrapping of decrementer
References: <20111124060716.362614789@samba.org>
 <20111124060847.105131188@samba.org>
In-Reply-To: <20111124060847.105131188@samba.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com,
 johnstul@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/24/2011 12:07 AM, Anton Blanchard wrote:
> Index: linux-build/arch/powerpc/kernel/irq.c
> ===================================================================
> --- linux-build.orig/arch/powerpc/kernel/irq.c	2011-11-17 10:04:16.551137554 +1100
> +++ linux-build/arch/powerpc/kernel/irq.c	2011-11-17 14:23:10.834514143 +1100
> @@ -164,16 +164,13 @@ notrace void arch_local_irq_restore(unsi
>  	 */
>  	local_paca->hard_enabled = en;
>  
> -#ifndef CONFIG_BOOKE
> -	/* On server, re-trigger the decrementer if it went negative since
> -	 * some processors only trigger on edge transitions of the sign bit.
> -	 *
> -	 * BookE has a level sensitive decrementer (latches in TSR) so we
> -	 * don't need that
> +	/*
> +	 * Trigger the decrementer if we have a pending event. Some processors
> +	 * only trigger on edge transitions of the sign bit. We might also
> +	 * have disabled interrupts long enough that the decrementer wrapped
> +	 * to positive.
>  	 */
> -	if ((int)mfspr(SPRN_DEC) < 0)
> -		mtspr(SPRN_DEC, 1);
> -#endif /* CONFIG_BOOKE */
> +	decrementer_check_overflow();

Where did the #ifndef CONFIG_BOOKE go?  BookE doesn't need this; the
interrupt will continue asserting until software clears TSR[DIS].

-Scott
