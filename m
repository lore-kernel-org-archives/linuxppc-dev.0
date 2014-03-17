Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 71A202C00AE
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 20:10:05 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 17 Mar 2014 03:10:03 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8041C1FF001A
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 03:10:01 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2H9A1xm54198294
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 10:10:01 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2H9A1ur009077
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2014 03:10:01 -0600
Message-ID: <5326BB06.4000007@linux.vnet.ibm.com>
Date: Mon, 17 Mar 2014 14:36:14 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/6] powernv:cpufreq: Create pstate_id_to_freq() helper
References: <1394449861-8688-1-git-send-email-ego@linux.vnet.ibm.com>
 <1394449861-8688-5-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1394449861-8688-5-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/10/2014 04:40 PM, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Create a helper routine that can return the cpu-frequency for the
> corresponding pstate_id.
> 
> Also, cache the values of the pstate_max, pstate_min and
> pstate_nominal and nr_pstates in a static structure so that they can
> be reused in the future to perform any validations.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 4c2e8ca..0ecd163 100644
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
> 
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
