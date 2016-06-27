Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdJwJ34TvzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 16:30:39 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id t190so58733580pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jun 2016 23:30:39 -0700 (PDT)
Date: Mon, 27 Jun 2016 12:00:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq: powernv: Replacing pstate_id with frequency
 table index
Message-ID: <20160627063034.GA3341@vireshk-i7>
References: <1466776987-19031-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466776987-19031-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Akshay,

Did you try running checkpatch for this?

On 24-06-16, 19:33, Akshay Adiga wrote:
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index b29c5c2..f6ce6f0 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -43,6 +43,7 @@
>  #define PMSR_SPR_EM_DISABLE	(1UL << 31)
>  #define PMSR_MAX(x)		((x >> 32) & 0xFF)
>  
> +

?

>  #define MAX_RAMP_DOWN_TIME				5120
>  /*
>   * On an idle system we want the global pstate to ramp-down from max value to
> @@ -124,20 +125,29 @@ static int nr_chips;
>  static DEFINE_PER_CPU(struct chip *, chip_info);
>  
>  /*
> - * Note: The set of pstates consists of contiguous integers, the
> - * smallest of which is indicated by powernv_pstate_info.min, the
> - * largest of which is indicated by powernv_pstate_info.max.
> + * Note: The set of pstates consists of contiguous integers,
> + *
> + * powernv_pstate_info stores the index of the frequency table
> + *  instead of pstate itself for each of the pstates referred
>   *
>   * The nominal pstate is the highest non-turbo pstate in this
>   * platform. This is indicated by powernv_pstate_info.nominal.
>   */
>  static struct powernv_pstate_info {
> -	int min;
> -	int max;
> -	int nominal;
> -	int nr_pstates;
> +	unsigned int min;
> +	unsigned int max;
> +	unsigned int nominal;
> +	unsigned int nr_pstates;
>  } powernv_pstate_info;
>  
> +/* Use following macros for conversions between pstate_id and index */
> +static inline int get_pstate(unsigned int i) {

Read coding-styles please on how to write functions.

> +	return powernv_freqs[i].driver_data;
> +}

Add a blank line here please.

> +static inline unsigned int get_index(int pstate) {
> +	return abs(pstate - get_pstate(powernv_pstate_info.max));
> +}
> +
>  static inline void reset_gpstates(struct cpufreq_policy *policy)
>  {
>  	struct global_pstate_info *gpstates = policy->driver_data;
> @@ -208,23 +218,28 @@ static int init_powernv_pstates(void)
>  		return -ENODEV;
>  	}
>  
> +	powernv_pstate_info.nr_pstates = nr_pstates;
>  	pr_debug("NR PStates %d\n", nr_pstates);
>  	for (i = 0; i < nr_pstates; i++) {
>  		u32 id = be32_to_cpu(pstate_ids[i]);
>  		u32 freq = be32_to_cpu(pstate_freqs[i]);
>  
> -		pr_debug("PState id %d freq %d MHz\n", id, freq);

?

>  		powernv_freqs[i].frequency = freq * 1000; /* kHz */
>  		powernv_freqs[i].driver_data = id;

Will it be possible for Shilpa who was earlier on this to review this patch? As
we don't really have great knowledge of the internals of this driver.

-- 
viresh
