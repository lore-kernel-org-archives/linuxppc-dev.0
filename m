Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpy2S184TzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 17:54:06 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id n1so4318666pfn.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 00:54:06 -0700 (PDT)
Date: Tue, 19 Apr 2016 13:24:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 scott.wood@nxp.com, yuantian.tang@nxp.com
Subject: Re: [PATCH V2] cpufreq: qoriq: Fix cooling device registration issue
 during suspend
Message-ID: <20160419075400.GB2715@vireshk-i7>
References: <1461048206-23567-1-git-send-email-hongtao.jia@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461048206-23567-1-git-send-email-hongtao.jia@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19-04-16, 14:43, Jia Hongtao wrote:
> Cooling device is registered by ready callback. It's also invoked while
> system resuming from sleep (Enabling non-boot cpus). Thus cooling device
> may be multiple registered. Matchable unregistration is added to exit
> callback to fix this issue.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
> Changes for V2:
> * Using qoriq_cpufreq_cpu_exit() callback instead of adding stop_cpu().
> 
>  drivers/cpufreq/qoriq-cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index b23e525..0b85f90 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -301,10 +301,11 @@ err_np:
>  	return -ENODEV;
>  }
>  
> -static int __exit qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)

Yes, __exit should have been removed, but not in this patch to create confusion.
You should have submitted two separate patches for these changes.

>  {
>  	struct cpu_data *data = policy->driver_data;
>  
> +	cpufreq_cooling_unregister(data->cdev);
>  	kfree(data->pclk);
>  	kfree(data->table);
>  	kfree(data);
> @@ -348,7 +349,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.name		= "qoriq_cpufreq",
>  	.flags		= CPUFREQ_CONST_LOOPS,
>  	.init		= qoriq_cpufreq_cpu_init,
> -	.exit		= __exit_p(qoriq_cpufreq_cpu_exit),
> +	.exit		= qoriq_cpufreq_cpu_exit,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qoriq_cpufreq_target,
>  	.get		= cpufreq_generic_get,
> -- 
> 2.1.0.27.g96db324

-- 
viresh
