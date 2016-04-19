Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpzmN58LSzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 19:12:04 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id c20so4983820pfc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 02:12:04 -0700 (PDT)
Date: Tue, 19 Apr 2016 14:42:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 scott.wood@nxp.com, yuantian.tang@nxp.com
Subject: Re: [PATCH V3 2/2] cpufreq: qoriq: Fix cooling device registration
 issue during suspend
Message-ID: <20160419091200.GB2905@vireshk-i7>
References: <1461056407-22542-1-git-send-email-hongtao.jia@nxp.com>
 <1461056407-22542-2-git-send-email-hongtao.jia@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461056407-22542-2-git-send-email-hongtao.jia@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19-04-16, 17:00, Jia Hongtao wrote:
> Cooling device is registered by ready callback. It's also invoked while
> system resuming from sleep (Enabling non-boot cpus). Thus cooling device
> may be multiple registered. Matchable unregistration is added to exit
> callback to fix this issue.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
>  drivers/cpufreq/qoriq-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 3a3fe39..0b85f90 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -305,6 +305,7 @@ static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cpu_data *data = policy->driver_data;
>  
> +	cpufreq_cooling_unregister(data->cdev);
>  	kfree(data->pclk);
>  	kfree(data->table);
>  	kfree(data);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
