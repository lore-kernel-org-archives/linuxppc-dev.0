Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmfKg3VvzzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:00:39 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CGweLQ013138
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 13:00:36 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b1xph0q1k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 13:00:35 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 03:00:25 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5CH0Ghm1114452
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:00:16 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5CH0FBI025412
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:00:15 +1000
Date: Mon, 12 Jun 2017 22:30:07 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/14] powerpc/64s: idle runlatch switch is done with
 MSR[EE]=0
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-15-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170611235835.7400-15-npiggin@gmail.com>
Message-Id: <20170612170007.GA4340@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-06-12 09:58:35]:

> 2*mfmsr and 2*mtmsr can be avoided in the idle sleep/wake code
> because we know the MSR[EE] is clear.

Good optimization for powernv.
 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

> ---
>  arch/powerpc/platforms/powernv/idle.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index ee416e016387..84c55a5ef7ea 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -291,9 +291,9 @@ static unsigned long __power7_idle_type(unsigned long type)
>  	if (!prep_irq_for_idle_irqsoff())
>  		return 0;
> 
> -	ppc64_runlatch_off();
> +	__ppc64_runlatch_off();
>  	srr1 = power7_idle_insn(type);
> -	ppc64_runlatch_on();
> +	__ppc64_runlatch_on();
> 
>  	fini_irq_for_idle_irqsoff();
> 
> @@ -328,9 +328,9 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
>  	psscr = mfspr(SPRN_PSSCR);
>  	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
> 
> -	ppc64_runlatch_off();
> +	__ppc64_runlatch_off();
>  	srr1 = power9_idle_stop(psscr);
> -	ppc64_runlatch_on();
> +	__ppc64_runlatch_on();
> 
>  	fini_irq_for_idle_irqsoff();
> 
> @@ -365,7 +365,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  	unsigned long srr1;
>  	u32 idle_states = pnv_get_supported_cpuidle_states();
> 
> -	ppc64_runlatch_off();
> +	__ppc64_runlatch_off();
> 
>  	if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
>  		unsigned long psscr;
> @@ -392,7 +392,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  		HMT_medium();
>  	}
> 
> -	ppc64_runlatch_on();
> +	__ppc64_runlatch_on();
> 
>  	return srr1;
>  }
> -- 
> 2.11.0
> 
