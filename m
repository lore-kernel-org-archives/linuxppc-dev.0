Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8nld6p2wzDvRR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 01:43:41 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA3EeY5j020878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 10:43:38 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26g6j6k3nr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 10:43:38 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 10:43:37 -0400
Date: Thu, 3 Nov 2016 20:13:33 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc: cpufreq: Use get_cpu()/put_cpu() instead of
 smp_processor_id() to avoid the oops
Reply-To: ego@linux.vnet.ibm.com
References: <1478172041-9067-1-git-send-email-kda@linux-powerpc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478172041-9067-1-git-send-email-kda@linux-powerpc.org>
Message-Id: <20161103144333.GA28138@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Denis,

On Thu, Nov 03, 2016 at 07:20:41AM -0400, Denis Kirjanov wrote:
> [   67.700897] BUG: using smp_processor_id() in preemptible [00000000] code: cat/7343
> [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
> [   67.700998] CPU: 13 PID: 7343 Comm: cat Not tainted 4.8.0-rc5-dirty #1
> [   67.701038] Call Trace:
> [   67.701066] [c0000007d25b75b0] [c000000000971378] .dump_stack+0xe4/0x150 (unreliable)
> [   67.701153] [c0000007d25b7640] [c0000000005162e4] .check_preemption_disabled+0x134/0x150
> [   67.701238] [c0000007d25b76e0] [c0000000007b63ac] .powernv_cpufreq_throttle_check+0x2c/0x710
> [   67.701322] [c0000007d25b7790] [c0000000007b6d18] .powernv_cpufreq_target_index+0x288/0x360
> [   67.701407] [c0000007d25b7870] [c0000000007acee4] .__cpufreq_driver_target+0x394/0x8c0
> [   67.701491] [c0000007d25b7920] [c0000000007b22ac] .cpufreq_set+0x7c/0xd0
> [   67.701565] [c0000007d25b79b0] [c0000000007adf50] .store_scaling_setspeed+0x80/0xc0
> [   67.701650] [c0000007d25b7a40] [c0000000007ae270] .store+0xa0/0x100
> [   67.701723] [c0000007d25b7ae0] [c0000000003566e8] .sysfs_kf_write+0x88/0xb0
> [   67.701796] [c0000007d25b7b70] [c0000000003553b8] .kernfs_fop_write+0x178/0x260
> [   67.701881] [c0000007d25b7c10] [c0000000002ac3cc] .__vfs_write+0x3c/0x1c0
> [   67.701954] [c0000007d25b7cf0] [c0000000002ad584] .vfs_write+0xc4/0x230
> [   67.702027] [c0000007d25b7d90] [c0000000002aeef8] .SyS_write+0x58/0x100
> [   67.702101] [c0000007d25b7e30] [c00000000000bfec] system_call+0x38/0xfc
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>


Thanks for looking into this!
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index d3ffde8..4cd91a3 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -475,7 +475,7 @@ static inline unsigned int get_nominal_index(void)
>  static void powernv_cpufreq_throttle_check(void *data)

The powernv_cpufreq_throttle_check() checks if the frequency on any of
the CPUs on this chip has been throttled. Hence it needs to be
executed without preemption on a CPU on the particular chip.

It is called in two places currently:

a) powernv_cpufreq_work_fn where
it is called via smp_call_function_any() which will ensure that the
function will be executed without preempted.

b) from powernv_cpufreq_target_index: Here it should be nested within
the preempt_disable() preempt_enable() calls. It currently is not.

So, I would suggest fixing b) instead of locally fixing
smp_processor_id() to get_cpu()/put_cpu().

>  {
>  	struct chip *chip;
> -	unsigned int cpu = smp_processor_id();
> +	int cpu;
>  	unsigned long pmsr;
>  	int pmsr_pmax;
>  	unsigned int pmsr_pmax_idx;
> @@ -491,9 +491,11 @@ static void powernv_cpufreq_throttle_check(void *data)
>  			goto next;
>  		chip->throttled = true;
>  		if (pmsr_pmax_idx > powernv_pstate_info.nominal) {
> +			cpu = get_cpu();
>  			pr_warn_once("CPU %d on Chip %u has Pmax(%d) reduced below nominal frequency(%d)\n",
>  				     cpu, chip->id, pmsr_pmax,
>  				     idx_to_pstate(powernv_pstate_info.nominal));
> +			put_cpu();
>  			chip->throttle_sub_turbo++;
>  		} else {
>  			chip->throttle_turbo++;
> -- 
> 1.8.3.1
> 

--
Thanks and Regards
gautham.
