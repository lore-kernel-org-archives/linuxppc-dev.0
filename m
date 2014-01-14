Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 460012C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 17:16:38 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 14 Jan 2014 16:16:35 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 369882BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 17:16:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0E5vTOk48562392
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 16:57:30 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0E6GUio007431
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 17:16:31 +1100
Message-ID: <52D4D64F.7020000@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 11:46:47 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle/menu: Fail cpuidle_idle_call() if no idle state
 is acceptable
References: <20140114060516.6109.14901.stgit@preeti.in.ibm.com>
In-Reply-To: <20140114060516.6109.14901.stgit@preeti.in.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 tuukka.tikkanen@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/14/2014 11:35 AM, Preeti U Murthy wrote:
> On PowerPC, in a particular test scenario, all the cpu idle states were disabled.
> Inspite of this it was observed that the idle state count of the shallowest
> idle state, snooze, was increasing.
> 
> This is because the governor returns the idle state index as 0 even in
> scenarios when no idle state can be chosen. These scenarios could be when the
> latency requirement is 0 or as mentioned above when the user wants to disable
> certain cpu idle states at runtime. In the latter case, its possible that no
> cpu idle state is valid because the suitable states were disabled
> and the rest did not match the menu governor criteria to be chosen as the
> next idle state.
> 
> This patch adds the code to indicate that a valid cpu idle state could not be
> chosen by the menu governor and reports back to arch so that it can take some
> default action.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---

Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

> 
>  drivers/cpuidle/cpuidle.c        |    6 +++++-
>  drivers/cpuidle/governors/menu.c |    7 ++++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index a55e68f..5bf06bb 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -131,8 +131,9 @@ int cpuidle_idle_call(void)
> 
>  	/* ask the governor for the next state */
>  	next_state = cpuidle_curr_governor->select(drv, dev);
> +
> +	dev->last_residency = 0;
>  	if (need_resched()) {
> -		dev->last_residency = 0;
>  		/* give the governor an opportunity to reflect on the outcome */
>  		if (cpuidle_curr_governor->reflect)
>  			cpuidle_curr_governor->reflect(dev, next_state);
> @@ -140,6 +141,9 @@ int cpuidle_idle_call(void)
>  		return 0;
>  	}
> 
> +	if (next_state < 0)
> +		return -EINVAL;
> +
>  	trace_cpu_idle_rcuidle(next_state, dev->cpu);
> 
>  	broadcast = !!(drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP);
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index cf7f2f0..6921543 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -283,6 +283,7 @@ again:
>   * menu_select - selects the next idle state to enter
>   * @drv: cpuidle driver containing state data
>   * @dev: the CPU
> + * Returns -1 when no idle state is suitable
>   */
>  static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  {
> @@ -292,17 +293,17 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	int multiplier;
>  	struct timespec t;
> 
> -	if (data->needs_update) {
> +	if (data->last_state_idx >= 0 && data->needs_update) {
>  		menu_update(drv, dev);
>  		data->needs_update = 0;
>  	}
> 
> -	data->last_state_idx = 0;
> +	data->last_state_idx = -1;
>  	data->exit_us = 0;
> 
>  	/* Special case when user has set very strict latency requirement */
>  	if (unlikely(latency_req == 0))
> -		return 0;
> +		return data->last_state_idx;
> 
>  	/* determine the expected residency time, round up */
>  	t = ktime_to_timespec(tick_nohz_get_sleep_length());
> 
