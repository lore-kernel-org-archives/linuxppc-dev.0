Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A47731A06B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 14:01:00 +1000 (AEST)
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CD3F2140E6A
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 14:00:59 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 5 May 2015 00:00:57 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 6F3036E8040
 for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2015 23:52:44 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4540tNK56164398
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 04:00:55 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4540rLR020440
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 00:00:54 -0400
Message-ID: <55484072.5060400@linux.vnet.ibm.com>
Date: Tue, 05 May 2015 09:30:50 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] cpufreq: powernv: Call throttle_check() on
 receiving OCC_THROTTLE
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1430729652-14813-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1430729652-14813-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-6
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shilpa,

On 05/04/2015 02:24 PM, Shilpasri G Bhat wrote:
> Re-evaluate the chip's throttled state on recieving OCC_THROTTLE
> notification by executing *throttle_check() on any one of the cpu on
> the chip. This is a sanity check to verify if we were indeed
> throttled/unthrottled after receiving OCC_THROTTLE notification.
> 
> We cannot call *throttle_check() directly from the notification
> handler because we could be handling chip1's notification in chip2. So
> initiate an smp_call to execute *throttle_check(). We are irq-disabled
> in the notification handler, so use a worker thread to smp_call
> throttle_check() on any of the cpu in the chipmask.

I see that the first patch takes care of reporting *per-chip* throttling
for pmax capping condition. But where are we taking care of reporting
"pstate set to safe" and "freq control disabled" scenarios per-chip ?

> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 9268424..9618813 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -50,6 +50,8 @@ static bool rebooting, throttled, occ_reset;
>  static struct chip {
>  	unsigned int id;
>  	bool throttled;
> +	cpumask_t mask;
> +	struct work_struct throttle;
>  } *chips;
> 
>  static int nr_chips;
> @@ -310,8 +312,9 @@ static inline unsigned int get_nominal_index(void)
>  	return powernv_pstate_info.max - powernv_pstate_info.nominal;
>  }
> 
> -static void powernv_cpufreq_throttle_check(unsigned int cpu)
> +static void powernv_cpufreq_throttle_check(void *data)
>  {
> +	unsigned int cpu = smp_processor_id();
>  	unsigned long pmsr;
>  	int pmsr_pmax, pmsr_lp, i;
> 
> @@ -373,7 +376,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  		return 0;
> 
>  	if (!throttled)
> -		powernv_cpufreq_throttle_check(smp_processor_id());
> +		powernv_cpufreq_throttle_check(NULL);
> 
>  	freq_data.pstate_id = powernv_freqs[new_index].driver_data;
> 
> @@ -418,6 +421,14 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>  };
> 
> +void powernv_cpufreq_work_fn(struct work_struct *work)
> +{
> +	struct chip *chip = container_of(work, struct chip, throttle);
> +
> +	smp_call_function_any(&chip->mask,
> +			      powernv_cpufreq_throttle_check, NULL, 0);
> +}
> +
>  static char throttle_reason[][30] = {
>  					"No throttling",
>  					"Power Cap",
> @@ -433,6 +444,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  	struct opal_msg *occ_msg = msg;
>  	uint64_t token;
>  	uint64_t chip_id, reason;
> +	int i;
> 
>  	if (msg_type != OPAL_MSG_OCC)
>  		return 0;
> @@ -466,6 +478,10 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  			occ_reset = false;
>  			throttled = false;
>  			pr_info("OCC: Active\n");
> +
> +			for (i = 0; i < nr_chips; i++)
> +				schedule_work(&chips[i].throttle);
> +
>  			return 0;
>  		}
> 
> @@ -476,6 +492,12 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>  		else if (!reason)
>  			pr_info("OCC: Chip %u %s\n", (unsigned int)chip_id,
>  				throttle_reason[reason]);
> +		else
> +			return 0;

Why the else section ? The code can never reach here, can it ?

> +
> +		for (i = 0; i < nr_chips; i++)
> +			if (chips[i].id == chip_id)
> +				schedule_work(&chips[i].throttle);
>  	}

Should we not do this only when we get unthrottled so as to cross verify
if it is indeed the case ? In case of throttling notification, opal's
verdict is final and there is no need to cross verify right ?

Perhaps the one thing that needs to be taken care in addition to
reporting throttling is setting the chip's throttled parameter to true.
This should do right ? I don't see the need to call throttle_check() here.

Regards
Preeti U Murthy


>  	return 0;
>  }
> @@ -527,6 +549,8 @@ static int init_chip_info(void)
>  	for (i = 0; i < nr_chips; i++) {
>  		chips[i].id = chip[i];
>  		chips[i].throttled = false;
> +		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
> +		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
>  	}
> 
>  	return 0;
> 
