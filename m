Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpPcR3FwpzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:33:11 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id er2so49249511pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 03:33:11 -0700 (PDT)
Date: Mon, 18 Apr 2016 16:02:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 scott.wood@nxp.com, yuantian.tang@nxp.com
Subject: Re: [PATCH 1/2] cpufreq: qoriq: Fix cooling device registration
 issue during suspend
Message-ID: <20160418103254.GD2322@vireshk-i7>
References: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460966372-4877-1-git-send-email-hongtao.jia@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18-04-16, 15:59, Jia Hongtao wrote:
> Cooling device is registered by ready callback. It's also invoked while
> system resuming from sleep (Enabling non-boot cpus). Thus cooling device
> may be multiple registered. Stop_cpu callback is invoked during suspend
> (Disabling non-boot cpus). So matchable unregistration is added to fix
> this issue.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index b23e525..1c2fdc1 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -305,6 +305,7 @@ static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cpu_data *data = policy->driver_data;
>  
> +	cpufreq_cooling_unregister(data->cdev);
>  	kfree(data->pclk);
>  	kfree(data->table);
>  	kfree(data);
> @@ -323,6 +324,12 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
>  	return clk_set_parent(policy->clk, parent);
>  }
>  
> +static void qoriq_cpufreq_stop_cpu(struct cpufreq_policy *policy)
> +{
> +	struct cpu_data *cpud = policy->driver_data;
> +
> +	cpufreq_cooling_unregister(cpud->cdev);
> +}
>  
>  static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
>  {
> @@ -352,6 +359,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qoriq_cpufreq_target,
>  	.get		= cpufreq_generic_get,
> +	.stop_cpu	= qoriq_cpufreq_stop_cpu,
>  	.ready		= qoriq_cpufreq_ready,
>  	.attr		= cpufreq_generic_attr,
>  };

You don't need to do it from stop_cpu(), please use
qoriq_cpufreq_cpu_exit() for this.

-- 
viresh
