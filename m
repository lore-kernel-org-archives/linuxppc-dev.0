Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqgG13nmKzF0lJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 22:53:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 15/27] cpufreq: powerenv: Don't validate the frequency
 table twice
In-Reply-To: <3120e4db4ae3bc014d198a206f46be1305ec65e8.1519620578.git.viresh.kumar@linaro.org>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
 <3120e4db4ae3bc014d198a206f46be1305ec65e8.1519620578.git.viresh.kumar@linaro.org>
Date: Mon, 26 Feb 2018 22:53:44 +1100
Message-ID: <871sh89dbr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Viresh Kumar <viresh.kumar@linaro.org> writes:
> Subject: Re: [PATCH 15/27] cpufreq: powerenv: Don't validate the frequency table twice
                                           ^
                                      powernv

> The cpufreq core is already validating the CPU frequency table after
> calling the ->init() callback of the cpufreq drivers and the drivers
> don't need to do the same anymore. Though they need to set the
> policy->freq_table field directly from the ->init() callback now.
>
> Stop validating the frequency table from powerenv driver.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 29cdec198657..0591874856d3 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -812,7 +812,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  
>  static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
> -	int base, i, ret;
> +	int base, i;
>  	struct kernfs_node *kn;
>  	struct global_pstate_info *gpstates;

Confusingly this function has two variables called ret, but the other
one is declared inside an if block below in context not shown.

So this hunk is correct.

> @@ -848,15 +848,10 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	gpstates->timer.expires = jiffies +
>  				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
>  	spin_lock_init(&gpstates->gpstate_lock);
> -	ret = cpufreq_table_validate_and_show(policy, powernv_freqs);
> -
> -	if (ret < 0) {
> -		kfree(policy->driver_data);
> -		return ret;
> -	}
>  
> +	policy->freq_table = powernv_freqs;
>  	policy->fast_switch_possible = true;
> -	return ret;
> +	return 0;
>  }

LGTM.

cheers
