Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCjrX0MCwzDt30
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 19:58:03 +1100 (AEDT)
Received: by mail-pf0-x22a.google.com with SMTP id d2so104524539pfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 00:58:02 -0800 (PST)
Date: Tue, 8 Nov 2016 14:27:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 shilpa.bhat@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq, powernv: Disable preemption while checking CPU
 throttling state throttling state
Message-ID: <20161108085757.GA22024@vireshk-i7>
References: <1478594159-27719-1-git-send-email-kda@linux-powerpc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478594159-27719-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+some more folks from IBM.

On 08-11-16, 03:35, Denis Kirjanov wrote:
>     [   67.700897] BUG: using smp_processor_id() in preemptible [00000000] code: cat/7343
>     [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
>     [   67.700998] CPU: 13 PID: 7343 Comm: cat Not tainted 4.8.0-rc5-dirty #1
>     [   67.701038] Call Trace:
>     [   67.701066] [c0000007d25b75b0] [c000000000971378] .dump_stack+0xe4/0x150 (unreliable)
>     [   67.701153] [c0000007d25b7640] [c0000000005162e4] .check_preemption_disabled+0x134/0x150
>     [   67.701238] [c0000007d25b76e0] [c0000000007b63ac] .powernv_cpufreq_throttle_check+0x2c/0x710
>     [   67.701322] [c0000007d25b7790] [c0000000007b6d18] .powernv_cpufreq_target_index+0x288/0x360
>     [   67.701407] [c0000007d25b7870] [c0000000007acee4] .__cpufreq_driver_target+0x394/0x8c0
>     [   67.701491] [c0000007d25b7920] [c0000000007b22ac] .cpufreq_set+0x7c/0xd0
>     [   67.701565] [c0000007d25b79b0] [c0000000007adf50] .store_scaling_setspeed+0x80/0xc0
>     [   67.701650] [c0000007d25b7a40] [c0000000007ae270] .store+0xa0/0x100
>     [   67.701723] [c0000007d25b7ae0] [c0000000003566e8] .sysfs_kf_write+0x88/0xb0
>     [   67.701796] [c0000007d25b7b70] [c0000000003553b8] .kernfs_fop_write+0x178/0x260
>     [   67.701881] [c0000007d25b7c10] [c0000000002ac3cc] .__vfs_write+0x3c/0x1c0
>     [   67.701954] [c0000007d25b7cf0] [c0000000002ad584] .vfs_write+0xc4/0x230
>     [   67.702027] [c0000007d25b7d90] [c0000000002aeef8] .SyS_write+0x58/0x100
>     [   67.702101] [c0000007d25b7e30] [c00000000000bfec] system_call+0x38/0xfc
> 

We expect some description of the problem here, not just the OPPs
dump.

> Fixes: 09a972d16209 ("cpufreq: powernv: Report cpu frequency throttling")
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
> ---
> 
> drivers/cpufreq/powernv-cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index d3ffde8..a84724e 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -647,8 +647,14 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>  	if (unlikely(rebooting) && new_index != get_nominal_index())
>  		return 0;
>  
> -	if (!throttled)
> +	if (!throttled) {
> +		/* we don't want to be preempted while
> +		 * checking if the CPU frequency has been throttled
> +		 */
> +		preempt_disable();
>  		powernv_cpufreq_throttle_check(NULL);
> +		preempt_enable();
> +	}
>  
>  	cur_msec = jiffies_to_msecs(get_jiffies_64());
>  
> -- 
> 1.8.3.1

-- 
viresh
