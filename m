Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA9D81A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 21:57:51 +1100 (AEDT)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DF0151402D9
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 21:57:50 +1100 (AEDT)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 16:27:48 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7DF423940064
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 16:27:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0CAvfOI52953160
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 16:27:41 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0CAvds2005848
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2016 16:27:40 +0530
Message-ID: <5694DC21.5000009@linux.vnet.ibm.com>
Date: Tue, 12 Jan 2016 16:27:37 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com,
 anton@samba.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH RESEND v4 1/4] cpufreq: powernv: Remove cpu_to_chip_id()
 from hot-path
References: <1452594267-12844-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1452594267-12844-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1452594267-12844-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/12/2016 03:54 PM, Shilpasri G Bhat wrote:
> cpu_to_chip_id() does a DT walk through to find out the chip id by taking a
> contended device tree lock. This adds an unnecessary overhead in a hot-path.
> So instead of cpu_to_chip_id() use PIR of the cpu to find the chip id.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index cb50138..597a084 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -39,6 +39,7 @@
>  #define PMSR_PSAFE_ENABLE	(1UL << 30)
>  #define PMSR_SPR_EM_DISABLE	(1UL << 31)
>  #define PMSR_MAX(x)		((x >> 32) & 0xFF)
> +#define pir_to_chip_id(pir)	(((pir) >> 7) & 0x3f)

Since this is platform specific and true only for power8, this is not
the right place to put it. Either you can move this to arch/powerpc  or
you can maintain a cpu to chip map within the driver.
> 
>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>  static bool rebooting, throttled, occ_reset;
> @@ -312,13 +313,14 @@ static inline unsigned int get_nominal_index(void)
>  static void powernv_cpufreq_throttle_check(void *data)
>  {
>  	unsigned int cpu = smp_processor_id();
> +	unsigned int chip_id = pir_to_chip_id(hard_smp_processor_id());
>  	unsigned long pmsr;
>  	int pmsr_pmax, i;
> 
>  	pmsr = get_pmspr(SPRN_PMSR);
> 
>  	for (i = 0; i < nr_chips; i++)
> -		if (chips[i].id == cpu_to_chip_id(cpu))
> +		if (chips[i].id == chip_id)
>  			break;
> 
>  	/* Check for Pmax Capping */
> @@ -558,7 +560,8 @@ static int init_chip_info(void)
>  	unsigned int prev_chip_id = UINT_MAX;
> 
>  	for_each_possible_cpu(cpu) {
> -		unsigned int id = cpu_to_chip_id(cpu);
> +		unsigned int id =
> +			pir_to_chip_id(get_hard_smp_processor_id(cpu));
> 
>  		if (prev_chip_id != id) {
>  			prev_chip_id = id;
> 

Thanks,
Shreyas
