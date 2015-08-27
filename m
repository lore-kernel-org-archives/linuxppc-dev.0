Return-Path: <viresh.kumar@linaro.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CEF131A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 22:29:47 +1000 (AEST)
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 559A014012C
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 22:29:46 +1000 (AEST)
Received: by pacdd16 with SMTP id dd16so24430512pac.2
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 05:29:44 -0700 (PDT)
Date: Thu, 27 Aug 2015 17:59:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernv: Increase the verbosity of OCC console
 messages
Message-ID: <20150827122940.GW8784@linux>
References: <1440666704-10666-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440666704-10666-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27-08-15, 14:41, Shilpasri G Bhat wrote:
> Modify the OCC reset/load/active event message to make it clearer for
> the user to understand the event and effect of the event.
> 
> Suggested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> This patch is based on top of linux-next/master
> 
>  drivers/cpufreq/powernv-cpufreq.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 546e056..64994e1 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -465,6 +465,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  	switch (omsg.type) {
>  	case OCC_RESET:
>  		occ_reset = true;
> +		pr_info("OCC (On Chip Controller - enforces hard thermal/power limits) Resetting\n");
>  		/*
>  		 * powernv_cpufreq_throttle_check() is called in
>  		 * target() callback which can detect the throttle state
> @@ -474,12 +475,12 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  		 */
>  		if (!throttled) {
>  			throttled = true;
> -			pr_crit("CPU Frequency is throttled\n");
> +			pr_crit("CPU frequency is throttled for duration\n");
>  		}
> -		pr_info("OCC: Reset\n");
> +
>  		break;
>  	case OCC_LOAD:
> -		pr_info("OCC: Loaded\n");
> +		pr_info("OCC Loading, CPU frequency is throttled until OCC is started\n");
>  		break;
>  	case OCC_THROTTLE:
>  		omsg.chip = be64_to_cpu(msg->params[1]);
> @@ -488,7 +489,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  		if (occ_reset) {
>  			occ_reset = false;
>  			throttled = false;
> -			pr_info("OCC: Active\n");
> +			pr_info("OCC Active, CPU frequency is no longer throttled\n");
>  
>  			for (i = 0; i < nr_chips; i++) {
>  				chips[i].restore = true;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
