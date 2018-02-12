Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zg22r5ZRtzF0mv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 21:29:05 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id 13so4835710plb.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 02:29:05 -0800 (PST)
Date: Mon, 12 Feb 2018 15:59:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH] cpufreq: powernv: Check  negative value returned by
 cpufreq_table_find_index_dl()
Message-ID: <20180212102900.GU28462@vireshk-i7>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12-02-18, 15:51, Shilpasri G Bhat wrote:
> This patch fixes the below Coverity warning:
> 
> *** CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
> /drivers/cpufreq/powernv-cpufreq.c: 1008 in powernv_fast_switch()
> 1002     					unsigned int target_freq)
> 1003     {
> 1004     	int index;
> 1005     	struct powernv_smp_call_data freq_data;
> 1006
> 1007     	index = cpufreq_table_find_index_dl(policy, target_freq);
> >>>     CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
> >>>     Using variable "index" as an index to array "powernv_freqs".
> 1008     	freq_data.pstate_id = powernv_freqs[index].driver_data;
> 1009     	freq_data.gpstate_id = powernv_freqs[index].driver_data;
> 1010     	set_pstate(&freq_data);
> 1011
> 1012     	return powernv_freqs[index].frequency;
> 1013     }
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 29cdec1..69edfe9 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -1005,6 +1005,9 @@ static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
>  	struct powernv_smp_call_data freq_data;
>  
>  	index = cpufreq_table_find_index_dl(policy, target_freq);
> +	if (unlikely(index < 0))
> +		index = get_nominal_index();
> +

AFAICT, you will get -1 here only if the freq table had no valid
frequencies (or the freq table is empty). Why would that happen ?

>  	freq_data.pstate_id = powernv_freqs[index].driver_data;
>  	freq_data.gpstate_id = powernv_freqs[index].driver_data;
>  	set_pstate(&freq_data);
> -- 
> 1.8.3.1

-- 
viresh
