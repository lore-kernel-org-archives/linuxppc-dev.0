Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FE81A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 17:06:20 +1000 (AEST)
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CF5E51401AD
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 17:06:19 +1000 (AEST)
Received: by pacfv12 with SMTP id fv12so138364432pac.2
 for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2015 00:06:17 -0700 (PDT)
Date: Mon, 14 Sep 2015 12:36:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq : powernv: Report Pmax throttling if capped
 below nominal frequency
Message-ID: <20150914070613.GA32551@linux>
References: <1442207874-5016-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442207874-5016-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14-09-15, 10:47, Shilpasri G Bhat wrote:
> Log a 'critical' message if the max frequency is reduced below nominal
> frequency. We already log 'info' message if the max frequency is
> capped below turbo frequency. CPU should guarantee atleast nominal
> frequency, but not turbo frequency in all system configurations and
> environments. So report the pmax throttling with severity when Pmax is
> dipped below nominal frequency.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 64994e1..2d9ed42 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -327,8 +327,13 @@ static void powernv_cpufreq_throttle_check(void *data)
>  		if (chips[i].throttled)
>  			goto next;
>  		chips[i].throttled = true;
> -		pr_info("CPU %d on Chip %u has Pmax reduced to %d\n", cpu,
> -			chips[i].id, pmsr_pmax);
> +		if (pmsr_pmax < powernv_pstate_info.nominal)
> +			pr_crit("CPU %d on Chip %u has Pmax reduced to %d\n",
> +				cpu, chips[i].id, pmsr_pmax);
> +		else
> +			pr_info("CPU %d on Chip %u has Pmax reduced to %d\n",
> +				cpu, chips[i].id, pmsr_pmax);

I think the messages here can be improved a bit here to something
like:

			pr_warn("CPU %d on Chip %u has Pmax reduced below nominal freq (%d < %d)\n",
                                 cpu, chips[i].id, pmsr_pmax, powernv_pstate_info.nominal);

And similarly for the pr_info case as well.

-- 
viresh
