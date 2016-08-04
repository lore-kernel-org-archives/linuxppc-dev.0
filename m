Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4ljH2WB6zDqSC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 19:57:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, 
Subject: Re: [PATCH] powerpc/book3s: Fix MCE console messages for
 unrecoverable MCE.
In-Reply-To: <147028600879.16761.7577655191376075114.stgit@jupiter.in.ibm.com>
References: <147028600879.16761.7577655191376075114.stgit@jupiter.in.ibm.com>
Date: Thu, 04 Aug 2016 19:57:22 +1000
Message-ID: <87bn18g8l9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> When machine check occurs with MSR(RI=0), it means MC interrupt is
> unrecoverable and kernel goes down to panic path. But the console
> message still shows it as recovered. This patch fixes the MCE console
> messages.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/mce.c             |    3 ++-
>  arch/powerpc/platforms/powernv/opal.c |    2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index ef267fd..5e7ece0 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -92,7 +92,8 @@ void save_mce_event(struct pt_regs *regs, long handled,
>  	mce->in_use = 1;
>  
>  	mce->initiator = MCE_INITIATOR_CPU;
> -	if (handled)
> +	/* Mark it recovered if we have handled it and MSR(RI=1). */
> +	if (handled && (regs->msr & MSR_RI))
>  		mce->disposition = MCE_DISPOSITION_RECOVERED;

This seems like it has bigger implications than just changing the
printk output? We're now (correctly) marking any MC where RI=0 as
unrecoverable.

Or is the only place that uses this the code below which *also* checks
MSR_RI?

> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 5385434..8154171 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -401,6 +401,8 @@ static int opal_recover_mce(struct pt_regs *regs,
>  
>  	if (!(regs->msr & MSR_RI)) {
>  		/* If MSR_RI isn't set, we cannot recover */

Why do we check MSR_RI again here? Shouldn't we just be looking at the evt->disposition?

> +		printk(KERN_ERR "Machine check interrupt unrecoverable:"
> +				" MSR(RI=0)\n");

Are we sure it's safe to call printk() there?

Please don't split the message across lines, and use pr_err() like the
rest of the code in this file. So it would be:

		pr_err("Machine check interrupt unrecoverable: MSR(RI=0)\n");

>  		recovered = 0;
>  	} else if (evt->disposition == MCE_DISPOSITION_RECOVERED) {
>  		/* Platform corrected itself */

cheers
