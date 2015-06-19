Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9ADE71A0EF5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 15:37:22 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 19 Jun 2015 01:37:18 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id F2DC76E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 01:29:01 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5J5bEXh62193776
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 05:37:15 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5J5bEa4004269
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 01:37:14 -0400
Message-ID: <5583AA86.9010203@linux.vnet.ibm.com>
Date: Fri, 19 Jun 2015 11:07:10 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, rjw@rjwysocki.net
CC: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] cpuidle: powernv/pseries: Auto-promotion of snooze
 to deeper idle state
References: <1434626591-14509-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1434626591-14509-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/18/2015 04:53 PM, Shilpasri G Bhat wrote:
> The idle cpus which stay in snooze for a long period can degrade the
> perfomance of the sibling cpus. If the cpu stays in snooze for more
> than target residency of the next available idle state, then exit from
> snooze. This gives a chance to the cpuidle governor to re-evaluate the
> last idle state of the cpu to promote it to deeper idle states.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

> Changes from v1:
> -Modified commit message
> 
>  drivers/cpuidle/cpuidle-powernv.c | 12 ++++++++++++
>  drivers/cpuidle/cpuidle-pseries.c | 11 +++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 5937207..1e3ef5e 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -29,18 +29,25 @@ struct cpuidle_driver powernv_idle_driver = {
>  
>  static int max_idle_state;
>  static struct cpuidle_state *cpuidle_state_table;
> +static u64 snooze_timeout;
> +static bool snooze_timeout_en;
>  
>  static int snooze_loop(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
>  			int index)
>  {
> +	u64 snooze_exit_time;
> +
>  	local_irq_enable();
>  	set_thread_flag(TIF_POLLING_NRFLAG);
>  
> +	snooze_exit_time = get_tb() + snooze_timeout;
>  	ppc64_runlatch_off();
>  	while (!need_resched()) {
>  		HMT_low();
>  		HMT_very_low();
> +		if (snooze_timeout_en && get_tb() > snooze_exit_time)
> +			break;
>  	}
>  
>  	HMT_medium();
> @@ -252,6 +259,11 @@ static int powernv_idle_probe(void)
>  		cpuidle_state_table = powernv_states;
>  		/* Device tree can indicate more idle states */
>  		max_idle_state = powernv_add_idle_states();
> +		if (max_idle_state > 1) {
> +			snooze_timeout_en = true;
> +			snooze_timeout = powernv_states[1].target_residency *
> +					 tb_ticks_per_usec;
> +		}
>   	} else
>   		return -ENODEV;
>  
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index bb9e2b6..07135e0 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -27,6 +27,8 @@ struct cpuidle_driver pseries_idle_driver = {
>  
>  static int max_idle_state;
>  static struct cpuidle_state *cpuidle_state_table;
> +static u64 snooze_timeout;
> +static bool snooze_timeout_en;
>  
>  static inline void idle_loop_prolog(unsigned long *in_purr)
>  {
> @@ -58,14 +60,18 @@ static int snooze_loop(struct cpuidle_device *dev,
>  			int index)
>  {
>  	unsigned long in_purr;
> +	u64 snooze_exit_time;
>  
>  	idle_loop_prolog(&in_purr);
>  	local_irq_enable();
>  	set_thread_flag(TIF_POLLING_NRFLAG);
> +	snooze_exit_time = get_tb() + snooze_timeout;
>  
>  	while (!need_resched()) {
>  		HMT_low();
>  		HMT_very_low();
> +		if (snooze_timeout_en && get_tb() > snooze_exit_time)
> +			break;
>  	}
>  
>  	HMT_medium();
> @@ -244,6 +250,11 @@ static int pseries_idle_probe(void)
>  	} else
>  		return -ENODEV;
>  
> +	if (max_idle_state > 1) {
> +		snooze_timeout_en = true;
> +		snooze_timeout = cpuidle_state_table[1].target_residency *
> +				 tb_ticks_per_usec;
> +	}
>  	return 0;
>  }
>  
> 
