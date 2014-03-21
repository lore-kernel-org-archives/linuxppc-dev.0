Return-Path: <ego@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E85D62C0208
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 17:25:07 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 02:25:04 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 224DC38C8027
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 02:25:03 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2L6P3rH9241002
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 06:25:03 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2L6P2je003248
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 02:25:02 -0400
Date: Fri, 21 Mar 2014 11:54:57 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/5] powernv:cpufreq: Create pstate_id_to_freq() helper
Message-ID: <20140321062457.GC27293@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-4-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395317460-14811-4-git-send-email-ego@linux.vnet.ibm.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-pm@vger.kernel.org
Reply-To: ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 05:40:58PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Create a helper routine that can return the cpu-frequency for the
> corresponding pstate_id.
> 
> Also, cache the values of the pstate_max, pstate_min and
> pstate_nominal and nr_pstates in a static structure so that they can
> be reused in the future to perform any validations.
> 

Forgot to add the following line:

  Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 66dae0d..e7b0292 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -39,6 +39,14 @@ static DEFINE_PER_CPU(struct mutex, freq_switch_lock);
>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>  static int powernv_pstate_ids[POWERNV_MAX_PSTATES+1];
> 
> +struct powernv_pstate_info {
> +	int pstate_min_id;
> +	int pstate_max_id;
> +	int pstate_nominal_id;
> +	int nr_pstates;
> +};
> +static struct powernv_pstate_info powernv_pstate_info;
> +
>  /*
>   * Initialize the freq table based on data obtained
>   * from the firmware passed via device-tree
> @@ -112,9 +120,28 @@ static int init_powernv_pstates(void)
>  	for (i = 0; powernv_freqs[i].frequency != CPUFREQ_TABLE_END; i++)
>  		pr_debug("%d: %d\n", i, powernv_freqs[i].frequency);
> 
> +	powernv_pstate_info.pstate_min_id = pstate_min;
> +	powernv_pstate_info.pstate_max_id = pstate_max;
> +	powernv_pstate_info.pstate_nominal_id = pstate_nominal;
> +	powernv_pstate_info.nr_pstates = nr_pstates;
> +
>  	return 0;
>  }
> 
> +/**
> + * Returns the cpu frequency corresponding to the pstate_id.
> + */
> +static unsigned int pstate_id_to_freq(int pstate_id)
> +{
> +	int i;
> +
> +	i = powernv_pstate_info.pstate_max_id - pstate_id;
> +
> +	BUG_ON(i >= powernv_pstate_info.nr_pstates || i < 0);
> +	WARN_ON(powernv_pstate_ids[i] != pstate_id);
> +	return powernv_freqs[i].frequency;
> +}
> +
>  static struct freq_attr *powernv_cpu_freq_attr[] = {
>  	&cpufreq_freq_attr_scaling_available_freqs,
>  	NULL,
> -- 
> 1.8.3.1
> 
