Return-Path: <rjwysocki@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r96bg3VGVzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 07:22:23 +1000 (AEST)
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r96bf3SXzz9t6j
 for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2016 07:22:21 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id n129so16147885wmn.1
 for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2016 14:22:21 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1463576020-18597-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1463576020-18597-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Wed, 18 May 2016 23:22:16 +0200
Message-ID: <CAJZ5v0iaGCi8X7Ko0aZL6CBgZ3i4=59cqFhzi1nBFumHL=huQw@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq: powernv: Add fast_switch callback
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 18, 2016 at 2:53 PM, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> Add fast_switch driver callback to support frequency update in
> interrupt context while using schedutil governor. Changing frequency
> in interrupt context will remove the jitter on the workloads which can
> be seen when a kworker thread is used for the changing the frequency.
>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

This looks simple enough. :-)

A couple of comments, though.

> ---
>  drivers/cpufreq/powernv-cpufreq.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 54c4536..4553eb6 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -678,6 +678,8 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>         for (i = 0; i < threads_per_core; i++)
>                 cpumask_set_cpu(base + i, policy->cpus);
>
> +       policy->fast_switch_possible = true;
> +
>         kn = kernfs_find_and_get(policy->kobj.sd, throttle_attr_grp.name);
>         if (!kn) {
>                 int ret;
> @@ -854,6 +856,24 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>         del_timer_sync(&gpstates->timer);
>  }
>
> +static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
> +                                       unsigned int target_freq)
> +{
> +       int index;
> +       struct powernv_smp_call_data freq_data;
> +
> +       cpufreq_frequency_table_target(policy, policy->freq_table,
> +                                      target_freq,
> +                                      CPUFREQ_RELATION_C, &index);

According to the discussion I had with Peter some time ago, this
should be RELATION_L or you may end up using a frequency that's not
sufficient to meet a deadline somewhere.

Also cpufreq_frequency_table_target() is somewhat heavy-weight
especially if the table is known to be sorted (which I guess is the
case).

> +       if (index < 0 || index >= powernv_pstate_info.nr_pstates)
> +               return CPUFREQ_ENTRY_INVALID;
> +       freq_data.pstate_id = powernv_freqs[index].driver_data;
> +       freq_data.gpstate_id = powernv_freqs[index].driver_data;
> +       set_pstate(&freq_data);
> +
> +       return pstate_id_to_freq(-index);
> +}
> +
>  static struct cpufreq_driver powernv_cpufreq_driver = {
>         .name           = "powernv-cpufreq",
>         .flags          = CPUFREQ_CONST_LOOPS,
> @@ -861,6 +881,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>         .exit           = powernv_cpufreq_cpu_exit,
>         .verify         = cpufreq_generic_frequency_table_verify,
>         .target_index   = powernv_cpufreq_target_index,
> +       .fast_switch    = powernv_fast_switch,
>         .get            = powernv_cpufreq_get,
>         .stop_cpu       = powernv_cpufreq_stop_cpu,
>         .attr           = powernv_cpu_freq_attr,
> --
