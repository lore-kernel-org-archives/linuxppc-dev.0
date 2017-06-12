Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmbth1W81zDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 01:10:35 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CF9jLb093308
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 11:10:32 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b1w6mghns-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 11:10:31 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 11:10:31 -0400
Date: Mon, 12 Jun 2017 20:40:25 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/14] powerpc/64s: cpuidle set polling before enabling
 irqs
Reply-To: ego@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-11-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170611235835.7400-11-npiggin@gmail.com>
Message-Id: <20170612151025.GG10921@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 12, 2017 at 09:58:31AM +1000, Nicholas Piggin wrote:
> local_irq_enable can cause interrupts to be taken which could
> take significant amount of processing time. The idle process
> should set its polling flag before this, so another process that
> wakes it during this time will not have to send an IPI.
> 
> Expand the TIF_POLLING_NRFLAG coverage to as large as possible.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks good. Were you able to see this make a difference in any of the
tests ?

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  drivers/cpuidle/cpuidle-powernv.c | 4 +++-
>  drivers/cpuidle/cpuidle-pseries.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 79152676f62b..50b3c2e0306f 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -51,9 +51,10 @@ static int snooze_loop(struct cpuidle_device *dev,
>  {
>  	u64 snooze_exit_time;
> 
> -	local_irq_enable();
>  	set_thread_flag(TIF_POLLING_NRFLAG);
> 
> +	local_irq_enable();
> +
>  	snooze_exit_time = get_tb() + snooze_timeout;
>  	ppc64_runlatch_off();
>  	HMT_very_low();
> @@ -66,6 +67,7 @@ static int snooze_loop(struct cpuidle_device *dev,
>  	ppc64_runlatch_on();
>  	clear_thread_flag(TIF_POLLING_NRFLAG);
>  	smp_mb();
> +
>  	return index;
>  }
> 
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index 166ccd711ec9..7b12bb2ea70f 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -62,9 +62,10 @@ static int snooze_loop(struct cpuidle_device *dev,
>  	unsigned long in_purr;
>  	u64 snooze_exit_time;
> 
> +	set_thread_flag(TIF_POLLING_NRFLAG);
> +
>  	idle_loop_prolog(&in_purr);
>  	local_irq_enable();
> -	set_thread_flag(TIF_POLLING_NRFLAG);
>  	snooze_exit_time = get_tb() + snooze_timeout;
> 
>  	while (!need_resched()) {
> -- 
> 2.11.0
> 
