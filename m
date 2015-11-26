Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x22c.google.com (mail-yk0-x22c.google.com
 [IPv6:2607:f8b0:4002:c07::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DA551A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 19:32:19 +1100 (AEDT)
Received: by ykba77 with SMTP id a77so82813818ykb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 00:32:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1448519249-11449-1-git-send-email-hongtao.jia@freescale.com>
References: <1448519249-11449-1-git-send-email-hongtao.jia@freescale.com>
Date: Thu, 26 Nov 2015 11:32:17 +0300
Message-ID: <CAOJe8K3g_B=Pa7U9zFY6RjqrKOPY2a3mqMAw6uSqQBVz9qW7Zg@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: qoriq: Register cooling device based on
 device tree
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: edubezval@gmail.com, viresh.kumar@linaro.org, scottwood@freescale.com,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/26/15, Jia Hongtao <hongtao.jia@freescale.com> wrote:
> Register the qoriq cpufreq driver as a cooling device, based on the
> thermal device tree framework. When temperature crosses the passive trip
> point cpufreq is used to throttle CPUs.
>
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
> Changes for V2:
> * Using ->ready callback for cpu cooling device registering.
>
>  drivers/cpufreq/qoriq-cpufreq.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c
> b/drivers/cpufreq/qoriq-cpufreq.c
> index 4f53fa2..a39f868 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -33,6 +34,7 @@
>  struct cpu_data {
>  	struct clk **pclk;
>  	struct cpufreq_frequency_table *table;
> +	struct thermal_cooling_device *cdev;
>  };
>
>  /*
> @@ -260,6 +262,30 @@ static int qoriq_cpufreq_target(struct cpufreq_policy
> *policy,
>  	return clk_set_parent(policy->clk, parent);
>  }
>
> +
> +static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	struct cpu_data *cpud = policy->driver_data;
> +	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
> +
> +	if (WARN_ON(!np))
> +		return;
I doubt that WARN_ON is necessary here. Do you know the exact case
where the np is NULL?
> +
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		cpud->cdev = of_cpufreq_cooling_register(np,
> +							 policy->related_cpus);
> +
> +		if (IS_ERR(cpud->cdev)) {
> +			pr_err("Failed to register cooling device cpu%d: %ld\n",
> +					policy->cpu, PTR_ERR(cpud->cdev));
> +
> +			cpud->cdev = NULL;
> +		}
> +	}
> +
> +	of_node_put(np);
> +}
> +
>  static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.name		= "qoriq_cpufreq",
>  	.flags		= CPUFREQ_CONST_LOOPS,
> @@ -268,6 +294,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qoriq_cpufreq_target,
>  	.get		= cpufreq_generic_get,
> +	.ready		= qoriq_cpufreq_ready,
>  	.attr		= cpufreq_generic_attr,
>  };
>
> --
> 2.1.0.27.g96db324
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
