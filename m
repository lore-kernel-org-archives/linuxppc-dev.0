Return-Path: <ego@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 171BB1A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 21:55:47 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E8041402D9
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 21:55:46 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 03:55:44 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 85C3E1FF0021
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 03:43:53 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u0CAthDH25559202
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 03:55:43 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0CAtgGW017820
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 03:55:42 -0700
Date: Tue, 12 Jan 2016 16:25:38 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com
Subject: Re: [PATCH RESEND v4 3/4] cpufreq: powernv: Add a trace print for
 the throttle event
Message-ID: <20160112105538.GA4187@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1452594267-12844-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1452594267-12844-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452594267-12844-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shilpa,

Just saw this resend!

On Tue, Jan 12, 2016 at 04:24:26AM -0600, Shilpasri G Bhat wrote:
> Record the throttle event with a trace print replacing the printk,
> except for events like throttling below nominal and occ reset
> event which print a warning message.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---

[..snip..]

> 
> -static void powernv_cpufreq_throttle_check(void *data)
> +static void powernv_cpufreq_check_pmax(void)
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This function only contains code moved from
powernv_cpufreq_throttle_check with pr_crit/pr_warns replaced by
trace_powernv_throttle. Furthermore, it is not called from any other
place. Given that the original function was ~60 lines do we really
need to split it into two separate functions ? If yes, could it be an
inline function ?

>  {
>  	unsigned int cpu = smp_processor_id();
>  	unsigned int chip_id = pir_to_chip_id(hard_smp_processor_id());
> -	unsigned long pmsr;
>  	int pmsr_pmax, i;
> 
> -	pmsr = get_pmspr(SPRN_PMSR);
> +	pmsr_pmax = (s8)PMSR_MAX(get_pmspr(SPRN_PMSR));
> 
>  	for (i = 0; i < nr_chips; i++)
>  		if (chips[i].id == chip_id)
>  			break;
> 
> -	/* Check for Pmax Capping */
> -	pmsr_pmax = (s8)PMSR_MAX(pmsr);
>  	if (pmsr_pmax != powernv_pstate_info.max) {
>  		if (chips[i].throttled)
> -			goto next;
> +			return;
> +
>  		chips[i].throttled = true;
>  		if (pmsr_pmax < powernv_pstate_info.nominal)
> -			pr_crit("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
> -				cpu, chips[i].id, pmsr_pmax,
> -				powernv_pstate_info.nominal);
> -		else
> -			pr_info("CPU %d on Chip %u has Pmax reduced below turbo frequency (%d < %d)\n",
> -				cpu, chips[i].id, pmsr_pmax,
> -				powernv_pstate_info.max);
> +			pr_warn_once("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
> +				     cpu, chips[i].id, pmsr_pmax,
> +				     powernv_pstate_info.nominal);
> +
> +		trace_powernv_throttle(chips[i].id,
> +				       throttle_reason[chips[i].throt_reason],
> +				       pmsr_pmax);
>  	} else if (chips[i].throttled) {
>  		chips[i].throttled = false;
> -		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,
> -			chips[i].id, pmsr_pmax);
> +		trace_powernv_throttle(chips[i].id,
> +				       throttle_reason[chips[i].throt_reason],
> +				       pmsr_pmax);
>  }
> +}
> +
> +static void powernv_cpufreq_throttle_check(void *data)
> +{
> +	unsigned long pmsr;
> +
> +	pmsr = get_pmspr(SPRN_PMSR);
> +
> +	/* Check for Pmax Capping */
> +	powernv_cpufreq_check_pmax();
  
If you want to retain this function, you could pass pmsr as an
argument instead of computing it afresh in
powernv_cpufreq_check_pmax()

>  	/* Check if Psafe_mode_active is set in PMSR. */
> -next:
>  	if (pmsr & PMSR_PSAFE_ENABLE) {
>  		throttled = true;
>  		pr_info("Pstate set to safe frequency\n");

--
Thanks and Regards
gautham.
