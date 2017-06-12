Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmgPQ0lj8zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:48:57 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CHiJEB075472
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 13:48:54 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b1qfa7q7s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 13:48:54 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 03:48:51 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5CHmmfO7864810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:48:48 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5CHmkdO018947
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:48:46 +1000
Date: Mon, 12 Jun 2017 23:18:44 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 12/14] powerpc/64s: cpuidle no memory barrier after break
 from idle
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-13-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170611235835.7400-13-npiggin@gmail.com>
Message-Id: <20170612174844.GC4340@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-06-12 09:58:33]:

> A memory barrier is not required after the task wakes up,
> only if we clear the polling flag before waking. The case
> where we have work to do is the important one, so optimise
> for it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>


> ---
>  drivers/cpuidle/cpuidle-powernv.c | 11 +++++++++--
>  drivers/cpuidle/cpuidle-pseries.c | 11 +++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 9d03326ac05e..37b0698b7193 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -59,14 +59,21 @@ static int snooze_loop(struct cpuidle_device *dev,
>  	ppc64_runlatch_off();
>  	HMT_very_low();
>  	while (!need_resched()) {
> -		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time)
> +		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
> +			/*
> +			 * Task has not woken up but we are exiting the polling
> +			 * loop anyway. Require a barrier after polling is
> +			 * cleared to order subsequent test of need_resched().
> +			 */
> +			clear_thread_flag(TIF_POLLING_NRFLAG);
> +			smp_mb();
>  			break;
> +		}
>  	}
> 
>  	HMT_medium();
>  	ppc64_runlatch_on();
>  	clear_thread_flag(TIF_POLLING_NRFLAG);
> -	smp_mb();

If we reach here without executing if(snooze_timeout) with the
barrier+break, that means we have seen the need_resched flag and hence
we can avoid the barrier.  Clearing of the polling flag can be seen
(take affect) later as we will exit the idle loop and re-enter anyway
at this point.  The caller also will check for need_resched and exit
the idle loop.

Actually do_idle() has a __current_set_polling() and
__current_clr_polling() in the default idle loop.  Do we really need
to set/clear the TIF_POLLING_NRFLAG again in cpuidle driver?

--Vaidy
