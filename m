Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26C151A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 20:28:16 +1000 (AEST)
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A80B91401AD
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 20:28:15 +1000 (AEST)
Received: by pacex6 with SMTP id ex6so141089946pac.0
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 03:28:13 -0700 (PDT)
Date: Mon, 14 Sep 2015 15:58:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq : powernv: Report Pmax throttling if capped
 below nominal frequency
Message-ID: <20150914102809.GD32551@linux>
References: <1442207874-5016-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1442219507-6499-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442219507-6499-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14-09-15, 14:01, Shilpasri G Bhat wrote:
> Log a 'critical' message if the max frequency is reduced below nominal
> frequency. We already log 'info' message if the max frequency is
> capped below turbo frequency. CPU should guarantee atleast nominal
> frequency, but not turbo frequency in all system configurations and
> environments. So report the pmax throttling with severity when Pmax is
> dipped below nominal frequency.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from v1:
> - Modified the printk messages as per Viresh's suggestion.
> 
>  drivers/cpufreq/powernv-cpufreq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 64994e1..cb50138 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -327,8 +327,14 @@ static void powernv_cpufreq_throttle_check(void *data)
>  		if (chips[i].throttled)
>  			goto next;
>  		chips[i].throttled = true;
> -		pr_info("CPU %d on Chip %u has Pmax reduced to %d\n", cpu,
> -			chips[i].id, pmsr_pmax);
> +		if (pmsr_pmax < powernv_pstate_info.nominal)
> +			pr_crit("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
> +				cpu, chips[i].id, pmsr_pmax,
> +				powernv_pstate_info.nominal);
> +		else
> +			pr_info("CPU %d on Chip %u has Pmax reduced below turbo frequency (%d < %d)\n",
> +				cpu, chips[i].id, pmsr_pmax,
> +				powernv_pstate_info.max);
>  	} else if (chips[i].throttled) {
>  		chips[i].throttled = false;
>  		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh
