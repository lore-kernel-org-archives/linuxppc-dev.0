Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZhCg4VDnzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 09:49:51 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i123so5161265pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 16:49:51 -0700 (PDT)
Subject: Re: [PATCH] cpuidle/powernv: Fix snooze timeout
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net
References: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <576B23EB.7080903@gmail.com>
Date: Thu, 23 Jun 2016 09:48:59 +1000
MIME-Version: 1.0
In-Reply-To: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 23/06/16 05:36, Shreyas B. Prabhu wrote:
> Snooze is a poll idle state in powernv and pseries platforms. Snooze
> has a timeout so that if a cpu stays in snooze for more than target
> residency of the next available idle state, then it would exit thereby
> giving chance to the cpuidle governor to re-evaluate and
> promote the cpu to a deeper idle state. Therefore whenever snooze exits
> due to this timeout, its last_residency will be target_residency of next
> deeper state.
> 
> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
> changed the math around last_residency calculation. Specifically, while
> converting last_residency value from nanoseconds to microseconds it does
> right shift by 10. Due to this, in snooze timeout exit scenarios
> last_residency calculated is roughly 2.3% less than target_residency of
> next available state. This pattern is picked up get_typical_interval()
> in the menu governor and therefore expected_interval in menu_select() is
> frequently less than the target_residency of any state but snooze.
> 
> Due to this we are entering snooze at a higher rate, thereby affecting
> the single thread performance.
> Since the math around last_residency is not meant to be precise, fix this
> issue setting snooze timeout to 105% of target_residency of next
> available idle state.
> 
> This also adds comment around why snooze timeout is necessary.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 14 ++++++++++++++
>  drivers/cpuidle/cpuidle-pseries.c | 13 +++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index e12dc30..5835491 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -268,10 +268,24 @@ static int powernv_idle_probe(void)
>  		cpuidle_state_table = powernv_states;
>  		/* Device tree can indicate more idle states */
>  		max_idle_state = powernv_add_idle_states();
> +
> +		/*
> +		 * Staying in snooze for a long period can degrade the
> +		 * perfomance of the sibling cpus. Set timeout for snooze such
> +		 * that if the cpu stays in snooze longer than target residency
> +		 * of the next available idle state then exit from snooze. This
> +		 * gives a chance to the cpuidle governor to re-evaluate and
> +		 * promote it to deeper idle states.
> +		 */
>  		if (max_idle_state > 1) {
>  			snooze_timeout_en = true;
>  			snooze_timeout = powernv_states[1].target_residency *
>  					 tb_ticks_per_usec;
> +			/*
> +			 * Give a 5% margin since target residency related math
> +			 * is not precise in cpuidle core.
> +			 */

Is this due to the microsecond conversion mentioned above? It would be nice to
have it in the comment. Does

(powernv_states[1].target_residency + tb_ticks_per_usec) / tb_ticks_per_usec solve
your rounding issues, assuming the issue is really rounding or maybe it is due
to the shift by 10, could you please elaborate on what related math is not
precise? That would explain to me why I missed understanding your changes.

> +			snooze_timeout += snooze_timeout / 20;

For now 5% is sufficient, but do you want to check to assert to check if

snooze_timeout (in microseconds) / tb_ticks_per_usec > powernv_states[i].target_residency?

>  		}
>   	} else
>   		return -ENODEV;
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index 07135e0..22de841 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -250,10 +250,23 @@ static int pseries_idle_probe(void)
>  	} else
>  		return -ENODEV;
>  
> +	/*
> +	 * Staying in snooze for a long period can degrade the
> +	 * perfomance of the sibling cpus. Set timeout for snooze such
> +	 * that if the cpu stays in snooze longer than target residency
> +	 * of the next available idle state then exit from snooze. This
> +	 * gives a chance to the cpuidle governor to re-evaluate and
> +	 * promote it to deeper idle states.
> +	 */
>  	if (max_idle_state > 1) {
>  		snooze_timeout_en = true;
>  		snooze_timeout = cpuidle_state_table[1].target_residency *
>  				 tb_ticks_per_usec;
> +		/*
> +		 * Give a 5% margin since target residency related math
> +		 * is not precise in cpuidle core.
> +		 */
> +		snooze_timeout += snooze_timeout / 20;
>  	}
>  	return 0;
>  }
> 
