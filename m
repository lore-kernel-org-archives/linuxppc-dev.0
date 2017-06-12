Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmSZg3yN5zDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 19:41:14 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5C9ddtK066080
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 05:41:11 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b19pufj7b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 05:41:11 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 03:41:10 -0600
Date: Mon, 12 Jun 2017 15:11:06 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/14] powerpc/64s: idle process interrupts from system
 reset wakeup
Reply-To: ego@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170611235835.7400-5-npiggin@gmail.com>
Message-Id: <20170612094105.GC10921@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Mon, Jun 12, 2017 at 09:58:25AM +1000, Nicholas Piggin wrote:
> When the CPU wakes from low power state, it begins at the system reset
> interrupt with the exception that caused the wakeup encoded in SRR1.
> 
> Today, powernv idle wakeup ignores the wakeup reason (except a special
> case for HMI), and the regular interrupt corresponding to the
> exception will fire after the idle wakeup exits.
> 
> Change this to replay the interrupt from the idle wakeup before
> interrupts are hard-enabled.
> 
> Test on POWER8 of context_switch selftests benchmark with polling idle
> disabled (e.g., always nap, giving cross-CPU IPIs) gives the following
> results:
> 
>                                 original         wakeup direct
> Different threads, same core:   315k/s           264k/s
> Different cores:                235k/s           242k/s
> 
> There is a slowdown for doorbell IPI (same core) case because system
> reset wakeup does not clear the message and the doorbell interrupt
> fires again needlessly.

Should we clear the doorbell message if we are recording the fact that
the Doorbell irq has happened in paca ?

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h     |  2 ++
>  arch/powerpc/kernel/irq.c             | 25 +++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/idle.c | 10 ++++++++--
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index f06112cf8734..8366bdc69988 100644

[..snip..]

> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -348,6 +348,7 @@ bool prep_irq_for_idle(void)
>  	return true;
>  }
> 
> +#ifdef CONFIG_PPC_BOOK3S
>  /*
>   * This is for idle sequences that return with IRQs off, but the
>   * idle state itself wakes on interrupt. Tell the irq tracer that
> @@ -379,6 +380,30 @@ bool prep_irq_for_idle_irqsoff(void)
>  }
> 
>  /*
> + * Take the SRR1 wakeup reason, index into this table to find the
> + * appropriate irq_happened bit.
> + */
> +static const u8 srr1_to_irq[0x10] = {
> +	0, 0, 0,
> +	PACA_IRQ_DBELL,
> +	0,
> +	PACA_IRQ_DBELL,
> +	PACA_IRQ_DEC,
> +	0,
> +	PACA_IRQ_EE,
> +	PACA_IRQ_EE,
> +	PACA_IRQ_HMI,
> +	0, 0, 0, 0, 0 };
> +
> +void irq_set_pending_from_srr1(unsigned long srr1)
> +{
> +	unsigned int idx = (srr1 >> 18) & SRR1_WAKEMASK_P8;

Shouldn't this be
	unsigned int idx = (srr1 & SRR1_WAKEMASK_P8) >> 18;
	
	?
> +
> +	local_paca->irq_happened |= srr1_to_irq[idx];
> +}
> +#endif /* CONFIG_PPC_BOOK3S */
> +


Looks good otherwise.

--
Thanks and Regards
gautham.
