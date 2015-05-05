Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB0E01A066D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 13:46:10 +1000 (AEST)
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0DBBB141324
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 13:46:09 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 4 May 2015 23:46:07 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 2D12D6E803F
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 23:37:54 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t453k5uY62193734
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 03:46:05 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t453k4Hs026744
 for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2015 23:46:05 -0400
Message-ID: <55483CFA.9010106@linux.vnet.ibm.com>
Date: Tue, 05 May 2015 09:16:02 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] cpufreq: powernv: Report Psafe only if
 PMSR.psafe_mode_active bit is set
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1430729652-14813-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430729652-14813-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2015 02:24 PM, Shilpasri G Bhat wrote:
> On a reset cycle of OCC, although the system retires from safe
> frequency state the local pstate is not restored to Pmin or last
> requested pstate. Now if the cpufreq governor initiates a pstate
> change, the local pstate will be in Psafe and we will be reporting a
> false positive when we are not throttled.
> 
> So in powernv_cpufreq_throttle_check() remove the condition which
> checks if local pstate is less than Pmin while checking for Psafe
> frequency. If the cpus are forced to Psafe then PMSR.psafe_mode_active
> bit will be set. So, when OCCs become active this bit will be cleared.
> Let us just rely on this bit for reporting throttling.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 9618813..0a59d5b 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -39,7 +39,6 @@
>  #define PMSR_PSAFE_ENABLE	(1UL << 30)
>  #define PMSR_SPR_EM_DISABLE	(1UL << 31)
>  #define PMSR_MAX(x)		((x >> 32) & 0xFF)
> -#define PMSR_LP(x)		((x >> 48) & 0xFF)
>  #define OCC_RESET		0
>  #define OCC_LOAD		1
>  #define OCC_THROTTLE		2
> @@ -316,7 +315,7 @@ static void powernv_cpufreq_throttle_check(void *data)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	unsigned long pmsr;
> -	int pmsr_pmax, pmsr_lp, i;
> +	int pmsr_pmax, i;
>  
>  	pmsr = get_pmspr(SPRN_PMSR);
>  
> @@ -338,14 +337,9 @@ static void powernv_cpufreq_throttle_check(void *data)
>  			chips[i].id, pmsr_pmax);
>  	}
>  
> -	/*
> -	 * Check for Psafe by reading LocalPstate
> -	 * or check if Psafe_mode_active is set in PMSR.
> -	 */
> +	/* Check if Psafe_mode_active is set in PMSR. */
>  next:
> -	pmsr_lp = (s8)PMSR_LP(pmsr);
> -	if ((pmsr_lp < powernv_pstate_info.min) ||
> -				(pmsr & PMSR_PSAFE_ENABLE)) {
> +	if (pmsr & PMSR_PSAFE_ENABLE) {
>  		throttled = true;
>  		pr_info("Pstate set to safe frequency\n");
>  	}
> 

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
