Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0B77DDEC0
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Aug 2007 05:26:49 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7FJQkVe002708
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 15:26:46 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7FJQjA9354010
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 15:26:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7FJQjO5007156
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 15:26:45 -0400
Date: Wed, 15 Aug 2007 14:25:27 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/3] Improve robustness of the UIC cascade handler
Message-ID: <20070815142527.7359755c@zod.rchland.ibm.com>
In-Reply-To: <20070814035242.CAE2BDDEFD@ozlabs.org>
References: <20070814034811.GA8791@localhost.localdomain>
	<20070814035242.CAE2BDDEFD@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Aug 2007 13:52:42 +1000 (EST)
David Gibson <david@gibson.dropbear.id.au> wrote:

> At present the cascade interrupt handler for the UIC (interrupt
> controller on 4xx embedded chips) will misbehave badly if it is called
> spuriously - that is if the handler is invoked when no interrupts are
> asserted in the child UIC.
> 
> Although spurious interrupts shouldn't happen, it's good to behave
> robustly if they do.  This patch does so by checking for and ignoring
> spurious interrupts.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> ---
>  arch/powerpc/sysdev/uic.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: working-2.6/arch/powerpc/sysdev/uic.c
> ===================================================================
> --- working-2.6.orig/arch/powerpc/sysdev/uic.c	2007-08-14 13:46:02.000000000 +1000
> +++ working-2.6/arch/powerpc/sysdev/uic.c	2007-08-14 13:46:02.000000000 +1000
> @@ -266,6 +266,9 @@ irqreturn_t uic_cascade(int virq, void *
>  	int subvirq;
> 
>  	msr = mfdcr(uic->dcrbase + UIC_MSR);
> +	if (!msr) /* spurious interrupt */
> +		return IRQ_HANDLED;

Hm.  Is there was a way we could have this case increment
ppc_spurious_interrupts so that the BAD entry in /proc/interrupts would
be updated with these?  Not a huge deal, but it might be nice to have.
Otherwise the patch looks fine.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
