Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzfbm25n7zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 21:49:38 +1000 (AEST)
Received: by mail-pa0-x232.google.com with SMTP id r5so9011441pag.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 May 2016 04:49:38 -0700 (PDT)
Date: Tue, 3 May 2016 17:19:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next 1/2] cpufreq: powernv: Move smp_call_function_any()
 out of irq safe block
Message-ID: <20160503114931.GA3083@vireshk-i7>
References: <1462268448-19954-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1462268448-19954-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462268448-19954-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03-05-16, 15:10, Akshay Adiga wrote:
> Fixing a WARN_ON caused by smp_call_function_any() when irq is disabled,
> because of changes made in the patch
> ('cpufreq: powernv: Ramp-down global pstate slower than local-pstate')
> https://patchwork.ozlabs.org/patch/612058/
> 
>  WARNING: CPU: 0 PID: 4 at kernel/smp.c:291
> smp_call_function_single+0x170/0x180
> 
>  Call Trace:
>  [c0000007f648f9f0] [c0000007f648fa90] 0xc0000007f648fa90 (unreliable)
>  [c0000007f648fa30] [c0000000001430e0] smp_call_function_any+0x170/0x1c0
>  [c0000007f648fa90] [c0000000007b4b00]
> powernv_cpufreq_target_index+0xe0/0x250
>  [c0000007f648fb00] [c0000000007ac9dc]
> __cpufreq_driver_target+0x20c/0x3d0
>  [c0000007f648fbc0] [c0000000007b1b4c] od_dbs_timer+0xcc/0x260
>  [c0000007f648fc10] [c0000000007b3024] dbs_work_handler+0x54/0xa0
>  [c0000007f648fc50] [c0000000000c49a8] process_one_work+0x1d8/0x590
>  [c0000007f648fce0] [c0000000000c4e08] worker_thread+0xa8/0x660
>  [c0000007f648fd80] [c0000000000cca88] kthread+0x108/0x130
>  [c0000007f648fe30] [c0000000000095e8] ret_from_kernel_thread+0x5c/0x74
> 
> Moving smp_call_function_any() out of the critical section and changing
> irq safe spinlocks to normal spinlocks.
> 
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.linux.com>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
> Patch is based on Rafael's linux-next
>  drivers/cpufreq/powernv-cpufreq.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 144c732..1f0e20c 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -581,9 +581,10 @@ void gpstate_timer_handler(unsigned long data)
>  	gpstates->last_gpstate = freq_data.gpstate_id;
>  	gpstates->last_lpstate = freq_data.pstate_id;
>  
> +	spin_unlock(&gpstates->gpstate_lock);
> +
>  	/* Timer may get migrated to a different cpu on cpu hot unplug */
>  	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
> -	spin_unlock(&gpstates->gpstate_lock);
>  }
>  
>  /*
> @@ -596,7 +597,6 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  {
>  	struct powernv_smp_call_data freq_data;
>  	unsigned int cur_msec, gpstate_id;
> -	unsigned long flags;
>  	struct global_pstate_info *gpstates = policy->driver_data;
>  
>  	if (unlikely(rebooting) && new_index != get_nominal_index())
> @@ -607,7 +607,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  
>  	cur_msec = jiffies_to_msecs(get_jiffies_64());
>  
> -	spin_lock_irqsave(&gpstates->gpstate_lock, flags);
> +	spin_lock(&gpstates->gpstate_lock);

You don't necessarily have to write 'what you are doing' in the commit log, but
tell us why you are doing that.

Please explain, why is this changed and why will things continue to work
without this.

-- 
viresh
