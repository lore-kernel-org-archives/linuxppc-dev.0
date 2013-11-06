Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
 [74.125.82.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 773152C012B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 08:02:22 +1100 (EST)
Received: by mail-we0-f178.google.com with SMTP id q59so61432wes.23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Nov 2013 13:02:19 -0800 (PST)
Message-ID: <527AAE59.9060009@linaro.org>
Date: Wed, 06 Nov 2013 22:02:17 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 4/7] pseries/cpuidle: Remove MAX_IDLE_STATE macro.
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
 <20131029110141.31547.23622.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131029110141.31547.23622.stgit@deepthi.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: preeti@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com,
 scottwood@freescale.com, linux-pm@lists.linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/29/2013 12:01 PM, Deepthi Dharwar wrote:
> This patch removes the usage of MAX_IDLE_STATE macro
> and dead code around it. The number of states
> are determined at run time based on the cpuidle
> state table selected on a given platform
>
> Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/cpuidle/cpuidle-ibm-power.c |   26 +++++++++-----------------
>   1 file changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-ibm-power.c b/drivers/cpuidle/cpuidle-ibm-power.c
> index 8c9e42c..e81c207 100644
> --- a/drivers/cpuidle/cpuidle-ibm-power.c
> +++ b/drivers/cpuidle/cpuidle-ibm-power.c
> @@ -25,9 +25,7 @@ struct cpuidle_driver pseries_idle_driver = {
>   	.owner            = THIS_MODULE,
>   };
>
> -#define MAX_IDLE_STATE_COUNT	2
> -
> -static int max_idle_state = MAX_IDLE_STATE_COUNT - 1;
> +static int max_idle_state;
>   static struct cpuidle_state *cpuidle_state_table;
>
>   static inline void idle_loop_prolog(unsigned long *in_purr)
> @@ -137,7 +135,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
>   /*
>    * States for dedicated partition case.
>    */
> -static struct cpuidle_state dedicated_states[MAX_IDLE_STATE_COUNT] = {
> +static struct cpuidle_state dedicated_states[] = {
>   	{ /* Snooze */
>   		.name = "snooze",
>   		.desc = "snooze",
> @@ -157,7 +155,7 @@ static struct cpuidle_state dedicated_states[MAX_IDLE_STATE_COUNT] = {
>   /*
>    * States for shared partition case.
>    */
> -static struct cpuidle_state shared_states[MAX_IDLE_STATE_COUNT] = {
> +static struct cpuidle_state shared_states[] = {
>   	{ /* Shared Cede */
>   		.name = "Shared Cede",
>   		.desc = "Shared Cede",
> @@ -227,11 +225,7 @@ static int pseries_cpuidle_driver_init(void)
>   	struct cpuidle_driver *drv = &pseries_idle_driver;
>
>   	drv->state_count = 0;
> -
> -	for (idle_state = 0; idle_state < MAX_IDLE_STATE_COUNT; ++idle_state) {
> -
> -		if (idle_state > max_idle_state)
> -			break;
> +	for (idle_state = 0; idle_state < max_idle_state; ++idle_state) {
>
>   		/* is the state not enabled? */
>   		if (cpuidle_state_table[idle_state].enter == NULL)
> @@ -256,16 +250,14 @@ static int pseries_idle_probe(void)
>   	if (cpuidle_disable != IDLE_NO_OVERRIDE)
>   		return -ENODEV;
>
> -	if (max_idle_state == 0) {
> -		printk(KERN_DEBUG "pseries processor idle disabled.\n");
> -		return -EPERM;
> -	}
> -
>   	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
> -		if (lppaca_shared_proc(get_lppaca()))
> +		if (lppaca_shared_proc(get_lppaca())) {
>   			cpuidle_state_table = shared_states;
> -		else
> +			max_idle_state = ARRAY_SIZE(shared_states);
> +		} else {
>   			cpuidle_state_table = dedicated_states;
> +			max_idle_state = ARRAY_SIZE(dedicated_states);
> +		}
>   	} else
>   		return -ENODEV;
>
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
