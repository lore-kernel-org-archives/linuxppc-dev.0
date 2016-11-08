Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCZp635M6zDvhh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 14:40:30 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA83dimW110503
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 22:40:28 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26k38febkr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 22:40:28 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 20:40:27 -0700
Date: Tue, 8 Nov 2016 09:10:20 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, shilpa.bhat@linux.vnet.ibm.com,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Use PMCR to verify global and
 local pstate
Reply-To: ego@linux.vnet.ibm.com
References: <1478504349-14796-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1478504349-14796-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478504349-14796-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <20161108034020.GD24936@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, Nov 07, 2016 at 01:09:09PM +0530, Akshay Adiga wrote:
> As fast_switch() may get called with interrupt disable mode, we cannot
> hold a mutex to update the global_pstate_info. So currently, fast_switch()
> does not update the global_pstate_info and it will end up with stale data
> whenever pstate is updated through fast_switch().
> 
> As the gpstate_timer can fire after fast_switch() has updated the pstates,
> the timer handler cannot rely on the cached values of local and global
> pstate and needs to read it from the PMCR.
> 
> Only gpstate_timer_handler() is affected by the stale cached pstate data
> beacause either fast_switch() or target_index() routines will be called
> for a given govenor, but gpstate_timer can fire after the governor has
> changed to schedutil.
> 
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
> 
> Changes from v1 :
> - Corrected Commit message
> - Type cast pstate values read from PMCR to type s8
> - Added Macros to get local and global pstates from PMCR

Thanks for this. Could you also send a (separate patch) to set the
local and global pstates to PMCR in set_pstate?

> 
> 
>  drivers/cpufreq/powernv-cpufreq.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 4a4380d..bf4bc585 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -42,6 +42,8 @@
>  #define PMSR_PSAFE_ENABLE	(1UL << 30)
>  #define PMSR_SPR_EM_DISABLE	(1UL << 31)
>  #define PMSR_MAX(x)		((x >> 32) & 0xFF)
> +#define PMCR_LPSTATE(x)		(((x) >> 48) & 0xFF)
> +#define PMCR_GPSTATE(x)		(((x) >> 56) & 0xFF)

You define:
#define LPSTATE_SHIFT    48
#define GPSTATE_SHIFT    56

since we can use this in the set_variants.

Moreover, the LPSTATE, GPSTATE retreival is applicable to both PMCR and PMSR. So
could you rename these functions to GET_LPSTATE, GET_GPSTATE.

Similarly, we might want to have a SET_LPSTATE, SET_GPSTATE and fix
the hard coded values that we have in set_pstate.


> 
>  #define MAX_RAMP_DOWN_TIME				5120
>  /*
> @@ -592,7 +594,8 @@ void gpstate_timer_handler(unsigned long data)
>  {
>  	struct cpufreq_policy *policy = (struct cpufreq_policy *)data;
>  	struct global_pstate_info *gpstates = policy->driver_data;
> -	int gpstate_idx;
> +	int gpstate_idx, lpstate_idx;
> +	unsigned long val;
>  	unsigned int time_diff = jiffies_to_msecs(jiffies)
>  					- gpstates->last_sampled_time;
>  	struct powernv_smp_call_data freq_data;
> @@ -600,21 +603,36 @@ void gpstate_timer_handler(unsigned long data)
>  	if (!spin_trylock(&gpstates->gpstate_lock))
>  		return;
> 
> +	/*
> +	 * If PMCR was last updated was using fast_swtich then
> +	 * We may have wrong in gpstate->last_lpstate_idx
> +	 * value. Hence, read from PMCR to get correct data.
> +	 */
> +	val = get_pmspr(SPRN_PMCR);
> +	freq_data.gpstate_id = (s8)PMCR_GPSTATE(val);
> +	freq_data.pstate_id = (s8)PMCR_LPSTATE(val);
> +	if (freq_data.gpstate_id  == freq_data.pstate_id) {
> +		reset_gpstates(policy);
> +		spin_unlock(&gpstates->gpstate_lock);
> +		return;
> +	}
> +
>  	gpstates->last_sampled_time += time_diff;
>  	gpstates->elapsed_time += time_diff;
> -	freq_data.pstate_id = idx_to_pstate(gpstates->last_lpstate_idx);
> 
> -	if ((gpstates->last_gpstate_idx == gpstates->last_lpstate_idx) ||
> -	    (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME)) {
> +	if (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME) {
>  		gpstate_idx = pstate_to_idx(freq_data.pstate_id);
>  		reset_gpstates(policy);
>  		gpstates->highest_lpstate_idx = gpstate_idx;
>  	} else {
> +		lpstate_idx = pstate_to_idx(freq_data.pstate_id);
>  		gpstate_idx = calc_global_pstate(gpstates->elapsed_time,
>  						 gpstates->highest_lpstate_idx,
> -						 gpstates->last_lpstate_idx);
> +						 lpstate_idx);
>  	}
> -
> +	freq_data.gpstate_id = idx_to_pstate(gpstate_idx);
> +	gpstates->last_gpstate_idx = gpstate_idx;
> +	gpstates->last_lpstate_idx = lpstate_idx;
>  	/*
>  	 * If local pstate is equal to global pstate, rampdown is over
>  	 * So timer is not required to be queued.
> @@ -622,10 +640,6 @@ void gpstate_timer_handler(unsigned long data)
>  	if (gpstate_idx != gpstates->last_lpstate_idx)
>  		queue_gpstate_timer(gpstates);
> 
> -	freq_data.gpstate_id = idx_to_pstate(gpstate_idx);
> -	gpstates->last_gpstate_idx = pstate_to_idx(freq_data.gpstate_id);
> -	gpstates->last_lpstate_idx = pstate_to_idx(freq_data.pstate_id);
> -
>  	spin_unlock(&gpstates->gpstate_lock);
> 
>  	/* Timer may get migrated to a different cpu on cpu hot unplug */
> -- 
> 2.5.5

Looks good otherwise.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
